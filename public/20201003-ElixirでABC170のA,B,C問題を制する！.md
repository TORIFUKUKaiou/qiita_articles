---
title: 'ElixirでABC170のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:19:09+09:00'
id: 584d4e9b3e14792fb701
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)でやってみました

# 問題
- [AtCoder Beginner Contest 170](https://atcoder.jp/contests/abc170)
- A〜Cまで解いてみます
- 今回は自力で行けました！

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Five Variables](https://atcoder.jp/contests/abc170/tasks/abc170_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_170_a.ex
defmodule Abc170A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc170/tasks/abc170_b

  ## Examples

      iex> Abc170A.solve([0, 2, 3, 4, 5])
      1
      iex> Abc170A.solve([1, 2, 0, 4, 5])
      3

  """
  def solve(list) do
    Enum.find_index(list, &(&1 == 0)) + 1
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
  doctest Abc170A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc170/submissions/17143572)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Crane and Turtle](https://atcoder.jp/contests/abc170/tasks/abc170_b)

```elixir:lib/abc_170_b.ex
defmodule Abc170B do
  def main do
    [x, y] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(x, y)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc170/tasks/abc170_b

  ## Examples

      iex> Abc170B.solve(3, 8)
      "Yes"
      iex> Abc170B.solve(2, 100)
      "No"
      iex> Abc170B.solve(1, 2)
      "Yes"

  """
  def solve(x, y) when y - 2 * x >= 0 and x - div(y - 2 * x, 2) >= 0 and rem(y - 2 * x, 2) == 0,
    do: "Yes"

  def solve(_x, _y), do: "No"
end

```

- [提出](https://atcoder.jp/contests/abc170/submissions/17143484)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Forbidden List](https://atcoder.jp/contests/abc170/submissions/17143240)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_170_c.ex
defmodule Abc170C do
  def main do
    [x, n] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    if n > 0 do
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> solve(x)
      |> IO.puts()
    else
      IO.read(:line)

      solve([], x)
      |> IO.puts()
    end
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc170/tasks/abc170_c

  ## Examples

      iex> Abc170C.solve([4, 7, 10, 6, 5], 6)
      8
      iex> Abc170C.solve([4, 7, 10, 6, 5], 10)
      9
      iex> Abc170C.solve([], 100)
      100

  """
  def solve([], x), do: x

  def solve(list, x) do
    0..100
    |> Enum.reduce_while(x, fn i, acc ->
      minus_one = x - i

      if !(minus_one in list) do
        {:halt, minus_one}
      else
        plus_one = x + i

        if !(plus_one in list) do
          {:halt, plus_one}
        else
          {:cont, acc}
        end
      end
    end)
  end
end


```

- [提出](https://atcoder.jp/contests/abc170/submissions/17143240)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
