---
title: 'ElixirでABC175のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:15:54+09:00'
id: ef22b61ef2672113144b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC175のA,B,C問題を制する！](https://qiita.com/u2dayo/items/ce1b420344e451560b42)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 175](https://atcoder.jp/contests/abc175)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Rainy Season](https://atcoder.jp/contests/abc175/tasks/abc175_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/at_coder_175_a.ex
defmodule AtCoder175A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc175/tasks/abc175_a

  ## Examples

      iex> AtCoder175A.solve("RRS")
      2
      iex> AtCoder175A.solve("SSS")
      0
      iex> AtCoder175A.solve("RSR")
      1

  """
  def solve(s) do
    ["RRR", "RR", "R"]
    |> Enum.map(&{String.contains?(s, &1), &1})
    |> Enum.filter(fn {b, _} -> b end)
    |> Enum.at(0, {true, ""})
    |> elem(1)
    |> String.length()
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
  doctest AtCoder175A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc175/submissions/17067424)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Making Triangle](https://atcoder.jp/contests/abc175/tasks/abc175_b)
- 問題文はリンク先をご参照くださいませ :bow:
- [元の記事](https://qiita.com/u2dayo/items/ce1b420344e451560b42)の解説をとても参考にしました！
    - ありがとうございます！

```elixir:lib/at_coder_175_b.ex
defmodule AtCoder175B do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(list, n) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc175/tasks/abc175_b

  ## Examples

      iex> AtCoder175B.solve([4, 4, 9, 7, 5], 5)
      5
      iex> AtCoder175B.solve([4, 5, 4, 3, 3, 5], 6)
      8
      iex> AtCoder175B.solve([9, 4, 6, 1, 9, 6, 10, 6, 6, 8], 10)
      39
      iex> AtCoder175B.solve([1, 1], 2)
      0

  """
  def solve(list, n) do
    for i <- 0..(n - 1),
        j <- (i + 1)..(n - 1),
        k <- (j + 1)..(n - 1),
        l_1 = Enum.at(list, i),
        l_2 = Enum.at(list, j),
        l_3 = Enum.at(list, k),
        l_1 != l_2,
        l_1 != l_3,
        l_2 != l_3,
        trialgle?(l_1, l_2, l_3),
        reduce: %{} do
      acc -> Map.update(acc, :ok, 1, &(&1 + 1))
    end
    |> Map.values()
    |> Enum.at(0, 0)
  end

  defp trialgle?(l_1, l_2, l_3) do
    [a, b, c] = [l_1, l_2, l_3] |> Enum.sort()
    c < a + b
  end
end
```

- [提出](https://atcoder.jp/contests/abc175/submissions/17065377)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Walking Takahashi](https://atcoder.jp/contests/abc175/tasks/abc175_c)
- 問題文はリンク先をご参照くださいませ :bow:
- [元の記事](https://qiita.com/u2dayo/items/ce1b420344e451560b42)の解説をとても参考にしました！
    - ありがとうございます！


```elixir:lib/at_coder_175_c.ex
defmodule AtCoder175C do
  def main do
    [x, k, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(x, k, d) |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc175/tasks/abc175_c

  ## Examples

      iex> AtCoder175C.solve(6, 2, 4)
      2
      iex> AtCoder175C.solve(7, 4, 3)
      1
      iex> AtCoder175C.solve(10, 1, 2)
      8
      iex> AtCoder175C.solve(1000000000000000, 1000000000000000, 1000000000000000)
      1000000000000000

  """
  def solve(x, k, d) do
    do_solve(x, k, d)
  end

  def do_solve(x, k, d) when div(abs(x), d) >= k, do: abs(x) - k * d

  def do_solve(x, k, d) when rem(k - div(abs(x), d), 2) == 0, do: abs(x) - div(abs(x), d) * d

  def do_solve(x, _k, d), do: abs(abs(x) - div(abs(x), d) * d - d)
end
```

- [提出](https://atcoder.jp/contests/abc175/submissions/17067386)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- 今回は[解説記事](https://qiita.com/u2dayo/items/ce1b420344e451560b42)にだいぶ助けていただきました
    - ありがとうございます！
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
