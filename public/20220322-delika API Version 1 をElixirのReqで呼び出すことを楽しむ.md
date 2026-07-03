---
title: delika API Version 1 をElixirのReqで呼び出すことを楽しむ
tags:
  - delika
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
  - Qiitadelika
private: false
updated_at: '2022-03-22T22:52:29+09:00'
id: 0971c880041c762e0213
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/30be12dd14c0aad2c1c2

**山川に風のかけたるしがらみは流れもあへぬもみぢなりけり**

Advent Calendar 2022 82日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」と銘打たれたイベントが開催中です。

この記事は、 **テーマ１　『delikaを使った記事を書こう！』** の参加記事です。
[delika API Version 1](https://docs.delika.io/api/v1/)を使用してみます。
[Elixir](https://elixir-lang.org/)で楽しんでみます。

自分自身で書きました「[delika API Version 1 をcurlで呼び出してみる](https://qiita.com/torifukukaiou/items/ea8b91d935f03a51b2cf)」の後続記事です。

https://qiita.com/torifukukaiou/items/ea8b91d935f03a51b2cf

# 前提

以下を前提とします。

- [delika](https://delika.io/)のSign upを済ませておいてください
- [delika API Version 1](https://docs.delika.io/api/v1/)の基本的な使い方を理解しておいてください

[delika API Version 1](https://docs.delika.io/api/v1/)の[ドキュメント](https://docs.delika.io/api/v1/)を読んでいただくか、私が書いた「[delika API Version 1 をcurlで呼び出してみる](https://qiita.com/torifukukaiou/items/ea8b91d935f03a51b2cf)」を参考にしてください。

https://qiita.com/torifukukaiou/items/ea8b91d935f03a51b2cf


# Elixirのプログラム

`Refresh Token`は、 https://api.delika.io/v1/auth にブラウザでアクセスしSign inすることで得てください。
HTTPクライアントは[Req](https://github.com/wojtekmach/req)を使用しています。
JSONのライブラリ[Jason](https://github.com/michalmuskala/jason)が漏れなく付いてきます。

```elixir:delika_api.exs
Mix.install([:req])

body =
  %{
    "RefreshToken" => "あなたが得たRefresh Token"
  }
  |> Jason.encode!()

%{body: %{"Data" => %{"AccessToken" => access_token}, "Status" => %{"Code" => 200}}, status: 200} =
  Req.post!("https://api.delika.io/v1/auth/token", body,
    headers: ["Content-Type": "application/json"], # この指定は必須です
    finch_options: [pool_timeout: 50000, receive_timeout: 50000]
  )

Req.get!("https://api.delika.io/v1/account/connecto-data/datasets",
  headers: [Authorization: "bearer #{access_token}"],
  finch_options: [pool_timeout: 50000, receive_timeout: 50000]
)
|> Map.get(:body)
|> IO.inspect()
```

# 実行

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)を使っています。
そのため、[Elixir](https://elixir-lang.org/)は`1.12` or laterを使用してください。
さきほど示したプログラムのファイル名は、`delika_api.exs`とします。

```bash
elixir delika_api.exs
```


# 結果（2022-03-22 22:42JST）

実行結果は以下のようになりました :tada::tada::tada: 

```elixir
%{
  "Data" => %{
    "DatasetCount" => 2,
    "DatasetList" => [
      %{"AccountName" => "connecto-data", "DatasetName" => "ds-skills"},
      %{"AccountName" => "connecto-data", "DatasetName" => "survey"}
    ]
  },
  "Status" => %{"Code" => 200, "Message" => "Found 2 datasets."}
}
```


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

この記事では、 [delika API Version 1](https://docs.delika.io/api/v1/)を[Elixir](https://elixir-lang.org/)でコールする方法を示しました。
私は楽しみました。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。

---

# 尚々書

[delika](https://delika.io/welcome)を[Elixir](https://elixir-lang.org/)で楽しむ準備は着々と進んでいます。


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





