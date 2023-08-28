---
title: AtCoder に登録したら解くべき精選過去問 10 問を私も"Elixir"で解いてみた
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:25:15+09:00'
id: 2a17b1cb850cde75f664
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @koyo-miyamura さんの[【doctestつき】AtCoder に登録したら解くべき精選過去問 10 問を"Elixir"で解いてみた](https://qiita.com/koyo-miyamura/items/9f224a3e56ea75939dca)を拝見しまして、私も[Elixir](https://elixir-lang.org/)でやってみました

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Product](https://atcoder.jp/contests/abc086/tasks/abc086_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_086_a.ex
defmodule Abc086A do
  def main do
    [a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(a, b)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc086/tasks/abc086_a

  ## Examples

      iex> Abc086A.solve(3, 4)
      "Even"
      iex> Abc086A.solve(1, 21)
      "Odd"

  """
  def solve(a, b) when rem(a, 2) == 0 or rem(b, 2) == 0, do: "Even"

  def solve(_, _), do: "Odd"
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc086A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc086/submissions/17274843)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、他の問題を解いていきます

# [問題A - Placing Marbles](https://atcoder.jp/contests/abc081/tasks/abc081_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_086_a.ex
defmodule Abc081A do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc081/tasks/abc081_a

  ## Examples

      iex> Abc081A.solve("101")
      2
      iex> Abc081A.solve("000")
      0

  """
  def solve(s) do
    String.codepoints(s)
    |> Enum.count(&(&1 == "1"))
  end
end
```

- [提出](https://atcoder.jp/contests/abc081/submissions/17274877)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題B - Shift only](https://atcoder.jp/contests/abc081/tasks/abc081_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_081_b.ex
defmodule Abc081B do
  def main do
    IO.read(:line)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc081/tasks/abc081_b

  ## Examples

      iex> Abc081B.solve([8, 12, 40])
      2
      iex> Abc081B.solve([5, 6, 8, 10])
      0
      iex> Abc081B.solve([382253568, 723152896, 37802240, 379425024, 404894720, 471526144])
      8

  """
  def solve(list) do
    Enum.reduce_while(list, 10_000_000_000, fn a, acc ->
      cnt = do_solve(a, 0)
      new_acc = if cnt < acc, do: cnt, else: acc
      if new_acc == 0, do: {:halt, 0}, else: {:cont, new_acc}
    end)
  end

  defp do_solve(a, acc) when rem(a, 2) == 1, do: acc

  defp do_solve(a, acc), do: do_solve(div(a, 2), acc + 1)
end
```

- [提出](https://atcoder.jp/contests/abc081/submissions/17274966)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# [問題B - Coins](https://atcoder.jp/contests/abc087/tasks/abc087_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_087_b.ex
defmodule Abc087B do
  def main do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    b = IO.read(:line) |> String.trim() |> String.to_integer()
    c = IO.read(:line) |> String.trim() |> String.to_integer()
    x = IO.read(:line) |> String.trim() |> String.to_integer()

    solve(a, b, c, x)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc087/tasks/abc087_b

  ## Examples

      iex> Abc087B.solve(2, 2, 2, 100)
      2
      iex> Abc087B.solve(5, 1, 0, 150)
      0
      iex> Abc087B.solve(30, 40, 50, 6000)
      213

  """
  def solve(a, b, c, x) do
    for(i <- 0..a, j <- 0..b, k <- 0..c, 500 * i + 100 * j + 50 * k == x, do: {i, j, k})
    |> Enum.count()
  end
end
```

- [提出](https://atcoder.jp/contests/abc087/submissions/17275028)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題B - Some Sums](https://atcoder.jp/contests/abc083/tasks/abc083_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_083_b.ex
defmodule Abc083B do
  def main do
    [n, a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, a, b)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc083/tasks/abc083_b

  ## Examples

      iex> Abc083B.solve(20, 2, 5)
      84
      iex> Abc083B.solve(10, 1, 2)
      13
      iex> Abc083B.solve(100, 4, 16)
      4554

  """
  def solve(n, a, b) do
    for(i <- 1..n, sum = digit_sum(i, 0), a <= sum, sum <= b, do: i)
    |> Enum.sum()
  end

  defp digit_sum(i, acc) when i < 10, do: acc + i

  defp digit_sum(i, acc), do: digit_sum(div(i, 10), acc + rem(i, 10))
end
```

- [提出](https://atcoder.jp/contests/abc083/submissions/17275149)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# [問題B - Card Game for Two](https://atcoder.jp/contests/abc088/tasks/abc088_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_088_b.ex
defmodule Abc088B do
  def main do
    IO.read(:line)

    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc088/tasks/abc088_b

  ## Examples

      iex> Abc088B.solve([3, 1])
      2
      iex> Abc088B.solve([2, 7, 4])
      5
      iex> Abc088B.solve([20, 18, 2, 18])
      18

  """
  def solve(list) do
    sorted_list = Enum.sort(list, :desc)
    alice_list = Enum.take_every(sorted_list, 2)
    Enum.sum(alice_list) * 2 - Enum.sum(list)
  end
end
```

- [提出](https://atcoder.jp/contests/abc088/submissions/17275313)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:



# [問題B - Kagami Mochi](https://atcoder.jp/contests/abc085/tasks/abc085_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_085_b.ex
defmodule Abc085B do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    for(_ <- 1..n, do: IO.read(:line) |> String.trim() |> String.to_integer())
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc085/tasks/abc085_b

  ## Examples

      iex> Abc085B.solve([10, 8, 8, 6])
      3
      iex> Abc085B.solve([15, 15, 15])
      1
      iex> Abc085B.solve([50, 30, 50, 100, 50, 80, 30])
      4

  """
  def solve(list), do: MapSet.new(list) |> MapSet.size()
end
```

- [提出](https://atcoder.jp/contests/abc085/submissions/17275453)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# [問題C - Otoshidama](https://atcoder.jp/contests/abc085/tasks/abc085_c)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_085_b.ex
defmodule Abc085C do
  def main do
    [n, y] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, y)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc085/tasks/abc085_b

  ## Examples

      iex> Abc085C.solve(9, 45000)
      "0 9 0"
      iex> Abc085C.solve(20, 196000)
      "-1 -1 -1"
      iex> Abc085C.solve(1000, 1234000)
      "2 54 944"
      iex> Abc085C.solve(2000, 20000000)
      "2000 0 0"

  """
  def solve(n, y) do
    for(
      i <- 0..n,
      j <- 0..(n - i),
      k = n - i - j,
      j >= 0,
      k >= 0,
      10000 * i + 5000 * j + 1000 * k == y,
      do: "#{i} #{j} #{k}"
    )
    |> Enum.at(0, "-1 -1 -1")
  end
end
```

- [提出](https://atcoder.jp/contests/abc085/submissions/17275879)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# [問題C - 白昼夢](https://atcoder.jp/contests/abc049/tasks/arc065_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_049_c.ex
defmodule Abc049C do
  @words ~w(dream dreamer erase eraser) |> Enum.map(&String.reverse/1)

  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc085/tasks/abc085_b

  ## Examples

      iex> Abc049C.solve("erasedream")
      "YES"
      iex> Abc049C.solve("dreameraser")
      "YES"
      iex> Abc049C.solve("dreamerer")
      "NO"

  """
  def solve(s) do
    String.reverse(s) |> do_solve()
  end

  defp do_solve(""), do: "YES"

  defp do_solve(nil), do: "NO"

  defp do_solve(s) do
    @words
    |> Enum.reduce_while(nil, fn word, acc ->
      if String.starts_with?(s, word) do
        {:halt, String.slice(s, String.length(word)..-1)}
      else
        {:cont, acc}
      end
    end)
    |> do_solve()
  end
end
```

- [提出](https://atcoder.jp/contests/abc049/submissions/17277396)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# [問題ABC086C - Traveling](https://atcoder.jp/contests/abs/tasks/arc089_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/lib/arc089_a.ex
defmodule Arc089A do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.reduce([], fn _, acc ->
      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> Enum.reverse()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc172/tasks/abc172_b

  ## Examples

      iex> Arc089A.solve([[3, 1, 2], [6, 1, 1]])
      "Yes"
      iex> Arc089A.solve([[2, 100, 100]])
      "No"
      iex> Arc089A.solve([[5, 1, 1], [100, 1, 1]])
      "No"

  """
  def solve(list_of_lists) do
    list_of_lists
    |> Enum.reduce_while([0, 0, 0, "No"], fn next, acc ->
      do_solve(next, acc)
    end)
    |> Enum.at(-1)
  end

  defp do_solve([next_t, next_x, next_y], [t, x, y, _])
       when abs(next_x - x) + abs(next_y - y) > next_t - t,
       do: {:halt, [next_t, next_x, next_y, "No"]}

  defp do_solve([next_t, next_x, next_y], [t, x, y, _])
       when rem(next_t - t - (abs(next_x - x) + abs(next_y - y)), 2) == 1,
       do: {:halt, [next_t, next_x, next_y, "No"]}

  defp do_solve([next_t, next_x, next_y], _),
    do: {:cont, [next_t, next_x, next_y, "Yes"]}
end
```

- [提出](https://atcoder.jp/contests/abs/submissions/17395021)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:

# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 


