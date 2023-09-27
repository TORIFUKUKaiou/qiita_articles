---
title: RubyのArray#combination(n)相当をElixirで書いてみる
tags:
  - Elixir
private: false
updated_at: '2020-09-20T11:43:03+09:00'
id: e8a27dd5bdfa31a1ec02
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Ruby](https://www.ruby-lang.org/ja/)の[Array#combination](https://docs.ruby-lang.org/ja/latest/method/Array/i/combination.html)相当のことを[Elixir](https://elixir-lang.org/)でやってみたいのであります
    - [オートレース](https://autorace.jp/)、競馬、競艇、競輪の賭式で言うところの二連複や三連複です
- permutationについては手前味噌の[RubyのArray#permutation(n)相当をElixirで書いてみる](https://qiita.com/torifukukaiou/items/0881555558387c66c5c4)をご参照ください
- `elixir: 1.10.4-otp-23`を使っています
- [Elixir built-in combinations method?](https://stackoverflow.com/questions/55894349/elixir-built-in-combinations-method)
    - こちらの記事を多いに参考にさせていただきました

# ソースコード

```elixir
defmodule Awesome do
  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end
```

```elixir
iex> IEx.configure(inspect: [limit: :infinity])
:ok

iex> Awesome.combination([1, 2, 3, 4, 5, 6, 7, 8], 3)
[
  [1, 2, 3],
  [1, 2, 4],
  [1, 2, 5],
  [1, 2, 6],
  [1, 2, 7],
  [1, 2, 8],
  [1, 3, 4],
  [1, 3, 5],
  [1, 3, 6],
  [1, 3, 7],
  [1, 3, 8],
  [1, 4, 5],
  [1, 4, 6],
  [1, 4, 7],
  [1, 4, 8],
  [1, 5, 6],
  [1, 5, 7],
  [1, 5, 8],
  [1, 6, 7],
  [1, 6, 8],
  [1, 7, 8],
  [2, 3, 4],
  [2, 3, 5],
  [2, 3, 6],
  [2, 3, 7],
  [2, 3, 8],
  [2, 4, 5],
  [2, 4, 6],
  [2, 4, 7],
  [2, 4, 8], 
  [2, 5, 6],
  [2, 5, 7],
  [2, 5, 8],
  [2, 6, 7],
  [2, 6, 8],
  [2, 7, 8],
  [3, 4, 5],
  [3, 4, 6],
  [3, 4, 7],
  [3, 4, 8],
  [3, 5, 6],
  [3, 5, 7],
  [3, 5, 8],
  [3, 6, 7],
  [3, 6, 8],
  [3, 7, 8],
  [4, 5, 6],
  [4, 5, 7],
  [4, 5, 8],
  [4, 6, 7],
  [4, 6, 8],
  [4, 7, 8],
  [5, 6, 7],
  [5, 6, 8],
  [5, 7, 8],
  [6, 7, 8]
]

iex> Awesome.combination([1, 2, 3, 4, 5, 6, 7, 8], 3) |> Enum.count
56
```

うん、良さそうです :tada::lgtm::tada::lgtm::tada::rocket:


