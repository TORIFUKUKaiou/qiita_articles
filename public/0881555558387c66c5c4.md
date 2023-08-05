---
title: RubyのArray#permutation(n)相当をElixirで書いてみる
tags:
  - Elixir
private: false
updated_at: '2020-09-20T11:45:08+09:00'
id: 0881555558387c66c5c4
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [プログラマ脳を鍛える数学パズル](https://www.amazon.co.jp/dp/479814245X) という本の問題を[Elixir](https://elixir-lang.org/)を使って解くということをやっています
- この本の正解例は[Ruby](https://www.ruby-lang.org/ja/)で書いてあるのですが、[Array#permutation](https://docs.ruby-lang.org/ja/latest/method/Array/i/permutation.html)的なことを[Elixir](https://elixir-lang.org/)でしたくなりました
    - [オートレース](https://autorace.jp/)、競馬、競艇、競輪の賭式で言うところの二連単や三連単です
- Google先生にたずねてみたところ、[Most elegant way to generate all permutations?](https://elixirforum.com/t/most-elegant-way-to-generate-all-permutations/2706) という記事がありましてエレガントなサンプルがのっていました

```Elixir:lib/awesome.exs
defmodule Awesome do
  def permutation([]), do: [[]]

  def permutation(list) do
    for x <- list, rest <- permutation(list -- [x]), do: [x | rest]
  end
end
```

```elixir
$ iex
Erlang/OTP 22 [erts-10.5] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Interactive Elixir (1.9.1) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 1..8 |> Enum.to_list() |> Awesome.permutation()
[
  [1, 2, 3, 4, 5, 6, 7, 8],
  [1, 2, 3, 4, 5, 6, 8, 7],
  [1, 2, 3, 4, 5, 7, 6, 8],
  [1, 2, 3, 4, 5, 7, 8, 6],
  [1, 2, 3, 4, 5, 8, 6, 7],
  [1, 2, 3, 4, 5, 8, 7, 6],
  [1, 2, 3, 4, 6, 5, 7, 8],
  [1, 2, 3, 4, 6, 5, 8, 7],
  [1, 2, 3, 4, 6, 7, 5, 8],
  [1, 2, 3, 4, 6, 7, 8, 5],
  [1, 2, 3, 4, 6, 8, 5, 7],
  [1, 2, 3, 4, 6, 8, 7, 5],
  [1, 2, 3, 4, 7, 5, 6, 8],
  [1, 2, 3, 4, 7, 5, 8, 6],
  [1, 2, 3, 4, 7, 6, 5, 8],
  [1, 2, 3, 4, 7, 6, 8, 5],
  [1, 2, 3, 4, 7, 8, 5, 6],
  [1, 2, 3, 4, 7, 8, 6, 5],
  [1, 2, 3, 4, 8, 5, 6, 7],
  [1, 2, 3, 4, 8, 5, 7, 6],
  [1, 2, 3, 4, 8, 6, 5, 7],
  [1, 2, 3, 4, 8, 6, 7, 5],
  [1, 2, 3, 4, 8, 7, 5, 6],
  [1, 2, 3, 4, 8, 7, 6, 5],
  [1, 2, 3, 5, 4, 6, 7, 8],
  [1, 2, 3, 5, 4, 6, 8, 7],
  [1, 2, 3, 5, 4, 7, 6, 8],
  [1, 2, 3, 5, 4, 7, 8, 6],
  [1, 2, 3, 5, 4, 8, 6, 7],
  [1, 2, 3, 5, 4, 8, 7, 6],
  [1, 2, 3, 5, 6, 4, 7, 8],
  [1, 2, 3, 5, 6, 4, 8, 7],
  [1, 2, 3, 5, 6, 7, 4, 8],
  [1, 2, 3, 5, 6, 7, 8, 4],
  [1, 2, 3, 5, 6, 8, 4, 7],
  [1, 2, 3, 5, 6, 8, 7, 4],
  [1, 2, 3, 5, 7, 4, 6, 8],
  [1, 2, 3, 5, 7, 4, 8, 6],
  [1, 2, 3, 5, 7, 6, 4, 8],
  [1, 2, 3, 5, 7, 6, 8, 4],
  [1, 2, 3, 5, 7, 8, 4, 6],
  [1, 2, 3, 5, 7, 8, 6, 4],
  [1, 2, 3, 5, 8, 4, 6, ...],
  [1, 2, 3, 5, 8, 4, ...],
  [1, 2, 3, 5, 8, ...],
  [1, 2, 3, 5, ...],
  [1, 2, 3, ...],
  [1, 2, ...],
  [1, ...],
  [...],
  ...
]
iex(3)> 1..8 |> Enum.to_list() |> Awesome.permutation() |> length()
40320
iex(4)> 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1
40320
```
- うん、すばらしい！

# ところで
- [Ruby](https://www.ruby-lang.org/ja/)の[Array#permutation](https://docs.ruby-lang.org/ja/latest/method/Array/i/permutation.html)の定義をよくみると、引数にnを取れるようです
- 生成される各配列の要素数の指定となります
- これは、いつ使うかというと、そうです、たとえば[オートレース](http://autorace.jp/)の３連単の組み合わせを列挙するときに必要となります
- これはぜひ実装しておきたいです

```Elixir:lib/awesome.exs
defmodule Awesome do
  def permutation(_, 0), do: [[]]

  def permutation(list, n) do
    for x <- list, rest <- permutation(list -- [x], n - 1), do: [x | rest]
  end
end
```

```elixir
iex(5)> 1..8 |> Enum.to_list() |> Awesome.permutation(3)       
[
  [1, 2, 3],
  [1, 2, 4],
  [1, 2, 5],
  [1, 2, 6],
  [1, 2, 7],
  [1, 2, 8],
  [1, 3, 2],
  [1, 3, 4],
  [1, 3, 5],
  [1, 3, 6],
  [1, 3, 7],
  [1, 3, 8],
  [1, 4, 2],
  [1, 4, 3],
  [1, 4, 5],
  [1, 4, 6],
  [1, 4, 7],
  [1, 4, 8],
  [1, 5, 2],
  [1, 5, 3],
  [1, 5, 4],
  [1, 5, 6],
  [1, 5, 7],
  [1, 5, 8],
  [1, 6, 2],
  [1, 6, 3],
  [1, 6, 4],
  [1, 6, 5],
  [1, 6, 7],
  [1, 6, 8],
  [1, 7, 2], 
  [1, 7, 3],
  [1, 7, 4],
  [1, 7, 5],
  [1, 7, 6],
  [1, 7, 8],
  [1, 8, 2],
  [1, 8, 3],
  [1, 8, 4],
  [1, 8, 5],
  [1, 8, 6],
  [1, 8, 7],
  [2, 1, 3],
  [2, 1, 4],
  [2, 1, 5],
  [2, 1, 6],
  [2, 1, 7],
  [2, 1, ...],
  [2, ...],
  [...],
  ...
]
iex(6)> 1..8 |> Enum.to_list() |> Awesome.permutation(3) |> length()
336
iex(7)> 8 * 7 * 6
336
iex(8)> 1..8 |> Enum.to_list() |> Awesome.permutation(0)           
[[]]
iex(9)> 1..8 |> Enum.to_list() |> Awesome.permutation(9) 
[]
```

- こんな感じになります
- nに0を指定したときと、nにリストの長さよりも長い値を指定したときの動作が、[Ruby](https://www.ruby-lang.org/ja/)と同じになっている点が私にはちょっとした驚きでした


