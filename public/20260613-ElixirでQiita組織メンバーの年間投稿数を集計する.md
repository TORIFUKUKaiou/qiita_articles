---
title: ElixirでQiita組織メンバーの年間投稿数を集計する
tags:
  - Qiita
  - Elixir
  - 猪木
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2026-06-13T10:36:40+09:00'
id: bbf1c18cb9dbe28ef664
organization_url_name: haw
slide: false
ignorePublish: false
---
会社の決算期間のように、技術発信も一定期間で区切って振り返ってみるとおもしろいです。

今回は、Qiita API v2を使って、ハウ社のQiita Organizationである `haw` に紐づけて投稿された記事を集計します。

対象期間は次の通りです。

```text
2025/7/1 〜 2026/6/30
```

やりたいことは2つです。

1. `org:haw` で投稿された記事を著者ごとに数える
2. その著者たちが、同じ期間にQiita全体で何本投稿しているかも数える

2つ目が少し大事です。

Qiitaでは、著者が必ずしも Organization に紐づけて投稿するとは限りません。

たとえば、ある人が会社のOrganizationで2本、個人として3本投稿している場合、`org:haw` だけを見ると2本です。しかし、その人の同期間の投稿総数は5本です。

せっかくなので、両方見えるようにします。

## 使うもの

- Elixir
- IEx
- Req
- Qiita API v2

Qiita API v2 の仕様はこちらです。

https://qiita.com/api/v2/docs

今回は、IEx上でそのまま動かすことを優先します。

Mixプロジェクトは作りません。

## Elixirをインストールしている場合

IExを起動します。

```bash
iex
```

そして、次のコードを貼り付けます。

```elixir
Mix.install([:req])

defmodule QiitaHawReport do
  @base_url "https://qiita.com/api/v2"
  @org "haw"
  @from "2025-07-01"
  @to "2026-06-30"
  @per_page 100
  @max_page 100

  def run do
    org_query = "org:#{@org} created:>=#{@from} created:<=#{@to}"

    org_items = fetch_all_items(org_query)

    rows =
      org_items
      |> Enum.group_by(&get_in(&1, ["user", "id"]))
      |> Enum.map(fn {user_id, items} ->
        total_query = "user:#{user_id} created:>=#{@from} created:<=#{@to}"
        total_count = count_items(total_query)

        %{
          user_id: user_id,
          org_count: length(items),
          total_count: total_count,
          other_count: total_count - length(items)
        }
      end)
      |> Enum.sort_by(fn row -> {-row.org_count, row.user_id} end)

    print_markdown_table(rows)
  end

  defp fetch_all_items(query, page \\ 1, acc \\ []) do
    response =
      get!("/items",
        query: query,
        page: page,
        per_page: @per_page
      )

    items = response.body
    acc = acc ++ items

    if length(items) == @per_page and page < @max_page do
      fetch_all_items(query, page + 1, acc)
    else
      acc
    end
  end

  defp count_items(query) do
    response =
      get!("/items",
        query: query,
        page: 1,
        per_page: 1
      )

    response.headers
    |> Map.get("total-count", ["0"])
    |> List.first()
    |> String.to_integer()
  end

  defp get!(path, params) do
    Req.get!(
      @base_url <> path,
      params: params,
      headers: headers()
    )
  end

  defp headers do
    case System.get_env("QIITA_TOKEN") do
      nil -> []
      "" -> []
      token -> [{"authorization", "Bearer #{token}"}]
    end
  end

  defp print_markdown_table(rows) do
    IO.puts("| 著者 | org:#{@org} 投稿数 | 同期間の全投稿数 | org外投稿数 |")
    IO.puts("| --- | ---: | ---: | ---: |")

    Enum.each(rows, fn row ->
      IO.puts(
        "| @#{row.user_id} | #{row.org_count} | #{row.total_count} | #{row.other_count} |"
      )
    end)
  end
end

QiitaHawReport.run()
```

実行すると、次のようなMarkdownテーブルが出力されます。

```markdown
| 著者 | org:haw 投稿数 | 同期間の全投稿数 | org外投稿数 |
| --- | ---: | ---: | ---: |
| @example_user | 3 | 5 | 2 |
| @another_user | 1 | 1 | 0 |
```

このまま記事や社内資料に貼れます。

## アクセストークンについて

