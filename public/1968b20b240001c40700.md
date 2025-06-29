---
title: '闘魂Elixir: クライアント証明書付きでHTTP POSTでアクセストークンを30個発行してみた（Tapyrus API編）'
tags:
  - Elixir
  - 猪木
  - req
  - Tapyrus
  - 闘魂
private: false
updated_at: '2025-06-28T20:43:41+09:00'
id: 1968b20b240001c40700
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/tech-festa/2025

# はじめに


前回の記事では「クライアント証明書付きでGETしてみた」でした。
今回は **Elixirで[Tapyrus API](https://site.tapyrus.chaintope.com/api/)のアクセストークンを30件一気に発行してPOSTしてみた** 話です。
**量産、闘魂、爆発力。**

## 参考: 前回の記事

前回の記事「[闘魂Elixir: Elixirの電池入りHTTPクライアントReqでクライアント証明書付きAPIコールを試す（Tapyrus API編）](https://qiita.com/torifukukaiou/items/6ea60dfc832e91074ff9)」です。

https://qiita.com/torifukukaiou/items/6ea60dfc832e91074ff9

# 対象のAPI

[ユーザーの作成](https://doc.api.tapyrus.chaintope.com/#operation/createUser) APIを使ってみます。API POSTです。

# プログラム例

[Elixir](https://elixir-lang.org/)で実装したプログラム例です。

```elixir:tapyrus_api_create_users.exs
Mix.install([{:req, "~> 0.5.0"}])

tapyrus_api_endpoint = System.get_env("TAPYRUS_API_ENDPOINT") |> IO.inspect()
tapyrus_api_admin_user_access_token = System.get_env("TAPYRUS_API_ADMIN_USER_ACCESS_TOKEN") |> IO.inspect()

headers = [
  "Content-Type": "application/json",
  Authorization: "Bearer #{tapyrus_api_admin_user_access_token}"
]

{:ok, dt} = DateTime.new(~D[2026-01-01], ~T[00:00:00], "Etc/UTC")
expires_at = DateTime.to_unix(dt)

url = "#{tapyrus_api_endpoint}/api/v1/users"

options = [
  connect_options: [transport_opts: [certfile: ~c"cert.pem"], timeout: 60_000],
  headers: headers,
  receive_timeout: 60_000
]

Enum.each(1..30, fn i ->
  json = %{
    "subject" => "user-#{String.pad_leading(Integer.to_string(i), 3, "0")}",
    "expires_at" => expires_at
  }
  options = Keyword.put(options, :json, json)
  %{status: 201, body: %{"access_token" => access_token}} = Req.post!(url, options)
  IO.puts(access_token)
end)
```

## 使い方

使い方を書いておきます。

- 実行方法は、Elixirをインストールしておいて、`elixir tapyrus_api_create_users.exs` です
- 環境変数`TAPYRUS_API_ENDPOINT`と`TAPYRUS_API_ADMIN_USER_ACCESS_TOKEN`を実行前にセットしておいてください
- クライアント証明書`cert.pem`として同じディレクトリにご用意ください

## 説明

説明をしておきます。

- [ユーザーの作成](https://doc.api.tapyrus.chaintope.com/#operation/createUser) APIを繰り返し呼び出しています
    - このプログラム例では、30回ですので、30ユーザーのアクセストークンが作られます
- `subject`は、`user-001`〜`user-030`を指定してコールしています
    - `String.pad_leading/3`を使って、先頭`0`埋めの文字列を作っています
- 各ユーザーアクセストークンの有効期限を設定しています
    - 上のプログラム例では、 `DateTime.new(~D[2026-01-01], ~T[00:00:00], "Etc/UTC")` としています
- `~c"..."` は Elixir の charlist（Erlang互換）リテラルです
    - `'cert.pem'`と書いても同じですが、実行時に警告がでるので、`~c"cert.pem"`にしています

# さいごに

`GET`ができたのだから、`POST`もできるだろうとはおもいましたが、やってみないと気が済まない性分で、さらにやってみたことは世紀の大発見でもしたかのように、この喜び、興奮を発信したくなる性分でして、記事を書きました。

弊社では、[Tapyrus API](https://site.tapyrus.chaintope.com/api/)を使うことが多く、たとえばハンズオンで、「ユーザー（アクセストークン）を用意しておいて」と言われることもあり、まあ、`GET`の内容さえあれば少し変えてこのくらいのことはすぐにできるわけですが、[Elixir](https://elixir-lang.org/) x [Tapyrus API](https://site.tapyrus.chaintope.com/api/) の事例はまだまだ少ないので、記事をしたためた次第です。  

私は、どこかでまたこの記事を参照して活用することがきっとあります。
私のような方がどこかにいらっしゃるかもしれませんので、**Qiitaさんの場をお借りして、全世界に発信** をしておきます。
本当にQiitaさんには感謝の言葉しかありません。

<b><font color="red">$\huge{ありがとうーーーッ！！！}$</font></b>

