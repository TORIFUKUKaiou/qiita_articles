---
title: AWS Lambda上で「LINE Messaging API SDK for Python」を使ったコードをデプロイしてLINE Botを作ることを楽しむ
tags:
  - AWS
  - lambda
  - LINEmessagingAPI
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-08-07T14:18:11+09:00'
id: 1794f001c7f81cbafca7
organization_url_name: haw
slide: false
ignorePublish: false
---
# はじめに

LINEの[Messaging API](https://developers.line.biz/ja/services/messaging-api/)を使ってオウム返しをするボットを作ります。

こちらの記事をとても参考にしています。ありがとうございます。

https://qiita.com/w2or3w/items/1b80bfbae59fe19e2015

LINEボットはWebhookを受け取って反応するものを作ればよいので、[Amazon API Gateway](https://aws.amazon.com/jp/api-gateway/)と[AWS Lambda](https://aws.amazon.com/jp/lambda/)の組み合わせでサクッと作れます。

大部分はさきほど紹介した上記記事をなぞってもらえばできます。
この記事では、[LINE Messaging API SDK for Python](https://github.com/line/line-bot-sdk-python)を[AWS Lambda](https://aws.amazon.com/jp/lambda/)で使えるように[レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)に指定する**ブツ**の作り方を説明します。

# 環境

私のマシンです。

- MacBook Pro
- Sonoma 14.5
- [Homebrew](https://brew.sh/ja/)でなにかのついでにPython 3.12がインストールされています

# コード例

[LINE Messaging API SDK for Python](https://github.com/line/line-bot-sdk-python)を利用した[AWS Lambda](https://aws.amazon.com/jp/lambda/)で動くコードの例です。
オウム返しをするのみです。
ほとんどSDKの[Synopsis](https://github.com/line/line-bot-sdk-python?tab=readme-ov-file#synopsis)をまんまです。

```python
import json
import requests
import logging
import os
from linebot.v3 import (
    WebhookHandler
)
from linebot.v3.exceptions import (
    InvalidSignatureError
)
from linebot.v3.messaging import (
    Configuration,
    ApiClient,
    MessagingApi,
    ReplyMessageRequest,
    TextMessage
)
from linebot.v3.webhooks import (
    MessageEvent,
    TextMessageContent
)

logger = logging.getLogger()
logger.setLevel(logging.INFO)

YOUR_CHANNEL_ACCESS_TOKEN = os.environ['YOUR_CHANNEL_ACCESS_TOKEN']
YOUR_CHANNEL_SECRET = os.environ['YOUR_CHANNEL_SECRET']

configuration = Configuration(access_token=YOUR_CHANNEL_ACCESS_TOKEN)
handler = WebhookHandler(YOUR_CHANNEL_SECRET)

def lambda_handler(event, context):
    logger.info(event)
    signature = event['headers']['x-line-signature']
    body = event['body']
    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        app.logger.info("Invalid signature. Please check your channel access token/channel secret.")
        abort(400)

    return {'statusCode': 200}


@handler.add(MessageEvent, message=TextMessageContent)
def handle_message(event):
    with ApiClient(configuration) as api_client:
        line_bot_api = MessagingApi(api_client)
        line_bot_api.reply_message_with_http_info(
            ReplyMessageRequest(
                reply_token=event.reply_token,
                messages=[TextMessage(text=event.message.text)]
            )
        )
```

このコードを[AWS Lambda](https://aws.amazon.com/jp/lambda/)で動かそうとすると、「[LINE Messaging API SDK for Python](https://github.com/line/line-bot-sdk-python)なんて知らねーよ」と怒られます。
それもそのはずです。Pythonの標準には入っていないライブラリですから[AWS Lambda](https://aws.amazon.com/jp/lambda/)で使えるようにどうにかライブラリを参照できるようにする必要があります。

そんなときに使うのが[レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)です。

# [レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)に指定するブツの作り方

[レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)に指定するブツをまずは作る必要があります。ここでいう**ブツ**とは、ヤバいものではなく、ライブラリを固めたものです。

公式ドキュメントがあります。

「[Python Lambda 関数にレイヤーを使用する](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/python-layers.html)」のドキュメントの通りにやればできます。
私にできたのだからあなたもきっとできます！

https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/python-layers.html

ここで記事を終えてもいいのですが、このへんを熱く語ってみます。

ドキュメントの通り、GitHubから[サンプルコード](https://github.com/awsdocs/aws-lambda-developer-guide)を`git clone`してきて実行してもよいです。
ただし、余計なものもいっぱいついてきます。実は以下の3ファイルだけあればよいのです。

- 1-install.sh 
- 2-package.sh 
- requirements.txt 

```sh:1-install.sh 
python3.12 -m venv create_layer
source create_layer/bin/activate
pip install -r requirements.txt
```

```sh:2-package.sh 
mkdir python
cp -r create_layer/lib python/
zip -r layer_content.zip python
```

```text:requirements.txt
line-bot-sdk==3.11.0
```

`1-install.sh`の先頭で指定しているPythonのバージョンは、[AWS Lambda](https://aws.amazon.com/jp/lambda/)のランタイムに指定するバージョンとあわせておくのが吉です。この記事の例ではPython 3.12を指定しています。私の場合、[Homebrew](https://brew.sh/ja/)でなにかのついでにインストールされていました。
`requirements.txt`には必要なライブラリをご指定ください。

3ファイルの準備ができたらあとは実行あるのみです。
実行方法は以下の通りです。

```bash
chmod 744 1-install.sh && chmod 744 2-package.sh
./1-install.sh
./2-package.sh
```

そうすると、`layer_content.zip`という[レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)に指定するブツができますのでこれを[AWS Lambda](https://aws.amazon.com/jp/lambda/)に設定すればよいわけです。
[AWS Lambda](https://aws.amazon.com/jp/lambda/)での設定方法は以下のドキュメントをご参照ください。

https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/adding-layers.html

話が前後しますが、`1-install.sh`と`2-package.sh`が一体何をしているのかをざっくり説明しておきます。

`1-install.sh`では、まず、`create_layer`という名前で[仮想環境](https://docs.python.org/ja/3/library/venv.html)を作成し、それをアクティベートして、`requirements.txt`の内容に従ってライブラリをインストールします。
次に`2-package.sh`では、`python`という名前のディレクトリを作成し、その中にさきほどインストールしたライブラリをコピーして、`layer_content.zip`というファイルに圧縮しているわけです。

なにか大層ありがたい解説がはじまるかと思いきや、ただ単に`.sh`の中身をただ単に言葉にしてみたに過ぎません。


# さいごに

[AWS Lambda](https://aws.amazon.com/jp/lambda/)で外部のライブラリを使えるようにする[レイヤー](https://docs.aws.amazon.com/ja_jp/lambda/latest/dg/chapter-layers.html)に指定する**ブツ**の作り方を説明しました。

あなたもLINEボットの制作をお楽しみください。
