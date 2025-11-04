---
title: DockerコンテナからS3にアクセスできない!? EC2のIAMロール"だけ"では動かない理由
tags:
  - AWS
  - IAM
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-04T08:16:04+09:00'
id: e6dccad33a333ff966bc
organization_url_name: null
slide: false
ignorePublish: false
---
## TL;DR

- **EC2上で直接動くアプリ**: IAMロールで自動的にS3アクセス可能 ✅
- **EC2上のDockerコンテナ内のアプリ**: 状況による
  - **bridgeネットワーク**: IAMロールで動く ✅
  - **ネットワーク分離**: IAMロールだけでは403エラー ❌
- **原因**: ネットワークを分離するとIMDSv2にアクセスできない
- **正解**: ECS/Fargateのタスクロールを使う

---

## 現象──Dockerネットワークの設定次第で結果が変わる

```bash
# EC2インスタンス上で直接実行
$ aws s3 ls
✅ S3アクセス成功

# Dockerコンテナ（bridgeネットワーク）
$ docker run --rm amazon/aws-cli s3 ls
✅ S3アクセス成功

# Dockerコンテナ（ネットワーク分離）
$ docker run --rm --network none amazon/aws-cli s3 ls
❌ Unable to locate credentials
```

**同じEC2、同じIAMロール、なのにネットワーク設定で結果が違う。**

この現象は**Node.jsに限らず、Python、Java、AWS CLI、どの言語・ツールでも同じ**です。  
以下のハンズオンで、なぜネットワーク設定が重要なのかを理解しましょう。

---

## ハンズオン：実際に試してみよう

### 前提条件

EC2インスタンスを作成します：

- **AMI**: Ubuntu 24.04 LTS
- **インスタンスタイプ**: t3.micro
- **IAMロール**: `AmazonS3ReadOnlyAccess` ポリシー、 `AmazonSSMManagedInstanceCore` ポリシー(※以下の説明では、セッションマネージャーでインスタンスに接続をするため。このポリシーをアタッチせず、SSH接続でももちろん可)をアタッチ
- **ユーザーデータ**:
```bash
#!/bin/bash
set -e

# ログファイル設定
LOG_FILE="/var/log/userdata.log"
exec > >(tee -a ${LOG_FILE}) 2>&1

echo "=========================================="
echo "Timestamp: $(date)"
echo "=========================================="

# SWAPファイルの作成（t3.micro用メモリ対策）
echo "[1/6] Creating SWAP file for t3.micro instance..."
dd if=/dev/zero of=/swapfile bs=128M count=16
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# Docker GPGキーの追加
echo "[2/6] Adding Docker's official GPG key..."
apt-get update
apt-get install -y ca-certificates curl unzip
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Dockerリポジトリの追加
echo "[3/6] Adding Docker repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Dockerのインストール
echo "[4/6] Installing Docker..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ubuntuユーザーをdockerグループに追加
echo "[5/6] Adding ubuntu user to docker group..."
usermod -aG docker ubuntu

# AWS CLIのインストール
echo "[6/6] Installing AWS CLI..."
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip
```

### Step 1: EC2上で直接実行（成功パターン）

Session Managerで接続し、以下を実行：

```bash
sudo su - ubuntu

# S3バケット一覧を取得
aws s3 ls
```

**結果**: ✅ バケット一覧が表示される

### Step 2: Dockerコンテナで実行（失敗パターン）

```bash
# ネットワークを分離したDockerコンテナで実行
docker run --rm --network none amazon/aws-cli s3 ls
```

**結果**: ❌ `Unable to locate credentials. You can configure credentials by running "aws configure".`

> **注**: `docker run --rm amazon/aws-cli s3 ls` (ネットワーク指定なし) は成功します。  
> これはデフォルトのbridgeネットワークがIMDSv2にアクセスできるためです。  
> `--network none` で明示的にネットワークを分離すると、IMDSv2にアクセスできなくなります。

### Step 3: コンテナ内からIMDSv2にアクセスしてみる

EC2上では成功：

```bash
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
  -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/iam/security-credentials/
```

**結果**: ✅ ロール名が返ってくる

コンテナ内では失敗：

```bash
docker run --rm --network none curlimages/curl:latest \
  http://169.254.169.254/latest/meta-data/
```

**結果**: ❌ `curl: (7) Failed to connect to 169.254.169.254 port 80 after 0 ms: Could not connect to server`

### Step 4: 構造を理解する

この実験で以下が確認できました：

1. EC2上のプロセスはIMDSv2にアクセス可能
2. **bridgeネットワーク**のDockerコンテナもIMDSv2にアクセス可能
3. **ネットワーク分離**したDockerコンテナはIMDSv2にアクセス不可

---

## 原因──Dockerネットワークモードの違い

