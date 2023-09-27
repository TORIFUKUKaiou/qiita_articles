---
title: 'ElixirでABC165のA,B,C問題を制する ！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:20:37+09:00'
id: 3689dff13044c0465384
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

- @u2dayoさんの記事を拝見して、私は[Elixir](https://elixir-lang.org/)でやってみました
    - [【AtCoder解説】PythonでABC165のA, B, (C), D問題を制する ！](https://qiita.com/u2dayo/items/40eae13cffff57471422)
    - [【AtCoder解説】PythonでABC165のC問題『Many Requirements』を制する！](https://qiita.com/u2dayo/items/386142030a70d2db4e58)

# 問題
- [AtCoder Beginner Contest 165](https://atcoder.jp/contests/abc165)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - We Love Golf](https://atcoder.jp/contests/abc165/tasks/abc165_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_165_a.ex
defmodule Abc165A do
  def main() do
    k = IO.read(:line) |> String.trim() |> String.to_integer()

    [a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(k, a, b)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc165/tasks/abc165_a

  ## Examples

      iex> Abc165A.solve(7, 500, 600)
      "OK"
      iex> Abc165A.solve(4, 5, 7)
      "NG"
      iex> Abc165A.solve(1, 11, 11)
      "OK"

  """
  def solve(k, a, b) do
    a..b
    |> Enum.any?(&(rem(&1, k) == 0))
    |> if(do: "OK", else: "NG")
  end
end


```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc165A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc165/submissions/17193570)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - 1%](https://atcoder.jp/contests/abc165/tasks/abc165_b)

```elixir:lib/abc_165_b.ex
defmodule Abc165B do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc165/tasks/abc165_b

  ## Examples

      iex> Abc165B.solve(103)
      3
      iex> Abc165B.solve(1000000000000000000)
      3760
      iex> Abc165B.solve(1333333333)
      1706

  """
  def solve(x) do
    1..3760
    |> Enum.reduce_while({0, 100}, fn year, {_, money} ->
      money = money + div(money, 100)
      {if(money >= x, do: :halt, else: :cont), {year, money}}
    end)
    |> elem(0)
  end
end
```

- [提出](https://atcoder.jp/contests/abc165/submissions/17194338)の際にはモジュール名は`Main`にしておいてください
- 1題`WA (Wrong Answer)`がなかなかとれなかったのですが、他の方の回答を参考にして割り算で計算することで答えが`AC (Accepted)`が取れました
- :tada::tada::tada:


# [問題C - Many Requirements](https://atcoder.jp/contests/abc165/tasks/abc165_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_165_c.ex
defmodule Abc165C do
  def main do
    [n, m, q] =
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    1..q
    |> Enum.reduce([], fn _, acc ->
      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> solve(n, m)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc165/tasks/abc165_c

  ## Examples

      iex> Abc165C.solve([[1, 3, 3, 100], [1, 2, 2, 10], [2, 3, 2, 10]], 3, 4)
      110
      iex> Abc165C.solve([[2, 4, 1, 86568], [1, 4, 0, 90629], [2, 3, 0, 90310], [3, 4, 1, 29211], [3, 4, 3, 78537], [3, 4, 2, 8580], [1, 2, 1, 96263], [1, 4, 2, 2156], [1, 2, 0, 94325], [1, 4, 3, 94328]], 4, 6)
      357500
      iex> Abc165C.solve([[1, 10, 9, 1]], 10, 10)
      1

  """
  def solve(list_of_lists, n, m) do
    combinations(n, m)
    |> Enum.map(fn list ->
      list_of_lists
      |> Enum.reduce(0, fn [a, b, c, d], acc ->
        if Enum.at(list, b - 1) - Enum.at(list, a - 1) == c, do: acc + d, else: acc
      end)
    end)
    |> Enum.max()
  end

  def combinations(n, m) when n >= 2,
    do: do_combinations(n - 2, m, for(x <- 1..m, y <- x..m, do: [y, x]))

  defp do_combinations(0, _m, acc), do: acc |> Enum.map(&Enum.reverse/1)

  defp do_combinations(n, m, acc) do
    do_combinations(
      n - 1,
      m,
      for([head | _] = list <- acc, z <- head..m, do: [z | list])
    )
  end
end
```

- [提出](https://atcoder.jp/contests/abc165/submissions/17193139)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
