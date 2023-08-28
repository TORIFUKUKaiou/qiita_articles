---
title: SMSをElixirで送る(Twilioを利用)
tags:
  - Elixir
  - twilio
  - 猪木
  - AdventCalendar2022
  - 闘魂
private: false
updated_at: '2022-12-26T18:38:13+09:00'
id: 833a54ec1064b9027eee
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

https://qiita.com/advent-calendar/2022

https://qiita.com/advent-calendar/2022/twilio

# はじめに

闘魂と[Elixir](https://elixir-lang.org/)が出会いました。
闘魂 meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

https://qiita.com/tuchiro/items/3ce7cba53e5b8715b4a0

を参照しました。

私もSMS送信をやってみたくなりました。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [ExTwilio](https://github.com/danielberkompas/ex_twilio)

[ExTwilio](https://github.com/danielberkompas/ex_twilio)は、

> ExTwilio is a relatively full-featured API client for the Twilio API.

です。
[Elixir](https://elixir-lang.org/)製の[Twilio](https://www.twilio.com/)ライブラリです。

参照した@tuchiroさんのコラム「[twilio+ex_twilioでSMSを簡単に送信する](https://qiita.com/tuchiro/items/3ce7cba53e5b8715b4a0)」でも使われています。
これを使うのが早そうです。

# アカウント登録

https://www.twilio.com/blog/how-to-create-twilio-account-jp

を参照しました。
@tuchiroさんのコラム「[twilio+ex_twilioでSMSを簡単に送信する](https://qiita.com/tuchiro/items/3ce7cba53e5b8715b4a0)」も参照しました。

必要なものは以下の3点です。

- Account SID
- Auth Token
- Twilio phone number (送信元の電話番号です。[Twilio](https://www.twilio.com/)さんに払い出してもらいます)

---

# 論よりRun!!!

迷わず動かしてみます。
今回は[IEx](https://hexdocs.pm/iex/1.14/IEx.html)で動かします。

時間がありません。

https://qiita.com/advent-calendar/2022/twilio

に応募、投稿（闘魂）したいとおもっています。
2022-12-25の23:59までに投稿(闘魂)する必要があります。
突貫小僧[星野勘太郎](https://ja.wikipedia.org/wiki/%E6%98%9F%E9%87%8E%E5%8B%98%E5%A4%AA%E9%83%8E)です。
[ビッシビシ行くからな！](https://www.youtube.com/watch?v=_KejwDWZdGo&t=36s)

https://www.youtube.com/watch?v=_KejwDWZdGo&t=36s

## プロジェクト作成

```bash:CMD
mix new hello_twilio
```

## mix.exsの編集

[ExTwilio](https://github.com/danielberkompas/ex_twilio)を導入します。

```elixir:mix.exs
  defp deps do
    [
      {:ex_twilio, "~> 0.9.1"}
    ]
  end
```

## mix deps.get

ライブラリをインストールします。

```bash:CMD
cd hello_twilio
mix deps.get
```

## 設定ファイル

設定ファイル `config/config.exs`を作ります。

[ExTwilio](https://github.com/danielberkompas/ex_twilio)の[configuration](https://github.com/danielberkompas/ex_twilio#configuration)をご参照ください。

https://github.com/danielberkompas/ex_twilio#configuration

設定ファイル `config/config.exs`無しでも動的に設定する方法があるかもしれません。
パッと見、公式のトップページには見当たりませんでした。
タイムリミットも迫っているため、深追いしませんでした。
2022-12-25の23:59までに投稿(闘魂)する必要があります。

https://qiita.com/advent-calendar/2022/twilio

に応募、投稿（闘魂）します。

## 動かす

準備は整いました。
いよいよ[IEx](https://hexdocs.pm/iex/1.14/IEx.html)で動かします。
プロジェクトのルートにいることを確認して、迷わず行きます。`iex -S mix`です。

```bash:CMD
iex -S mix
```

```elixir
ExTwilio.Message.create(
  to: "+817xxxxxxxxx",
  from: "+12xxxxxxxxxx",
  body: "闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことだとおもいます")
```

`:to`と`:from`は適切な値を設定してください。
[IEx](https://hexdocs.pm/iex/1.14/IEx.html)に上記をペタっと貼り付けて迷わず実行してください！

# SMS来ましたよ :tada::tada::tada:

![スクリーンショット 2022-12-25 22.58.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/89700ecb-b2bc-0d5f-288e-ea49f6ee9552.png)

[Twilio](https://www.twilio.com/)さんから **闘魂注入** していただきました！！！
**ありがとうーーーーッ!!!** ございます。
 


# ワンポイントレッスン エラーがでた

私は以下のエラーに遭遇しました。

```elixir
{:error,
 %{
   "code" => 21211,
   "message" => "The 'To' number +817xxxxxxxxx is not a valid phone number.",
   "more_info" => "https://www.twilio.com/docs/errors/21211",
   "status" => 400
 }, 400}
```

これは設定が足りていません。
無料アカウントでは、送信先をあらかじめ登録しておく必要があります。
私はコンソールの中で、**My First Twilio account**を押したときに表示される下記の画面からNext -> Nextと指示に従いました。

![スクリーンショット 2022-12-25 22.51.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/df228172-33c3-1b20-2e1f-c83b79c4f3c7.png)

途中curlで、SMS送信先の自身の電話番号を入力しました。
curlの実行例は丁寧に[Twilio](https://www.twilio.com/)さんがコンソールに書いてくださっています。
迷わず実行してください。




---

# おわりに

[ExTwilio](https://github.com/danielberkompas/ex_twilio)を使うと、簡単に[Elixir](https://elixir-lang.org/)でSMS送信ができます。

また明日からは[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)がはじまります！
がんばっていきましょう！
**元氣があればなんでもできる！！！**

<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

https://qiita.com/torifukukaiou/items/b6361f98194f3687a13c

https://qiita.com/torifukukaiou/items/4c35ace6db3f02ac3897

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

https://qiita.com/torifukukaiou/items/833a54ec1064b9027eee

https://qiita.com/torifukukaiou/items/44db8a4997812518730a




---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダー！}$</font></b>

