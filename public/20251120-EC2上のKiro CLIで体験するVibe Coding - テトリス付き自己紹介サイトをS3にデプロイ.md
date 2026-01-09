---
title: EC2上のKiro CLIで体験するVibe Coding - テトリス付き自己紹介サイトをS3にデプロイ
tags:
  - AWS
  - 闘魂
  - AmazonQDeveloperCLI
  - Kiro
  - KiroCLI
private: false
updated_at: '2026-01-08T21:47:10+09:00'
id: 29e217d5f7483d4218aa
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
Kiro CLI(旧Amazon Q Developer CLI)をEC2にインストールして、Vibe Codingで静的ウェブサイトのコンテンツの制作ならびに、デプロイまでを行います。

参考:  [S3への静的ウェブサイトホスティング](https://docs.aws.amazon.com/ja_jp/AmazonS3/latest/userguide/WebsiteHosting.html)


## 必要なもの
必要なものを列挙します。
- 楽しむ気持ち
- 準備をいとわない姿勢
- AWS Builder ID
- (当然) AWSアカウント

### AWS Builder ID
AWS Builder IDの取得方法は、以下のページを参考にしてください。
参考: [Create your AWS Builder ID](https://docs.aws.amazon.com/signin/latest/userguide/create-builder-id.html)

取得したらログインしておいてください。すぐ使います。

このIDがあると、[AWS Skill Builder](https://skillbuilder.aws/)というAWS謹製の学習コンテンツを学べるIDにもなります。無料で学べるコンテンツも充実しているので、持っておいて損はないIDです。ぜひつくりましょう。

### AWSアカウント
当然、AWSアカウントは必要になります。すでにお持ちの方はスキップしてください。

参考: [AWS アカウント作成の流れ](https://aws.amazon.com/jp/register-flow/)

---

## ハンズオン

ハンズオンの流れを示します。

1. EC2インスタンスの作成
1. Kiro CLIの[Authentication](https://kiro.dev/docs/cli/authentication/)
1. Vibe Coding & Deploy

以下、ひとつひとつをゆっくりと、もう少し詳しく説明します。

### 1. EC2インスタンスの作成

以下のEC2インスタンスを立ち上げます。
- OS: Ubuntu 24.04
- インスタンスタイプ: t3.medium
- VPC, セキュリティグループ: default
- EBS: GP3 16GB
- IAMインスタンスプロファイルに以下のIAMポリシーを持つIAMロール
  - AWS Academy環境をお使いの方は、あらかじめ用意されている`LabInstanceProfile`をお使いください
  - AmazonSSMManagedInstanceCore: セッションマネージャーで接続するため
  - AmazonS3FullAccess: 構築するシステムに応じて、広げたり、狭くしてください。後述のプロンプト例でもちょっと広いのかもしれませんが、とりあえず事足りるマネージドな管理ポリシーを使っています
- ユーザーデータは以下をお使いください。Kiro CLIとAWS CLIのインストールをしています

```bash
#!/bin/bash
apt-get update -y

# AWS CLI インストール
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
apt-get install -y unzip
unzip -q awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

# Kiro CLI インストール
wget https://desktop-release.q.us-east-1.amazonaws.com/latest/kiro-cli.deb
dpkg -i kiro-cli.deb
apt-get install -f -y
rm kiro-cli.deb
```

CDKのお心得がある方は、 https://github.com/haw/strong-system-dot-com/tree/main/docs/day5/cdk をご覧いただいたほうが通じるかもしれません。


### 2. Kiro CLIの[Authentication](https://kiro.dev/docs/cli/authentication/)
無事にEC2インスタンスが立ち上がったとします。


#### 2-1. セッションマネージャーで接続
セッションマネージャーで接続をします。

![スクリーンショット 2025-11-20 8.35.32.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1d739c71-a1c3-44dc-809c-d952c5e4572c.png)

ユーザを`ubuntu`に切り替えます

```bash
sudo su - ubuntu
```

![スクリーンショット 2025-11-20 8.38.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e928fc8a-bf15-4b9b-93ee-cca186284bba.png)

#### 2-2. Kiro CLIの[Authentication](https://kiro.dev/docs/cli/authentication/)
いよいよ本題です。Kiro CLIの[Authentication](https://kiro.dev/docs/cli/authentication/)をします。

```bash
kiro-cli login --use-device-flow
```

![スクリーンショット 2025-11-20 8.40.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/853e3f65-5121-4c27-bd21-fb14cac15dfb.png)

この資料では「Use with Builder ID」で進めます。エンターキーを押します。
そうすると以下のようなURLが表示されますので、AWS Builder IDでログインしているブラウザに貼り付けてアクセスをします。

![スクリーンショット 2025-11-20 8.41.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dcdcf33c-5977-466a-829e-bb1ec20a74cf.png)

### 2-3. Open this URL
あとは迷わず「次へ」「次へ」です。その一足がVibe Codingへと近づいています。

![スクリーンショット 2025-11-20 8.45.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dc380815-bfed-4116-8748-ca443c6595c6.png)

![スクリーンショット 2025-11-20 8.45.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4b34e097-c66f-4c50-a5cd-1c183eb1c27f.png)

![スクリーンショット 2025-11-20 8.45.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1b72c73b-197e-403a-a726-3c4080c6673f.png)

ここまでくれば、画面の案内の通りに、このページは閉じても大丈夫です。

セッションマネージャーの方がどうなっているかというと、Device authorizedされています :tada::tada::tada:

![スクリーンショット 2025-11-20 8.46.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b18f0eea-efa0-4434-817b-d9293d34b30d.png)

おめでとうございます:tada::tada::tada:
準備は整いました。


### 3. Vibe Coding & Deploy
準備、お疲れさまでした。あとはけっこうあっけないです。`kiro-cli chat`でチャットを開始します。起動したディレクトリにファイルが作られるので、必要に応じてディレクトリを掘ったりして移動してください。大学生のころのことを思い出して、この記事ではホームディレクトリに全部置きます。

```bash
kiro-cli chat
```

![スクリーンショット 2025-11-20 8.53.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/40eae8c1-f5bf-4adb-8145-67231e2c0963.png)

あとは、プロンプトを打ち込んで`y`を押していけば完成です。
プロンプト例を示します。

```txt
「ようこそ Awesome YAMAUCHI のページへ」というタイトルで、自己紹介ページを作成してください。
私の名前は山内修、会社はストロングシステム、住んでいる場所は福岡県飯塚市です。
山と川に囲まれた自然豊かな土地です。
会社の横には https://www.haw.co.jp/wp-content/uploads/2019/06/haw_logo_2019_06.png の写真を掲載してください。
これをバージニア北部リージョンのAmazon S3バケットにindex.htmlとして配置し、
ウェブサイトホスティング機能を有効にして、一般公開してください。
HTML以外にCSSやJSファイルを作成していただいてもかまいません。
バケット名はawesomeに続けて今日の日付を8桁 + ランダムな文字列10桁で設定してください。
サイト訪問者を楽しませるためテトリスを実装してください。
```

プロンプトはご自由にアレンジしてください。
ノリで`y`を数回押している間に完成です。

### Tips
- プロンプトを打ち込むときに改行したい: Ctl + J です
- `/usage`コマンドで、Kiro CLIの残使用量を見ることができます。このプロンプトを一回流して、`y`を複数回押したとして、だいたい1 credit未満です
- 離席などしてセッションマネージャーの接続がきれた。再開したい。そんなときも安心です。さきほどKiro CLIを起動した同じディレクトリで、`kiro-cli chat --resume`です
- Kiro CLIのヘルプをみたい: `/help`です
- Kiro CLIを終わりたい: `/quit`です

## 完成例
完成例です。テトリスをプレイできます。

![スクリーンショット 2025-11-20 8.58.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6d012f8b-1f60-46f4-b301-28a3a8efd43b.png)


## さいごに
Kiro CLI(旧Amazon Q Developer CLI)をEC2にインストールして、Vibe Codingで静的ウェブサイトのコンテンツの制作ならびに、デプロイまでを行いました。
みなさまご存知の通り、「テトリス作って」でテトリスができてしまうことが驚きですし、Kiro CLIはまさにAWSの専門家です。

**AWSのことはKiro CLIに聞け！**

## おまけ

```
> ありがとうございます。いいサイトができました。もっとモダンで刺激的なサイトに作り変えてください。
```

早速、ノリで変更してもらいました。
モダンで刺激的なサイトになりました！

![スクリーンショット 2025-11-20 9.09.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a1a68e6a-eb3f-4786-a9c5-978bae3f752c.png)

![スクリーンショット 2025-11-20 9.09.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4a337214-9256-4937-81f4-d9dd66ac8ce2.png)

![スクリーンショット 2025-11-20 9.10.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/162bbf0a-d533-4899-960b-fa5ca2a9c947.png)


---


## ⚠️ 注意事項

### S3公開設定の責任について（重要）

S3の静的ウェブサイトホスティングは、自分で「公開する」と決めたものだけが、世界に公開される仕組みです。
AWSはデフォルトでパブリックアクセスをブロックしています。
つまり、S3は「危険だから閉じておく」思想で設計されています。

今回は学習目的のため、
- パブリックアクセスの許可
- `s3:GetObject` を許可するバケットポリシー

を明示的に設定します。

重要なのは、「知らないうちに公開される」ことはないという点です。
公開されるのは、自分が公開したときだけです。
だからこそ、S3を使うときはそこに置いてよい情報かを必ず自分で判断してください。

### IAMにおける最小権限の原則について

今回のハンズオンでは、理解と成功体験を優先するため、`AmazonS3FullAccess` のような広い権限を使用します。

しかし、実際のシステム開発・運用ではこれは推奨されません。

IAMの基本原則は 最小権限（Least Privilege） です。
- 必要な操作だけ
- 必要なリソースだけ
- 必要な期間だけ

を許可します。

本資料では「なぜ動くか」を体験する。
実務では「なぜ制限するか」を考える。
本資料では前者に集中します。




---

## 参考

- [EC2でAmazon Q Developer CLIを触ってみよう！](https://qiita.com/natsumi_a/items/906b8d48494ca0948fd4)
