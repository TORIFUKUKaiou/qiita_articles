---
title: Bolt for Pythonを利用して作ったSlackアプリをHacobuneでイゴかす （2021/12/13）
tags:
  - Python
  - Docker
  - さくらインターネット
  - Slack
  - 40代駆け出しエンジニア
private: false
updated_at: '2022-01-08T18:06:47+09:00'
id: e3c9793c052ca7b19f31
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/docker

2021/12/13(月)の回です。
前の日は、@kaizen_nagoyaさんによる『[あなたもdocker, 私もdockerから５ヶ月。](https://qiita.com/kaizen_nagoya/items/5bd936de6d26c914af4d)』でした。
私は
<font color="purple">$\huge{どっかーら}$</font>
やってこうかしら。
そうだ！　[Slack](https://slack.com/)アプリをイゴかしてみよう[^2]!!!

---

# はじめに

[docker](https://www.docker.com/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Slack](https://slack.com/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)を楽しんでいますか:bangbang::bangbang::bangbang:

「[Bolt 入門ガイド（Bolt for Python）](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)」はとてもすぐれたガイドです。
こちらを一周することで、[Slack](https://slack.com/)アプリの制作を**完全に理解**[^1]できます。

さてどこでイゴかそう[^2]かとお悩みの方はいらっしゃいませんか:interrobang:
そんな、あなたに、[さくらインターネット](https://www.sakura.ad.jp/)さんの[Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)をご紹介します。

:::note info
2021/11/24 現在、オープンβ版とのことで無料で使わせていただけます!
:::

:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

[^1]: 例の**完全に理解した**: https://twitter.com/ito_yusaku/status/1042604780718157824

[^2]: 「動かそう」の意。おそらく西日本の方言、たぶん。NervesJPではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^3]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^3]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# What is [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/) ?

> Hacobuneは、当社が「インフラを意識しない世界を実現する」をビジョンに開発したPaaS型クラウドサービスです。スタートアップ企業や少人数でのサービスの開発を行うお客さまなど、スモールスタートでの開発に適しています。Hacobuneを利用することで、インフラの構築が不要となり、お客さまはアプリケーションの開発およびアップデートのみに専念することができ、サービスリリースのサイクルを加速させることが可能となります。

(https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

# ハイライト

`Dockerfile`をつくればでデプロイできちゃいます :rocket::rocket::rocket: 

「[Bolt 入門ガイド（Bolt for Python）](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)」をまだやっていない方は一周やってみてください。
タイポレベルですが日本語訳の誤りは私がプルリク出して、マージしてもらっていますから、な〜んにも迷うところはありません。

## 私が出して取り込んでもらったプルリク

- https://github.com/slackapi/bolt-python/pull/507
- https://github.com/slackapi/bolt-python/pull/508
- https://github.com/slackapi/bolt-python/pull/519

マージされたとおもったら即座に[日本語サイト](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)の内容が更新されていたことに感動しました :rocket::rocket::rocket:
世界を相手にしているスピード感はさすがだと感服いたしました。

# 用意するもの

ここからは用意するものを書いておきます。

## app.py

「[Bolt 入門ガイド（Bolt for Python）](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)」に記載のソースコードそのままです。
あなたのアプリケーションをご用意ください。

```python:app.py
import os
from slack_bolt import App
from slack_bolt.adapter.socket_mode import SocketModeHandler

# ボットトークンと署名シークレットを使ってアプリを初期化します
app = App(token=os.environ.get("SLACK_BOT_TOKEN"))

# 'hello' を含むメッセージをリッスンします
@app.message("hello")
def message_hello(message, say):
    # イベントがトリガーされたチャンネルへ say() でメッセージを送信します
    say(
        blocks=[
            {
                "type": "section",
                "text": {"type": "mrkdwn", "text": f"Hey there <@{message['user']}>!"},
                "accessory": {
                    "type": "button",
                    "text": {"type": "plain_text", "text":"Click Me"},
                    "action_id": "button_click"
                }
            }
        ],
        text=f"Hey there <@{message['user']}>!"
    )

@app.action("button_click")
def action_button_click(body, ack, say):
    # アクションを確認したことを即時で応答します
    ack()
    # チャンネルにメッセージを投稿します
    say(f"<@{body['user']['id']}> clicked the button")

# アプリを起動します
if __name__ == "__main__":
    SocketModeHandler(app, os.environ["SLACK_APP_TOKEN"]).start()
```

### [Slack](https://slack.com/)アプリ

[ガイド](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)の通りに、[Slack](https://slack.com/)アプリの各種設定を行っておいてください。
そもそもこれをきちんと設定しないと、`SLACK_APP_TOKEN`や`SLACK_BOT_TOKEN`をもらえませんからね〜

## Dockerfile

```docker:Dockerfile
FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./app.py" ]
```

https://hub.docker.com/_/python

に記載の通りそのままです。


## requirements.txt

```:requirements.txt
slack_bolt
```


# [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)へのデプロイ

さ〜ていよいよお待ちかね、デプロイの時間ですよ。
[Deploy Time!](https://hexdocs.pm/phoenix/gigalixir.html#deploy-time)
この記事のハイライトです。


https://manual.c1.hacobuneapp.com/docs

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:公式ドキュメントです。

## 事前準備

デプロイ方法は次の３種類とのことです。

**①パブリックのDockerイメージを使用**
②プライベートのDockerイメージを使用
③GitHubレポジトリをHacobuneに接続して使用（Dockerfileが必須）

**①パブリックのDockerイメージを使用**を説明します。
[dockerhub](https://hub.docker.com/)を使う例で書きます。

```bash
$ docker build -t first-bolt-app .
$ docker tag first-bolt-app <your_username>/first-bolt-app
$ docker login
$ docker push torifukukaiou/first-bolt-app
```

## [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

https://manual.c1.hacobuneapp.com/docs

に従ってすすめるとよいです。
こんな感じです。

![スクリーンショット 2021-11-24 5.25.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/963fc6cb-e6ea-a894-1608-585b600c13ee.png)



[ソケットモード](https://slack.dev/bolt-python/ja-jp/concepts#socket-mode)を利用する場合、**外部公開はOFF**でよく、**アプリケーションのポートは適当**でよいです。

あとは環境変数の設定を行ってください。
先述の`app.py`では次の２つの環境変数を設定する必要があります。

- SLACK_BOT_TOKEN
- SLACK_APP_TOKEN

たったこれだけで、しかもいまなら無料!!! で、[Slack](https://slack.com/)アプリをイゴかすことができます:tada::tada::tada:

<font color="purple">$\huge{Thank\ you\ very\ much!!!}$</font>


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [docker](https://www.docker.com/)!!!
Enjoy [Slack](https://slack.com/)!!!
Enjoy [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)!!!
