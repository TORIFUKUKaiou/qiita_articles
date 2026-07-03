---
title: ElixirのHTTP ClientライブラリReqでベーシック認証を楽しんでみる
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-12T21:54:25+09:00'
id: b56320bc23324eee9280
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**わびぬれば今はた同じなにはなるみをつくしてもあはむとぞ思ふ**

:::note warn
ReqはヤングなHTTP Clientライブラリです。
この記事の内容はすでに古くなっているかもしれません。
https://hexdocs.pm/req/Req.html
をご確認ください。
:::


---

Advent Calendar 2022 69日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Elixir](https://elixir-lang.org/)のHTTP Clientライブラリ[Req](https://hexdocs.pm/req/Req.html)でベーシック認証の楽しみ方がわかりましたので書いておきます。

# 題材

https://developer.atlassian.com/cloud/bitbucket/rest/intro/#authentication

Bitbucketからアクセストークンを取得するAPIを[Req](https://hexdocs.pm/req/Req.html)で使ってみます。

## curl

サンプルとしてcurlを使用した例を示します。

```
$ curl -X POST -u "client_id:secret" \
  https://bitbucket.org/site/oauth2/access_token \
  -d grant_type=client_credentials
```

これを[Elixir](https://elixir-lang.org/)で書いてみるわけです。

## 参考記事

https://qiita.com/torifukukaiou/items/6558d211a80f7174f85a

`client_id:secret`については上記の記事を参考にしてください。


# プログラム

この記事のハイライトです。
[Elixir](https://elixir-lang.org/)のHTTP Clientライブラリ[Req](https://hexdocs.pm/req/Req.html)でベーシック認証を楽しんでみます。

```elixir
Mix.install([
  {:req, "~> 0.2.1"}
])

client_id = "client id"
secret = "secret"

%{body: body, status: 200} =
  Req.post!(
    "https://bitbucket.org/site/oauth2/access_token",
    {:form, [grant_type: "client_credentials"]},
    auth: {client_id, secret}
  )

access_token = Map.get(body, "access_token")
```

[Req.post!/3](https://hexdocs.pm/req/Req.html#post!/3)の第3引数に`auth: {client_id, secret}`というふうに指定をします。

どうでしょうか？
楽しんでいただけましたでしょうか！



# 公式ドキュメントの記述

https://hexdocs.pm/req/Req.html#auth/2

公式ドキュメントは、[こちら](https://hexdocs.pm/req/Req.html#auth/2)にベーシック認証に関して書かれています。

ぼーっとなんとな〜く眺めていてみつけました。





---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

この記事は、[Elixir](https://elixir-lang.org/)のHTTP Clientライブラリ[Req](https://hexdocs.pm/req/Req.html)でベーシック認証の楽しみ方がわかりましたので書いておきました。

:lgtm: やコメントは、励みになりますし、私はちょっぴりハゲています。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



以上です。





