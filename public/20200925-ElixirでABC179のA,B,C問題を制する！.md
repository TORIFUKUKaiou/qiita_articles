---
title: 'ElixirでABC179のA,B,C問題を制する！'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T12:09:41+09:00'
id: d9f968d0dc8b9d4a9b0f
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC179のA,B,C問題を制する！](https://qiita.com/u2dayo/items/acfeb20a912b04276641)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 179](https://atcoder.jp/contests/abc179/tasks)
- A〜Cまで解いてみます

# [問題A - Plural Form](https://atcoder.jp/contests/abc179/tasks/abc179_a)
- 問題文はリンク先をご参照くださいませ :bow: 
- 自力で行けました :lgtm: 

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    |> String.trim()
    |> (fn word -> solve(word, String.at(word, -1)) end).()
    |> IO.puts()
  end

  def solve(word, last) when last == "s", do: "#{word}es"

  def solve(word, _), do: "#{word}s"
end
```

- [提出](https://atcoder.jp/contests/abc179/submissions/17003643)

# [問題B - Go to Jail](https://atcoder.jp/contests/abc179/tasks/abc179_b)
- 問題文はリンク先をご参照くださいませ :bow: 
- 自力で行けました :lgtm: 

```elixir
defmodule AtCoder179B do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.reduce([], fn _, acc ->
      pair =
        IO.read(:line)
        |> String.trim()
        |> String.split(" ")
        |> Enum.map(&String.to_integer/1)

      [pair | acc]
    end)
    |> Enum.map(fn [d1, d2] -> d1 == d2 end)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.any?(&solve/1)
    |> output()
    |> IO.puts()
  end

  defp solve([true, true, true]), do: true
  defp solve(_), do: false

  defp output(true), do: "Yes"
  defp output(_), do: "No"
end
```

- [Enum.chunk_every/4](https://hexdocs.pm/elixir/Enum.html#chunk_every/4)が大活躍でした
- サイコロを２個ずつふって、3回連続でゾロ目がでたという回が有りや無しやという問題なのですが、リストを3個ずつ組みにしたかったのです
- きっと[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールにいいのがあるだろうと探ったらありました
- [Enum.chunk_every/4](https://hexdocs.pm/elixir/Enum.html#chunk_every/4)はどこかで使ったことがある気がするのですが理解が深まりました
- [提出](https://atcoder.jp/contests/abc179/submissions/17003874)

# [問題C - A x B + C](https://atcoder.jp/contests/abc179/tasks/abc179_c)
- 自力では解けませんでした... :baby:
- 元の記事の解説をとても参考にしました！
    - [【AtCoder解説】PythonでABC179のA,B,C問題を制する！](https://qiita.com/u2dayo/items/acfeb20a912b04276641)
    - ありがとうございます :lgtm::lgtm::lgtm:

# 私のオススメ解答
```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
 
    for a <- 1..n, b <- 1..div(n, a), c = n - a * b, c > 0, reduce: %{} do
      acc -> Map.update(acc, :ok, 1, & &1 + 1)
    end
    |> Map.values()
    |> Enum.at(0)
    |> IO.puts()
  end
end
```
- ここでのポイントは、[The :reduce option](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1-the-reduce-option)です！
- [提出](https://atcoder.jp/contests/abc179/submissions/17005553)

## 別解

```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
 
    1..n
    |> Enum.reduce(0, fn a, acc_total_count ->
      1..div(n, a)
      |> Enum.reduce_while(0, fn b, acc_count ->
        c = n - a * b
        if c > 0, do: {:cont, acc_count + 1}, else: {:halt, acc_count}
      end)
      |> Kernel.+(acc_total_count)
    end)
    |> IO.puts()
  end
end
```

- 元の記事を参考にPythonから置き換えてみた感じです
- [提出](https://atcoder.jp/contests/abc179/submissions/17005230)

## 駄目な例
- `TLE (Time Limit Exceeded)`や`MLE (Memory Limit Exceeded)`がでます

```elixir
defmodule Main do
 
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
 
    for(a <- 1..n, b <- 1..div(n, a), c = n - a * b, c > 0, do: :ok)
    |> Enum.count()
    |> IO.puts()
  end
end
```

- 一番短くて何をやっているのかはわかりやすくはありますが、[for](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)を使っていて結局リストの末尾に追加していくことになるから遅く[^1]なったり、メモリを多く使うというところで駄目だということでしょうか
- 駄目な例に近いものを書いて不合格を受けて自信を失い、それから[元の記事]((https://qiita.com/u2dayo/items/acfeb20a912b04276641))のPythonを置き換える形で合格してふたたび自信を取り戻しました
- この問題では、[for](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)を使う形が一番すっきりするように思えたのでどうにか解けないのかとドキュメントを読み込んで[The :reduce option](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1-the-reduce-option)をみつけた[次第](https://qiita.com/torifukukaiou/items/d9f968d0dc8b9d4a9b0f#%E7%A7%81%E3%81%AE%E3%82%AA%E3%82%B9%E3%82%B9%E3%83%A1%E8%A7%A3%E7%AD%94)です
- [提出](https://atcoder.jp/contests/abc179/submissions/17005165)

# Wrapping Up :qiita-fabicon:
- At Coderを解くことを通じて[Elixir](https://elixir-lang.org/)の公式ドキュメントを読みこむことで理解が増えていくことを楽しんでいます
- 私は時間内に解く自信は全くありませんが、諸先輩方が詳しく解説していただいている問題をじっくりと[Elixir](https://elixir-lang.org/)で書いてみることを楽しんでいます
- Enjoy [Elixir](https://elixir-lang.org/) !!! :lgtm::rocket::lgtm::rocket::lgtm::rocket::fire::rocket::rocket::rocket: 


[^1]: [Due to their cons cell based representation, prepending an element to a list is always fast (constant time), while appending becomes slower as the list grows in size (linear time):](https://hexdocs.pm/elixir/List.html#content)




