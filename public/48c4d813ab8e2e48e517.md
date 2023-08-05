---
title: 'ElixirでABC180のA,B,C,D問題を解いてみる！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:04:32+09:00'
id: 48c4d813ab8e2e48e517
organization_url_name: fukuokaex
slide: false
---
# はじめに

- [Elixir](https://elixir-lang.org/)でやってみました


# 問題
- [AtCoder Beginner Contest 180](https://atcoder.jp/contests/abc180)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_corder
```

# [問題A - box](https://atcoder.jp/contests/abc180/tasks/abc180_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_180_a.ex
defmodule Abc180A do
  def main do
    [n, a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, a, b)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc180_a

  ## Examples

      iex> Abc180A.solve(100, 1, 2)
      101

  """
  def solve(n, a, b) do
    n - a + b
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
  doctest Abc180A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc180/submissions/17506826)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、B問題、C問題を解いていきます

# [問題B - Various distances](https://atcoder.jp/contests/abc180/tasks/abc180_b)

```elixir:lib/abc_180_b.ex
defmodule Abc180B do
  def main do
    IO.read(:line)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> Enum.join("\n")
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc180_b

  ## Examples

      iex> Abc180B.solve([2, -1])
      [3, 2.236067977499790, 2]

  """
  def solve(list) do
    m = Enum.map(list, &abs/1) |> Enum.sum()
    u = Enum.map(list, &(&1 * &1)) |> Enum.sum() |> :math.sqrt()
    c = Enum.map(list, &abs/1) |> Enum.max()
    [m, u, c]
  end
end
```

- [提出](https://atcoder.jp/contests/abc180/submissions/17506459)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Cream puff](https://atcoder.jp/contests/abc180/tasks/abc180_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_180_c.ex
defmodule Abc180C do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> Enum.join("\n")
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc180_c

  ## Examples

      iex> Abc180C.solve(6)
      [1, 2, 3, 6]

  """
  def solve(n) do
    for(i <- 1..round(:math.sqrt(n)), rem(n, i) == 0, do: i)
    |> Enum.reduce(MapSet.new(), fn i, acc ->
      MapSet.put(acc, i)
      |> MapSet.put(div(n, i))
    end)
    |> Enum.to_list()
    |> Enum.sort()
  end
end
```


- [提出](https://atcoder.jp/contests/abc180/submissions/17506037)の際にはモジュール名は`Main`にしておいてください

# [問題D - Takahashi Unevolved](https://atcoder.jp/contests/abc180/tasks/abc180_d)
- 問題文はリンク先をご参照くださいませ :bow:
- [解説](https://atcoder.jp/contests/abc180/editorial/219)を読んで[Python](https://www.python.org/)を置き換えてみました
    - なぜこれで答えがでるのかいまいちピンときておらんとであります :sweat:
    - いま二くらいやね（[オートレース](https://autorace.jp/)ファンなら、わかる人にはわかる) 

```elixir:lib/abc_180_d.ex
defmodule Abc180D do
  def main do
    [x, y, a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(x, y, a, b)
    |> IO.puts()
  end
  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc180_d

  ## Examples

      iex> Abc180D.solve(4, 20, 2, 10)
      2

      iex> Abc180D.solve(1, 1000000000000000000, 10, 1000000000)
      1000000007

  """
  def solve(x, y, a, b) do
    {x, idx} =
      1..10_000_000_000_000_000_000
      |> Enum.reduce_while({x, 0}, fn i, {acc_x, acc_idx} ->
        new_acc_x = acc_x * a

        if new_acc_x <= acc_x + b && new_acc_x < y,
          do: {:cont, {new_acc_x, i}},
          else: {:halt, {acc_x, acc_idx}}
      end)

    idx + div(y - 1 - x, b)
  end
end
```


- [提出](https://atcoder.jp/contests/abc180/submissions/17507092)の際にはモジュール名は`Main`にしておいてください

# Wrapping Up :qiita-fabicon: 
- A〜Cは自力でいけました！ :smile: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