### DockerネットワークモードとIMDSv2アクセス

| ネットワークモード | IMDSv2アクセス | 説明 |
|------------------|---------------|------|
| `bridge` (デフォルト) | ✅ 可能 | ホストのネットワークスタックを経由してアクセス可能 |
| `host` | ✅ 可能 | ホストのネットワークを直接使用 |
| `none` | ❌ 不可 | ネットワーク完全分離 |
| カスタムブリッジ | ✅ 可能 | `driver: bridge` なら同じ |

### 実際の構造

```
EC2インスタンス
├── IAMロール（EC2 Instance Profile）✅
│   └── IMDSv2経由で一時認証情報を提供
│
├── bridgeネットワークのDockerコンテナ
│   └── ホスト経由でIMDSv2にアクセス可能 ✅
│
└── ネットワーク分離したDockerコンテナ
    └── IMDSv2にアクセス不可 ❌
```

### なぜbridgeネットワークなら動くのか

EC2のIAMロールは **IMDSv2（Instance Metadata Service v2）** 経由で一時認証情報を提供します：

```bash
# EC2インスタンス上では動く
$ curl -H "X-aws-ec2-metadata-token: $TOKEN" \
  http://169.254.169.254/latest/meta-data/iam/security-credentials/
✅ 一時認証情報が返ってくる
```

**bridgeネットワーク**のDockerコンテナは、ホストのネットワークスタックを経由してIMDSv2（`169.254.169.254`）にアクセスできます。

しかし、**ネットワークを分離**すると：

**IMDSv2にアクセスできない = 認証情報を取得できない = 403エラー**

---

## AWS SDKの認証情報探索順序

```javascript
const AWS = require('aws-sdk');
const s3 = new AWS.S3({ region: 'ap-northeast-1' });
```

このコードは認証情報を明示していないため、AWS SDKが自動的に探します：

1. **環境変数** (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`) → ❌ なし
2. **共有認証情報ファイル** (`~/.aws/credentials`) → ❌ なし
3. **Web Identity Token** (EKS等) → ❌ 該当なし
4. **ECSコンテナ認証情報** (`AWS_CONTAINER_CREDENTIALS_RELATIVE_URI`) → ❌ ECSじゃない
5. **EC2インスタンスメタデータ** (IMDSv2) → ❌ アクセスできない（ネットワーク分離時）

**結果**: 認証情報が見つからず403エラー

> **参考**: [AWS SDK for JavaScript - Credential provider chain](https://docs.aws.amazon.com/sdk-for-javascript/v3/developer-guide/setting-credentials-node.html)  
> Java SDKも同様の順序: [Default credentials provider chain](https://docs.aws.amazon.com/sdk-for-java/latest/developer-guide/credentials-chain.html)

---

## 解決策の比較

### ✅ bridgeネットワークを使う（簡易的）

```yaml
services:
  app-server:
    networks:
      - my-network

networks:
  my-network:
    driver: bridge  # デフォルト
```

**メリット**:
- EC2のIAMロールがそのまま使える
- 環境変数不要

**デメリット**:
- EC2に依存（ポータビリティなし）
- 本番環境では推奨されない

### ❌ IAMユーザーの認証情報を環境変数で渡す

```yaml
services:
  app-server:
    environment:
      - AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
      - AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

**問題点**:
- **長期的な認証情報をコードに埋め込む** = セキュリティリスク
- IAMユーザーの管理が必要（ローテーション、削除忘れ）
- **AWSのベストプラクティスに反する**

### ✅ ECS/Fargateのタスクロール（推奨）

**メリット**:
- コンテナに自動的に認証情報を注入
- 一時認証情報（自動ローテーション）
- ポータビリティあり
- **本番環境の正解**

---

## 比較表

| 環境 | 認証情報の取得方法 | 本番推奨 | 備考 |
|------|------------------|---------|------|
| EC2上で直接実行 | IMDSv2（IAMロール） | ✅ | |
| EC2 + Docker (bridge) | IMDSv2（IAMロール） | △ | EC2依存 |
| EC2 + Docker (IAMユーザー) | 環境変数（長期認証情報） | ❌ | セキュリティリスク |
| ECS/Fargate | タスクロール | ✅ | 推奨 |

---

## 結論

**bridgeネットワークのDockerコンテナは、EC2のIAMロールで動く。**

**しかし、本番環境ではECS/Fargateのタスクロールが適切な選択。**

**己の設計ミスに克つこと、それが闘魂である。** 🔥

---

## 参考資料

- [EC2のIAMロール(IAM Instance profile)は裏でSTSが動いている](https://qiita.com/torifukukaiou/items/eb82619303a9156a8d02)
- [AWS ECS タスクロール公式ドキュメント](https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task-iam-roles.html)

