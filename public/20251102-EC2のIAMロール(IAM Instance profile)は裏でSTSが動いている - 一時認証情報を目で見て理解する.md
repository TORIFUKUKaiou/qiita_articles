---
title: EC2のIAMロール(IAM Instance profile)は裏でSTSが動いている - 一時認証情報を目で見て理解する
tags:
  - AWS
  - IAM
  - STS
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-22T12:03:25+09:00'
id: eb82619303a9156a8d02
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

「EC2にS3アクセス権限を持つIAMロールをアタッチすると、EC2上で`aws s3 ls`が実行できる」

これはAWSでIAMを学んだ誰もが知っている基本ですが、**裏で何が起きているか**を理解している人は意外と少ないのではないでしょうか。何を隠そう、March 27, 2019から一応、[
AWS Certified Solutions Architect – Associate](https://www.credly.com/badges/fa8c9f69-de7c-4dbf-adb1-569164774a78/public_url)を保持し続けている私は理解していませんでした。堂々と恥ずかしげもなく言うことではありませんが、知れた喜びをQiitaという大舞台で公開させていただきます。

「IAMロールは一時的な認証情報を使う」と説明されることがありますが、その実態を体感したことはありますか？

この記事では、EC2インスタンスが`aws s3 ls`を実行する際に**STS（Security Token Service）が発行する一時認証情報**を「目に見える形」で確認し、その仕組みをハンズオンで理解します。一時認証情報の実態を体感できることうけあいです。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7fdc86fe-c99e-475a-aef5-13b3f0b58db8.png)



## 前提知識

### IAMロールとは

- AWSリソース（EC2、Lambda等）に付与する権限
- アクセスキー/シークレットキーを持たない
- 一時的な認証情報を使用

### STSとは

- Security Token Service
- 一時的な認証情報（Temporary Security Credentials）を発行
- 有効期限付き（デフォルト1時間）

## 検証環境

- EC2インスタンス（Amazon Linux 2023）
- IAMロール（S3読み取り権限 + SSM権限）
- AWS Systems Manager セッションマネージャー
- AWS CLI

## ハンズオン：IAMロールとSTSの仕組みを見る

### Step 1: IAMロールの作成（AWSマネジメントコンソール）

#### 1-1. IAMコンソールを開く

1. AWSマネジメントコンソールにログイン
2. サービス検索で「IAM」を検索
3. 左メニューから「ロール」を選択
4. 「ロールを作成」ボタンをクリック

#### 1-2. 信頼されたエンティティを選択

1. **信頼されたエンティティタイプ**: 「AWSのサービス」を選択
2. **ユースケース**: 「EC2」を選択
3. 「次へ」をクリック

**裏で何が起きているか**: 以下の信頼ポリシーが自動生成されます。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
```

**ポイント**: `sts:AssumeRole` がここで登場します。ただし、コンソール操作上は次のステップへと進みます。確認ができるのは1-4の「信頼ポリシー」です。

#### 1-3. 許可ポリシーをアタッチ

1. 検索ボックスに「S3」と入力
2. 「AmazonS3ReadOnlyAccess」にチェック
3. 検索ボックスに「SSM」と入力
4. 「AmazonSSMManagedInstanceCore」にチェック（セッションマネージャー用）
5. 「次へ」をクリック

**ポリシーの説明**:
- `AmazonS3ReadOnlyAccess`: S3の読み取り権限
- `AmazonSSMManagedInstanceCore`: セッションマネージャーで接続するために必要

#### 1-4. ロール名を設定

1. **ロール名**: `EC2-S3-ReadOnly-Role`
2. **説明**: IAM role for EC2 to read S3
3. 「ロールを作成」をクリック

✅ IAMロールの作成完了！

### Step 2: EC2インスタンスの起動（AWSマネジメントコンソール）

#### 2-1. EC2コンソールを開く

1. サービス検索で「EC2」を検索
2. 「インスタンスを起動」ボタンをクリック

#### 2-2. インスタンスの設定

1. **名前**: `IAM-Role-Test`
2. **AMI**: Amazon Linux 2023
3. **インスタンスタイプ**: t3.micro

#### 2-3. IAMロールをアタッチ（重要！）

1. **高度な詳細** セクションを展開
2. **IAMインスタンスプロフィール**: `EC2-S3-ReadOnly-Role` を選択

**ここがポイント**: このドロップダウンで選択することで、EC2がIAMロールを使えるようになります。

#### 2-4. インスタンスを起動

1. 「インスタンスを起動」ボタンをクリック
2. インスタンスが起動するまで待つ

✅ EC2インスタンスの起動完了！

### Step 3: セッションマネージャーでEC2に接続

#### 3-1. EC2コンソールでインスタンスを選択

1. EC2コンソールで起動したインスタンスを選択
2. 「接続」ボタンをクリック
3. 「セッションマネージャー」タブを選択
4. 「接続」ボタンをクリック

**メリット**:
- ✅ SSHキーペア不要
- ✅ セキュリティグループでポート22を開ける必要なし
- ✅ ブラウザだけで接続可能

#### 3-2. セッションマネージャーのターミナルが開く

ブラウザ上でEC2のターミナルが開きます。

```bash
# ec2-userに切り替え
sudo su - ec2-user

