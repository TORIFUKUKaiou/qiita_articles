---
title: 'ElixirでABC171のA,B,C問題を制する！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:18:16+09:00'
id: 84a7249a86a51fb8ac80
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC171のA,B,C問題を制する！](https://qiita.com/u2dayo/items/5f9dfee2ec0145402d75)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 171](https://atcoder.jp/contests/abc171)
- A〜Cまで解いてみます
- 今回は自力で行けました！　ただ私の場合、C問題は解法をなんとなくおもいついてからコードにするまでにめちゃくちゃ時間かかっています :sweat: 

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - αlphabet](https://atcoder.jp/contests/abc171/tasks/abc171_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_171_a.ex
defmodule Abc171A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_charlist()
    |> hd()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc171/tasks/abc171_a

  ## Examples

      iex> Abc171A.solve(?B)
      "A"
      iex> Abc171A.solve(?a)
      "a"

  """
  def solve(a) when a in ?a..?z, do: "a"

  def solve(_), do: "A"
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
  doctest Abc171A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc171/submissions/17138562)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- 以下、B問題、C問題を解いていきます

# [問題B - Mix Juice](https://atcoder.jp/contests/abc171/tasks/abc171_b)

```elixir:lib/abc_171_b.ex
defmodule Abc171B do
  def main do
    [_, k] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve(k)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc171/tasks/abc171_b

  ## Examples

      iex> Abc171B.solve([50, 100, 80, 120, 80], 3)
      210
      iex> Abc171B.solve([1000], 1)
      1000

  """
  def solve(list, k) do
    Enum.sort(list)
    |> Enum.take(k)
    |> Enum.sum()
  end
end

```

- [提出](https://atcoder.jp/contests/abc171/submissions/17138649)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - One Quadrillion and One Dalmatians](https://atcoder.jp/contests/abc171/tasks/abc171_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_171_c.ex
defmodule Abc171C do
  @table ?a..?z
         |> Enum.with_index()
         |> Enum.map(fn {a, b} -> {b, [a] |> List.to_string()} end)
         |> Map.new()

  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc171/tasks/abc171_c

  ## Examples

      iex> Abc171C.solve(2)
      "b"
      iex> Abc171C.solve(27)
      "aa"
      iex> Abc171C.solve(123456789)
      "jjddja"

  """
  def solve(n) when n - 1 < 26 do
    Map.get(@table, n - 1)
  end

  def solve(n) do
    do_solve(n, [])
  end

  defp do_solve(n, acc) when n - 1 < 26 do
    [Map.get(@table, n - 1) | acc]
    |> Enum.join()
  end

  defp do_solve(n, acc) do
    list = Integer.to_charlist(n - 1, 26)
    last = Map.get(@table, [List.last(list)] |> List.to_string() |> String.to_integer(26))

    list
    |> List.delete_at(-1)
    |> List.to_string()
    |> String.to_integer(26)
    |> do_solve([last | acc])
  end
end

```

- [提出](https://atcoder.jp/contests/abc171/submissions/17138460)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada: 

# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
