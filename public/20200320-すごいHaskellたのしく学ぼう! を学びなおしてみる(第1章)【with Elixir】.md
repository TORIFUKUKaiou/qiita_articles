---
title: 'すごいHaskellたのしく学ぼう! を学びなおしてみる(第1章)[with Elixir]'
tags:
  - Elixir
private: false
updated_at: '2020-04-18T12:51:12+09:00'
id: c85ec8e360b665981dc9
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)を使いはじめてだいたい1年くらいがたちました
- [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)という本を2015年に買って、一通り読んだあとずっと本棚にしまわれていたままでした
- 久しぶりに引っ張り出して読んでみると、こんなに愉快な内容だったけ！？　という感想を持ちました
- [Elixir](https://elixir-lang.org/)で関数プログラミングにだいぶ慣れたので、ユーモアの部分を楽しむ余裕ができたのだとおもいます
- 少しずつ読み進めながら、興味が向いたところだけ[Elixir](https://elixir-lang.org/)で書き換えてみたりして理解を深めていきたいとおもいます

# init関数

```Haskell
ghci> init [5,4,3,2,1]  
[5,4,3,2]  
```

### [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)から引用
> init関数はリストを受け取り、最後の要素を除いた残りのリストを返します

- [Starting Out](http://learnyouahaskell.com/starting-out)
    - [原文サイト](http://learnyouahaskell.com/chapters)内の上記ページの中央ほどにある可愛らしい絵をみるとイメージしやすいです

## [Elixir](https://elixir-lang.org/)で書いてみます

```Elixir
defmodule LearnYouAHaskellForGreatGood do
  def init([_ | []]) do
    []
  end

  def init([head | tail]) do
    [head] ++ init(tail)
  end
end
```

```Elixir
iex> LearnYouAHaskellForGreatGood.init([5,4,3,2,1]) 
[5, 4, 3, 2]
```
- 本当にこれ自分で書かないと無いのだろうか？　とおもって[List](https://hexdocs.pm/elixir/List.html#content)を眺めてみました
- **ありました！**

```Elixir
iex> [5, 4, 3, 2, 1] |> List.delete_at(-1)
[5, 4, 3, 2]
```

**こんな感じで、少しずつ [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/) を学びなおしてみようとおもいます :rocket::rocket::rocket:**
