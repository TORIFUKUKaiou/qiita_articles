---
title: Qiitaイベント投稿を応援してもらうための“仕組み”をElixirで作ろうとしたが、URLでよかった話
tags:
  - Qiita
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-25T14:55:25+09:00'
id: 5ee42757ad079844c543
organization_url_name: haw
slide: false
ignorePublish: false
---


![ChatGPT Image 2025年6月25日 11_21_20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/603ed913-fe39-4e37-b531-2f7e1147c5a9.png)


# 1. 背景：Qiita Tech Festaが始まった

[Qiita Tech Festa 2025](https://qiita.com/tech-festa/2025)が始まりました。  
自分も記事を投稿してみたものの、なかなかいいねは増えません。  
考えてみると、投稿したこと自体が社内に共有されていなかったのだと思います。  

「だったら、自動で投稿を知らせる仕組みがあればいいのでは？」  
そう思い、ちょっと作ってみようかという気になりました。  

https://qiita.com/tech-festa/2025

# 2. Qiita APIを使ってSlack通知BotをElixirで作ろうとした

Qiitaの新着記事を取得してSlackに通知するBotを、Elixirで作ろうと考えました。
Qiita APIの [`/api/v2/items`](https://qiita.com/api/v2/docs#get-apiv2items) を使えば新着記事を取得できますし、Elixirなら非同期処理や整形も比較的楽です。

当初は、Qiita APIには「組織単位で投稿をフィルタする機能はない」と思い込んでいました。  
そのため、組織メンバーのユーザー一覧を管理し、対象ユーザーの投稿を抽出していく構成を検討していました。  

# 3. でも、`org:` でできると後から知った

実装の前にふとQiitaの検索オプションを調べてみたところ、公式ドキュメントに `org:` というパラメータがあるのを発見しました。

つまり、こういうURLです：

👉 [org\:haw の2025年6月17日以降の投稿一覧](https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17)

[https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17](https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17)

このURLだけで、HAW組織の新着投稿を日付指定で確認できます。  
`org:` で組織を絞り、`created:` で期間を指定、`sort=created` で新着順に並び替え。
まさに欲しかった結果が、そのまま得られる検索URLでした。  

Qiitaには最初から目的に合った機能が用意されていたのに、自分が知らなかっただけでした。  

## ドキュメント

ドキュメントは、その名も「[検索機能](https://help.qiita.com/ja/articles/qiita-search-options)」です。もちろんAPIのquery（クエリ）にも使えます。

## 実装例

```elixir
defmodule Qiita.Haw.Repo do
  def fetch_items do
    build_query()
    |> Qiita.Api.items()
  end

  defp build_query do
    "org:haw"
  end
end

defmodule Qiita.Api do
  @token System.get_env("HELLO_NERVES_QIITA_READ_WRITE_TOKEN")
  @headers [
    Authorization: "Bearer #{@token}",
    Accept: "Application/json; Charset=utf-8",
    "Content-Type": "application/json"
  ]
  @options [timeout: 50_000, recv_timeout: 50_000]
  @base_url "https://qiita.com/api/v2"
  @per_page 100

  def items(query) when is_bitstring(query) do
    %{"query" => query}
    |> URI.encode_query()
    |> do_items()
  end

  defp do_items(query) do
    total_count(query) |> max_page() |> do_items(query)
  end

  defp do_items(0, _query), do: []

  defp do_items(max_page, query) do
    1..max_page
    |> Enum.reduce([], fn page, acc_list ->
      "#{@base_url}/items?#{query}&per_page=#{@per_page}&page=#{page}"
      |> HTTPoison.get!(@headers, @options)
      |> Map.get(:body)
      |> Jason.decode()
      |> handle_json_decode()
      |> Kernel.++(acc_list)
    end)
  end

  defp total_count(query) do
    "#{@base_url}/items?#{query}&per_page=1"
    |> HTTPoison.get!(@headers, @options)
    |> Map.get(:headers)
    |> Enum.filter(fn {key, _} -> key == "Total-Count" end)
    |> Enum.at(0)
    |> elem(1)
    |> String.to_integer()
  end

  defp max_page(total_count) when rem(total_count, @per_page) == 0 do
    div(total_count, @per_page)
    # https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3
    |> min(100)
  end

  defp max_page(total_count) do
    (div(total_count, @per_page) + 1)
    # https://qiita.com/api/v2/docs#%E3%83%9A%E3%83%BC%E3%82%B8%E3%83%8D%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3
    |> min(100)
  end

  defp handle_json_decode({:error, _}), do: []

  defp handle_json_decode({:ok, map}) do
    Enum.map(
      map,
      &Map.take(&1, [
        "title",
        "likes_count",
        "updated_at",
        "created_at",
        "url",
        "user",
        "tags",
        "private",
        "organization_url_name"
      ])
    )
    |> Enum.map(fn %{
                     "user" => %{"id" => user_id},
                     "updated_at" => updated_at,
                     "created_at" => created_at,
                     "tags" => tags
                   } = item ->
      updated_at = Timex.parse!(updated_at, "{ISO:Extended}") |> Timex.to_datetime()
      created_at = Timex.parse!(created_at, "{ISO:Extended}") |> Timex.to_datetime()
      tags = Enum.map(tags, &Map.get(&1, "name"))

      item
      |> Map.delete("user")
      |> Map.delete("tags")
      |> Map.merge(%{
        "user_id" => user_id,
        "updated_at" => updated_at,
        "created_at" => created_at,
        "tags" => tags
      })
    end)
    |> Enum.reject(&Map.get(&1, "private"))
  end
end
```

# 4. 結論：「作る前に知る」

仕組みをコードで作ること自体は楽しいし、ElixirでBotを作るのも悪くなかったと思います。  
でも今回に関しては、Qiitaの検索URLを使うだけで目的は達成できました。  

すでに存在している手段を知らずに、遠回りをしようとしていた。  
今回の件は、それに気づくよい機会になりました。  

Generative AI先生に、この記事を例えるコードを書いてもらいました。  

```elixir
defmodule Simplify do
  def reach_goal_fast do
    IO.puts("目的が明確なら、最短距離を探せ。")
    IO.puts("仕組みよりURL。判断をリファクタしろ。")
  end
end

Simplify.reach_goal_fast()
```

# 5. 気づき：「効率化」とは、知っていることから始まる

効率化と聞くと、すぐに「自動化」や「プログラミング」で何とかしようと考えがちです。  
でも本当の効率化は、「すでにある機能を正しく知り、使えること」から始まるのだと感じました。  

知らなかっただけで、Qiitaはすでに十分すぎる機能を持っていた。  
それに気づけたのは、技術的というより、思考の整理として有意義でした。  

**それを超える、もっと良い手段がないか考え抜く**

## :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:

![スクリーンショット 2025-06-25 11.04.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8d01ecec-7360-4268-9751-e46df55089e4.png)

「Standard Organization」の条件である10記事は、すでに投稿（闘魂）を終えました。  
あとは、いいね :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5: が増えるのを切に乞い願う次第です。  

---

# おまけ：同じような状況の方へ

もし「Qiitaの組織投稿をチームで共有したい」と考えている方がいれば、検索URLをそのままSlackなどに貼るだけで済むかもしれません。

例:

👉 [HAW組織による最近の投稿一覧](https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17)

[https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17](https://qiita.com/search?sort=created&q=org%3Ahaw+created%3A%3E%3D2025-06-17)

`org`の値をあなたの組織に変えてください。  

---

ここまで読んでいただいてアレですが、組織ページでもいいんじゃないの？　と思われた方、そうです。その通りです。

[https://qiita.com/organizations/haw/items](https://qiita.com/organizations/haw/items) これでもいいと思います。  

https://qiita.com/tech-festa/2025/tech-sprint

あえてこの記事の利点を申せば、（申すほどの利点もありませんが、）[Qiita Tech Sprint](https://qiita.com/tech-festa/2025/tech-sprint)の対象期間の始期日でフィルタリングしている点でしょうか。[https://qiita.com/organizations/haw/items](https://qiita.com/organizations/haw/items) こちらの場合は、はりきって、いいね :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:していただける方に、それはそれでいいと思って押したのでしょうからもちろんよいのですが、対象外の記事まで提示してしまうことになります。



---

**いいと思った記事に、「いいね」をしましょう！**
**いい記事を書きましょう！** (果たして、じゃあ、この記事はいい記事なのか :interrobang: それは、時が判断してくれる。猪木vsアリ戦のように再評価されることを願って）

https://qiita.com/official-events/373107c63dfb360f9d9b
