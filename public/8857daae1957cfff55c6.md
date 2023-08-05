---
title: 'ElixirでABC161のA,B,C問題を制する ！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:21:45+09:00'
id: 8857daae1957cfff55c6
organization_url_name: fukuokaex
slide: false
---
# はじめに

- [Elixir](https://elixir-lang.org/)でやってみました


# 問題
- [AtCoder Beginner Contest 161](https://atcoder.jp/contests/abc161)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - ABC Swap](https://atcoder.jp/contests/abc161/tasks/abc161_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_161_a.ex
defmodule Abc161A do
  def main do
    [x, y, z] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(x, y, z) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc161/tasks/abc161_a

  ## Examples

      iex> Abc161A.solve(1, 2, 3)
      "3 1 2"
      iex> Abc161A.solve(100, 100, 100)
      "100 100 100"
      iex> Abc161A.solve(41, 59, 31)
      "31 41 59"

  """
  def solve(x, y, z) do
    [z, x, y] |> Enum.join(" ")
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
  doctest Abc161A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc161/submissions/17259575)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、B問題、C問題を解いていきます

# [問題B - Popular Vote](https://atcoder.jp/contests/abc161/tasks/abc161_b)

```elixir:lib/abc_161_b.ex
defmodule Abc161B do
  def main do
    [_n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve(m)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc161/tasks/abc161_b

  ## Examples

      iex> Abc161B.solve([5, 4, 2, 1], 1)
      "Yes"
      iex> Abc161B.solve([380, 19, 1], 2)
      "No"
      iex> Abc161B.solve([4, 56, 78, 901, 2, 345, 67, 890, 123, 45, 6, 789], 3)
      "Yes"

  """
  def solve(list, m) do
    sum = Enum.sum(list)

    Enum.sort(list, :desc)
    |> Enum.take(m)
    |> Enum.all?(fn a ->
      a * 4 * m >= sum
    end)
    |> if(do: "Yes", else: "No")
  end
end
```

- [提出](https://atcoder.jp/contests/abc161/submissions/17259514)の際にはモジュール名は`Main`にしておいてください
- `|> if(do: "Yes", else: "No")` の箇所はマイブームです
- :tada::tada::tada:


# [問題C - Replacing Integer](https://atcoder.jp/contests/abc161/submissions/17259514)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_161_c.ex
defmodule Abc161C do
  def main do
    [n, k] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, k)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc161/tasks/abc161_c

  ## Examples

      iex> Abc161C.solve(7, 4)
      1
      iex> Abc161C.solve(2, 6)
      2
      iex> Abc161C.solve(1000000000000000000, 1)
      0

  """
  def solve(n, k) when rem(n, k) == 0, do: 0

  def solve(n, k) do
    [abs(n), abs(n - div(n, k) * k), abs(n - div(n, k) * k - k)]
    |> Enum.min()
  end
end
```

- [提出](https://atcoder.jp/contests/abc161/submissions/17259277)の際にはモジュール名は`Main`にしておいてください


# Wrapping Up :qiita-fabicon: 
- 今回は自力でいけました！ :smile: 
    - B問題は判定に`=`を入れていなくて`WA (Wrong Answer)`を２回もだしてしまいました
    - C問題は以前似たような問題をやったときの経験が活きました
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
