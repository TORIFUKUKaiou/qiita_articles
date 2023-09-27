---
title: 'ElixirでABC176のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:13:49+09:00'
id: bc104e3859f2ffaebc31
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC176のA,B,C問題を制する！](https://qiita.com/u2dayo/items/479b23967d39f75bc969)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 176](https://atcoder.jp/contests/abc176)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_corder
$ cd at_corder
```

# [問題A - Takoyaki](https://atcoder.jp/contests/abc176/tasks/abc176_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/at_coder_176_a.ex
defmodule AtCoder176A do
  def main do
    [n, x, t] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, x, t) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc176/tasks/abc176_a

  ## Examples

      iex> AtCoder176A.solve(20, 12, 6)
      13
      iex> AtCoder176A.solve(1000, 1, 1000)
      1000000

  """
  def solve(n, x, t) do
    _solve(n, x, t)
  end

  defp _solve(n, x, t) when rem(n, x) == 0, do: div(n, x) * t

  defp _solve(n, x, t), do: (div(n, x) + 1) * t
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest AtCoder176A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc176/submissions/17062259)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Multiple of 9](https://atcoder.jp/contests/abc176/tasks/abc176_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/at_coder_176_b.ex
defmodule AtCoder176B do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc176/tasks/abc176_b

  ## Examples

      iex> AtCoder176B.solve("123456789")
      "Yes"
      iex> AtCoder176B.solve("0")
      "Yes"
      iex> AtCoder176B.solve("31415926535897932384626433832795028841971693993751058209749445923078164062862089986280")
      "No"

  """
  def solve(n) do
    n
    |> String.split("")
    |> tl()
    |> List.delete_at(-1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
    |> rem(9)
    |> do_solve()
  end

  defp do_solve(0), do: "Yes"

  defp do_solve(_), do: "No"
end
```

- この問題では入力で与えられた整数の各桁を足す必要があります
- たとえば`String.split("123456789", "")`を実行してみると以下のようになります

```elixir
$ iex -S mix

iex> String.split("123456789", "")
["", "1", "2", "3", "4", "5", "6", "7", "8", "9", ""]
```

- 先頭と末尾の`""`を除外するために、[tl/1](https://hexdocs.pm/elixir/Kernel.html#tl/1)と[List.delete_at/2](https://hexdocs.pm/elixir/List.html#delete_at/2)を使っています
    - [List.delete_at/2](https://hexdocs.pm/elixir/List.html#delete_at/2)を2回使ったり、[Enum.reject/2](https://hexdocs.pm/elixir/Enum.html#reject/2)で除外するでもよいです
- [提出](https://atcoder.jp/contests/abc176/submissions/17064411)の際には、モジュール名は`Main`にしてください
- :tada::tada::tada:


# [問題C - Step](https://atcoder.jp/contests/abc176/tasks/abc176_c)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/at_coder_176_c.ex
defmodule AtCoder176C do
  def main do
    IO.read(:line)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(list) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc176/tasks/abc176_c

  ## Examples

      iex> AtCoder176C.solve([2, 1, 5, 4, 3])
      4
      iex> AtCoder176C.solve([3, 3, 3, 3, 3])
      0

  """
  def solve(list) do
    list
    |> Enum.reduce({List.first(list), 0}, fn a, {max, sum_of_steps} ->
      if a < max do
        {max, sum_of_steps + (max - a)}
      else
        {a, sum_of_steps}
      end
    end)
    |> elem(1)
  end
end
```

- [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)が大活躍です！
- [提出](https://atcoder.jp/contests/abc176/submissions/17062180)の際には、モジュール名は`Main`にしてください
- :tada::tada::tada:

# Wrapping Up :qiita-fabicon: 
- 今回から解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめる[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書いてみました
- Enjoy [Elixir](https://elixir-lang.org/) !!! :fire::rocket::rocket::rocket:
