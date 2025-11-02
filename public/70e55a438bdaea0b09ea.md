---
title: MinIOのDocker ImageをREADMEを参考に作ってみる
tags:
  - Docker
  - minio
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-01T14:16:43+09:00'
id: 70e55a438bdaea0b09ea
organization_url_name: null
slide: false
ignorePublish: false
---
:::note info
**Qiita Advent Calendar 2025**
今年もこの季節がいよいよ始まりました :tada::tada::tada:
誰よりもこの日を待ちわびていたと自負しております。

2024年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

https://qiita.com/advent-calendar/2025


## はじめに

:::note info
この記事は社内ハッカソン、通称[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)での成果です。
:::

[オープンソースソフトの「MinIO」がDockerイメージの無料配布を停止し大炎上](https://gigazine.net/news/20251023-minio-stops-distributing-free-docker-images/)という話があります。

それぞれに言い分は、イーブンです。引き分けです。

OSSとして公開されていることに感謝すべきかもしれません。
他の信用できる団体からのDockerHubへのアップロードは停止しており、必要となれば自分でビルドするのが一番信頼できるかと思います。
そのへんの背景はさておき。

Dockerコンテナとして動かしたいことがあるかもしれません。幸い、古いイメージはDockerHubで公開され続けていますが、更新されることはないので自分で作るしかありません。[README](https://github.com/minio/minio/blob/master/README.md)にそう書いてありますので。

> Important: The MinIO community edition is now distributed as source code only. We will no longer provide pre-compiled binary releases for the community version.

自分で[MinIO](https://github.com/minio/minio)のDocker imageを作ってみましたという話です。

## 手順

[README](https://github.com/minio/minio/blob/master/README.md)にヒントらしきことは書いてあるし、`Dockerfile*`も置いてあるのでがんばれば自分でイメージをビルドすることはできそうです。しかし、「わかっている人」にしかわからない書き方なので実際にやってみました。

Claude Desktop(無料プラン)に相談しながら進めました。いろいろと右往左往、試行錯誤はありましたが、最終的にうまくいった手順を書いておきます。


# MinIO Docker Image ビルド手順（完全版）

## 前提条件
- EC2上のUbuntu (x86_64)
- Docker インストール済み

**それ以外は不要。Goのインストールも、ホスト上でのビルドも不要。**

---

## 手順

### 1. MinIO リポジトリのクローン
```bash
cd ~
git clone https://github.com/minio/minio.git
cd minio
```

---

### 2. 最新リリースバージョン取得
```bash
git fetch --tags
LATEST_RELEASE=$(git tag | grep '^RELEASE\.' | sort -V | tail -1)
echo "最新バージョン: $LATEST_RELEASE"
```

---

### 3. 最新バージョンをチェックアウト
```bash
git checkout ${LATEST_RELEASE}
```

---

### 4. Dockerfile.source を作成
```bash
cat > Dockerfile.source << 'EOF'
FROM golang:1.24-alpine AS build

ENV GOPATH=/go
ENV CGO_ENABLED=0

WORKDIR /build

# 必要なツール
RUN apk add --no-cache ca-certificates

# ホストのソースをコピー
COPY . /build/minio

# MinIOをビルド
RUN cd /build/minio && \
    go build -o /go/bin/minio

# 最終イメージ
FROM alpine:latest

COPY --from=build /go/bin/minio /usr/bin/minio
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

RUN chmod +x /usr/bin/minio && \
    mkdir -p /data

EXPOSE 9000 9001

ENTRYPOINT ["/usr/bin/minio"]
CMD ["server", "/data", "--console-address", ":9001"]
EOF
```

---

### 5. Docker Imageをビルド
```bash
docker build \
  -f Dockerfile.source \
  -t myminio:${LATEST_RELEASE} \
  -t myminio:latest \
  .
```

`docker build`は、気持ち10分くらいです。

---

### 6. コンテナ起動
```bash
docker run -d \
  --name minio-server \
  -p 9000:9000 \
  -p 9001:9001 \
  -e MINIO_ROOT_USER=minioadmin \
  -e MINIO_ROOT_PASSWORD=minioadmin \
  -v /tmp/minio-data:/data \
  myminio:latest

# ログ確認
docker logs minio-server

# 動作確認
curl http://localhost:9000/minio/health/live
```

最後の`curl`コマンドは何も標準出力には、表示されません。

---

### 7. ブラウザでアクセス
```
http://<EC2のパブリックIP>:9001

ユーザー名: minioadmin
パスワード: minioadmin
```

---

## クリーンアップ
```bash
docker stop minio-server
docker rm minio-server
docker rmi myminio:latest
sudo rm -rf /tmp/minio-data
```

---

## 必要なもの
- Ubuntu
- Docker
- git

**以上。Goは不要。全部Dockerの中で完結。**

---

:tada::tada::tada: 

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6315ab27-3960-4b05-9ca0-63237dc04593.png)


:tada::tada::tada: 


## 実行環境

順番は前後しますが、今回はEC2インスタンスで実行しました。

- AMI(OS): Ubuntu 24.04
- インスタンスタイプ: t3.medium
- セキュリティグループで、インバウンドの9001番ポートを開けました
- EBSサイズ: 20GB以上あればよいかと思います（私は30GBで実施しました。使用量は12GBほどでした）


### ユーザーデータ

SWAP領域の設定とDockerのインストールをしています。

```bash
#!/bin/bash
set -e

# ログファイル設定
LOG_FILE="/var/log/userdata.log"
exec > >(tee -a ${LOG_FILE}) 2>&1

echo "=========================================="
echo "Day 1: EC2 Setup Script Started"
echo "Timestamp: $(date)"
echo "=========================================="

# SWAPファイルの作成（t3.micro用メモリ対策）
echo "[1/5] Creating SWAP file for t2.micro instance..."
dd if=/dev/zero of=/swapfile bs=128M count=16
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile swap swap defaults 0 0' >> /etc/fstab

# Docker GPGキーの追加
echo "[2/5] Adding Docker's official GPG key..."
apt-get update
apt-get install -y ca-certificates curl
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

# Dockerリポジトリの追加
echo "[3/5] Adding Docker repository to Apt sources..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

# Dockerのインストール
echo "[4/5] Installing Docker..."
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# ubuntuユーザーをdockerグループに追加
echo "[5/5] Adding ubuntu user to docker group..."
usermod -aG docker ubuntu
```

## ハウッカソン

冒頭申し上げました、[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)についてご説明します。
私が所属している[**ハウ**インターナショナル](https://www.haw.co.jp/)という社名とハッカソンを組み合わせてそう呼ばれています。毎週月末の木曜に開催をしています。

[レイダック](https://www.rayduck1986.com/)という福岡飯塚市にある老舗のハンバーガーショップのハンバーガーを食べることが定番化しており、いかにも本場感のあるハッカソンを開催しています。

## さいごに

[README](https://github.com/minio/minio/blob/master/README.md)で、だいたい言わんとしていることはわかりますが、いざ必要となったときにすぐにできるかどうかわからなかったので、必要とはしない「いま」だからこそ逆に試行錯誤をしてみました。Claude Desktop(無料プラン)ががんばってくれました。

この記事が、どなたかの助けになれば幸いです。
