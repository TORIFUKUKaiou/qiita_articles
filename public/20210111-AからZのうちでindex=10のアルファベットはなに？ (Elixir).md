---
title: '"A"から"Z"のうちでindex=10のアルファベットはなに？ (Elixir)'
tags:
  - Elixir
private: false
updated_at: '2021-01-11T01:54:56+09:00'
id: d35c729a2dad5ab2d62b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- つい先日書いた「[Rails on Tiles（どう書く） (Elixir)](https://qiita.com/torifukukaiou/items/8c684fec556a132efe3f)」の中で工夫した点があったのでそこだけを切り出して書いておきます

# "A"から"Z"のうちでindex=10のアルファベットはなに？

## [Ruby](https://www.ruby-lang.org/ja/)
- まずは[Ruby](https://www.ruby-lang.org/ja/)先輩

```ruby
irb(main):006:0> ('A'..'Z').to_a[10]
=> "K"
```
 
## [Elixir](https://elixir-lang.org/)

```elixir
iex> "A".."Z"
** (ArgumentError) ranges (first..last) expect both sides to be integers, got: "A".."Z"
    (elixir 1.11.2) lib/kernel.ex:3467: Kernel.range/3
    (elixir 1.11.2) expanding macro: Kernel.".."/2
    iex:1: (file)
```

- [Ruby](https://www.ruby-lang.org/ja/)先輩っぽい書き方はコンパイルエラーになりました[^1]

```elixir
iex> ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)
["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P",
 "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

iex> ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) |> Enum.at(10)
"K"
```

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: は嫌だなと:sweat_smile:
    - [~w](https://hexdocs.pm/elixir/Kernel.html#sigil_w/2)って、なんだろう？　という方はリンク先をご参照ください

### 結論
- これでどうでしょうか :point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5:  

[^1]: [Range](https://hexdocs.pm/elixir/Range.html#content)は整数が指定されることを期待しています。https://github.com/elixir-lang/elixir/blob/v1.11.3/lib/elixir/lib/range.ex#L57-L66

```elixir
iex> (?A..?Z) |> Enum.at(10) |> (&<<&1>>).() 
"K"

iex> (?A..?Z) |> Enum.at(10) |> (fn c -> <<c>> end).()
"K"
```

- 何でも**pipe operator [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)**で書ききってしまいたい症候群です
    - `(&<<&1>>)` と
    - `(fn c -> <<c>> end)`
    - は同じ意味の無名関数です
- もっと簡潔に書けるよ！　ってことをご存知の方いらっしゃいましたら、ぜひ教えてください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  

## 参考
- [String -- Integer code points](https://hexdocs.pm/elixir/String.html#module-integer-code-points)
- `IEx(Elixir's Interactive Shel)`さんに教えてもらったこと

```elixir
iex> i "K"
Term
  "K"
Data type
  BitString
Byte size
  1
Description
  This is a string: a UTF-8 encoded binary. It's printed surrounded by
  "double quotes" because all UTF-8 encoded code points in it are printable.
Raw representation
  <<75>>
Reference modules
  String, :binary
Implemented protocols
  Collectable, IEx.Info, Inspect, List.Chars, String.Chars
```

- `Raw representation`の`<<75>>`でハハーんとなりました :relaxed: 

# Wrapping Up 🎍🎍🎍🎍🎍
- [Elixir](https://elixir-lang.org/)は[公式ドキュメント](https://elixir-lang.org/)を読むのが一番いい
- `IEx(Elixir's Interactive Shel)`さんに聞くのが一番はやい場合もありそう
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 
