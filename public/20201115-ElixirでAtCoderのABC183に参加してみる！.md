---
title: ElixirでAtCoderのABC183に参加してみる！
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-22T12:41:08+09:00'
id: d7f6b7e511716b79d42a
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 2020-11-15(日) 21:00 ~ 2020-11-15(日) 22:40 (100分)に行われた[AtCoder Beginner Contest 183](https://atcoder.jp/contests/abc183)に参加してみました
- A〜C問題までは時間内に解けました
- 今回はまだ使っていませんが、[kyopuro](https://hex.pm/packages/kyopuro)というツールがあるようなのでこちらも今後は使ってみたいとおもっています
    - [そういえば提出を実装しました](https://twitter.com/g_kenkun/status/1327979853262385152)

# [AtCoder](https://atcoder.jp/home)について
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、今年からはじめました

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_corder
```

# [問題A - ReLU](https://atcoder.jp/contests/abc183/tasks/abc183_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_183_a.ex
defmodule Abc183A do
  def main do
    IO.read(:line) |> String.trim() |> String.to_integer() |> solve() |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc183_a

  ## Examples

      iex> Abc183A.solve(1)
      1
      iex> Abc183A.solve(0)
      0
      iex> Abc183A.solve(-1)
      0

  """
  def solve(x) when x >= 0, do: x

  def solve(_x), do: 0
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc183A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc183/submissions/18121506)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で問題を解いていきます

# [問題B - Billiards](https://atcoder.jp/contests/abc183/tasks/abc183_b)

```elixir:lib/abc_183_b.ex
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

- [提出](https://atcoder.jp/contests/abc183/tasks/abc183_b)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Trave](https://atcoder.jp/contests/abc183/tasks/abc183_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/abc_183_c.ex
defmodule Abc183C do
  def main do
    [n, k] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..n
    |> Enum.reduce([], fn _, acc ->
      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> Enum.reverse()
    |> solve(n, k)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc183_c

  ## Examples

      iex> Abc183C.solve([[0, 1, 10, 100], [1, 0, 20, 200], [10, 20, 0, 300], [100, 200, 300, 0]], 4, 330)
      2

      iex> Abc183C.solve([[0, 1, 1, 1, 1], [1, 0, 1, 1, 1], [1, 1, 0, 1, 1], [1, 1, 1, 0, 1], [1, 1, 1, 1, 0]], 5, 5)
      24

  """
  def solve(list_of_lists, n, k) do
    1..(n - 1)
    |> Enum.to_list()
    |> permutation(n - 1)
    |> Enum.map(&(&1 ++ [0]))
    |> Enum.map(&do_solve(&1, list_of_lists, k))
    |> Enum.filter(&(&1 == k))
    |> Enum.count()
  end

  def do_solve(route, list_of_lists, k) do
    Enum.reduce_while(route, {0, 0}, fn j, {i, sum} ->
      sum = sum + get_in(list_of_lists, [Access.at(i), Access.at(j)])
      if sum > k, do: {:halt, {nil, nil}}, else: {:cont, {j, sum}}
    end)
    |> elem(1)
  end

  def permutation(_, 0), do: [[]]

  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end
end
```

- [提出](https://atcoder.jp/contests/abc183/submissions/18141563)の際にはモジュール名は`Main`にしておいてください
- `list_of_lists`から値をとるところは、最近覚えた(!) [Kernel.get_in/2](https://hexdocs.pm/elixir/Kernel.html#get_in/2)を使っています

# [問題D - Water Heater](https://atcoder.jp/contests/abc183/tasks/abc183_d)
- 問題文はリンク先をご参照くださいませ :bow:
- なんとなく書いてはみましたが、`TLE (Time Limit Exceeded)`になるだろうとおもって、提出したら予想通り`TLE (Time Limit Exceeded)`でした
- このへんでコンテストの時間切れでした
- トップの方はF問題までを13分59秒というタイムで解いていらっしゃるのでただただ驚きです
- 精進をかさねたいとおもいます

## パスしません :cry: 
- パスしませんが、とりあえず載せておきます
- パスするコードにして更新したいとおもってはいます
    - [パスするコード！](https://atcoder.jp/contests/abc183/submissions/18153843)
    - ↑こちらを眺めていてなんとなく改善ポイントがわかりました
    - ありがとうございます！

```elixir:lib/abc_183_d.ex
defmodule Abc183D do
  def main do
    [n, w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..n
    |> Enum.reduce([], fn _, acc ->
      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> solve(w)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc183_d

  ## Examples

      iex> Abc183D.solve([[[1, 3, 5], [2, 4, 4], [3, 10, 6], [2, 4, 1]], 4)
      "No"

  """
  def solve(list_of_lists, w) do
    p_max = p_max(list_of_lists)

    if p_max > w do
      "No"
    else
      do_solve(list_of_lists, w)
    end
  end

  def do_solve(list_of_lists, w) do
    list_of_lists
    |> Enum.reduce_while(%{}, fn [s, t, p], acc ->
      {new_acc, v_max} =
        s..(t - 1)
        |> Enum.reduce({acc, 0}, fn i, {acc2, v_max} ->
          acc2 =
            case acc2 do
              %{^i => value} -> %{acc2 | i => value + p}
              %{} -> Map.put(acc2, i, p)
            end

          v = Map.get(acc2, i)
          {acc2, max(v, v_max)}
        end)

      if v_max > w, do: {:halt, nil}, else: {:cont, new_acc}
    end)
    |> if(do: "Yes", else: "No")
  end

  def t_max(list_of_lists) do
    Enum.max_by(list_of_lists, fn [_, t, _] -> t end)
    |> Enum.at(1)
  end

  def p_max(list_of_lists) do
    Enum.max_by(list_of_lists, fn [_, _, p] -> p end)
    |> Enum.at(2)
  end
end
```

# パスする！ :tada::tada::tada: 
- [パスするコード！](https://atcoder.jp/contests/abc183/submissions/18153843)
- ↑こちらを参考に処理のスリム化をしました！
    - なるほど :lgtm::lgtm::lgtm: って感じでした！ 
- ありがとうございます！


```elixir:lib/abc_183_d.ex
defmodule Abc183D do
  def main do
    [n, w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..n
    |> Enum.reduce([], fn _, acc ->
      list =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)
    |> solve(w)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc180/tasks/abc183_d

  ## Examples

      iex> Abc183D.solve([[1, 3, 5], [2, 4, 4], [3, 10, 6], [2, 4, 1]], 4)
      "No"

  """
  def solve(list_of_lists, w) do
    p_max = p_max(list_of_lists)

    if p_max > w do
      "No"
    else
      do_solve(list_of_lists, w)
    end
  end

  def do_solve(list_of_lists, w) do
    list_of_lists
    |> Enum.reduce(%{}, fn [s, t, p], acc ->
      acc =
        case acc do
          %{^s => value} -> %{acc | s => value + p}
          %{} -> Map.put(acc, s, p)
        end

      case acc do
        %{^t => value} -> %{acc | t => value - p}
        %{} -> Map.put(acc, t, -p)
      end
    end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {i, _} -> i end)
    |> Enum.reduce_while(0, fn {_, v}, acc ->
      new_acc = acc + v
      if new_acc > w, do: {:halt, nil}, else: {:cont, new_acc}
    end)
    |> if(do: "Yes", else: "No")
  end

  def p_max(list_of_lists) do
    Enum.max_by(list_of_lists, fn [_, _, p] -> p end)
    |> Enum.at(2)
  end
end
```

- [提出](https://atcoder.jp/contests/abc183/submissions/18156477)の際にはモジュール名は`Main`にしておいてください

# Wrapping Up :lgtm: :qiita-fabicon: :lgtm: 
- A〜Cは自力でいけました！ :smile:
- Dはあと一歩、計算量を減らす工夫が足りませんでした
- 解くスピードはまだまだ全然です
    - つまり**伸びしろしかない！！！**:fire::fire::fire:
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:


