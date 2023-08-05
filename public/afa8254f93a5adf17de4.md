---
title: 'すごいHaskellたのしく学ぼう! を学びなおしてみる(第2章、第3章)[with Elixir]'
tags:
  - Elixir
  - fukuoka.ex
  - kokura.ex
private: false
updated_at: '2020-04-18T12:50:49+09:00'
id: afa8254f93a5adf17de4
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 前回
    - [すごいHaskellたのしく学ぼう! を学びなおしてみる(第1章)[Elixir]](https://qiita.com/torifukukaiou/items/c85ec8e360b665981dc9)
- [Elixir](https://elixir-lang.org/)を使いはじめてだいたい1年くらいがたちました
- [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)という本を2015年に買って、一通り読んだあとずっと本棚にしまわれていたままでした
- 久しぶりに引っ張り出して読んでみると、こんなに愉快な内容だったけ！？　という感想を持ちました
- [Elixir](https://elixir-lang.org/)で関数プログラミングにだいぶ慣れたので、ユーモアの部分を楽しむ余裕ができたのだとおもいます
- 少しずつ読み進めながら、興味が向いたところだけ[Elixir](https://elixir-lang.org/)で書き換えてみたりして理解を深めていきたいとおもいます

# リストのパターンマッチとリスト内包表記
- タプルの2番目の要素が`3`のものだけに絞りこんで、1番目の要素を100倍して3を足したリストをつくります

## Haskell
```Haskell:
Prelude> let xs = [(1,3),(4,3),(2,4),(5,3),(5,6),(3,1)]
Prelude> [x*100+3 | (x,3) <- xs]
[103,403,503]
```

## Elixir

```Elixir:
iex> for {x,3} <- [{1,3},{4,3},{2,4},{5,3},{5,6},{3,1}], do: x * 100 + 3
[103, 403, 503] 
```
- [Elixir](https://elixir-lang.org/)でも同じような感じです

# asパターン
- firstLetterという関数は文字列をうけとって、`"The first letter of #{文字列} is #{先頭文字}"` を返します


## Haskell

```Haskell
Prelude> firstLetter "" = "Empty string, whoops!"
Prelude> firstLetter all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x] 
Prelude> firstLetter "Dracula"
"The first letter of Dracula is D"
```
- 全体の文字列にもアクセスしたい場合に、Haskellでは `asパターン` というものを使うそうです 

## Elixir
- [Elixir](https://elixir-lang.org/)でも同じことをやってみましょう

```Elixir:awesome.exs
defmodule Awesome do
  def first_letter(<<>>) do
    "Empty string, whoops!"
  end

  def first_letter(<<x::8, _rest::binary>> = all) do
    "The first letter of " <> all <> " is " <> List.to_string([x])
  end
end
```

```Elixir:
iex> c "awesome.exs"
iex> Awesome.first_letter("Dracula")
"The first letter of Dracula is D"
```
- [Elixir](https://elixir-lang.org/)の場合は、パターンマッチさせつつ、その全体も欲しいときには、`<<x::8, _rest::binary>> = all` のように書きます
    - 文字列のパターンマッチってどうやるのかこの記事を書いている瞬間は知らなかったのですが、きっとできるのだろうとおもって[String](https://hexdocs.pm/elixir/String.html#content)のドキュメントを眺めていたら、[String and binary operations](https://hexdocs.pm/elixir/String.html#module-string-and-binary-operations) の内容でなんとなく理解しました
    - `x` は整数で得られたのでそれを文字列に戻す処理は、[[Elixir/OTP 20] Covert ascii/number to string](https://medium.com/@alxtz.tw/elixir-otp-20-covert-ascii-number-to-string-97f4e2751b93) を参考にしました

# まとめ
- [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)
- 題名の通り、楽しく学べています。