# 確認
whoami
# 出力: ec2-user
```

**なぜ切り替えるのか**: セッションマネージャーはデフォルトで`ssm-user`で接続されますが、通常のEC2操作は`ec2-user`で行います。

### Step 4: メタデータエンドポイントから認証情報を確認

#### 4-1. トークンを取得（IMDSv2）

最近のEC2インスタンスは**IMDSv2（Instance Metadata Service Version 2）**がデフォルトで有効になっています。まずトークンを取得する必要があります。

```bash
# トークンを取得（有効期限6時間）
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`

# トークンを確認
echo $TOKEN
# 出力: AQAAANhD... (長い文字列)
```

#### 4-2. IAMロール名を取得

```bash
# トークンを使ってIAMロール名を取得
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/iam/security-credentials/
# 出力: EC2-S3-ReadOnly-Role
```

#### 4-3. 一時認証情報を取得

```bash
# トークンを使って一時認証情報を取得
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/iam/security-credentials/EC2-S3-ReadOnly-Role
```

**出力例**:

```json
{
  "Code" : "Success",
  "LastUpdated" : "2025-11-02T00:30:00Z",
  "Type" : "AWS-HMAC",
  "AccessKeyId" : "ASIAXXXXXXXXXXX",
  "SecretAccessKey" : "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "Token" : "IQoJb3JpZ2luX2VjEDo...(長い文字列)",
  "Expiration" : "2025-11-02T06:45:00Z"
}
```

**重要なポイント**:

1. **AccessKeyId**: `ASIA`で始まる（一時認証情報の証）
2. **SecretAccessKey**: 一時的なシークレットキー
3. **Token**: セッショントークン（STSが発行）
4. **Expiration**: 有効期限（約6時間後）

#### 3-2. 環境変数に設定して使ってみる

```bash
# 一時認証情報を環境変数に設定
export AWS_ACCESS_KEY_ID="ASIAXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEDo..."

# S3バケット一覧を取得
aws s3 ls --region us-east-1
```

**これが動く理由**: STSが発行した一時認証情報を使っているから。

### Step 4: AWS CLIが自動でやっていることを確認

通常、EC2上でAWS CLIを使う際は、環境変数を設定する必要はありません。

```bash
# 環境変数をクリア
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

# それでもS3にアクセスできる
aws s3 ls --region us-east-1
```

**なぜ動くのか？**

AWS CLIは以下の順序で認証情報を探します：

1. 環境変数（`AWS_ACCESS_KEY_ID`等）
2. `~/.aws/credentials`ファイル
3. **IAMロール（メタデータエンドポイント）** ← ここ！

AWS CLIが自動的にメタデータエンドポイントから一時認証情報を取得しています。

### Step 5: 一時認証情報の有効期限を確認

```bash
# 現在の認証情報を確認
aws sts get-caller-identity
```

**出力例**:

```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXXX:i-0123456789abcdef0",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:assumed-role/EC2-S3-ReadOnly-Role/i-0123456789abcdef0"
}
```

**ポイント**: `assumed-role`という文字列が見える。これがSTSを使っている証拠。

#### 有効期限を確認

```bash
# メタデータから有効期限を確認
curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/iam/security-credentials/EC2-S3-ReadOnly-Role | jq .Expiration
# 出力: "2025-11-02T06:45:00Z"
```

有効期限が近づくと、AWS CLIは自動的に新しい一時認証情報を取得します。

## 仕組みの図解

```
┌─────────────┐
│   EC2       │
│  Instance   │
└──────┬──────┘
       │
       │ 1. メタデータエンドポイントにアクセス
       │    http://169.254.169.254/latest/meta-data/iam/...
       │
       ↓
┌─────────────────────────────────────────┐
│  EC2 Instance Metadata Service (IMDS)   │
└──────┬──────────────────────────────────┘
       │
       │ 2. IAMロールを確認
       │
       ↓
┌─────────────┐
│     STS     │  3. AssumeRole API呼び出し
│   Service   │
└──────┬──────┘
       │
       │ 4. 一時認証情報を発行
       │    - AccessKeyId (ASIA...)
       │    - SecretAccessKey
       │    - SessionToken
       │    - Expiration
       │
       ↓
┌─────────────┐
│   EC2       │  5. 一時認証情報を使ってAWS APIを呼び出し
│  Instance   │
└─────────────┘
```

## 実験：一時認証情報をローカルPCで使ってみる

EC2から取得した一時認証情報を、ローカルPCで使ってみます。

```bash
aws s3 ls --region us-east-1

Unable to locate credentials. You can configure credentials by running "aws configure".
```

