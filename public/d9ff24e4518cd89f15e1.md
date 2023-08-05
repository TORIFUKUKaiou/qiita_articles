---
title: '"foo" <> x = "foobar" (Elixir)'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-02-17T11:26:05+09:00'
id: d9ff24e4518cd89f15e1
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [<>/2](https://hexdocs.pm/elixir/Kernel.html#%3C%3E/2)のおもしろい使い方をご紹介します
    - いつかそのうち使う機会があるだろうと個人的におもっています
- 2021/02/15(月)に開催した[autoracex #10](https://autoracex.connpass.com/event/203963/)という[Elixir](https://elixir-lang.org/)の純粋なもくもく会での成果です

# "foo" <> x = "foobar"

```elixir
iex> "foo" <> x = "foobar"
"foobar"

iex> x
"bar"
```

- [<>/2](https://hexdocs.pm/elixir/Kernel.html#%3C%3E/2)は上のような使い方ができます
    - 上の例は公式の[Examples](https://hexdocs.pm/elixir/Kernel.html#%3C%3E/2-examples)を拝借しました
- 私は[Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)という本:book:で知りました

```elixir
iex> "foo" <> "bar" = "foobar"
"foobar"

iex> "f" <> "o" <> "o" <> "bar" = "foobar"
"foobar
```
- あまり意味は無いかもしれませんが:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:こういう使いかたもできます
- ちなみに[<>/2](https://hexdocs.pm/elixir/Kernel.html#%3C%3E/2)の左側は、_literal binary_である必要があります
- 要は次のように左側に変数をもってきてマッチさせようとしても動かなくて、[CompileError](https://hexdocs.pm/elixir/CompileError.html)となってしまいます

```elixir
iex> x <> "bar" = "foobar"
** (ArgumentError) the left argument of <> operator inside a match should always be a literal binary because its size can't be verified. Got: x
    (elixir 1.11.3) lib/kernel.ex:1857: Kernel.invalid_concat_left_argument_error/1
    (elixir 1.11.3) lib/kernel.ex:1829: Kernel.wrap_concatenation/3
    (elixir 1.11.3) lib/kernel.ex:1808: Kernel.extract_concatenations/2
    (elixir 1.11.3) expanding macro: Kernel.<>/2
    iex:10: (file)
```

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [Pattern matching](https://elixir-lang.org/getting-started/pattern-matching.html)、奥が深いですね
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 
