---
title: 'イディオムとして覚えたい!!!  Elixirでの転置 Enum.zip_with(enumerables, & &1)'
tags:
  - Elixir
  - 競技プログラミング
  - 猪木
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-15T11:49:48+09:00'
id: 2aee585d149b9a79eff5
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
Advent Of Code等を解いていると行列を転置したいことがあります。

たとえばインプットが以下だとしてします。

```elixir
list_of_lists = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]
```

期待結果は次の通りです。

```elixir
[
 [1, 4, 7],
 [2, 5, 8],
 [3, 6, 9]
]
```

果たしてどうやるとよいでしょうか。

## Enum.zip_with !!!

```elixir
Enum.zip_with(list_of_lists, & &1)
```

これがオススメです。Kiro CLIに教えてもらいました。

## 力ワザ

```elixir
height = Enum.count(list_of_lists)
width = Enum.at(list_of_lists, 0) |> Enum.count()

(for i <- 0..(height - 1), j <- (0..(width - 1)), do: {j, i})
|> Enum.map(fn {row, col} -> Enum.at(list_of_lists, row) |> Enum.at(col) end)
|> Enum.chunk_every(height)
```

これでも一応できますが、[Enum.zip_with/2](https://hexdocs.pm/elixir/1.19.4/Enum.html#zip_with/2)を使ったほうがよっぽど簡単にできます。力ワザでは、Elixirでプログラミングしているっぽい感じがあまりしません……　なにやら手続き型言語で書いているみたいな雰囲気になってしまいます。
この記事で紹介する`Enum.zip_with(enumerables, & &1)`は、いかにも関数型プログラミング言語をよく使いこなしている感じがして美しいです。

## さいごに
イディオムとして覚えたいElixirでの転置 `Enum.zip_with(enumerables, & &1)`のご紹介でした。
