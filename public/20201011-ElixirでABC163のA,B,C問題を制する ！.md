---
title: 'ElixirでABC163のA,B,C問題を制する ！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:23:23+09:00'
id: 00b5b0a8b8e81ad0ae46
organization_url_name: fukuokaex
slide: false
---
# はじめに

- [Elixir](https://elixir-lang.org/)でやってみました


# 問題
- [AtCoder Beginner Contest 163](https://atcoder.jp/contests/abc163)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Circle Pond](https://atcoder.jp/contests/abc163/tasks/abc163_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_163_a.ex
defmodule Abc163A do
  def main do
    IO.read(:line) |> String.trim() |> String.to_integer() |> solve() |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc163/tasks/abc163_c

  ## Examples

      iex> Abc163A.solve(1)
      6.283185307179586

      iex> Abc163A.solve(73)
      458.67252742410977361942

  """
  def solve(r) do
    2 * :math.pi() * r
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
  doctest Abc163A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc163/submissions/17321307)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、B問題、C問題を解いていきます

# [問題B - Homework](https://atcoder.jp/contests/abc163/tasks/abc163_b)

```elixir:lib/abc_163_b.ex
defmodule Abc163B do
  def main do
    [n, _m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve(n)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc163/tasks/abc163_b

  ## Examples

      iex> Abc163B.solve([5, 6], 41)
      30

      iex> Abc163B.solve([5, 8], 10)
      -1

      iex> Abc163B.solve([5, 6], 11)
      0

  """
  def solve(list, n) do
    do_solve(Enum.sum(list), n)
  end

  defp do_solve(work_sum, n) when n >= work_sum, do: n - work_sum

  defp do_solve(_, _), do: -1
end
```

- [提出](https://atcoder.jp/contests/abc163/submissions/17321448)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - management](https://atcoder.jp/contests/abc163/tasks/abc163_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_163_c.ex
defmodule Abc163C do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> (fn map -> 1..n |> Enum.map(&Map.get(map, &1, 0)) end).()
    |> Enum.join("\n")
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc163/tasks/abc163_c

  ## Examples

      iex> Abc163C.solve([1, 1, 2, 2])
      %{1 => 2, 2 => 2}

  """
  def solve(list), do: list |> Enum.frequencies()
end
```

- [Enum.frequencies/1](https://hexdocs.pm/elixir/Enum.html#frequencies/1)を使えば解けることに気づけばしめたものです
    - @QWYNG さんの[プルリク](https://github.com/elixir-lang/elixir/pull/9425)に感謝です:lgtm::tada::tada::tada::+1::+1::+1::lgtm:
    - [OSSとしてのElixir](https://qiita.com/QWYNG/items/c8ea8cc1f95b2d20337e)
- もうひとつポイントは[IO.puts/2](https://hexdocs.pm/elixir/IO.html#puts/2)の呼び出しを一回にすることです
- 以下のように何度も[IO.puts/2](https://hexdocs.pm/elixir/IO.html#puts/2)を呼び出す書き方をすると[タイムアウトエラー](https://atcoder.jp/contests/abc163/submissions/17321681)になります

```elixir
    |> solve()
    |> (fn map -> 1..n |> Enum.map(&Map.get(map, &1, 0)) end).()
    |> Enum.each(&IO.puts/1)
```

- [提出](https://atcoder.jp/contests/abc163/submissions/17321211)の際にはモジュール名は`Main`にしておいてください


# Wrapping Up :qiita-fabicon: 
- 今回は自力でいけました！ :smile: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
