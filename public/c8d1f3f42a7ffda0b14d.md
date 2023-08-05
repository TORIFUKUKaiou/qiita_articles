---
title: 'ElixirでABC164のA,B,C問題を制する ！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:21:11+09:00'
id: c8d1f3f42a7ffda0b14d
organization_url_name: fukuokaex
slide: false
---
# はじめに

- @u2dayoさんの記事を拝見して、私は[Elixir](https://elixir-lang.org/)でやってみました
    - [【AtCoder解説】PythonでABC164のA, B, C問題を制する ！](https://qiita.com/u2dayo/items/ed686afffea40c9253ba)

# 問題
- [AtCoder Beginner Contest 164](https://atcoder.jp/contests/abc164)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Sheep and Wolves](https://atcoder.jp/contests/abc164/tasks/abc164_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_164_a.ex
defmodule Abc164A do
  def main do
    [s, w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(s, w) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc164/tasks/abc164_a

  ## Examples

      iex> Abc164A.solve(4, 5)
      "unsafe"
      iex> Abc164A.solve(100, 2)
      "safe"

  """
  def solve(s, w) when s <= w, do: "unsafe"

  def solve(_s, _w), do: "safe"
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc164A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc164/submissions/17207064)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Battle](https://atcoder.jp/contests/abc164/tasks/abc164_b)

```elixir:lib/abc_164_b.ex
defmodule Abc164B do
  def main do
    [a, b, c, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(a, b, c, d) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc164/tasks/abc164_b

  ## Examples

      iex> Abc164B.solve(10, 9, 10, 10)
      "No"
      iex> Abc164B.solve(46, 4, 40, 5)
      "Yes"

  """
  def solve(a, b, c, d) do
    do_solve(battle_cnt(b, c), battle_cnt(d, a))
  end

  defp do_solve(takahashi_battle_cnt, aoki_battle_cnt)
       when takahashi_battle_cnt <= aoki_battle_cnt,
       do: "Yes"

  defp do_solve(_, _), do: "No"

  defp battle_cnt(attack, hit_point) do
    Enum.reduce_while(1..100, hit_point, fn cnt, acc_hit_point ->
      acc_hit_point = acc_hit_point - attack
      if acc_hit_point <= 0, do: {:halt, cnt}, else: {:cont, acc_hit_point}
    end)
  end
end
```

- [提出](https://atcoder.jp/contests/abc164/submissions/17206997)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - gacha](https://atcoder.jp/contests/abc164/tasks/abc164_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_164_c.ex
defmodule Abc164C do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.reduce([], fn _, acc ->
      [IO.read(:line) |> String.trim() | acc]
    end)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc164/tasks/abc164_c

  ## Examples

      iex> Abc164C.solve(~w(apple orange apple))
      2

  """
  def solve(list) do
    list
    |> Enum.frequencies()
    |> map_size()
  end
end
```

- [提出](https://atcoder.jp/contests/abc164/submissions/17206839)の際にはモジュール名は`Main`にしておいてください
- [Kernel.map_size/1](https://hexdocs.pm/elixir/Kernel.html#map_size/1)
- :tada::tada::tada: 

## [Elixir](https://elixir-lang.org/)では`size`と`length`に意味がそれぞれあります 💡
- [length and size](https://hexdocs.pm/elixir/naming-conventions.html#length-and-size)

> When you see size in a function name, it means the operation runs in constant time (also written as "O(1) time") because the size is stored alongside the data structure.
> Examples: Kernel.map_size/1, Kernel.tuple_size/1

> When you see length, the operation runs in linear time ("O(n) time") because the entire data structure has to be traversed.
> Examples: Kernel.length/1, String.length/1

- `length`の方はデータの数に比例して長さの取得時間が大きくなります
- それに対して、`size`の方はデータ構造にサイズをもっているのでデータの数によらず一定時間でサイズを取得できます

# Wrapping Up :qiita-fabicon: 
- 今回は自力でいけました！ :smile: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
