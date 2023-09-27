---
title: 'すごいHaskellたのしく学ぼう! を学びなおしてみる(第5章)[with Elixir]'
tags:
  - Elixir
private: false
updated_at: '2020-04-26T18:10:23+09:00'
id: c0dc17c55fe5db93389d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- 前回
    - [すごいHaskellたのしく学ぼう! を学びなおしてみる(第4章)[with Elixir]](https://qiita.com/torifukukaiou/items/2cb4dff82b5bf020c3b9)
- [Elixir](https://elixir-lang.org/)を使いはじめてだいたい1年くらいがたちました
- [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)という本を2015年に買って、一通り読んだあとずっと本棚にしまわれていたままでした
- 久しぶりに引っ張り出して読んでみると、こんなに愉快な内容だったけ！？　という感想を持ちました
- [Elixir](https://elixir-lang.org/)で関数プログラミングにだいぶ慣れたので、ユーモアの部分を楽しむ余裕ができたのだとおもいます
- 少しずつ読み進めながら、興味が向いたところだけ[Elixir](https://elixir-lang.org/)で書き換えてみたりして理解を深めていきたいとおもいます
- 今回は**第５章　高階関数**

# applyTwice

## Haskell
```haskell
Prelude> applyTwice f x = f (f x)
Prelude> applyTwice (+3) 10
16
```

## Elixir
```elixir:awesome.exs
defmodule Awesome do
  def apply_twice(fun, x), do: fun.(x) |> fun.()
end

iex> Awesome.apply_twice(&(&1 + 3), 10)                                     
16
```

# zipWith

## Haskell
```haskell:baby.hs 
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

Prelude> :l baby.hs 
*Main> zipWith' (+) [4,2,5,6] [2,6,2,3]
[6,8,7,9]
*Main> zipWith' (++) ["foo ", "bar ", "baz "] ["fighters", "hoppers", "aldrin"]
["foo fighters","bar hoppers","baz aldrin"]
```

## Elixir
```elixir:awesome.exs
defmodule Awesome do
  def zip_with(_, [], _), do: []
  def zip_with(_, _, []), do: []
  def zip_with(fun, [x | xs], [y | ys]), do: [fun.(x, y) | zip_with(fun, xs, ys)]
end

iex> Awesome.zip_with(&(&1 + &2), [4,2,5,6], [2,6,2,3])                                        
[6, 8, 7, 9]
iex> Awesome.zip_with(&(&1 <> &2), ["foo ", "bar ", "baz "], ["fighters", "hoppers", "aldrin"])
["foo fighters", "bar hoppers", "baz aldrin"]
```

# map

## Haskell
```haskell
Prelude> map (+3) [1,5,3,1,6]
[4,8,6,4,9]
```

## Elixir
```elixir
iex(47)> [1,5,3,1,6] |> Enum.map(&(&1 + 3))
[4, 8, 6, 4, 9]
```

[Enum.map/2](https://hexdocs.pm/elixir/1.10.2/Enum.html#map/2)

# filter

## Haskell

```haskell
Prelude> filter (>3) [1,5,3,2,1,6,4,3,2,1]
[5,6,4]
```

## Elixir

```elixir
iex> Enum.filter([1,5,3,2,1,6,4,3,2,1], &(&1 > 3))
[5, 6, 4]
```

[Enum.filter/2](https://hexdocs.pm/elixir/1.10.2/Enum.html#filter/2)

# 10万以下の数のうち3829で割り切れる最大の数を探してみる

## Haskell
```haskell:baby.hs
largestDivisible = head (filter p [100000, 99999..])
    where p x = x `mod` 3829 == 0

Prelude> :l baby.hs 
*Main> largestDivisible
99554
```

## Elixir
```elixir
iex> (
...> Stream.iterate(100000, &(&1 - 1))
...> |> Stream.filter(&(rem(&1, 3829) == 0))
...> |> Enum.take(1)
...> |> hd
...> )
99554
```

# 1から100までの数のうち、長さ15以上の[コラッツ列](https://ja.wikipedia.org/wiki/%E3%82%B3%E3%83%A9%E3%83%83%E3%83%84%E3%81%AE%E5%95%8F%E9%A1%8C)の開始数になるものはいくつあるか?

## Haskell
```haskell:baby.hs
chain 1 = [1]
chain n
    | even n = n : chain (n `div` 2)
    | odd n  = n : chain (n * 3 + 1)

numLongChians = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

Prelude> :l baby.hs 
*Main> numLongChians 
66
```

## Elxiir
```elixir:awesome.exs
defmodule Awesome do
  def chain(1), do: [1]
  def chain(n) when rem(n, 2) == 0, do: [n | div(n, 2) |> chain()]
  def chain(n), do: [n | (n * 3 + 1) |> chain()]

  def num_long_chains do
    # Pipe operator is great!!!
    1..100
    |> Enum.map(&chain/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.filter(&(&1 > 15))
    |> Enum.count()
  end
end
```

[Pipe operator](https://hexdocs.pm/elixir/1.10.2/Kernel.html#%7C%3E/2)

# scanl

## Haskell
```haskell
Prelude> scanl (+) 0 [3,5,2,1]
[0,3,8,10,11]
```

## Elixir
```elixir
iex(68)> Enum.scan([3,5,2,1], 0, &(&1 + &2))
[3, 8, 10, 11]
```

[Enum.scan/3](https://hexdocs.pm/elixir/1.10.2/Enum.html#scan/3)

# 奇数の平方根で10000より小さいものの総和を求める

## Haskell
```haskell
Prelude> oddSquareSum = sum . takeWhile (<10000) . filter odd $ map (^2) [1..]
Prelude> oddSquareSum
166650
```

- 関数合成というものを利用した書き方だそうです

## Elixir
```elixir
iex> (
...> 1..(:math.sqrt(10000) |> round)
...>     |> Enum.filter(&(rem(&1, 2) == 1))
...>     |> Enum.map(&(&1 * &1))
...>     |> Enum.filter(&(&1 < 10000))
...>     |> Enum.sum()
...> )
166650
```

Haskellのほうにでてきた【カリー化】とか【部分適用】、【関数適用】、【関数合成】あたりはあんまり理解が進んでいませんが、[Elixir](https://elixir-lang.org/)では`|>`を使うと似たようなことをうまく書ける印象を持ちました

[Elixir](https://elixir-lang.org/)で&記法を使って引数に指定する関数を書くと、Haskellと[Elixir](https://elixir-lang.org/)で書き方がよく似た形になるようにおもいました

## Wrapping Up
- [`|>` Pipe operator](https://hexdocs.pm/elixir/1.10.2/Kernel.html#%7C%3E/2)と:curry:は大好きです
- I like it!
- Enjoy! with Elixir :rocket:

