---
title: '私は、Elixirの関数やifを1行で書くときに , を忘れがちだし、Enum.reduce/3のfunのaccが1番目だったか2番目だったかを忘れがち'
tags:
  - Elixir
  - kokuraex
private: false
updated_at: '2019-12-17T22:19:59+09:00'
id: 63823013b7b6e76fd9ef
organization_url_name: fukuokaex
slide: false
---
# はじめに
- **私**は、[Elixir](https://elixir-lang.org/)の関数や[if](https://hexdocs.pm/elixir/Kernel.html#if/2)を1行で書くときに `,` を忘れがちです
- **私**は、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)のfunのaccが1番目だったか2番目だったかを忘れがちです
- Twitterにぶつぶつつぶやいたことをまとめておきます
    - https://twitter.com/torifukukaiou/status/1206220067899244545
    - https://twitter.com/torifukukaiou/status/1206220346082414595
    - https://twitter.com/torifukukaiou/status/1206216429877379072
    - https://twitter.com/torifukukaiou/status/1206216461884112897
- [kokura.ex#4：Elixirもくもく会～入門もあるよ(19:00)](https://fukuokaex.connpass.com/event/158084/) 参加中にまとめました

```
$ elixir -v
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.9.4 (compiled with Erlang/OTP 22)
```

# [if](https://hexdocs.pm/elixir/Kernel.html#if/2)

```Elixir
if false do
  :this
else
  :that
end
```

- ↑これを1行で書こうとすると

```Elixir
if false, do: :this, else: :that
```

- これが正解です
- が、私は`false`のうしろの`,`を忘れがちです

```
iex> if false do: :this, else: :that 
** (SyntaxError) iex:6: unexpected keyword: do:. In case you wanted to write a "do" expression, you must either use do-blocks or separate the keyword argument with comma. For example, you should either write:

    if some_condition? do
      :this
    else
      :that
    end

or the equivalent construct:

    if(some_condition?, do: :this, else: :that)

where "some_condition?" is the first argument and the second argument is a keyword list
```

- [プログラミング Elixir](https://www.amazon.co.jp/dp/4274219151) には次のように書かれています

> Elixirでは、ifと、その邪悪な双子であるunlessは、２つのパラメータを取る。条件と、do:、else:というキーワードリストだ。

- ここにはっきりそう答えが書いてありますが、**キーワードリスト**というのを読み飛ばしていました
- いろいろあって改めて[GUIDES](https://elixir-lang.org/getting-started/introduction.html)を読んでいまして、[Keyword lists](https://elixir-lang.org/getting-started/keywords-and-maps.html#keyword-lists)を英語が苦手なのでよちよち読んでいて上で言っている意味がわかりました

```Elixir
iex> if(false, [{:do, :this}, {:else, :that}])
:that
```
- そういうことだったのね！
- **[if](https://hexdocs.pm/elixir/Kernel.html#if/2) の一行表記は間違えないとおもいます！**

# 関数の一行表記

```Elixir
defmodule Foo do
  def bar do
    :bar
  end
end
```
- ↑これの`bar`を1行で書こうとすると

```Elixir
defmodule Foo do
  def bar, do: :bar
end
```
- これが正解です
- 私は`bar`の後ろの`,`を忘れがちです
- これも[if](https://hexdocs.pm/elixir/Kernel.html#if/2)のときとだいたい話は同じです

```Elixir
defmodule Foo do
  def(bar, [{:do, :bar}])
end
```
- **関数の一行表記は間違えないとおもいます！**
- 参考: [def/2](https://hexdocs.pm/elixir/Kernel.html#def/2)


# [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)
- **私**は、いつも第３引数に指定する関数の引数が、どっちが`acc`だったかを迷います
- 単なる**私のこじつけ**ですが、`&1`で書いたときに、`&1`は繰り返されるものが１個ずつ入るので、１番めが`item`、余った２番めが`acc`とおぼえました
- 具体的にみてみましょう


## &で書いた場合
```Elixir
iex> (
...> %{carol: 99, alice: 50, david: 40, bob: 60}
...> |> Enum.reduce([], &if(elem(&1, 1) >= 60, do: &2 ++ [elem(&1, 0)], else: &2))
...> )
[:bob, :carol]

iex> (
...> [1, 2, 3]
...> |> Enum.map(&(&1 * 2))
...> )
[2, 4, 6]
```
- 参考として、[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)も並べておきました
- `&1`には両方とも共通して、一個ずつ渡されるものが入っています

## fnで書いた場合
```Elixir
iex> (
...> %{carol: 99, alice: 50, david: 40, bob: 60}
...> |> Enum.reduce([], fn {name, age}, acc -> if age >= 60, do: acc ++ [name], else: acc end)
...> )
[:bob, :carol]

iex> (
...> [1, 2, 3]
...> |> Enum.map(fn x -> x * 2 end)
...> )
[2, 4, 6]
```
- **1個ずつ渡されるものはfunの第一引数に入って、`acc`はfunの第二引数のほうに入ります！**

### おまけ
- [Ruby](https://www.ruby-lang.org/ja/)の場合は、`acc`, `item`の順ですよ
    - 参考: [reduce](https://docs.ruby-lang.org/ja/2.6.0/class/Enumerable.html#I_INJECT)

```Ruby
p [2, 3, 4, 5].reduce(0) {|acc, item| acc + item**2 }  #=> 54
```


