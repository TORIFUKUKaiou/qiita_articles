---
title: AdventCalendar2022タグがついた記事をQiita API v2を使わせていただいて取得することを楽しむ（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-15T08:22:02+09:00'
id: ba2b283537bc84e0c196
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**このたびはぬさも取りあへずたむけ山もみぢのにしき神のまにまに（菅公）**

Advent Calendar 2022 73日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグがついた記事を取得してみます。

# [AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグ

@kaizen_nagoya さんの[記事](https://qiita.com/kaizen_nagoya/items/0f48e2a8402f40630976)である事実を知りました。

https://qiita.com/kaizen_nagoya/items/0f48e2a8402f40630976

[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグが付いた記事の数が、[AdventCalendar2021](https://qiita.com/tags/adventcalendar2021)タグが付いた記事の数を超えたそうです。

# [Qiita API v2](https://qiita.com/api/v2/docs)

[Qiita API v2](https://qiita.com/api/v2/docs)で[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグがついた記事を取得してみます。
もちろん、[Elixir](https://elixir-lang.org/)で書きます。

[GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items) APIを使います。

```elixir:adventcalendar2022.exs
Mix.install([:req])

Stream.iterate(1, &(&1 + 1))
|> Enum.reduce_while([], fn page, acc ->
  IO.puts(page)
  encoded_query = URI.encode_query(%{query: "tag:AdventCalendar2022", page: page, per_page: 100})

  %{body: body, headers: headers} =
    Req.get!("https://qiita.com/api/v2/items?#{encoded_query}",
      finch_options: [pool_timeout: 50000, receive_timeout: 50000]
    )

  total_count = headers |> Map.new() |> Map.get("total-count") |> String.to_integer()
  new_acc = body ++ acc

  {if(Enum.count(new_acc) >= total_count, do: :halt, else: :cont), new_acc}
end)
|> IO.inspect()
```

# 実行

[Elixir](https://elixir-lang.org/)は1.12 or laterをインストールしておいてください。

```
elixir adventcalendar2022.exs
```

結果は、Listで得られます。
List内の各要素は以下のようなMapです。
先頭のMapのみすべてのキーを書いています。

```elixir
[
%{
  "body" => "**月見ればちぢにものこそ悲しけれわが身ひとつの秋にはあらねど**\n\nAdvent Calendar 2022 72日目[^1]の記事です。\nI'm looking forward to 12/25,2022 ...",
  "coediting" => false,
  "comments_count" => 0,
  "created_at" => "2022-03-13T22:48:32+09:00",
  "group" => nil,
  "id" => "e29ccaffa405ebdbc4c1",
  "likes_count" => 3,
  "page_views_count" => nil,
  "private" => false,
  "reactions_count" => 0,
  "rendered_body" => "<p><strong>月見ればちぢにものこそ悲しけれわが身ひとつの秋にはあらねど</strong></p>\n<p>Advent Calendar 2022 72日目<sup><a href=\"#fn-1\" id=\"fnref-1\">1</a></sup>の記事です。<br>\nI'm looking forward to 12/25,2022 ...",
  "tags" => [
    %{"name" => "Elixir", "versions" => []},
    %{"name" => "40代駆け出しエンジニア", "versions" => []},
    %{"name" => "autoracex", "versions" => []},
    %{"name" => "AdventCalendar2022", "versions" => []}
  ],
  "team_membership" => nil,
  "title" => "thenを読んでみる、見様見真似でマクロを書いて楽しむ（Elixir）",
  "updated_at" => "2022-03-14T22:11:45+09:00",
  "url" => "https://qiita.com/torifukukaiou/items/e29ccaffa405ebdbc4c1",
  "user" => %{
    "description" => "",
    "facebook_id" => "",
    "followees_count" => 437,
    "followers_count" => 137,
    "github_login_name" => nil,
    "id" => "torifukukaiou",
    "items_count" => 343,
    "linkedin_id" => "",
    "location" => "",
    "name" => "",
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


[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールでいろいろ整形したり、`likes_count`で並び替えたり、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)で作者ごとの`likes_count`数を集計したり、いろいろ楽しめます。

[PATCH /api/v2/items/:item_id](https://qiita.com/api/v2/docs#patch-apiv2itemsitem_id)と組み合わせれば、記事の自動更新ができます。

そうだ！
以下を書きます。

- LGTM数順に記事を並べる自動更新される記事
- これを題材に[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールの連載を書こうとおもいます。

楽しみます。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

今回は、[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグが付いた記事の数が、[AdventCalendar2021](https://qiita.com/tags/adventcalendar2021)タグが付いた記事の数を超えたことを記念？　して、[Qiita API v2](https://qiita.com/api/v2/docs)から[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)タグが付いた記事を取得するプログラムを作ってみました。
もちろんプログラミング言語は、[Elixir](https://elixir-lang.org/)を使いました。


Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





