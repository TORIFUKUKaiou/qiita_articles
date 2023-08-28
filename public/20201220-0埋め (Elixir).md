---
title: 0埋め (Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-12-20T00:04:40+09:00'
id: df3c28dd6ee5cb9c526e
organization_url_name: fukuokaex
slide: false
---
先頭に0を埋めたいことありませんか？
ありますよね？

@tksmaru さんの[言語別 0埋め数字を作成する方法](https://qiita.com/tksmaru/items/0f9283d0c5f0ee716f2f) みたいな感じのことです。

# たとえばRuby

```ruby
irb(main):001:0> '%04d' % 55
=> "0055"
```

[Elixir](https://elixir-lang.org/)ではどうやればいいのでしょうか:interrobang:

# [String.pad_leading/3](https://hexdocs.pm/elixir/String.html#pad_leading/3)

## example

```elixir
iex> String.pad_leading("55", 4, "0")
"0055"

iex> String.pad_leading("abc", 5)
"  abc"

iex> String.pad_leading("abc", 4, "12")
"1abc"

iex> String.pad_leading("abc", 6, "12")
"121abc"

iex> String.pad_leading("abc", 5, ["1", "23"])
"123abc"
```

お仲間に[String.pad_trailing/3](https://hexdocs.pm/elixir/String.html#pad_trailing/3)があります

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:
