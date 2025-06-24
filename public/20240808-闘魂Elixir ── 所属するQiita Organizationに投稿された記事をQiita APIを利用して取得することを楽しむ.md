---
title: 闘魂Elixir ── 所属するQiita Organizationに投稿された記事をQiita APIを利用して取得することを楽しむ
tags:
  - Elixir
  - Organizations
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2025-06-24T00:03:14+09:00'
id: 9ea1d1652d08d330a2ce
organization_url_name: haw
slide: false
ignorePublish: false
---
:::note alert
【2025/06/24追記】

org:haw
のようなクエリで検索した方が効率的です！！！

https://help.qiita.com/ja/articles/qiita-search-options
:::

# はじめに

私達、[ハウインターナショナル](https://www.haw.co.jp/)は、Qiita Organizationを利用させていただいております。

https://qiita.com/organizations/haw

自分たちの組織が書いた記事の一覧が欲しくなりました。

[Qiita API v2](https://qiita.com/api/v2/docs)には、Organizationを指定して記事を取得するAPIは無いように見えました。
（本当はあったらごめんなさい :pray: :pray_tone1: :pray_tone2: :pray_tone3: :pray_tone4: :pray_tone5:）

無いなら**作ればいいじゃない！の精神**で作ってみました。

もちろん、私は[Elixir](https://elixir-lang.org/)で作ってみます。

# 実装方針

組織に属している`user`で検索して、引っかかった記事をさらにOrganizationに登録しているものだけにフィルタリングすることにします。

# ソースコード

```elixir:qiita/api.exs
Mix.install([
  {:req, "~> 0.5.0"}
])

defmodule Qiita.API do
  def items(page, per_page, query) do
    items_uri_encode(page, per_page, query)
    |> Req.get!()
  end

  def total_count(per_page, query) do
    items(1, per_page, query)
    |> Map.get(:headers)
    |> Map.get("total-count")
    |> Enum.at(0)
    |> String.to_integer()
  end

  defp items_uri_encode(page, per_page, query) do
    "https://qiita.com/api/v2/items?page=#{page}&per_page=#{per_page}&query=#{query}"
    |> URI.encode()
  end
end
```

```elixir:main.exs
defmodule Main do
  @users ~w(sgtakeru tsuruoka91 mnishiguchi torifukukaiou t_kamiya78 haw_ohnuma Erga-mion)
  @organization_url_name "haw"
  @per_page 100

  def raw_items do
    query = build_query()
    max_page = Qiita.API.total_count(@per_page, query) |> max_page()

    1..max_page
    |> Enum.reduce([], fn page, acc ->
      Qiita.API.items(page, @per_page, query)
      |> Map.get(:body)
      |> Enum.filter(fn item -> Map.get(item, "organization_url_name") == @organization_url_name end)
      |> then(fn items -> acc ++ items end)
    end)
  end

  def output_markdown do
    raw_items() # ここをソートするといろいろな並び順で出力できる
    |> build_markdown()
  end

  defp build_query do
    @users
    |> Enum.map(& "user:#{&1}")
    |> Enum.join(" or ")
  end

  defp max_page(total_count) when rem(total_count, @per_page) == 0, do: div(total_count, @per_page)
  defp max_page(total_count), do: div(total_count, @per_page) + 1

  defp build_markdown(items) do
    items
    |> Enum.with_index(1)
    |> Enum.reduce("|No|Title|user|likes_count|created_at|\n|:-:|:-|:-|:-:|:-|", fn {item, index}, acc ->
      title = Map.get(item, "title")
      url = Map.get(item, "url")
      user = get_in(item, ["user", "id"])
      likes_count = Map.get(item, "likes_count")
      created_at = Map.get(item, "created_at")

      "#{acc}\n|#{index}|[#{title}](#{url})|@#{user}|#{likes_count}|#{created_at}|"
    end)
  end
end
```

ご自身の組織にあわせて`@users`と`@organization_url_name`の値を置き換えてください。
`Main.raw_items/0`関数は[Qiita API v2](https://qiita.com/api/v2/docs)から得られた結果を特に整形せずにリストにまとめています。
`Main.output_markdown/0`関数は、情報を絞ってマークダウンの表形式で出力します。

# 実行例

Dockerで動かしてみます。

```bash
docker run --rm -it hexpm/elixir:1.17.2-erlang-27.0.1-alpine-3.20.2 iex
```

そうすると[IEx](https://hexdocs.pm/iex/IEx.html)という **REPL** (Read-Eval-Print Loop) が立ち上がりますので、上のソースコードをペターっと貼り付けてください。
そして`Main.raw_items/0`関数か、`Main.output_markdown/0`関数を実行してください。

## `Main.raw_items/0`関数の実行例

```elixir
iex> Main.raw_items
[
  %{
    "body" => "# Example",
    "coediting" => false,
    "comments_count" => 0,
    "created_at" => "2024-08-06T20:55:57+09:00",
    "group" => nil,
    "id" => "1794f001c7f81cbafca7",
    "likes_count" => 4,
    "organization_url_name" => "haw",
    "page_views_count" => nil,
    "private" => false,
    "reactions_count" => 0,
    "rendered_body" => "<h1>Example</h1>",
    "slide" => false,
    "stocks_count" => 0,
    "tags" => [
      %{"name" => "AWS", "versions" => []},
      %{"name" => "lambda", "versions" => []},
      %{"name" => "LINEmessagingAPI", "versions" => []},
      %{"name" => "闘魂", "versions" => []},
      %{"name" => "AdventCalendar2024", "versions" => []}
    ],
    "team_membership" => nil,
    "title" => "AWS Lambda上で「LINE Messaging API SDK for Python」を使ったコードをデプロイしてLINE Botを作ることを楽しむ",
    "updated_at" => "2024-08-07T14:18:11+09:00",
    "url" => "https://qiita.com/torifukukaiou/items/1794f001c7f81cbafca7",
    "user" => %{
      "description" => "",
      "facebook_id" => "",
      "followees_count" => 532,
      "followers_count" => 365,
      "github_login_name" => "TORIFUKUKaiou",
      "id" => "torifukukaiou",
      "items_count" => 615,
      "linkedin_id" => "",
      "location" => "",
      "name" => "Awesome YAMAUCHI",
      "organization" => "",
      "permanent_id" => 131808,
      "profile_image_url" => "https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/profile-images/1616590306",
      "team_only" => false,
      "twitter_screen_name" => "torifukukaiou",
      "website_url" => "https://www.torifuku-kaiou.tokyo/"
    }
  },
  %{...},
  ...
]
```

[Qiita API v2](https://qiita.com/api/v2/docs)から得られた結果をそのままリストに格納しています。

## `Main.output_markdown/0`関数の実行例

```elixir
iex> Main.output_markdown |> IO.puts
|No|Title|user|likes_count|created_at|
|:-:|:-|:-|:-:|:-|
|1|[AWS Lambda上で「LINE Messaging API SDK for Python」を使ったコードをデプロイしてLINE Botを作ることを楽しむ](https://qiita.com/torifukukaiou/items/1794f001c7f81cbafca7)|@torifukukaiou|4|2024-08-06T20:55:57+09:00|
|2|[Linux Mint (LMDE6)で L2TP/IPsecを使ったVPNを使う](https://qiita.com/mnishiguchi/items/e5ccc2c57b1981a5a4ee)|@mnishiguchi|6|2024-07-24T07:44:24+09:00|
|3|[postgresql.conf をマウントするとGithubActions 上でエラーになる](https://qiita.com/sgtakeru/items/a23b32a484ee93659a8c)|@sgtakeru|1|2024-07-16T09:42:10+09:00|
|4|[postgresql で shared buffer hash table corrupted が発生した ](https://qiita.com/sgtakeru/items/af55cc1f901eafe5d6ea)|@sgtakeru|2|2024-07-08T13:41:58+09:00|
|5|[Phi-3-miniをFine-Tuningしてみる。](https://qiita.com/t_kamiya78/items/c63c9358820f9200452a)|@t_kamiya78|5|2024-06-08T17:10:39+09:00|
|6|[闘魂Elixir ーー 書籍『Elixir実践入門』のご紹介（書きました！）](https://qiita.com/torifukukaiou/items/132fa43dd1c84f6b6b68)|@torifukukaiou|11|2024-05-20T11:44:49+09:00|
|7|[Difyでローカル環境のチャットボットを作る](https://qiita.com/t_kamiya78/items/ec9f62db9349b1804366)|@t_kamiya78|19|2024-05-13T13:09:36+09:00|
|8|[AtCoder Beginner Contest 352をRustで楽しむ](https://qiita.com/haw_ohnuma/items/fa1ea555dbf7e0b5314c)|@haw_ohnuma|3|2024-05-07T10:53:08+09:00|
|9|[闘魂Elixir ーー AtCoder Beginner Contest 350をElixirで楽しむ](https://qiita.com/torifukukaiou/items/54ec41d12a4f84dd1773)|@torifukukaiou|2|2024-04-26T13:17:17+09:00|
|10|[闘魂Elixir ーー AtCoder Beginner Contest 349をElixirで楽しむ](https://qiita.com/torifukukaiou/items/3454a1425e677524fbff)|@torifukukaiou|5|2024-04-22T17:24:27+09:00|
|11|[闘魂Elixir ── Qiitaを書いていると技術書の著者になれましたので、「Qiitaに投稿することを続けているときっとあなたの新たな可能性という扉を開いてくれます」](https://qiita.com/torifukukaiou/items/2a692cb060ffe5d926c1)|@torifukukaiou|18|2024-03-13T23:20:28+09:00|
|12|[LLM(gemma)&LangChainで会社のQABotっぽい物を作成する](https://qiita.com/t_kamiya78/items/659d156c4a88e6a37de9)|@t_kamiya78|15|2024-02-26T20:57:04+09:00|
|13|[pandasのDataFrameに複数行の値をインプットにして新しい列の値を作ることをPythonで楽しんでなおかつ、Elixirでも同じことを楽しむ](https://qiita.com/torifukukaiou/items/764cea61d3f724688a04)|@torifukukaiou|4|2024-02-23T20:20:03+09:00|
|14|[Fletを触ってみる。](https://qiita.com/t_kamiya78/items/017aa0be45c9bf7ba78b)|@t_kamiya78|3|2024-02-17T19:20:01+09:00|
|15|[LangChainでGeminiを触ってみる](https://qiita.com/t_kamiya78/items/4fbb802a98a32bf4c5f7)|@t_kamiya78|7|2023-12-25T18:55:42+09:00|
|16|[高校生向けプログラミング講座「福岡県Rubyキャンプ」にコーチとして参加してきました！](https://qiita.com/torifukukaiou/items/5165ac61a092002cf3a4)|@torifukukaiou|8|2023-11-24T15:36:20+09:00|
|17|[Google Cloud Next Tokyo ’23 Day2参加レポート](https://qiita.com/haw_ohnuma/items/e29ddd683f3e7a12cc5d)|@haw_ohnuma|2|2023-11-20T09:15:46+09:00|
|18|[Monacoinのマイニングから学ぶブロックチェーン](https://qiita.com/torifukukaiou/items/5bd93c1b2df055dcacc4)|@torifukukaiou|6|2023-09-29T13:03:04+09:00|
|19|[国土交通省が公開しているハザードマップをLeaflet上に表示する](https://qiita.com/tsuruoka91/items/8b32c33be983b0ca208a)|@tsuruoka91|2|2023-09-22T14:25:30+09:00|
|20|[探検Elixir: OTP 26のマップに関する不思議な冒険](https://qiita.com/torifukukaiou/items/638e9cd16eeef1450528)|@torifukukaiou|4|2023-09-18T08:18:14+09:00|
|21|[Dockerコンテナ上でSpringを使ってHello Worldを楽しむ（in チャレキャラ）](https://qiita.com/torifukukaiou/items/5bf02da6dee22efecf3c)|@torifukukaiou|3|2023-09-06T08:59:31+09:00|
|22|[Qiita CLIで取得した.mdファイルのファイル名をElixirで変更する](https://qiita.com/torifukukaiou/items/aaca74a5033d0ddbc363)|@torifukukaiou|8|2023-08-30T09:12:09+09:00|
|23|[Qiita Organizationに登録するまでの社内調整（おもいで）](https://qiita.com/torifukukaiou/items/23c85293e673f537b5e4)|@torifukukaiou|8|2023-08-27T09:15:22+09:00|
:ok
```

マークダウンの表形式で出力します。

# さいごに

[Elixir](https://elixir-lang.org/)を使って、組織に属する記事を取得することを楽しみました。
あたなもお好きな言語を使って、ぜひあなたの組織の記事を取得してみてください。

**APIあるよ！** の情報をお持ちの方はぜひコメント欄でお知らせください！
お便りお待ちしています。


:::note alert
【2025/06/24追記】

org:haw
のようなクエリで検索した方が効率的です！！！

https://help.qiita.com/ja/articles/qiita-search-options
:::
