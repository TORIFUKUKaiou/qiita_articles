---
title: Slackのusers.list APIをElixirのHTTP ClientライブラリReqを使用して呼び出すことを楽しむ
tags:
  - Elixir
  - Slack
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-12T21:18:02+09:00'
id: 4ab415d1b1bcbd375e48
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**なにはがた短きあしのふしのまもあはでこの世をすごしてよとや**


---

Advent Calendar 2022 68日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

Slackの[users.list](https://api.slack.com/methods/users.list) APIを[Elixir](https://elixir-lang.org/)のHTTP Clientライブラリ[Req](https://hexdocs.pm/req/Req.html)を使用して呼び出すことを楽しんでみます。

# プログラム

プログラム例を示します。
`user_oauth_token`は後述します。

```elixir:users_list.exs
Mix.install([:req])

user_oauth_token = "xoxp-xxxx"

headers = [
  "Content-type": "application/json",
  Authorization: "Bearer #{user_oauth_token}"
]

Stream.iterate(1, &(&1 + 1))
|> Enum.reduce_while({[], ""}, fn _, {acc_members, cursor} ->
  IO.puts cursor
  %{
    body: %{
      "members" => members,
      "response_metadata" => %{"next_cursor" => next_cursor},
      "ok" => true
    }
  } =
    "https://slack.com/api/users.list?limit=100&cursor=#{cursor}"
    |> URI.encode()
    |> Req.get!(headers: headers)

  {if(next_cursor == "", do: :halt, else: :cont), {acc_members ++ members, next_cursor}}
end)
|> elem(0)
```

どうでしょうか。

元気ですかー！
お楽しみいただけましたでしょうか！

# Slackアプリの作成

[Bolt for Python の入門ガイド](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started)内にある「[アプリを作成する](https://slack.dev/bolt-python/ja-jp/tutorial/getting-started#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%92%E4%BD%9C%E6%88%90%E3%81%99%E3%82%8B)」が参考になります。

Slackアプリを作成した後は、`OAuth & Permissions`の設定です。
`OAuth & Permissions`設定画面にて、以下のScopesを有効にしておいてください。

- `users:read`
- `users:read.email` （任意）

![スクリーンショット 2022-03-12 21.00.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0d8a46d9-8ed7-ff5d-390c-6c8cb23b0295.png)



`OAuth & Permissions`設定画面内にある、`xoxp-`ではじまる`User OAuth Token`をプログラムで使用します。




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

この記事は、Slackの[users.list](https://api.slack.com/methods/users.list) APIを[Elixir](https://elixir-lang.org/)のHTTP Clientライブラリ[Req](https://hexdocs.pm/req/Req.html)を使用して呼び出すことを楽しんでみました。

:lgtm: やコメントは、励みになりますし、私はちょっぴりハゲています。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



以上です。





