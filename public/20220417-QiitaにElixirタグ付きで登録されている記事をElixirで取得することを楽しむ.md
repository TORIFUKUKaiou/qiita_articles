---
title: QiitaにElixirタグ付きで登録されている記事をElixirで取得することを楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-12-19T22:04:40+09:00'
id: 38493ca50c57d88a65fb
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**風をいたみ岩打つ波のおのれのみくだけてものを思ふ頃かな**

Advent Calendar 2022 100日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、[Elixirタグ](https://qiita.com/tags/elixir)付きで登録されている記事を[Elixir](https://elixir-lang.org/)のプログラムで取得してみます。
もちろん[Elixir](https://elixir-lang.org/)を使います。

# プログラム

さっそくプログラムです。
どうぞ〜。
ファイル名は`sample.exs`にしています。

```elixir:sample.exs
Mix.install([:req], force: true)

tag = "Elixir"

Stream.iterate(1, &(&1 + 1))
|> Enum.reduce_while([], fn page, acc ->
  IO.puts("page: #{page}")

  %{body: body, status: 200, headers: headers} =
    URI.encode_query(%{query: "tag:#{tag}", per_page: 100, page: page})
    |> then(fn query -> "https://qiita.com/api/v2/items?#{query}" end)
    |> Req.get!(pool_timeout: 50000, receive_timeout: 50000)

  total_count =
    headers
    |> Enum.find(fn {key, _} -> key == "total-count" end)
    |> elem(1)
    |> String.to_integer()

  if total_count > (page * 100) do
    {:cont, body ++ acc}
  else
    {:halt, body ++ acc}
  end
end)
|> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
|> Jason.encode!(pretty: true)
|> then(&File.write!("output.json", &1))
```

# 実行

上記の通り、`sample.exs`を作ってみましょう。
実行してみましょう。

[Elixir](https://elixir-lang.org/)をインストールしていない方のために[Docker](https://www.docker.com/)での実行方法も書いておきます。

2022/04/17現在、約2,700件弱、[Elixirタグ](https://qiita.com/tags/elixir)の付いた記事がQiitaに登録されています。
そのため、`page: 27`となったところでAPIコールは停止します。

この27回を前提にすると、APIの[利用制限](https://qiita.com/api/v2/docs#%E5%88%A9%E7%94%A8%E5%88%B6%E9%99%90)は以下のようになっておりますので、現時点では認証なしでもすべての記事を取得できます。

> 認証している状態ではユーザごとに1時間に1000回まで、認証していない状態ではIPアドレスごとに1時間に60回までリクエストを受け付けます。


## [Docker](https://www.docker.com/)

```bash
docker pull hexpm/elixir:1.13.4-erlang-23.0.2-debian-bullseye-20210902

docker run --rm -w /app -v `pwd`:/app hexpm/elixir:1.13.4-erlang-23.0.2-debian-bullseye-20210902 mix local.hex --force && elixir sample.exs
```

## [Elixir](https://elixir-lang.org/)インストールしているよ

```bash
elixir sample.exs
```

macOS Catalina 10.15.7
Elixir 1.13.1 (compiled with Erlang/OTP 24)



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:


この記事は、[Elixirタグ](https://qiita.com/tags/elixir)付きで登録されている記事を[Elixir](https://elixir-lang.org/)のプログラムで取得してみることを楽しんでみました。

区切りの私の[Advent Calendar 2022](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955) 100日目の記事はこんなところで終わります。


Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

---

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We appreciate this shoutout, Torifuku! <a href="https://t.co/dThmJg4CYN">pic.twitter.com/dThmJg4CYN</a></p>&mdash; ClickUp (@clickup) <a href="https://twitter.com/clickup/status/1513541411634913284?ref_src=twsrc%5Etfw">April 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 






