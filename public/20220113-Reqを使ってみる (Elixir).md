---
title: Reqを使ってみる (Elixir)
tags:
  - Elixir
  - autoracex
private: false
updated_at: '2022-01-30T17:36:56+09:00'
id: 4d842c6acae2b8967467
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**昔より 主を内海の 野間なれば 報いを待てや 羽柴筑前**

Advent Calendar 2022 13日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

<font color="purple">$\huge{Enjoy\ Elixir🚀🚀🚀}$</font>

今回は、[Req](https://hexdocs.pm/req/Req.html)を使ってみます。

> Req is an HTTP client with a focus on ease of use and composability, built on top of Finch.


# What is [Req](https://hexdocs.pm/req/Req.html) ?

[Elixir](https://elixir-lang.org/)でHTTP通信する[Hex](https://hex.pm/)と言えば何をおもいうかべますか？

私は、[HTTPoison](https://github.com/edgurgel/httpoison)です。

それで昨日、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)にデフォルトで[HTTPoison](https://github.com/edgurgel/httpoison)を入れてみない？　というプルリクを出してみました。

https://github.com/livebook-dev/nerves_livebook/pull/148

そうしたら、[Req](https://hexdocs.pm/req/Req.html)はどうだい？　という返事をいただきました。

[Req](https://hexdocs.pm/req/Req.html)って何だい？　ということで調べてみました。

> Req is an HTTP client with a focus on ease of use and composability, built on top of Finch.

# Youngです!

https://hex.pm/packages/req

をみると、初登場は**Jul 15, 2021**です。

[Jason](https://github.com/michalmuskala/jason)が依存ライブラリに入っていて、JSONをいい感じに扱ってくれます。

# HTTP Get!

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!()
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))
```

:tada::tada::tada:

@mnishiguchi さんの実装例が参考になりますのでご紹介しておきます。
[HTTPoison](https://github.com/edgurgel/httpoison)を[Req](https://hexdocs.pm/req/Req.html)に置き換えられています:rocket::rocket::rocket:

```diff
  def fetch_current_weather!() do
-    %HTTPoison.Response{status_code: 200, body: body} = HTTPoison.get!(@weather_url)
-    [current_weather] = body |> Jason.decode!() |> Access.fetch!("current_condition")
+    %Req.Response{status: 200, body: body} = Req.get!(@weather_url)
+    [current_weather] = body |> Access.fetch!("current_condition")
```


https://github.com/mnishiguchi/nerves_inky_phat_weather_example/commit/f6a767c80942af54cf1c4ca220b3a6f168d32029



# HTTP POST!

LINEのAPIでの使用例を書いてみました。

https://developers.line.biz/en/reference/messaging-api/#send-reply-message

```elixir
Mix.install [{:req, "~> 0.2.1"}]

reply_token = "reply_token"
text = "text"
channel_access_token = "channel_access_token"

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
  Authorization: "Bearer #{channel_access_token}"
]

%Req.Response{status: 200} = Req.post!(url, json, headers: headers)
```

こんな感じです。
楽しんでください:rocket::rocket::rocket:

---

こういうときにHTTP POSTの例を書くのにいいやつ知りませんか〜
あー　思い出した。

https://httpbin.org

がよさそうですね!!!

```elixir
Mix.install [{:req, "~> 0.2.1"}]

json = %{ enjoy: "Elixir" } |> Jason.encode!()
%Req.Response{body: %{"json" => something}, status: 200}
  = Req.post!("https://httpbin.org/post", json)

something["enjoy"] == "Elixir" # true
```

また、こんな使い方もできます！

```elixir
iex> Req.post!("https://httpbin.org/post", {:json, %{ enjoy: %{Elixir: "awesome"} }})
```

コメント欄をご覧ください。

- https://qiita.com/torifukukaiou/items/4d842c6acae2b8967467#comment-8fa5b5989fc5ee6d4c30

@mnishiguchi さんのコメントから調べました。
コメントありがとうございます。


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

<font color="purple">$\huge{I\ like\ Req\ 👍}$</font>
 


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
