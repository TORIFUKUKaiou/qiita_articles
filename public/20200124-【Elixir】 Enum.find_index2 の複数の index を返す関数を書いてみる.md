---
title: '[Elixir] Enum.find_index/2 の複数の index を返す関数を書いてみる'
tags:
  - Elixir
private: false
updated_at: '2020-01-24T22:43:47+09:00'
id: f5c0cb895617427f84b3
organization_url_name: fukuokaex
slide: false
---
@QUANON さんの[[Ruby] Array#find_index の複数の index を返すバージョンがほしい](https://qiita.com/QUANON/items/ca06f3068c87b3a21e18) を[Elixir](https://elixir-lang.org/)で書いてみました

# バージョン情報
```
% elixir -v
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.9.4 (compiled with Erlang/OTP 22)
```

# やりたいこと
[Enum.find_index/2](https://hexdocs.pm/elixir/Enum.html#find_index/2) は引数に一致する最初の要素のインデックスを返す。

```Elixir
iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Enum.find_index(&(&1 == "🐁"))
2
```

でも一致するすべてのインデックスを返してほしいな。

```Elixir
iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome.indexes(&(&1 == "🐁"))
[2, 4]
```

# 方法
```Elixir:lib/awesome.ex
defmodule Awesome do
  @moduledoc false

  @doc """
  indexes

  ## Examples

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome.indexes(&(&1 == "🐁"))
      [2, 4]

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome.indexes(&(&1 == "🐟"))
      [1]

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome.indexes(&(&1 == "🐝"))
      []

      iex> ~w(🦜 🐟 🦄) |> Awesome.indexes(&(&1 == "🐁"))
      []

      iex> ~w(🐁 🐁 🐁 🐁 🐁) |> Awesome.indexes(&(&1 == "🐁"))
      [0, 1, 2, 3, 4]

      iex> [] |> Awesome.indexes(&(&1 == "🐁"))
      []

  """
  def indexes(list, fun) do
    list
    |> Enum.with_index()
    |> Enum.filter(fn {v, _} -> fun.(v) end)
    |> Enum.map(fn {_, idx} -> idx end)
  end
end
```

# 最初に書いたバージョン
```Elixir:lib/awesome2.ex
defmodule Awesome2 do
  @moduledoc false

  @doc """
  indexes

  ## Examples

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome2.indexes(&(&1 == "🐁"))
      [2, 4]

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome2.indexes(&(&1 == "🐟"))
      [1]

      iex> ~w(🦜 🐟 🐁 🦄 🐁) |> Awesome2.indexes(&(&1 == "🐝"))
      []

      iex> ~w(🦜 🐟 🦄) |> Awesome2.indexes(&(&1 == "🐁"))
      []

      iex> ~w(🐁 🐁 🐁 🐁 🐁) |> Awesome2.indexes(&(&1 == "🐁"))
      [0, 1, 2, 3, 4]

      iex> [] |> Awesome2.indexes(&(&1 == "🐁"))
      []

  """
  def indexes(list, fun) when is_list(list), do: _indexes(list, fun, 0, [])

  defp _indexes([], _, _, result_list), do: result_list

  defp _indexes([head | tail], fun, idx, result_list) do
    if fun.(head) do
      _indexes(tail, fun, idx + 1, result_list ++ [idx])
    else
      i = Enum.find_index(tail, &fun.(&1))

      if i,
        do:
          _indexes(Enum.slice(tail, (i + 1)..-1), fun, idx + 2 + i, result_list ++ [idx + 1 + i]),
        else: result_list
    end
  end
end
```
- 長い。。。
- [if/2](https://hexdocs.pm/elixir/Kernel.html#if/2) 入れ子で使っている。。。
- こんなに複雑なことをする必要はないと思い直して、発想を変えてみました
- もとの記事の `map.with_index { |element, i| i if element == val }.compact` これをよく見ればよかった。。。
- まあ、とにかく書けたことはよかった
