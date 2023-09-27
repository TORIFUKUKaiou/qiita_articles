---
title: 'Advent Of Code 2021 (Day 3: Binary Diagnostic)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:50:22+09:00'
id: 111ae746293319dbc1ff
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**明けぬれば暮るるものとは知りながらなほ恨めしき朝ぼらけかな**

Advent Calendar 2022 104日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-20 22.41.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/984df211-ce05-6534-e89c-bdcd03ab8553.png)


https://adventofcode.com/2021/day/3


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

`input`はサンプルです。
ログインをすると、たくさんあるインプットデータがみえます。

## Part 1

```elixir
input = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""

map = input
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.map(&Enum.with_index(&1))
|> Enum.reduce(%{}, fn list, acc ->
  Enum.reduce(list, acc, fn {number, index}, acc ->
    number = String.to_integer(number)
    Map.update(acc, index, [number], & &1 ++ [number])
  end)
end)

gamma_rate = 0..(map_size(map) - 1)
|> Enum.map(fn i -> map[i] end)
|> Enum.map(fn list -> if(Enum.count(list, & &1 == 0) > Enum.count(list, & &1 == 1), do: "0", else: "1") end)
|> Enum.join()
|> String.to_integer(2)

require Bitwise

epsilon_rate = List.duplicate("1", map_size(map))
|> Enum.join()
|> String.to_integer(2)
|> Bitwise.bxor(gamma_rate)

gamma_rate * epsilon_rate
```

## Part 2

```elixir
input = """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
"""

list_of_lists = input
|> String.split("\n", trim: true)
|> Enum.map(&String.codepoints/1)
|> Enum.map(fn list -> Enum.map(list, &String.to_integer/1) end)

build_map = fn list_of_lists ->
  list_of_lists
  |> Enum.map(&Enum.with_index(&1))
  |> Enum.reduce(%{}, fn list, acc ->
    Enum.reduce(list, acc, fn {number, index}, acc ->
      Map.update(acc, index, [number], & &1 ++ [number])
    end)
  end)
end


oxygen_generator_rating = 0..(map_size(build_map.(list_of_lists)) - 1)
|> Enum.reduce_while({list_of_lists, build_map.(list_of_lists)}, fn key, {list_of_lists, map} ->
  zero_count = map[key] |> Enum.count(& &1 == 0)
  one_count = map[key] |> Enum.count(& &1 == 1)
  list_of_lists = if one_count >= zero_count do
    Enum.filter(list_of_lists, fn list -> Enum.at(list, key) == 1 end)
  else
    Enum.filter(list_of_lists, fn list -> Enum.at(list, key) == 0 end)
  end

  cont = if Enum.count(list_of_lists) == 1, do: :halt, else: :cont

  {cont, {list_of_lists, build_map.(list_of_lists)}}
end)
|> elem(0)
|> Enum.at(0)
|> Enum.map(&Integer.to_string/1)
|> Enum.join()
|> String.to_integer(2)

co2_scrubber_rating = 0..(map_size(build_map.(list_of_lists)) - 1)
|> Enum.reduce_while({list_of_lists, build_map.(list_of_lists)}, fn key, {list_of_lists, map} ->
  zero_count = map[key] |> Enum.count(& &1 == 0)
  one_count = map[key] |> Enum.count(& &1 == 1)
  list_of_lists = if zero_count <= one_count do
    Enum.filter(list_of_lists, fn list -> Enum.at(list, key) == 0 end)
  else
    Enum.filter(list_of_lists, fn list -> Enum.at(list, key) == 1 end)
  end

  cont = if Enum.count(list_of_lists) == 1, do: :halt, else: :cont

  {cont, {list_of_lists, build_map.(list_of_lists)}}
end)
|> elem(0)
|> Enum.at(0)
|> Enum.map(&Integer.to_string/1)
|> Enum.join()
|> String.to_integer(2)


oxygen_generator_rating * co2_scrubber_rating
```


</details>

**It works!**
**Amazing!**

私の回答は、正解を得ることができていますがなんとなくイケていない感が満載です。
後述する[José Valim](https://twitter.com/josevalim)さんのお手本はとても勉強になります。
お見逃し無く！


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

いきなり正解を書くわけではなく、少しずつ試しながら作っていって、リファクタしていくさまが[José Valim](https://twitter.com/josevalim)さんの息遣いでみれるのでとても参考になります。
私は英語をよく聞き取れてはいませんが、コードが進化していくさまをみるのはとても勉強になります。


<iframe width="1031" height="580" src="https://www.youtube.com/embed/SGQFAn4HtAI?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<details><summary>お手本</summary>

## Part 1

```elixir
import Bitwise

numbers =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(&(&1 |> String.to_charlist() |> List.to_tuple()))

[sample | _] = numbers
number_length = tuple_size(sample)
half = div(length(numbers), 2)

gamma_as_list = 
  for pos <- 0..number_length - 1 do
    zero_count = Enum.count_until(numbers, &(elem(&1, pos) == ?0), half + 1)
    if zero_count > half, do: ?0, else: ?1
  end

gamma = List.to_integer(gamma_as_list, 2)
mask = 2**number_length - 1
epsilon = ~~~gamma &&& mask
gamma * epsilon
```

[for/1](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)の使い方がうまい！

## Part 2

```elixir
defmodule Recursion do
  defp recur([number], _pos, _fun) do
    number
    |> Tuple.to_list()
    |> List.to_integer(2)
  end

  defp recur(numbers, pos, fun) do
    zero_count = Enum.count(numbers, &elem(&1, pos) == ?0)
    one_count = length(numbers) - zero_count
    to_keep = fun.(zero_count, one_count)
    numbers = Enum.filter(numbers, &elem(&1, pos) == to_keep)
    recur(numbers, pos + 1, fun)
  end

  def o2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if one_count >= zero_count, do: ?1, else: ?0
    end)
  end
  
  def co2(numbers) do
    recur(numbers, 0, fn zero_count, one_count ->
      if zero_count <= one_count, do: ?0, else: ?1
    end)
  end
end

numbers =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(&(&1 |> String.to_charlist() |> List.to_tuple()))

o2 = Recursion.o2(numbers) |> IO.inspect()
co2 = Recursion.co2(numbers) |> IO.inspect()
o2 * co2
```

再帰が芸術的 :rocket::rocket::rocket:

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021)[Day 3: Binary Diagnostic](https://adventofcode.com/2021/day/3)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。
だんだん、私には難しくなってきました :sweat_smile: 

**It works!**
**Amazing!**

自分で解いてみて、なんだかイマイチだなあとおもいながら、動画をみることで[José Valim](https://twitter.com/josevalim)さんに特別家庭教師をしてもらっている気に勝手になっています :sweat_smile:。
海綿が水を吸うように、[Elixir](https://elixir-lang.org/)のイケている書き方を吸収しています。
伸びしろしかありません。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



以上です。





---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

---

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We appreciate this shoutout, Torifuku! <a href="https://t.co/dThmJg4CYN">pic.twitter.com/dThmJg4CYN</a></p>&mdash; ClickUp (@clickup) <a href="https://twitter.com/clickup/status/1513541411634913284?ref_src=twsrc%5Etfw">April 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 