何も認証情報を持っていないのでアクセスできません。


```bash
# ローカルPCで実行
export AWS_ACCESS_KEY_ID="ASIAXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export AWS_SESSION_TOKEN="IQoJb3JpZ2luX2VjEDo..."

# S3にアクセスできる
aws s3 ls --region us-east-1

# 誰としてアクセスしているか確認
aws sts get-caller-identity
```

**出力**:

```json
{
    "UserId": "AIDAXXXXXXXXXXXXXXXXX:i-0123456789abcdef0",
    "Account": "123456789012",
    "Arn": "arn:aws:sts::123456789012:assumed-role/EC2-S3-ReadOnly-Role/i-0123456789abcdef0"
}
```

**重要**: ローカルPCからでも、EC2のIAMロールとして認識されている！

## セキュリティ上の注意点

### 一時認証情報の有効期限

一時認証情報には有効期限があり、期限が切れると使えなくなります。

```bash
# 有効期限を過ぎると...
aws s3 ls --region us-east-1
# エラー: The security token included in the request is expired
```

**重要なポイント**:
- 一時認証情報は**自動的にローテーション**される
- 新しい認証情報は**有効期限の5分前**に利用可能になる
- AWS CLI/SDKは自動的に新しい認証情報を取得する

有効期限が切れると使えなくなります。これがセキュリティ上の利点です。

**参考**: [Retrieve security credentials from instance metadata - Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-metadata-security-credentials.html)

## よくある質問

### Q1: AccessKeyIdが`ASIA`で始まるのはなぜ？

**A**: 一時認証情報の識別子です。

- `AKIA`: 長期的な認証情報（IAMユーザー）
- `ASIA`: 一時的な認証情報（STS）

### Q2: SessionTokenは何のため？

**A**: 一時認証情報であることを証明するためです。AccessKeyIdとSecretAccessKeyだけでは不十分で、SessionTokenも必要です。

### Q3: 有効期限はどうやって決まる？

**A**: デフォルトは1時間ですが、最大12時間まで延長できます（IAMロールの設定による）。

### Q4: 発行済みの一時認証情報を無効化できる？

**A**: 直接無効化はできませんが、IAMロールの「セッションを取り消す」機能で対応できます。

既に発行された一時認証情報（AccessKeyId、SecretAccessKey、SessionToken）は、EC2を停止・終了しても有効期限（通常6時間）まで使用可能です。

**セキュリティリスク**:
- EC2を削除しても、漏洩した認証情報は有効期限まで悪用される可能性がある
- 環境変数をunsetしても、コピーされた認証情報は有効

**対処方法: IAMロールのセッション取り消し**

1. IAMコンソールを開く
2. 対象のロール（例: `EC2-S3-ReadOnly-Role`）を選択
3. 「Revoke sessions」タブを選択
4. 「Revoke active sessions」ボタンをクリック

これにより、特定時刻以前に発行されたすべての一時認証情報が無効化されます。

**仕組み**:
- ロールに`AWSRevokeOlderSessions`ポリシーが自動的にアタッチされる
- 取り消し実行時刻より前に発行された認証情報はすべて拒否される
- 新しい認証情報は通常通り発行される

**参考**: [Revoke IAM role temporary security credentials - AWS IAM](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_revoke-sessions.html)

## まとめ

### 学んだこと

1. ✅ EC2のIAMロールは、裏でSTSが一時認証情報を発行している
2. ✅ メタデータエンドポイントから認証情報を取得できる
3. ✅ AWS CLIは自動的にメタデータエンドポイントを使う
4. ✅ 一時認証情報には有効期限がある（セキュリティ）
5. ✅ `ASIA`で始まるAccessKeyIdは一時認証情報の証

### IAMロールを使うメリット

- ✅ アクセスキーをEC2に保存する必要がない
- ✅ 認証情報が自動的にローテーションされる
- ✅ 有効期限があるのでセキュア
- ✅ IAMロールの権限を変更すれば、すぐに反映される

### 実務での活用

```bash
# EC2上でAWS CLIを使う場合
# 何も設定しなくてOK（IAMロールが自動的に使われる）
aws s3 cp myfile.txt s3://my-bucket/

# Lambdaでも同じ仕組み
# Lambda実行ロールが自動的に使われる
```

## おわりに

IAMロールとSTSの仕組みを「目に見える形」でご理解いただけましたでしょうか。

普段何気なく使っているAWS CLIの裏側では、STSが一時認証情報を発行し、セキュアにAWS APIを呼び出しています。この仕組みを理解することで、より安全なAWSインフラを構築できます。

**迷わず使えよ、使えばわかるさ。** 🔥

---

**参考リンク**:
- [IAM roles for Amazon EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/iam-roles-for-amazon-ec2.html)
- [Using temporary security credentials with the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-role.html)
- [AWS STS API Reference](https://docs.aws.amazon.com/STS/latest/APIReference/welcome.html)
