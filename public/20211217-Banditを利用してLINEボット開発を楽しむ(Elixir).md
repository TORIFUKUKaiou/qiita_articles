---
title: Banditを利用してLINEボット開発を楽しむ(Elixir)
tags:
  - Elixir
  - LINE
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2022-02-13T21:32:27+09:00'
id: 05255dc857ddd5a695ee
organization_url_name: linedc_jp
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/linedc

2021/12/22(水)の回です。

前の日は、 @yukima77  さんの「[Azure Logic Appsを使って、受信メールをLINE公式アカウントに投稿する](https://zenn.dev/yukima77/articles/51dc557350a47a)」でした。

防災のためのアプリとのことで、地域の方にとって安心安全への貢献がハンパないです。
このアプリから発信される情報はクマの出没情報とのことなので、内容は「けっこうやべえ」投稿なのですが、アイコンのクマがかわいらしいというのがこれまたにくいです。

---
2022/02/11追記
この記事により、
<font color="purple">$\huge{参加景品}$</font>
を頂きました!!!

[Clova Friends mini](https://clova.line.me/clova-friends-series/clova-friends-mini/)です。

<font color="purple">$\huge{ありがとうございます！}$</font>

![IMG_20220211_110946.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/34701d0e-4bc9-5dba-ea8e-50704f0ca73b.jpeg)


---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか :bangbang::bangbang::bangbang:
[Elixir](https://elixir-lang.org/)を使ってLINEボットを作ってみます。
まずは基本の:interrobang:オウム返しです。

## ソースコード

https://github.com/TORIFUKUKaiou/bandit_line_bot

# What is [Elixir](https://elixir-lang.org/)?

[Elixir](https://elixir-lang.org/)は、関数型言語に分類されます。
安心してください。
コワくない関数型言語です。
世俗派関数型言語[^1]と言われています。

[^1]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

[Elixir](https://elixir-lang.org/)の作者は[José Valim](https://twitter.com/josevalim)さんです。
Railsのご経験がある方ならご存知のあの[devise](https://github.com/heartcombo/devise)の[最初のコミッター](https://github.com/heartcombo/devise/commit/673fda9725b3a0b5522afdbe4fc9c0608243723c)は、[José Valim](https://twitter.com/josevalim)さんです。
[José Valim](https://twitter.com/josevalim)さんは、["The main, the top three influences are Erlang, Ruby, and Clojure."](https://cognitect.com/cognicast/120)とおっしゃっています。
私はなんとなくRubyに似ていると感じています。

ここで[Elixir](https://elixir-lang.org/)のプログラム例をお示しします。
[Qiita API v2](https://qiita.com/api/v2/docs)の[GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)の使用例です。
[Elixir](https://elixir-lang.org/)は1.12 or laterを使ってください。

```elixir
Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

"https://qiita.com/api/v2/items?query=tag:elixir"
|> HTTPoison.get!([], [timeout: 50_000, recv_timeout: 50_000])
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& Map.take(&1, ["title", "url"]))
```

1. URLがあります
1. HTTP GETします
1. レスポンスから`body`を取り出します
1. JSONデコードします => 結果は要素がマップ[^1]であるリストが得られます
1. 各要素から`title`と`url`を取り出したマップに変換します

ということを行っています。
[`|>`](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)は、パイプ演算子と呼ばれるものです。
前の計算結果を次の関数の第一引数にいれて実行してくれます。
[Elixir](https://elixir-lang.org/)のプログラムではよく使います。

[^1]: 他の言語ではHashと呼ばれたり、辞書型と呼ばれたりするキーと値の組み合わせで表現されるデータ型のことです

# What is [Bandit](https://github.com/mtrudel/bandit)?

> Bandit is an HTTP server for Plug apps.

[Elixir](https://elixir-lang.org/)のライブラリは、[Hex](https://hex.pm/)と呼ばれます。
[Bandit](https://github.com/mtrudel/bandit)は、[Hex](https://hex.pm/)の一種で、「Bandit is an HTTP server for Plug apps.」です。
banditという英単語をあえて日本語にしてみると、**山賊**のことです。


「[banditをイゴかしてみる](https://qiita.com/torifukukaiou/private/d31efea6cd4320bfbc59)」という記事で、ごくごく簡単な使い方をまとめました。


# Let's get started:rocket::rocket::rocket:

それではプログラムをつくっていきましょう。
[Elixir](https://elixir-lang.org/)はインストール済であるとします。
[Elixir](https://elixir-lang.org/)をインストールすると、`mix`というコマンドが使えるようになります。

## ①プロジェクトの作成

次のコマンドでプロジェクトを作成します。

```
$ mix new bandit_line_bot --sup
```

> A --sup option can be given to generate an OTP application skeleton including a
supervision tree. Normally an app is generated without a supervisor and without
the app callback.

です。

## ②ライブラリの追加

プロジェクトのルートにある`mix.exs`を編集します。

```elixir:mix.exs
  defp deps do
    [
      {:bandit, "~> 0.4.5"},
      {:jason, "~> 1.2"},
      {:httpoison, "~> 1.8"}
    ]
  end
```

バージョンの指定は各[Hex](https://hex.pm/)のドキュメントに従います。

[Bandit](https://github.com/mtrudel/bandit)
[Jason](https://github.com/michalmuskala/jason)
[HTTPoison](https://github.com/edgurgel/httpoison)

次のコマンドで、依存関係を解決します。

```bash
$ mix deps.get
```

## ③プログラムを書く:fire:

[Webhookイベントを受信する](https://developers.line.biz/ja/docs/messaging-api/building-bot/#confirm-webhook-behavior)モジュール`BanditLineBot.MyPlug`を作ります。

```elixir:lib/bandit_line_bot/my_plug.ex
defmodule BanditLineBot.MyPlug do
  import Plug.Conn

  def init(options) do
    # initialize options
    options
  end

  def call(conn, opts) do
    {:ok, body, _conn} = Plug.Conn.read_body(conn, opts)

    if BanditLineBot.Line.verify(conn, body) do
      Jason.decode!(body)
      |> Map.get("events")
      |> do_something()

      conn
      |> put_resp_content_type("application/json")
      |> send_resp(200, Jason.encode!(%{}))
    end
  end

  defp do_something(events) do
    spawn(fn -> BanditLineBot.Handler.handle_events(events) end)
  end
end
```

`BanditLineBot.MyPlug`モジュールを`children`に追加しておきます。
これで[Elixir](https://elixir-lang.org/)アプリの開始と同時に、`BanditLineBot.MyPlug`モジュールがイゴき始めます[^2]。

[^2]: 「動き始めます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^3]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^3]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。


```elixir:lib/bandit_line_bot/application.ex
  def start(_type, _args) do
    children = [
      {Bandit, plug: BanditLineBot.MyPlug, scheme: :http, options: [port: 4000]} # add
    ]
```

「[署名を検証する](https://developers.line.biz/ja/reference/messaging-api/#signature-validation)」を参考に[Elixir](https://elixir-lang.org/)で実装してみます。

```elixir:lib/bandit_line_bot/line.ex
defmodule BanditLineBot.Line do

  # https://developers.line.biz/ja/reference/messaging-api/#signature-validation
  def verify(conn, body) do
    x_line_signature =
      conn.req_headers
      |> Enum.find(fn {key, _} -> key == "x-line-signature" end)
      |> elem(1)

    my_signature =
      :crypto.mac(:hmac, :sha256, channel_secret(), body)
      |> Base.encode64()

    my_signature == x_line_signature
  end

  defp channel_secret do
    System.get_env("CHANNEL_SECRET")
  end
end
```

LINEから届いたデータを煮るなり焼くなりするモジュール`BanditLineBot.Handler`を作ります。
ここでは単純に、イベントの`type`が`text`であるものを対象にして、そのままオウム返ししています。

```elixir:lib/bandit_line_bot/handler.ex
defmodule BanditLineBot.Handler do
  def handle_events(events) do
    events
    |> Enum.filter(fn event ->
      Map.get(event, "type") == "message"
    end)
    |> Enum.filter(fn event ->
      Map.get(event, "message")
      |> Map.get("type")
      |> Kernel.==("text")
    end)
    |> Enum.map(fn %{"message" => %{"text" => text}, "replyToken" => replyToken} ->
      {text, replyToken}
    end)
    |> Enum.each(fn {text, replyToken} ->
      BanditLineBot.Line.Api.reply(text, replyToken)
    end)
  end
end
```

「[応答メッセージを送る](https://developers.line.biz/ja/reference/messaging-api/#send-reply-message)」を参考に、[Elixir](https://elixir-lang.org/)で実装します。

```elixir:lib/bandit_line_bot/line/api.ex
defmodule BanditLineBot.Line.Api do

  # https://developers.line.biz/ja/reference/messaging-api/#send-reply-message
  def reply(text, reply_token) do
    json =
      %{
        replyToken: reply_token,
        messages: [
          %{
            type: "text",
            text: text
          }
        ]
      }
      |> Jason.encode!()

    url = "https://api.line.me/v2/bot/message/reply"

    headers = [
      "Content-type": "application/json",
      Authorization: "Bearer #{channel_access_token()}"
    ]

    {:ok, _response} = HTTPoison.post(url, json, headers)
  end

  defp channel_access_token do
    System.get_env("CHANNEL_ACCESS_TOKEN")
  end
end
```

以上です。

# Run :rocket::rocket::rocket:

まずはローカルマシンでイゴかしてみます。

あー、そもそも[LINE Developersコンソール](https://developers.line.biz/en/)での設定の話を一切書いていません。
「[Messaging APIを始めよう](https://developers.line.biz/ja/docs/messaging-api/getting-started/)」をご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

以下の環境変数に[LINE Developersコンソール](https://developers.line.biz/en/)にて払い出していただいた値を設定しておいてください。


- **CHANNEL_SECRET**
- **CHANNEL_ACCESS_TOKEN**

次のコマンドで[Elixir](https://elixir-lang.org/)アプリケーションつまりここでは、LINEボットをイゴかします。

```bash
$ iex -S mix
```

ローカルマシンでイゴかしている場合には[ngrok](https://ngrok.com/)などを使ってHTTPSにしてください。
@hyodoblog さんの「[画像・音声・動画を文字起こしするLINE BotをNode.jsでつくってみよう！　〜ngrokによる高速Bot開発〜](https://hyodoblog.com/mojiokoshi-line-bot/)」でもご紹介されています。

こんな感じです。
以下の例では、`https://95fa-163-49-206-28.ngrok.io`を`Webhook URL`に設定するとよいです。

```
$ ./ngrok authtoken <token>

$ ./ngrok http 4000
ngrok by @inconshreveable                                                                                                      (Ctrl+C to quit)

Session Status                online                                                                                                           
Account                       TORIFUKUKaiou (Plan: Free)                                                                                       
Version                       2.3.40                                                                                                           
Region                        United States (us)                                                                                               
Web Interface                 http://127.0.0.1:4040                                                                                            
Forwarding                    https://95fa-163-49-206-28.ngrok.io -> http://localhost:4000                                                     
Forwarding                    https://95fa-163-49-206-28.ngrok.io -> http://localhost:4000 
```



これでイゴきます！

---

ずっとローカルマシンでイゴかし続けるのはいろいろ辛いとおもいます。
`Dockerfile`をつくるだけでデプロイできる！、しかも2021/12/17現在今なら無料で使える[さくらインターネット](https://www.sakura.ad.jp/)さんの[Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)をご紹介します。

これは以下の記事にて書いております。
「[Elixirで作ったLINEボットをHacobuneでイゴかす](https://qiita.com/torifukukaiou/private/7283f17c956a567e660e)」
どうぞご参照ください。

![Screenshot_20211217_003322_jp.naver.line.android.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2fe2ae63-d1a8-8efa-d7fd-02c920090979.jpeg)

:tada::tada::tada:



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm: 

[Elixir](https://elixir-lang.org/)を使って、まずは基本:interrobang: のオウム返しを作りました。
ソースコードは、[ここ](https://github.com/TORIFUKUKaiou/bandit_line_bot)にあります。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

# Where to go next :rocket:

返信内容を変えたい場合には「[A3RTさんのTalk APIをElixirで使ってみます](https://qiita.com/torifukukaiou/private/6e9a02e7a20d3d43b4a2)」を参考に[Talk API](https://a3rt.recruit.co.jp/product/talkAPI/)を組み込んでみたり、さまざまなAPIとの連携が考えられます。

[Nerves](https://www.nerves-project.org/)でイゴかすこともできます[^2]！

https://qiita.com/torifukukaiou/items/8393fb3deb2448163b07

---

[Elixir](https://elixir-lang.org/)に興味をもっていただけましたら幸いです。
以下、[Elixir](https://elixir-lang.org/)のお役立ち情報です。

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:





