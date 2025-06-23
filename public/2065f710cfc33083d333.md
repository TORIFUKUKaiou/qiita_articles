---
title: 闘魂CDK道場：TypeScriptでAWSインフラを組み、Python Lambdaを叩き込むまで
tags:
  - AWS
  - TypeScript
  - CDK
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-22T22:01:03+09:00'
id: 2065f710cfc33083d333
organization_url_name: haw
slide: false
ignorePublish: false
---
いよいよはじまりました！
[Qiita Tech Festa](https://qiita.com/tech-festa/2025) :tada::tada::tada: 

https://qiita.com/tech-festa/2025

「[TypeScriptでトライしたこと、トライしていることを共有しよう](https://qiita.com/official-events/36211da6b9930787d8e2)」に参加してみます。

https://qiita.com/official-events/36211da6b9930787d8e2

# はじめに

[AWS CDK（AWS Cloud Development Kit) ](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/home.html)でAWSインフラストラクチャを構築するのがマイブームです。  

CDK自体はTypeScriptで構築して、Pythonで書いたLambdaと組み合わせる例をしたためます。  


# 想定する読者

以下を想定しています。  

- 「[チュートリアル: 最初の AWS CDK アプリを作成する](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/hello-world.html)」を完全に理解している。
    - つまり一周しているということです。
-  LambdaはPythonランタイムで実行したいと考えている。
-  Pythonのプログラムでは、標準のPythonでは使えないライブラリを使いたいと考えている。
-  プロジェクトの構成をどうすべき迷っている。


つまり、幾日か前の私です。  

# 題材と動機

以前、「[超シンプル！リモートワークの電話連絡を自動化してみた話](https://qiita.com/torifukukaiou/items/0a65efe197fc4e15577a)」という記事を書きました。  

https://qiita.com/torifukukaiou/items/0a65efe197fc4e15577a  

この記事を書いたときは、Rubyを使って作りました。  
内容は、電話代行業者にかかってきた自分宛のメール(Google Workspace)が届いたら、Slackへ通知を送るというものです。以下に図示します。  

![](https://qiita-user-contents.imgix.net/https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F131808%2F5b73b35d-eef6-ff4f-7472-533dfe4b6911.png?ixlib=rb-4.0.0&auto=format&gif-q=60&q=75&w=1400&fit=max&s=0a166e0c910aa1620ad7933842d3efb3)

以前は、 https://developers.google.com/gmail/api/quickstart/ruby というページがありましたが、2024-12-11に見たらありませんでした！ それでクイックスタートに残っているプログラミング言語のうち、比較的得意としているPythonのクイックスタート https://developers.google.com/workspace/gmail/api/quickstart/python?hl=ja を使うことにしました。  

Rubyのプログラムで動かしていたときは、EC2インスタンスを使ってcronで動かしていました。Pythonで書き直すにあたり、せっかくなのでLambdaで実行することにしました。そして手動でぽちぽち構築するのではなく、[AWS CDK（AWS Cloud Development Kit) ](https://docs.aws.amazon.com/ja_jp/cdk/v2/guide/home.html)で構築することにしました。  

# プロジェクトの構成

プロジェクトの構成について説明をします。
前提として以下のようにプロジェクトを初期化しました。

```bash
$ mkdir gmail-to-slack && cd gmail-to-slack
$ cdk init app --language typescript
```

プロジェクトの構成は以下のようにしました。  

```
.
├── bin
│   └── gmail-to-slack.ts
├── cdk.json
├── jest.config.js
├── lambda
│   ├── requirements.txt
│   └── main.py
├── lib
│   └── gmail-to-slack-stack.ts
├── node_modules
├── package-lock.json
├── package.json
├── README.md
├── test
├── token.json
└── tsconfig.json
```

この記事でお伝えしたいことをもう一度、書いておきます。  
「**CDK自体はTypeScriptで構築して、Pythonで書いたLambdaと組み合わせる例をしたためる**」  

このテーマに沿って、Pythonで書いたLambdaをどこに配置したかというと、`lambda/`フォルダに入れました。   
もう一つ注目すべき点は、`main.py`と`requirements.txt`を置いている点です。使いたいライブラリは、`requirements.txt`に書いておけばよいのです。これだけです。  

# @aws-cdk/aws-lambda-python-alpha module

いよいよこの記事のハイライトです。レゾンデートルです。  

`lambda/`フォルダにおいたPythonランタイムのプラグラムをStackに追加するか示します。  
Pythonのプログラムは、外部のライブラリを使いたいです。`lambda/requirements.txt`に使いたいライブラリを書いておきます。  

あとは、[@aws-cdk/aws-lambda-python-alpha module](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-lambda-python-alpha-readme.html)にあるexperimentalな**Amazon Lambda Python Library**を使えばよいです。モジュール名にalphaの文字が見える通り、experimentalなライブラリです。  

```typescript:gmail-to-slack-stack.ts
import * as cdk from 'aws-cdk-lib';
import { Construct } from 'constructs';
import { PythonFunction } from '@aws-cdk/aws-lambda-python-alpha';
// import * as sqs from 'aws-cdk-lib/aws-sqs';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import * as logs from 'aws-cdk-lib/aws-logs';
import * as events from 'aws-cdk-lib/aws-events';
import * as targets from 'aws-cdk-lib/aws-events-targets';
import * as iam from 'aws-cdk-lib/aws-iam';
import * as path from 'path';
import * as sns from 'aws-cdk-lib/aws-sns';
import * as subscriptions from 'aws-cdk-lib/aws-sns-subscriptions';
import * as cloudwatch from 'aws-cdk-lib/aws-cloudwatch';
import * as cloudwatch_actions from 'aws-cdk-lib/aws-cloudwatch-actions';

export class GmailToSlackStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here

    // example resource
    // const queue = new sqs.Queue(this, 'GmailToSlackQueue', {
    //   visibilityTimeout: cdk.Duration.seconds(300)
    // });

    // Lambda関数の定義
    const gmailToSlackLambda = new PythonFunction(this, 'GmailToSlackLambda', {
      runtime: lambda.Runtime.PYTHON_3_13,
      index: 'main.py',
      handler: 'lambda_handler',
      entry: path.join(__dirname, '../lambda'), // main.pyがあるディレクトリを指定
      logRetention: logs.RetentionDays.ONE_WEEK, // CloudWatch Logsの保存期間を7日間に設定
      timeout: cdk.Duration.seconds(60),
      memorySize: 160,
      environment: {
        GMAIL_TO_SLACK_FROM: process.env.GMAIL_TO_SLACK_FROM || 'hogehoge@gmail.com',
        GMAIL_TO_SLACK_WEB_HOOK_URL: process.env.GMAIL_TO_SLACK_WEB_HOOK_URL || '',
        GMAIL_TO_SLACK_CHANNEL: process.env.GMAIL_TO_SLACK_CHANNEL || '#times_yamauchi',
        ENVIRONMENT: process.env.ENVIRONMENT || 'aws',
      },
    });

    //...
  }
}
```

デプロイをするためには、Dockerが必要です。
もっと詳しいことを知りたい場合には、ドキュメントの「[Packaging](https://docs.aws.amazon.com/cdk/api/v2/docs/aws-lambda-python-alpha-readme.html#packaging)」の節をご確認いただくとよいと思います。

以下、細かなところを補足しておきます:  

- `...`以降は本記事とは関係ないので省略しています。  
- import文は、本記事とは関係のない`...`で使用しているものもそのまま残しています。  

# おわりに

CDK自体はTypeScriptで構築して、Pythonで書いたLambdaと組み合わせる例をしたためました。  
特別なことはしていません。ですが、私にとっては確かな「はじめの一歩」でした。  

LambdaをPythonで書きたい、CDKはTypeScriptで触りたい、そんな交差点に立つ人の背中を押す記事になれば嬉しいです。  
そして何より、コードもまた闘いであり、自分自身との闘魂を注ぎ込む場であることを再確認しました。  

> 書いて、壊して、組み直す。  
> その手に握るキーボードこそ、我らの鍬（くわ）であり、刀であるッ！  

迷わず叩けよ、叩けばデプロイされるッ！！！  
