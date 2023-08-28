---
title: 'Enjoy Elixir #004 Modules and functions'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T11:25:25+09:00'
id: 2b6f30db0a7d37c4f139
organization_url_name: fukuokaex
slide: true
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/6/23(火)の回](https://kfieyaruki.connpass.com/event/177853/)
- 今日は以下を学びます
    - Modules and functions
- A journey of a thousand miles begins with a single step.
- この記事は[Elixir](https://elixir-lang.org/)を触るのがはじめてという方に向けて書いています

----
# もくじ
[001 mix new, iex -S mix, mix format](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af)
|> [002 型](https://qiita.com/torifukukaiou/items/1f5789dbd05498be1132)
|> [003 Pattern matching](https://qiita.com/torifukukaiou/items/47b088f6c44ccf213226)
|> [004 Modules and functions](https://qiita.com/torifukukaiou/items/2b6f30db0a7d37c4f139)
|> [005 Pipe operator and Enum module](https://qiita.com/torifukukaiou/items/70a350cfc45d0eb58371)
|> [006 HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)
|> [007 Flow](https://qiita.com/torifukukaiou/items/eb1aa2c8842adfc40637)
|> [008 AtCoderを解いてみる](https://qiita.com/torifukukaiou/items/98f875ee4d0f4038b5a2)
|> [999 Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a)

----
# 準備

```console
$ mix new hello
$ cd hello
```

----
# はじめてのモジュール

- ここまでにすでにいくつかの最初から用意されているモジュールをさわっています
    - [String](https://hexdocs.pm/elixir/String.html#content)
    - [Enum](https://hexdocs.pm/elixir/Enum.html#content)
- 今回は自作のモジュールを作ってみましょう



```elixir:lib/math.ex
defmodule Math do
  def sum(a, b) do
    a + b
  end
end
```
- `Math.sum/2`という関数を定義しています
    - 関数のあとの(`/数字`)は引数の数です

```elixir
$ iex -S mix

iex> Math.sum(1, 2)
3
```

----
# Private functions

```elixir:lib/math.ex
defmodule Math do
  def sum(a, b) do
    do_sum(a, b)
  end

  defp do_sum(a, b) do
    a + b
  end
end
```

```elixir
iex> recompile

iex> Math.sum(1, 2)
3

iex> Math.do_sum(1, 2)
** (UndefinedFunctionError) function Math.do_sum/2 is undefined or private
    (hello 0.1.0) Math.do_sum(1, 2)
```

----
# ガード


```lib/fizz_buzz.ex
defmodule FizzBuzz do
  def number(n) when rem(n, 3) == 0 and rem(n, 5) == 0 do
    "Fizz Buzz"
  end

  def number(n) when rem(n, 3) == 0 do
    "Fizz"
  end

  def number(n) when rem(n, 5) == 0 do
    "Buzz"
  end

  def number(n), do: n
end
```

- 上から最初にマッチする関数が実行されます

```elixir
iex> recompile

iex> 1..15 |> Enum.map(&FizzBuzz.number/1)
[1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
 "Fizz Buzz"]
```

- `when`のうしろに使える演算子は、[Guards](https://hexdocs.pm/elixir/Kernel.html#guards)に書いてあります
- `def number(n), do: n`はこういう書き方もできますという例です
    - `do`の前の`,`を忘れないようにしてください
    - `do:` と`:`が必要なことに注意してください
    - [私は、Elixirの関数やifを1行で書くときに , を忘れがちだし、Enum.reduce/3のfunのaccが1番目だったか2番目だったかを忘れがち](https://qiita.com/torifukukaiou/items/63823013b7b6e76fd9ef)

----
# デフォルト引数

```elixir:lib/concat.ex
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end
```

- `\\`の後ろにデフォルト引数を指定できます

```elixir
iex> recompile

iex> Concat.join("Hello", "World")
"Hello World"

iex> Concat.join("Hello", "World", "_")
"Hello_World"
```

----
# 参考
- [Modules and functions](https://elixir-lang.org/getting-started/modules-and-functions.html)

----
# Wrapping Up
- 今日のポイントは、[defmodule](https://hexdocs.pm/elixir/Kernel.html#defmodule/2)、[def](https://hexdocs.pm/elixir/Kernel.html#def/2)です
- 次回は、すでにちょいちょいでてきていますが、`Pipe operator and Enum module`を詳しくみていきたいとおもいます
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- **Enjoy!!!**
