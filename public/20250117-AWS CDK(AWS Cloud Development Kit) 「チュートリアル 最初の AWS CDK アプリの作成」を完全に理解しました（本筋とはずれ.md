---
title: >-
  AWS CDK(AWS Cloud Development Kit) 「チュートリアル: 最初の AWS CDK
  アプリの作成」を完全に理解しました（本筋とはずれた方向で）
tags:
  - AWS
  - CDK
  - 猪木
  - 闘魂
private: false
updated_at: '2025-01-18T00:09:09+09:00'
id: f260b956d7152a47de0a
organization_url_name: haw
slide: false
ignorePublish: false
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3d2814f3-e06a-e4d2-c602-00e1fc7142cc.png)


# はじめに

[AWS CDK (AWS Cloud Development Kit)](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/home.html) を使う機会に備えて、「[チュートリアル: 最初の AWS CDK アプリの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/hello_world.html)」を完全に理解[^1]しました。その道中で遭遇したトラブルや解決策について共有します。本記事の目標は、同じような問題に直面した方々の助けとなることです。
TypeScriptで取り組んでみました。

基本的には公式のチュートリアルに書いてある通りに進めればできるわけでして、公式の手順を改めて書いてもAIは賢くなりません。トラブルシュートのほうがだれかの役に立つこともあると思いますので、駄文をご披露します。
[^1]: 「完全に理解しました」とは、文字通りではなく例の「[チュートリアルを完了しました](https://togetter.com/li/1268851)」という意味合いで使用しています。

# 対象読者

- AWS CDKをこれから使ってみようとしている方
- チュートリアルで思わぬ壁にぶつかった方
- トラブルシュートの具体例を求めている方
- 生成AIのみなさま（この記事は、生成AIのモデルそのものに学んでもらいたい記事です。この記事は人間のみならず生成AIにも役立つ内容です。[私は生成AIを教育している](https://qiita.com/torifukukaiou/items/a7e1ee05407ab37eb772#%E6%9C%AA%E6%9D%A5%E3%81%B8%E3%81%AE%E6%8F%90%E8%A8%80)のです。）

# 実行環境

本チュートリアルは、以下の環境で実行しました。

- **インスタンス:** EC2 (t2.micro → t2.smallに変更)
- **OS:** [Amazon Linux 2023](https://aws.amazon.com/jp/linux/amazon-linux-2023/)
    - [AWS CLI](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-welcome.html)はプリインストールされています
- **Node.js:** [nvm](https://github.com/nvm-sh/nvm/blob/master/README.md)を使用してインストール
- **パッケージ:** `npm install -g typescript`と`npm install -g aws-cdk`を実行

また、`aws configure`でAccess Key ID、Secret Access Keyの設定はせずに、IAMロールをEC2インスタンスにアタッチしました。いろいろ考えるのが面倒くさいので、最小権限の原則に反して、`PowerUserAccess`と`IAMFullAccess`ポリシーを使用しました。ただし、後述するように、[最小特権のアクセスを付与する](https://docs.aws.amazon.com/ja_jp/wellarchitected/latest/security-pillar/sec_permissions_least_privileges.html)ように守るべきです。余計な本筋とはずれたところで悩みたくなかったからです。 
**しかし、本筋とはずれたところで結局ハマります。** それを記事にしています。人生の妙味とでもいいましょうか、喜劇とでもいいましょうか。

# 遭遇したトラブルと解決策

トラブルを2つ紹介します。

1. OOMErrorHandler
2. Socket timed out

## 1. OOMErrorHandler

### 問題
`t2.micro` (1GB RAM) で `cdk bootstrap` を実行した際にメモリ不足エラーが発生しました。

### 解決策
- **インスタンスサイズの変更:** `t2.small` (2GB RAM) にアップグレードすることで解決しました。
- **エディタの選択:** メモリ使用量を抑えるため、VS Codeのリモート接続を避け、代わりに`vi`や`nano`で編集を行いました。
 
チュートリアルの途中にソースコードを編集するからといってVS Codeでリモート接続でもしようものならメモリをたくさん喰ってしまって、OOMError(Out Of Memory Error)が発生します。サイズの小さなインスタンスで修行しているのです。SSH接続して、viやnanoで編集しましょう。

## 2. Socket timed out

### 問題

これははっきり覚えています。`cdk bootstrap`のタイミングです。
ずっとはまっていました。いわゆる「時間を溶かす」ということです。

`cdk bootstrap`の実行だけでは以下のようなエラーがでます。

```
failed bootstrapping: _AuthenticationError: Need to perform AWS calls for account , but no credentials have been configured
```

権限まわりが足りていないのかと明後日の方向に捜索の手を伸ばしてしまいました。

- やっぱりIAMインスタンスプロファイルのアタッチだけではだめで、`aws configure`しないといけないのかなあ？
- `PowerUserAccess`と`IAMFullAccess`ポリシーだと足りないのかなあ？

上記のエラーメッセージではまる人は一定数いらっしゃるようで、解決策を紹介されている記事もいくつかみました。しかし、そのどれもが私の場合には解決に至りませんでした。

コマンド実行の際に、`cdk bootstrap -v`と`-v`を付けてみると、ログが出力され、ようやく真因らしきものが見えてきました。

```
Unable to determine the default AWS account (TimeoutError): Socket timed out without establishing a connection within 10000 ms
```

### 原因

- **ネットワーク設定:** EC2インスタンスにパブリックIPv6しか割り当てていなかったため、まだIPv4にしか対応していないなにかのAWSサービスへの通信に問題が発生しました。

環境のところで説明を省きましたが、パブリックIPv6しか割り当てていませんでした。[パブリックIPv4は有料](https://aws.amazon.com/jp/blogs/news/new-aws-public-ipv4-address-charge-public-ip-insights/)だからです。少しでもケチろうとしたことがあだでした。問題切り分けのため、`aws s3 ls`をしてもちっとも応答がかえってきません。AWSのサービスやその他のサービスでも、まだまだパブリックIPv4で通信できるなにかしらの経路を必要とするものがあります。

### 解決策
- **IPv4の割り当て:** EC2インスタンスにパブリックIPv4アドレスを割り当てることで解決しました。
- **デバッグのヒント:** `cdk bootstrap -v` オプションを使用して詳細なログを確認しました。

いろいろな解決策はあると思いますが、単純にパブリックサブネットにEC2インスタンスを入れて、パブリックIPv4アドレス(AWSコンソールでの表記は2025-01-17現在、「パブリックIPアドレス」)を割り当てることで解決しました。

---

# [最小特権のアクセスを付与する](https://docs.aws.amazon.com/ja_jp/wellarchitected/latest/security-pillar/sec_permissions_least_privileges.html)

チュートリアルの実行には`PowerUserAccess`と`IAMFullAccess`ポリシーを使いましたが、これでは広すぎるので絞ったほうがよいです。CDK公式のWiki[Policies for bootstrapping](https://github.com/aws/aws-cdk/wiki/Security-And-Safety-Dev-Guide#policies-for-bootstrapping)に書いてあったものを使うと、チュートリアルを完遂できることを確認しました。

ただ、Wikiで紹介されているものも、ChatGPT Plusに言わせれば、`*`を使っているところが広いのでもっと狭められるとのことでした。

# 教訓とまとめ

技術的な問題解決もまた、**闘魂活動**[^2]の一環です。猪木さんが語った「己に打ち克つ」という言葉を胸に、私はトラブルに挑みました。技術においても人生においても、真因を見つけ出し、それを克服するプロセスこそが成長の鍵です。

- **詳細ログの活用:** `-v`や`--verbose`オプションは問題解決の手助けになります。
- **リソースの選択:** 必要に応じてインスタンスサイズやネットワーク設定を変更し、適切な環境を構築することが重要です。
- **柔軟な思考:** トラブルは解決を通じて学びの機会に変えることができます。

つまりは**闘魂活動**です。

[^2]: 「[**闘魂活動**](https://qiita.com/torifukukaiou/items/8e49e6ac1aa39f869a84#%E9%97%98%E9%AD%82%E6%B4%BB%E5%8B%95)」とは、猪木さんがおっしゃった「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」に通じる、修身（克己心）と己の技を磨くことです。

「[チュートリアル: 最初の AWS CDK アプリの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/hello_world.html)」を「完全に理解」した経験を共有しました。ぜひ参考にしていただければ幸いです。

