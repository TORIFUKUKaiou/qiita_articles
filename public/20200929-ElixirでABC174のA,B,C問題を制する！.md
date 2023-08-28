---
title: 'ElixirでABC174のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:17:30+09:00'
id: 156f8da828c0fac58f11
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC174のA,B,C問題を制する！](https://qiita.com/u2dayo/items/83faeb39ac14c63c8986)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 174](https://atcoder.jp/contests/abc174)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Air Conditioner](https://atcoder.jp/contests/abc174/tasks/abc174_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/at_coder_174_a.ex
defmodule AtCoder174A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc174/tasks/abc174_a

  ## Examples

      iex> AtCoder174A.solve(25)
      "No"
      iex> AtCoder174A.solve(30)
      "Yes"
      iex> AtCoder174A.solve(-1)
      "No"

  """
  def solve(x) when x >= 30, do: "Yes"

  def solve(_), do: "No"
end

```

- `solve/1`関数を２つ書いていますが上から順に最初にマッチしたものが実行されることになります
- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest AtCoder174A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc174/submissions/17077516)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Distance](https://atcoder.jp/contests/abc174/tasks/abc174_b)

```elixir:lib/at_coder_174_b.ex
defmodule AtCoder174B do
  def main do
    [n, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..n
    |> Enum.reduce([], fn _, acc ->
      [
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
        | acc
      ]
    end)
    |> solve(d)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc174/tasks/abc174_b

  ## Examples

      iex> AtCoder174B.solve([[0, 5], [-2, 4], [3, 4], [4, -4]], 5)
      3

  """
  def solve(list_of_lists, d) do
    square_of_d = d * d

    list_of_lists
    |> Enum.map(fn [x, y] -> x * x + y * y end)
    |> Enum.filter(&(&1 <= square_of_d))
    |> Enum.count()
  end
end
```

- [提出](https://atcoder.jp/contests/abc174/submissions/17077902)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 地味に入力値を読み取るところで、`String.split(" ")`とせずに`String.split()`と`pattern`を指定せずに呼び出すとタイムアウトしてしまうということがありました


# [問題C - Repsept](https://atcoder.jp/contests/abc174/tasks/abc174_c)
- 問題文はリンク先をご参照くださいませ :bow:
- [元の記事](https://qiita.com/u2dayo/items/83faeb39ac14c63c8986)の解説をとても参考にしました！
    - ありがとうございます！


```elixir:lib/at_coder_174_c.ex
defmodule AtCoder174C do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc174/tasks/abc174_c

  ## Examples

      iex> AtCoder174C.solve(101)
      4
      iex> AtCoder174C.solve(2)
      -1
      iex> AtCoder174C.solve(999983)
      999982


  """
  def solve(k) do
    1..k
    |> Enum.reduce_while({0, -1}, fn i, {a, _result} ->
      a = a * 10 + 7
      rem = rem(a, k)
      if rem == 0, do: {:halt, {rem, i}}, else: {:cont, {rem, -1}}
    end)
    |> elem(1)
  end
end
```

- [提出](https://atcoder.jp/contests/abc174/submissions/17078978)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- [String.split/3](https://hexdocs.pm/elixir/String.html#split/3)で入力をスペースで分割するときは第2引数の`pattern`に`" "`を指定しましょう
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
