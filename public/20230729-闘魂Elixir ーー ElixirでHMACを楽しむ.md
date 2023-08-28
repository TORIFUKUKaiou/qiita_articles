---
title: 闘魂Elixir ーー ElixirでHMACを楽しむ
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-08-17T10:02:54+09:00'
id: 04d16887e31eaa7822fe
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[Elixir](https://elixir-lang.org/)という素敵な関数型言語の話をします。
[Elixir](https://elixir-lang.org/)で[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)をしてみます。

[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)は、Hash-based Message Authentication Code または keyed-Hash Message Authentication Codeの略語です。

> HMAC (Hash-based Message Authentication Code または keyed-Hash Message Authentication Code) とは、メッセージ認証符号 (MAC; Message Authentication Code) の一つであり、秘密鍵とメッセージ（データ）とハッシュ関数をもとに計算される。

ウィキペディア [HMAC](https://ja.wikipedia.org/wiki/HMAC)



# [Elixir](https://elixir-lang.org/)で[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)

こんな感じです。猪木寛至です。猪木さんです。  


```elixir
signed_payload = "闘魂"
secret = "123da-"

:crypto.mac(:hmac, :sha256, secret, signed_payload)
|> Base.encode16(case: :lower)
```

実行すると、`"16fc9aface82759ece52bd84c99d8c48f7886f061789b4f97e4225241a997a27"`が得られます。

最後の`Base.encode16(case: :lower)`は、バイナリデータを16進数の文字列（小文字)に変換しています。
`:case`オプションのデフォルト値は`:upper`です。
16進数の文字列表現が必要かどうかは**ケース場合ケース**だとおもいます。
必要に応じて取捨選択してください。

# 一体いつ使うの？

[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)は、一体いつ使うのでしょうか。

https://api.slack.com/authentication/verifying-requests-from-slack

https://developers.line.biz/ja/docs/messaging-api/receiving-messages/#verifying-signatures

このへんです。もう少し説明を続けます。
SlackやLINEのボット（アプリ)を作る場合、SlackやLINEの方からイベントを通知してもらって受け取ることがあります。
たとえば、「◯◯さんがメッセージを送信しました」とか「△△さんがジョインしました」といったイベントです。
この通知が本当にSlackやLINEからきたものであるかを確かめるために使われます。署名検証を行うわけです。

署名検証をLINEの場合で説明します。
LINEはボット（アプリ）にイベントを通知する際に、リクエストbodyとあらかじめLINEと開発者間で決めた(LINE Developers Consoleで払い出された)`Channel secret`で署名を作成します。
その署名をHTTPヘッダのX-Line-Signatureに埋め込んで、ボット（アプリ）にイベントを通知（HTTP POST)します。
イベントを受け取ったボット（アプリ）でも、リクエストbodyと`Channel secret`で署名を作ります。そして、HTTPヘッダに含まれているX-Line-Signatureの値と比較して一致すればLINEからの通知だと判定できるわけです。

Slackの場合も考え方は同じです。`v0`とか`timestamp`とかでてきますけど、まあ同じです。

LINEのSDKで話を続けます。
[LINE Messaging API SDK for Python](https://github.com/line/line-bot-sdk-python)を使った場合には、署名検証はSDKに隠蔽されています。

```python
app = Flask(__name__)

configuration = Configuration(access_token='YOUR_CHANNEL_ACCESS_TOKEN')
handler = WebhookHandler('YOUR_CHANNEL_SECRET')


@app.route("/callback", methods=['POST'])
def callback():
    # get X-Line-Signature header value
    signature = request.headers['X-Line-Signature']

    # get request body as text
    body = request.get_data(as_text=True)
    app.logger.info("Request body: " + body)

    # handle webhook body
    try:
        handler.handle(body, signature) # ①
    except InvalidSignatureError:
        app.logger.info("Invalid signature. Please check your channel access token/channel secret.")
        abort(400)

    return 'OK'
```

import文は省いています。
ここでお伝えしたいことは、①のhandleメソッド内で署名検証が行われている、隠蔽されているという点をお伝えしたいです。
`handler`は初期化時に`Channel secret`を指定しています。
handleメソッドでは、リクエストbodyとHTTPヘッダのX-Line-Signatureが渡されています。
情報はそろいましたので、handleメソッド内で署名の検証ができるわけです。

LINEのボット（アプリ)を作る際に、私はサンプルの通りに言われた通りになんとなくで指定していた`Channel secret`の必要性がわかりました。

---

話を[Nerves](https://nerves-project.org/)に転じます。

『[Build a Weather Station with Elixir and Nerves](https://pragprog.com/titles/passweather/build-a-weather-station-with-elixir-and-nerves/)』という本の中では、IoTデバイスから通知を受け取るPhoenix APIサーバーとの間の通信で[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)を使うことが紹介されています。[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)を使うことで自身の管理するIoTデバイスからのPOSTなのだということを確かめられるという寸法です。

よいリンクも紹介されていましたので貼っておきます。

https://dashbit.co/blog/how-we-verify-webhooks

[Phoenix](https://www.phoenixframework.org/)で、オンライン決済サービス[Stripe](https://stripe.com/jp)からのWebhookを受け取る実装例が書かれています。

# さいごに

[Elixir](https://elixir-lang.org/)で[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)してみました。
[HMAC](https://datatracker.ietf.org/doc/html/rfc2104)を一体いつ使うのかを説明しました。署名検証に使われます。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
