---
title: ABC167 C - Skill UpをElixirで解く
tags:
  - Elixir
private: false
updated_at: '2021-02-28T23:24:51+09:00'
id: 7ae8d2b21729ac19e5ef
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @kgtkr さんの[ABC167 C - Skill UpをHaskellで解く](https://qiita.com/kgtkr/items/ea4df8f7e7654b3a83e9)を拝見しまして、私はぜひ[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
[C - Skill Up](https://atcoder.jp/contests/abc167/tasks/abc167_c)

# [解答例](https://atcoder.jp/contests/abc167/submissions/16903698)

```elixir
defmodule Main do
  def main do
    [n, _m, x] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list_of_lists =
      Enum.reduce(1..n, [], fn _, acc ->
        IO.read(:line)
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
        |> List.duplicate(1)
        |> Kernel.++(acc)
      end)

    Enum.reduce(1..n, [], fn i, acc ->
      combination(list_of_lists, i) ++ acc
    end)
    |> Enum.filter(&pass?(&1, x))
    |> Enum.map(&bill/1)
    |> Enum.min(fn -> -1 end)
    |> IO.puts()
  end

  defp pass?(list_of_lists, x) do
    List.zip(list_of_lists)
    |> tl()
    |> Enum.map(&(Tuple.to_list(&1) |> Enum.sum()))
    |> Enum.all?(&(&1 >= x))
  end

  defp bill(list_of_lists) do
    List.zip(list_of_lists) |> hd() |> Tuple.to_list() |> Enum.sum()
  end

  defp combination(_, 0), do: [[]]
  defp combination([], _), do: []

  defp combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end
```

- 愚直にやりました
- 問題は[C - Skill Up](https://atcoder.jp/contests/abc167/tasks/abc167_c)をご参照ください

# 解説
- インプットに下記のデータを入れた場合の実行結果をあわせてかいておきます

```
3 3 10
60 2 2 4
70 8 7 9
50 2 3 9
```

## 一行目を読み込んで、インプット続きの行数Nと理解度Xをそれぞれ変数`n`と`x`に入れています

```elixir
    [n, _m, x] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
```
- `n`に3、`x`に10が入ります
- `M`は以降で使わなかったので`_`をつけて警告がでないようにしています


## その次に、1行ずつN行まで読み込んでいます
- 各行のデータはリストにしています

```elixir
    list_of_lists =
      Enum.reduce(1..n, [], fn _, acc ->
        IO.read(:line)
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)
        |> List.duplicate(1)
        |> Kernel.++(acc)
      end)
```

### ここまでの実行結果
- `list_of_lists`には以下が入っております。

```elixir
[[50, 2, 3, 9], [70, 8, 7, 9], [60, 2, 2, 4]]
```
- `IEx`では２番目が`'F\b\a\t'`と表示されているとおもいます
- 詳しくは[Charlists](https://hexdocs.pm/elixir/List.html#module-charlists)をご参照ください

# 入力データを読み込めたので、各行を組み合わせて、理解度が基準を満たしている組み合わせだけを残して、その中で一番書籍代金が小さいものを答えにします(該当する組み合わせがない場合には、-1を返します)

## 各行を順序は気にせず組み合わせる
- 任意の1行のみ、任意の2行、3行の組み合わせをすべて列挙しています

```elixir
    Enum.reduce(1..n, [], fn i, acc ->
      combination(list_of_lists, i) ++ acc
    end)
```

- `combination/2`は独自に定義したメソッドです
- 手前味噌の[RubyのArray#combination(n)相当をElixirで書いてみる](https://qiita.com/torifukukaiou/items/e8a27dd5bdfa31a1ec02)をご参照ください

### ここまでの実行結果

```elixir
[
  [[50, 2, 3, 9], [70, 8, 7, 9], [60, 2, 2, 4]],
  [[50, 2, 3, 9], [70, 8, 7, 9]],
  [[50, 2, 3, 9], [60, 2, 2, 4]],
  [[70, 8, 7, 9], [60, 2, 2, 4]],
  [[50, 2, 3, 9]],
  [[70, 8, 7, 9]],
  [[60, 2, 2, 4]]
]
```

## 理解度が基準を満たしている組み合わせだけを残す

```elixir
    |> Enum.filter(&pass?(&1, x))
```

- [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)を使っています
- `pass?/2`は独自に定義したメソッドです
- `&pass?(&1, x)`のところは下のように書いても同じです

```elixir
    |> Enum.filter(fn list_of_lists -> pass?(list_of_lists, x) end)
```


### ここまでの実行結果

```elixir
[
  [[50, 2, 3, 9], [70, 8, 7, 9], [60, 2, 2, 4]], 
  [[50, 2, 3, 9], [70, 8, 7, 9]]
]
```
- 1行目〜3行目すべてを選んだ場合と2行目と3行目を組み合わせた場合が理解度X超えの基準を満たしています


## 書籍代金を計算します

```elixir
    |> Enum.map(&bill/1)
```

- `bill/1`は独自に定義したメソッドです

### ここまでの実行結果
```elixir
[180, 120]
```

## 一番書籍代金が小さいものを答えにします(該当する組み合わせがない場合には、-1を返します)

```elixir
    |> Enum.min(fn -> -1 end)
    |> IO.puts()
```

- [Enum.min/3](https://hexdocs.pm/elixir/Enum.html#min/3)を使って一番小さい値を返します
- もし直前までの結果でリストが空の場合は`-1`を返すようにしています
    - 手前味噌の[Enum.min(enumerable)でenumerableが空の時に値を返したい(Elixir)](https://qiita.com/torifukukaiou/items/d6b61375f0f3b6ecada2)をご参照ください

### 実行結果 :tada::lgtm::tada::lgtm::tada::lgtm: 
```elixir
120
```
:relaxed:

# Wrapping Up
- [Pipe operator](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)[^1]で気持ちよくプログラムが書けます:lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 


[^1]: `|>`のことです。


