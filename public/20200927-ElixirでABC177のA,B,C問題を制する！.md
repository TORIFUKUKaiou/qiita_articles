---
title: 'ElixirでABC177のA,B,C問題を制する！'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T12:11:30+09:00'
id: 70d52ddb6c192d1f012d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC177のA,B,C問題を制する！](https://qiita.com/u2dayo/items/d8f4877aee602a913bec)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 177](https://atcoder.jp/contests/abc177)
- A〜Cまで解いてみます

# [問題A - Don't be late](https://atcoder.jp/contests/abc177/tasks/abc177_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir
defmodule AtCoder177A do
  def main do
    [d, t, s] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(d, t, s) |> IO.puts()
  end

  defp solve(d, t, s) when t * s >= d, do: "Yes"

  defp solve(_, _, _), do: "No"
end
```

- [提出](https://atcoder.jp/contests/abc177/submissions/17058901)

# [問題B - Substring](https://atcoder.jp/contests/abc177/tasks/abc177_b)
- 問題文はリンク先をご参照くださいませ :bow:
- [元の記事](https://qiita.com/u2dayo/items/d8f4877aee602a913bec)の解説をとても参考にしました
    - ありがとうございます！ :lgtm::lgtm::lgtm:

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()
    t = IO.read(:line) |> String.trim()

    solve(s, t) |> IO.puts()
  end

  def solve(s, t) do
    len = String.length(t)
    t_charlist = String.to_charlist(t)

    String.to_charlist(s)
    |> Enum.chunk_every(len, 1, :discard)
    |> Enum.map(&Enum.zip(&1, t_charlist))
    |> Enum.map(&Enum.map(&1, fn {a, b} -> a == b end))
    |> Enum.map(&Enum.count(&1, fn b -> b == false end))
    |> Enum.min()
  end
end
```

- [Enum.chunk_every/4](https://hexdocs.pm/elixir/Enum.html#chunk_every/4)が大活躍です！
- [提出](https://atcoder.jp/contests/abc177/submissions/17059113)


# [問題C - Sum of product of pairs](https://atcoder.jp/contests/abc177/tasks/abc177_c)
- 問題文はリンク先をご参照くださいませ :bow:
- [元の記事](https://qiita.com/u2dayo/items/d8f4877aee602a913bec)の解説をとても参考にしました
    - ありがとうございます！ :lgtm::lgtm::lgtm:

```elixir
defmodule Main do
  @prime 1000000007
 
  def main do
    IO.read(:line)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    solve(list) |> IO.puts()
  end
 
  def solve(list) do
    list
    |> Enum.reduce({Enum.sum(list), 0}, fn x, {sum, ans} ->
      sum = sum - x
      ans = ans + sum * x
      {sum, ans}
    end)
    |> elem(1)
    |> rem(@prime)
  end
end
```

- [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)が大活躍です！
- [提出](https://atcoder.jp/contests/abc177/submissions/17059587)

## [Enum.at/3](https://hexdocs.pm/elixir/Enum.html#at/3)をいちいち使って書いたところ`TLE (Time Limit Exceeded)`してしまった例
- 最初にこれを提出して不合格をもらい、よく見直したところ、[Enum.at/3](https://hexdocs.pm/elixir/Enum.html#at/3)でアクセスする必要はないと気づいて上のコードに書き換えました

```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    solve(n, list) |> IO.puts()
  end
 
  def solve(n, list) do
    0..(n - 1)
    |> Enum.reduce({Enum.sum(list), 0}, fn i, {sum, ans} ->
      sum = sum - Enum.at(list, i)
      ans = ans + sum * Enum.at(list, i)
      {sum, ans}
    end)
    |> elem(1)
    |> rem(1000000007)
  end
end
```
- [不合格...](https://atcoder.jp/contests/abc177/submissions/17059291)


# Wrapping Up
- 今回は[元の記事](https://qiita.com/u2dayo/items/d8f4877aee602a913bec)の解説の解説にとてもお世話になりました :bow:
    - ありがとうございます！
    - Cまではありますし時間制限もなしでやっていますが`AC (Accepted)`になって嬉しくおもっています :relaxed:
- Enjoy [Elixir](https://elixir-lang.org/)! :fire::rocket::rocket::rocket: 



 
