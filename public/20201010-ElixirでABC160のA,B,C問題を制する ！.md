---
title: 'ElixirでABC160のA,B,C問題を制する ！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:22:31+09:00'
id: 41b06055d8ac5fb7bb94
organization_url_name: fukuokaex
slide: false
---
# はじめに

- [Elixir](https://elixir-lang.org/)でやってみました


# 問題
- [AtCoder Beginner Contest 160](https://atcoder.jp/contests/abc160)
- A〜Cまで解いてみます

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Coffee](https://atcoder.jp/contests/abc160/tasks/abc160_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_160_a.ex
defmodule Abc160A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc160/tasks/abc160_a

  ## Examples

      iex> Abc160A.solve("sippuu")
      "Yes"
      iex> Abc160A.solve("iphone")
      "No"
      iex> Abc160A.solve("coffee")
      "Yes"

  """
  def solve(s) do
    String.codepoints(s) |> do_solve()
  end

  defp do_solve([_, _, f, f, e, e]), do: "Yes"
  defp do_solve(_), do: "No"
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- この問題は入力が6文字で、3番目と4番目が等しいかつ5番目と6番目が等しい場合に`"Yes"`を表示し、そうではない場合には`"No"`を返すことになっています
- [if/2](https://hexdocs.pm/elixir/Kernel.html#if/2)で書くこともできます
- `do_solve/1`のようにリストの要素に同じ変数名を使うことで3番目と4番目が等しいかつ5番目と6番目が等しいということを表現しています(こういう書き方アリなんだというのは私にとって発見でした)
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc160A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc160/submissions/17267636)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、B問題、C問題を解いていきます

# [問題B - Golden Coins](https://atcoder.jp/contests/abc160/tasks/abc160_b)

```elixir:lib/abc_160_b.ex
defmodule Abc160B do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc160/tasks/abc160_b

  ## Examples

      iex> Abc160B.solve(1024)
      2020
      iex> Abc160B.solve(0)
      0
      iex> Abc160B.solve(1000000000)
      2000000000

  """
  def solve(x) do
    div(x, 500) * 1000 + div(rem(x, 500), 5) * 5
  end
end
```

- [提出](https://atcoder.jp/contests/abc160/submissions/17267643)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Traveling Salesman around Lake](https://atcoder.jp/contests/abc160/tasks/abc160_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_160_c.ex
defmodule Abc160C do
  def main do
    [k, _n] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve(k)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc160/tasks/abc160_c

  ## Examples

      iex> Abc160C.solve([5, 10, 15], 20)
      10
      iex> Abc160C.solve([0, 5, 15], 20)
      10

  """
  def solve(list, k) do
    first = hd(list)

    list
    |> Kernel.++([first + k])
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [small, big], acc ->
      diff = big - small
      if diff > acc, do: diff, else: acc
    end)
    |> Kernel.-(k)
    |> Kernel.*(-1)
  end
end
```

- [Enum.chunk_every/4](https://hexdocs.pm/elixir/Enum.html#chunk_every/4)が大活躍です！
- [提出](https://atcoder.jp/contests/abc160/submissions/17267629)の際にはモジュール名は`Main`にしておいてください


# Wrapping Up :qiita-fabicon: 
- 今回は自力でいけました！ :smile: 
    - C問題は法則といいますかこうやれば計算は少なくて済むだろうなあというものを自力で発見できて解けたことに喜びを感じています
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
