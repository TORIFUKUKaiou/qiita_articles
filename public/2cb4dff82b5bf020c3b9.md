---
title: 'すごいHaskellたのしく学ぼう! を学びなおしてみる(第4章)[with Elixir]'
tags:
  - Elixir
private: false
updated_at: '2020-04-18T20:24:17+09:00'
id: 2cb4dff82b5bf020c3b9
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 前回
    - [すごいHaskellたのしく学ぼう! を学びなおしてみる(第2章、第3章)[with Elixir]](https://qiita.com/torifukukaiou/items/afa8254f93a5adf17de4)
- [Elixir](https://elixir-lang.org/)を使いはじめてだいたい1年くらいがたちました
- [すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854/)という本を2015年に買って、一通り読んだあとずっと本棚にしまわれていたままでした
- 久しぶりに引っ張り出して読んでみると、こんなに愉快な内容だったけ！？　という感想を持ちました
- [Elixir](https://elixir-lang.org/)で関数プログラミングにだいぶ慣れたので、ユーモアの部分を楽しむ余裕ができたのだとおもいます
- 少しずつ読み進めながら、興味が向いたところだけ[Elixir](https://elixir-lang.org/)で書き換えてみたりして理解を深めていきたいとおもいます
- 今回は**Hello 再帰!**

# maximum
- リストの中から一番でっかいやつを返します

```haskell:baby.hs
maximum' [] = error "maximum of empty list!"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

Prelude> maximum' [2,5,1]
5
```

```elixir:awesome.exs
defmodule Awesome do
  def maximum([]), do: raise "maximum of empty list!"
  def maximum([x]), do: x
  def maximum([x|xs]), do: max(x, maximum(xs))
end

iex> Awesome.maximum([2,5,1])
5
```
- [Enum.max/2](https://hexdocs.pm/elixir/1.9.4/Enum.html#max/2)


# replicate n x
- n個の要素がxのリストを返します

```haskell:baby.hs
replicate' n x
    | n <= 0    = []
    | otherwise = x : replicate' (n-1) x

Prelude> replicate' 10 3
[3,3,3,3,3,3,3,3,3,3]
```

```elixir:awesome.exs
defmodule Awesome do
  def replicate(n, _) when n <= 0, do: []
  def replicate(n, x), do: [x | replicate(n - 1, x)]
end

iex> Awesome.replicate(10, 3)
[3, 3, 3, 3, 3, 3, 3, 3, 3, 3]
```
- [List.duplicate/2](https://hexdocs.pm/elixir/1.9.4/List.html#duplicate/2)


# take n [a]
- リストからn個取り出します

```haskell:baby.hs
take' n _ 
    | n <= 0    = []
take' _ []      = []
take' n (x:xs)  = x : take' (n-1) xs

Prelude> take' 2 [1,2,3,4,5]
[1,2]
```

```elixir:awesome.exs
defmodule Awesome do
  def take(_, n) when n <= 0, do: []
  def take([], _), do: []
  def take([x | xs], n), do: [x | take(xs, n - 1)]
end

iex> Awesome.take([1,2,3,4,5],2)
[1, 2]
```
- 引数の順は、[Enum.take/2](https://hexdocs.pm/elixir/Enum.html#take/2)とあわせました

# reverse
- リストの中身をひっくり返します

```haskell:baby.hs
reverse' []     = []
reverse' (x:xs) = reverse' xs ++ [x]

Prelude> reverse' [1,2,3]
[3,2,1]
```

```elixir:awesome.exs
defmodule Awesome do
  def reverse([]), do: []
  def reverse([x | xs]), do: reverse(xs) ++ [x]
end

iex> Awesome.reverse([1,2,3])
[3, 2, 1]
```
- [Enum.reverse/1](https://hexdocs.pm/elixir/1.9.4/Enum.html#reverse/1)

# repeat
- 無限リストをつくります

```haskell:baby.hs
repeat' x = x : repeat' x

Prelude> take' 10 (repeat' 3)
[3,3,3,3,3,3,3,3,3,3]
```

```elixir:awesome.exs
defmodule Awesome do
  def repeat(x), do: Stream.cycle([x])
end

iex> Awesome.repeat(3) |> Enum.take(10)
[3, 3, 3, 3, 3, 3, 3, 3, 3, 3]
```
- [Stream.cycle/1](https://hexdocs.pm/elixir/1.9.4/Stream.html#cycle/1)

# zip
- zipします

```haskell:baby.hs
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

Prelude> zip' [1,2,3] ['a', 'b']
[(1,'a'),(2,'b')]
```

```elixir:awesome.exs
defmodule Awesome do
  def zip(_, []), do: []
  def zip([], _), do: []
  def zip([x | xs], [y | ys]), do: [{x,y} | zip(xs, ys)]
end

iex> Awesome.zip([1,2,3], ["a", "b"])
[{1, "a"}, {2, "b"}]
```
- [Enum.zip/2](https://hexdocs.pm/elixir/1.9.4/Enum.html#zip/2)

# elem
- 値がリストに含まれるかどうか

```haskell:baby.hs
elem' a [] = False
elem' a (x:xs)
    | a == x     = True
    | otherwise  = a `elem'` xs

Prelude> 3 `elem` [1,2,3]
True
Prelude> -1 `elem` [1,2,3]
False
```

```elixir:awesome.exs
defmodule Awesome do
  def member?([], _), do: false
  def member?([x | _], element) when x == element, do: true
  def member?([_ | xs], element), do: member?(xs, element)
end

iex> Awesome.member?([1,2,3], 3)
true

iex> Awesome.member?([1,2,3], -1)
false
```
- [Enum.member?/2](https://hexdocs.pm/elixir/1.9.4/Enum.html#member?/2)

# quicksort
- クイックソートです

```haskell:baby.hs
quicksort [] = []
quicksort (x:xs) =
    let smallerOrEqual = [a | a <- xs, a <= x]
        larger = [a | a <-xs, a > x]
    in quicksort smallerOrEqual ++ [x] ++ quicksort larger

Prelude> quicksort [10,2,5,3,1,6,7,4,2,3,4,8,9]
[1,2,2,3,3,4,4,5,6,7,8,9,10]
```

```elixir:awesome.exs
defmodule Awesome do
  def quicksort([]), do: []
  def quicksort([x | xs]) do
    smaller_or_equal = (for a <- xs, a <= x, do: a)
    larger = (for a <- xs, a > x, do: a)
    quicksort(smaller_or_equal) ++ [x] ++ quicksort(larger)
  end
end

iex> Awesome.quicksort([10,2,5,3,1,6,7,4,2,3,4,8,9])
[1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 10]
```
- [Enum.sort/1](https://hexdocs.pm/elixir/1.9.4/Enum.html#sort/1)

# まとめ
- 私は元来、再帰はからっきし苦手だったのですが、不思議と[Elixir](https://elixir-lang.org/)では書けるようになってきました
- [Elixir](https://elixir-lang.org/)で慣れてきたことが手伝ってか、[Haskell](https://www.haskell.org/)のほうも割とすんなり理解できました
- Enjoy! with [Elixir](https://elixir-lang.org/) :rocket:
