---
title: 'ElixirでABC166のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:19:52+09:00'
id: 68ae12c5801b7f41bf23
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)でやってみました

# 問題
- [AtCoder Beginner Contest 166](https://atcoder.jp/contests/abc166)
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

# [問題A - A?C](https://atcoder.jp/contests/abc166/tasks/abc166_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_166_a.ex
defmodule Abc166A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc166/tasks/abc166_a

  ## Examples

      iex> Abc166A.solve("ABC")
      "ARC"
      iex> Abc166A.solve("ARC")
      "ABC"

  """
  def solve(s) when s == "ABC", do: "ARC"

  def solve(_s), do: "ABC"
end

```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc166A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc166/submissions/17152102)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Trick or Treat](https://atcoder.jp/contests/abc166/tasks/abc166_b)

```elixir:lib/abc_166_b.ex
defmodule Abc166B do
  def main do
    [n, k] =
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    1..k
    |> Enum.reduce([], fn _, acc ->
      IO.read(:line)

      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> List.flatten()
    |> solve(n)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc166/tasks/abc166_a

  ## Examples

      iex> Abc166B.solve([1, 3, 3], 3)
      1
      iex> Abc166B.solve([3, 3, 3], 3)
      2

  """
  def solve(list, n) do
    MapSet.new(list)
    |> MapSet.size()
    |> Kernel.-(n)
    |> Kernel.*(-1)
  end
end


```

- [提出](https://atcoder.jp/contests/abc166/submissions/17152315)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Peaks](https://atcoder.jp/contests/abc166/tasks/abc166_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_166_c.ex
defmodule Abc166C do
  def main do
    [n, m] =
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    h_list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..m
    |> Enum.reduce([], fn _, acc ->
      a_b = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
      [a_b | acc]
    end)
    |> solve(h_list, n)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc166/tasks/abc166_c

  ## Examples

      iex> Abc166C.solve([[1, 3], [2, 3],[2, 4]], [1, 2, 3, 4], 4)
      2
      iex> Abc166C.solve([[1, 3], [4, 2],[4, 3], [4, 6], [4, 6]], [8, 6, 9, 1, 2, 1], 6)
      3

  """
  def solve(a_b_list, h_list, n) do
    h_map = Enum.zip(1..n, h_list) |> Map.new()
    peaks_map = for(i <- 1..n, do: {i, true}) |> Map.new()

    a_b_list
    |> Enum.reduce(peaks_map, fn [a, b], acc_map ->
      a_value = Map.get(acc_map, a)
      b_value = Map.get(acc_map, b)
      a_hight = Map.get(h_map, a)
      b_hight = Map.get(h_map, b)

      do_solve(acc_map, a, b, a_value, b_value, a_hight, b_hight)
    end)
    |> Enum.count(fn {_, b} -> b end)
  end

  defp do_solve(map, _a, _b, a_value, b_value, _a_hight, _b_hight)
       when not a_value and not b_value,
       do: map

  defp do_solve(map, _a, b, a_value, b_value, a_hight, b_hight)
       when a_value and b_value and a_hight > b_hight do
    Map.update!(map, b, &(!&1))
  end

  defp do_solve(map, a, b, a_value, b_value, a_hight, b_hight)
       when a_value and b_value and a_hight == b_hight do
    Map.update!(map, a, &(!&1)) |> Map.update!(b, &(!&1))
  end

  defp do_solve(map, a, _b, a_value, b_value, a_hight, b_hight)
       when a_value and b_value and a_hight < b_hight do
    Map.update!(map, a, &(!&1))
  end

  defp do_solve(map, _a, _b, a_value, b_value, a_hight, b_hight)
       when a_value and not b_value and a_hight > b_hight do
    map
  end

  defp do_solve(map, a, _b, a_value, b_value, a_hight, b_hight)
       when a_value and not b_value and a_hight == b_hight do
    Map.update!(map, a, &(!&1))
  end

  defp do_solve(map, a, _b, a_value, b_value, a_hight, b_hight)
       when a_value and not b_value and a_hight < b_hight do
    Map.update!(map, a, &(!&1))
  end

  defp do_solve(map, _a, b, a_value, b_value, a_hight, b_hight)
       when not a_value and b_value and a_hight > b_hight do
    Map.update!(map, b, &(!&1))
  end

  defp do_solve(map, _a, b, a_value, b_value, a_hight, b_hight)
       when not a_value and b_value and a_hight == b_hight do
    Map.update!(map, b, &(!&1))
  end

  defp do_solve(map, _a, _b, a_value, b_value, a_hight, b_hight)
       when not a_value and b_value and a_hight < b_hight do
    map
  end
end
```

- [提出](https://atcoder.jp/contests/abc166/submissions/17151519)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
