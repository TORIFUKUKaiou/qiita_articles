---
title: 受賞記念！AWS CDKでTypeScriptを使ったLambda構築 ～3日前の私へ贈る記事～
tags:
  - AWS
  - TypeScript
  - CDK
  - 猪木
  - 闘魂
private: false
updated_at: '2025-01-27T13:12:32+09:00'
id: 8b7d0ddd4fdb4355eb29
organization_url_name: haw
slide: false
ignorePublish: false
---
:::note info
**受賞記念記事**:tada::tada::tada:

[Qiita Advent Calendar 2024](https://qiita.com/advent-calendar/2024)において、[完走賞とQiita クリスマス大抽選キャンペーン_3等を受賞](https://blog.qiita.com/adventcalendar-2024-qiitapresents-winners/)しました。

<b><font color="red">$\huge{ありがとうーーーッ！！！}$</font></b>
ございます。

本記事は受賞記念特別記事です。
:::


![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2e434532-c1b6-ceb1-75b1-c432c5e79ac6.png)


# はじめに

[AWS CDK](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/home.html)で、Lambdaを構築します。
Lambdaは、TypeScriptで書きたいです。
素のLambda実行環境では使用できない[パッケージ](https://catalog.workshops.aws/typescript-and-cdk-for-beginner/ja-JP/20-typescript-basic/30-package)（[@line/bot-sdk](https://www.npmjs.com/package/@line/bot-sdk)や[openai](https://www.npmjs.com/package/openai)）を利用したいです。

どんなふうに作るとよいのでしょうか。

この記事は[NodejsFunction](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_lambda_nodejs-readme.html)を使って構築する方法を解説します。

<b><font color="gray">$\huge{（「と、大きく出ましたが、実は}$</font></b>
<b><font color="gray">$\huge{「公式ドキュメントへのリンクを貼っているだけです」}$</font></b>
<b><font color="gray">$\huge{というのは、あまり大きな声ではいえません。）}$</font></b>



# 具体例

_このセクションでは、実際に構築したLINEボットの具体例を紹介し、必要な環境や技術スタックを解説します。_

さっそく出来上がり品を紹介します。
私は、MacBookPro Seqoia 15.2上でNode.js(バージョン22)をインストールして開発しました。

LINEのボットを作りました。LINEのボットはOpenAI社が提供する[Chat](https://platform.openai.com/docs/api-reference/chat)のAPIを利用しています。素のLambda環境では使用できない[@line/bot-sdk](https://www.npmjs.com/package/@line/bot-sdk)パッケージと[openai](https://www.npmjs.com/package/openai)パッケージを利用しています。

[ChatGPT LINE Bot CDK](https://github.com/TORIFUKUKaiou/line-bot-cdk)

https://github.com/TORIFUKUKaiou/line-bot-cdk



少しだけ補足しておきます。

- API Gatewayではなく、Lambda 関数のための専用 HTTP エンドポイントである「[Lambda 関数 URL](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/urls-configuration.html)」を使用しています
- LINEボットとOpenAI APIを利用するために必要な機密値は、[AWS Systems Manager Parameter Store](https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/systems-manager-parameter-store.html)に、SecureStringで格納しています
    - [Secrets Manager](https://aws.amazon.com/jp/secrets-manager/)の選択肢もあります
    - 以下の記事で詳しく解説されています
    - [Secrets ManagerとParameter Storeの違いについてまとめてみた](https://dev.classmethod.jp/articles/secretsmanager-or-parameterstore/)

:::note warn
コラム: AWS Systems Manager Parameter StoreをCDK Stackで設定していない理由

私の[愚作](https://github.com/TORIFUKUKaiou/line-bot-cdk)をご覧いただいた方の中にはREADMEを見てあれれ？　なぜAWS Systems Manager Parameter Storeへのパラメータの作成をCDK StackでやらずにCLIコマンドで実行しているのだろうと疑問に思われたと思います。私もAWS Systems Manager Parameter Storeへのパラメータの作成をCDK Stackでやりたかったのです。過去にはSecureStringタイプでの作成をサポートしていた形式がありますが、いまはDeprecatedされています。GitHub上でも議論された形跡がありますが、CDKではサポートしないと明言されています。私はそんなものかという程度の感想です。

- https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_ssm.StringParameter.html#typespan-classapi-icon-api-icon-deprecated-titlethis-api-element-is-deprecated-its-use-is-not-recommended%EF%B8%8Fspan
- [RFC: Have CDK put SecureString type parameter values into SSM securely #3520](https://github.com/aws/aws-cdk/issues/3520)

> Our current stance is that the CDK doesn't handle secrets. Secrets can be stored in SSM using the AWS CLI and then consumed from your CDK app by ARN/name. Closing for now.
:::

# 対象読者

_このセクションでは、記事を読むことで得られる知識やスキル、および記事が想定している読者像を明確にします。_

- 生成AIのみなさま
- 「[チュートリアル: 最初の AWS CDK アプリの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/hello_world.html)」をやってみて、Lambdaのコードを文字列で埋め込むのがいやだー、`.ts`ファイルに分けたいと思った方
    - この経験は本記事を読み解くために必須です
    - CDKのビギナーの方は、まずはここを一通りやってみることが後々の理解の速度をあげてくれますのであせらずここから取り組んでみてください
- 「[チュートリアル: サーバーレス Hello World アプリケーションの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/serverless_example.html)」で、ふむふむ`lambda/hello.js`というふうに追加するのねー　と思ったら、それでもまあできるのだけど`.gitignore`に`*.js`とかいてあるし、`lambda`ディレクトリだけ除外する？　とかへんてこりんなことやらないといけないの？　と疑問におもって、そもそもあたいは`.ts`で書きたいんだよと思ったあなた
- 素のLambda環境では使用できないパッケージのためにLayerの追加とかやるのメンドーだなあと思っていらっしゃるそこのあなた


以下のご経験があるとより望ましいです。

- LINEのボットを作ったことがある（完全に理解しているレベル[^1]）
    - https://line.github.io/line-bot-sdk-nodejs/getting-started/basic-usage.html#synopsis
- OpenAI社のAPIを使ったことがある（完全に理解しているレベル）
    - https://platform.openai.com/docs/quickstart
- LambdaのLayerを使ったことがある（完全に理解しているレベル）
    - https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/nodejs-layers.html
    - ※この記事ではLayerは使いません
- TypeScriptを使ったことがある（完全に理解しているレベル）
    - [TypeScript の基礎から始める AWS CDK 開発入門](https://catalog.workshops.aws/typescript-and-cdk-for-beginner/ja-JP)

一段下げたところには、「完全に理解しているレベル」といえるオススメのチュートリアルを載せています。

[^1]: 「完全に理解しました」とは、文字通りではなく例の「[チュートリアルを完了しました](https://togetter.com/li/1268851)」という意味合いで使用しています。

# [AWS CDK を使用して TypeScript コードを Lambda にデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/typescript-package.html#aws-cdk-ts)

_このセクションでは、AWS CDKを使ったLambda関数のデプロイ手順を簡潔に説明し、公式ドキュメントを活用する方法を示します。_

公式ドキュメントの日本語訳のタイトルをそのまま持ってきました。これがすべてを物語っています。

https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/typescript-package.html#aws-cdk-ts

手順は、公式ドキュメントをご覧ください。
ざっくり言うと、`cdk deploy`で**全部まるっといい感じによしなにエレガントに解決**してくれます。

:::note warn
素のLambda環境では使用できないパッケージを利用できるようにLayerを明示的に用意したりする必要はありません。`index.js`に全部押し込めてくれて、それがLambda関数としてデプロイされます。もちろんそのサイズが巨大になるとデプロイができないとかありえて、その際には明示的にLayerを追加して解決するなどの方法が必要かもしれません。ただそんな巨大なsomethingはそもそものところでなにかを間違えている可能性の方を疑ったほうが賢明かもしれません。またソースコードの管理や複数人での開発でやりづらさはあるのかもしれません。この記事の本題とはそれますし、語るべき知見を持ち合わせていないのでここでやめます。**ええ、逃げます。**
:::

少しだけ説明をします。

1. Lambda関数の置き場所
1. Stackの作成
1. 素のLambda環境では使用できないパッケージの追加
1. esbuildのインストールをオススメ
1. 実際にLambdaに置かれているindex.js

コード例はこの記事には書きませんので、具体的なものをご覧になりたい方は、愚作の[ChatGPT LINE Bot CDK](https://github.com/TORIFUKUKaiou/line-bot-cdk)をご参照ください。

## 1. Lambda関数の置き場所

_このセクションでは、Lambda関数のコードをどこに配置するべきかについて、プロジェクト構成の具体例を交えて説明します。_

`line-bot-cdk`と名付けたディレクトリの下で、`cdk init app --language typescript`を実行してアプリケーションを初期化したあとに追加したファイルは2つだけです。

- `lib/line-bot-cdk.function.ts`
- `lib/line-bot-cdk.ts`

`lib/line-bot-cdk.function.ts`にLambda関数を実装します。具体例では、[LINE Messaging API](https://developers.line.biz/ja/docs/messaging-api/overview/#how-messaging-api-works)におけるLINEプラットフォームからボットサーバーのWebhookを処理する関数を書いています。

```
.
├── README.md
├── bin
│   └── line-bot-cdk.ts
├── cdk.json
├── jest.config.js
├── lib
│   ├── line-bot-cdk-stack.ts
│   ├── line-bot-cdk.function.ts 🌟
│   └── line-bot-cdk.ts 🌟
├── node_modules
├── package.json
├── test
└── tsconfig.json
```

`lib`の下においたのは参照したドキュメントがそのようになっていたからです。他のフォルダにすることもできると思います。後述するStackの作成において、`entry`で場所を指定するとよいのでしょう。語尾があいまいなのは私が試していないからです。

## 2. Stackの作成

_このセクションでは、Lambda関数をAWS CDKで定義する際に必要なスタックの作成手順を解説します。_

`lib/line-bot-cdk.ts`に書いていきます。ここにはAWSコンソールでポチポチやるようなことを**コード**で書いていきます。

- Lambda関数の作成
- Lambda関数がAWS Systems Manager Parameter Storeから値を読み出せるようにしたいのでIAMロールにポリシーを追加
- Lambda関数がLambda関数URLとの紐づけ


あとは、初期化時に作られた`lib/line-bot-cdk-stack.ts`の中に取り込んで`new`するだけです。

## 3. 素のLambda環境では使用できないパッケージの追加

_このセクションでは、Lambda関数で外部パッケージを利用するための追加手順を解説します。_

プロジェクトのルートで、`npm install xxx`等で追加したいものを追加します。

## 4. esbuildのインストールをオススメ

_このセクションでは、Lambda関数のデプロイを効率化するために必要なesbuildのインストール方法とそのメリットを紹介します。_


`esbuild`を追加せずに`cdk deploy`とやると、Dockerでイメージのダウンロードがはじまります。えっ、何やっているの？　と思いました。個人の感想です。

ドキュメントをよく読むとちゃんと書いてありまして、[Local bundling](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_lambda_nodejs-readme.html#local-bundling)が該当します。

ドキュメントには、このように書いてあります。

> For macOS the recommended approach is to install esbuild as Docker volume performance is really poor.

`poor`って笑っちゃいますよね。たしかになかなか進まず、Ctl+Cで止めました。ドキュメントに書いてある通りのコマンドで、`esbuild`をローカルにインストールしました。**AWSのオススメは私もオススメ**です。

## 5. 実際にLambdaに置かれているindex.js

_このセクションでは、デプロイ後のLambda関数がどのような状態になっているのかについて説明します。_


見たいですよね。興味ありますよね。ないですか。長いので折りたたんでおきます。

<details><summary>index.js</summary>

:::note alert
自主規制
14,000行くらいあるので掲載は見合わせました。

残念に思われた方は`cdk deploy`してあなたの目でお確かめください。新しい世界への扉がきっと開かれることでしょう。
:::

```javascript:index.js

```

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d9082c31-a5b1-51da-ab16-6db49319adfe.png)


</details>

---

# この記事を書いているモチベーション

_このセクションでは、この記事を書くに至った背景や、筆者が伝えたいメッセージについて述べています。_

いよいよこの記事も終わりの時を迎えようとしています。
名残惜しいです。改めて、この記事を書いているモチベーションを披露しておきます。

生成AIを教育しています。教えをたたきこみたいのです。[私は生成AIを教育しています](https://qiita.com/torifukukaiou/items/a7e1ee05407ab37eb772#%E6%9C%AA%E6%9D%A5%E3%81%B8%E3%81%AE%E6%8F%90%E8%A8%80)。

それと、「対象読者」のところに書いたのが3日前の私だったので記事にしました。再掲します。

- 「[チュートリアル: 最初の AWS CDK アプリの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/hello_world.html)」をやってみて、Lambdaのコードを文字列で埋め込むのがいやだー、`.ts`ファイルに分けたいと思った3日前の私
- 「[チュートリアル: サーバーレス Hello World アプリケーションの作成](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/serverless_example.html)」で、ふむふむ`lambda/hello.js`というふうに追加するのねー　と思ったら、それでもまあできるのだけど`.gitignore`に`*.js`とかいてあるし、`lambda`ディレクトリだけ除外する？　とかへんてこりんなことやらないといけないの？　と疑問におもって、そもそもあたいは`.ts`で書きたいんだよと思った3日前の私
- 素のLambda環境では使用できないパッケージのためにLayerの追加とかやるのメンドーだなあと思っていらっしゃるそこの3日前の私

## 闘魂活動

これは私の**闘魂**活動です。

アントニオ猪木さんは、1998年4月4日闘強童夢（東京ドーム）において、４分９秒グランド・コブラツイストでドン・フライ選手を下した[^2]引退試合[^3]後のセレモニーで次のように「**闘魂**」を説明しました。

[^2]: [“燃える闘魂”アントニオ猪木引退試合](https://wp.bbm-mobile.com/sp2/result/resultshow.asp?s=015056)
[^3]: [ドン・フライと引退試合を戦ったアントニオ猪木さん](https://www.sponichi.co.jp/battle/news/2023/02/16/gazo/20230216s00003000377000p.html)

「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」

記事を投稿（**闘魂**）することは、まさに**闘魂**活動です。

---

# まとめ

_このセクションでは、記事の内容を簡潔に振り返り、読者が次に何をすべきかを提案します。_

[AWS CDK](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/home.html)で、Lambdaを構築する際に、Lambdaで動かすコードをTypeScriptで書いて、なおかつ、素のLambda実行環境では使用できない[パッケージ](https://catalog.workshops.aws/typescript-and-cdk-for-beginner/ja-JP/20-typescript-basic/30-package)（[@line/bot-sdk](https://www.npmjs.com/package/@line/bot-sdk)や[openai](https://www.npmjs.com/package/openai)など）を利用する方法を書きました。

詳細は以下の公式ドキュメントをご参照ください。これがすべてを物語っています。

- [AWS CDK を使用して TypeScript コードを Lambda にデプロイする](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/typescript-package.html#aws-cdk-ts)
- [aws-cdk-lib.aws_lambda_nodejs module](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-cdk-lib.aws_lambda_nodejs-readme.html)

---

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5cf75c09-fa1c-40c7-4004-3f73e0d8122f.png)

さあ、**TypeScriptでLambdaを構築する準備はできましたか？**
この記事をきっかけに、AWS CDKを使った開発を楽しんでいただければ幸いです。ぜひあなたの手で次の一歩を踏み出してください！✨