Qiita APIは、アクセストークンなしでも公開記事を取得できます。

ただし、Qiita API v2は、認証ありの場合は1時間1000回、認証なしの場合はIPアドレスごとに1時間60回という制限があります。
著者数が多いOrganizationで集計する場合は、アクセストークンを使うほうが安心です。

アクセストークンを使う場合は、環境変数 `QIITA_TOKEN` にセットします。

```bash
export QIITA_TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
iex
```

上のElixirコードは、`QIITA_TOKEN` が設定されていれば自動でAuthorizationヘッダーを付けます。

```elixir
Authorization: Bearer <token>
```

Qiitaのアクセストークンは、 https://qiita.com/settings/applications から取得できます。

## Elixirをインストールしていない場合

Elixirをローカルに入れていなくても、Dockerで試せます。

今回は、手元で `Mix.install([:req])` の動作確認ができた `elixir:1.20.1-otp-29-alpine` コンテナを使います。

```bash
docker run --rm -it elixir:1.20.1-otp-29-alpine iex
```

IExが起動したら、先ほどのElixirコードをそのまま貼り付けます。

アクセストークンを使う場合は、ホスト側で `QIITA_TOKEN` を設定してから、コンテナに渡します。

```bash
export QIITA_TOKEN="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

docker run --rm -it \
  -e QIITA_TOKEN="$QIITA_TOKEN" \
  elixir:1.20.1-otp-29-alpine \
  iex
```

あとは同じです。

IExにコードを貼り付ければ、集計結果のMarkdownテーブルが出力されます。

## コードの考え方

最初に、Organizationに紐づいた記事を検索します。

```elixir
org_query = "org:haw created:>=2025-07-01 created:<=2026-06-30"
```

この検索で取得した記事を、記事の `user.id` ごとにグルーピングします。

```elixir
Enum.group_by(org_items, &get_in(&1, ["user", "id"]))
```

これで、`org:haw` として投稿した著者一覧が取れます。

次に、その著者ごとに、Organization条件を外して検索します。

```elixir
"user:#{user_id} created:>=2025-07-01 created:<=2026-06-30"
```

この件数を `Total-Count` ヘッダーから取得します。

記事本文を全部取得しなくても、件数だけ知りたい場合は `per_page: 1` で十分です。

```elixir
response =
  Req.get!(
    "https://qiita.com/api/v2/items",
    params: [
      query: query,
      page: 1,
      per_page: 1
    ]
  )

response.headers
|> Map.get("total-count", ["0"])
|> List.first()
|> String.to_integer()
```

このようにすると、APIアクセス数もレスポンスサイズも抑えられます。

## 出力している列

出力している列は次の4つです。

| 列 | 意味 |
| --- | --- |
| 著者 | QiitaのユーザーID |
| `org:haw` 投稿数 | 対象期間に `org:haw` として投稿された記事数 |
| 同期間の全投稿数 | 対象期間にその著者がQiita全体へ投稿した記事数 |
| org外投稿数 | 全投稿数から `org:haw` 投稿数を引いた数 |

`org外投稿数` は、次の計算です。

```elixir
total_count - org_count
```

Organizationへの投稿だけを見るのではなく、メンバー個人の発信も含めて見るための列です。

## 自分の組織でも集計する

他のOrganizationで使う場合は、ここを変えます。

```elixir
@org "haw"
@from "2025-07-01"
@to "2026-06-30"
```

たとえば、Organization名が `your-org` なら次のようにします。

```elixir
@org "your-org"
```

年度や決算期間に合わせて、日付も変えられます。

```elixir
@from "2026-04-01"
@to "2027-03-31"
```

## おわりに

技術記事の投稿数は、単なる本数ではありません。

誰が、どの期間に、どれだけ知見を外へ出したのか。

それを眺めるだけで、組織の技術文化の輪郭が少し見えてきます。

「<ruby>山中<rt>さんちゅう</rt></ruby>の賊を破るは易く、<ruby>心中<rt>しんちゅう</rt></ruby>の賊を破るは<ruby>難し<rt>かたし</rt></ruby>」という言葉があります。

投稿も同じです。

外の課題を語る前に、自分たちの知見を外に出す一歩を踏み出す。

その一歩を、まずは数字で見えるようにしてみる。

あなたの組織でも、Qiita APIで一年分の技術発信を集計してみませんか。
