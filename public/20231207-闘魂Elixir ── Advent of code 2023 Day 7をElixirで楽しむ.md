---
title: 闘魂Elixir ── Advent of code 2023 Day 7をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-07T23:07:50+09:00'
id: 5361b81407b15e7c2f00
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir


# はじめに

今年もいよいよやってまいりました！ :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 
[Elixir](https://elixir-lang.org/)で、[Advent of code 2023](https://adventofcode.com/2023)の問題を解いてみます。

https://adventofcode.com/2023

1日1題ずつ問題が出題されます。
実行時間は問われません。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [Day 7: Camel Cards](https://adventofcode.com/2023/day/7)

[Day 7: Camel Cards](https://adventofcode.com/2023/day/7)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

ポーカーみたいな問題でした。

## 私の答え Part 1

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

強い手、弱い手、強いカード、弱いカードの大小比較があるので適当に数字を割り振ったほうが比較がしやすいとおもいます。
このへんが解法のヒントだとおもいます。

```elixir
input = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""


defmodule Awesome do
  def run(input) do
    parse(input)
    |> Enum.map(fn {hand, bid} ->
      {type(hand), hand, bid}
    end)
    |> Enum.sort(fn {type1, hand1, _}, {type2, hand2, _} ->
      sorter({type1, hand1}, {type2, hand2})
    end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  defp sorter({type1, _hand1}, {type2, _hand2}) when type1 > type2, do: false
  defp sorter({type1, hand1}, {type2, hand2}) when type1 == type2, do: do_sorter(hand1, hand2)
  defp sorter({type1, _hand1}, {type2, _hand2}) when type1 < type2, do: true

  defp do_sorter(hand1, hand2) do
    [
      Enum.map(hand1, fn c -> Map.get(map(), c) end),
      Enum.map(hand2, fn c -> Map.get(map(), c) end)
    ]
    |> Enum.zip()
    |> Enum.reduce_while(nil, fn
      {a, a}, nil -> {:cont, nil}
      {a, b}, nil when a > b -> {:halt, false}
      {a, b}, nil when a < b -> {:halt, true}
    end)
  end

  defp map do
    %{
      ?A => 12,
      ?K => 11,
      ?Q => 10,
      ?J => 9,
      ?T => 8,
      ?9 => 7,
      ?8 => 6,
      ?7 => 5,
      ?6 => 4,
      ?5 => 3,
      ?4 => 2,
      ?3 => 1,
      ?2 => 0
    }
  end

  defp type(list) do
    list
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort(&>/2)
    |> do_type()
  end

  def do_type([5]), do: 10
  def do_type([4, 1]), do: 9
  def do_type([3, 2]), do: 8
  def do_type([3, 1, 1]), do: 7
  def do_type([2, 2, 1]), do: 6
  def do_type([2, 1, 1, 1]), do: 5
  def do_type([1, 1, 1, 1, 1]), do: 4

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [hand, bid] = String.split(s, " ")
      {String.to_charlist(hand), String.to_integer(bid)}
    end)
  end
end

Awesome.run(input)
```

</details>


## 私の答え Part 2

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>



```elixir
defmodule Awesome2 do
  def run(input) do
    parse(input)
    |> Enum.map(fn {hand, bid} ->
      {type(hand), hand, bid}
    end)
    |> Enum.sort(fn {type1, hand1, _}, {type2, hand2, _} ->
      sorter({type1, hand1}, {type2, hand2})
    end)
    |> Enum.with_index(1)
    |> Enum.map(fn {{_, _, bid}, rank} -> bid * rank end)
    |> Enum.sum()
  end

  defp sorter({type1, _hand1}, {type2, _hand2}) when type1 > type2, do: false
  defp sorter({type1, hand1}, {type2, hand2}) when type1 == type2, do: do_sorter(hand1, hand2)
  defp sorter({type1, _hand1}, {type2, _hand2}) when type1 < type2, do: true

  defp do_sorter(hand1, hand2) do
    [
      Enum.map(hand1, fn c -> Map.get(map(), c) end),
      Enum.map(hand2, fn c -> Map.get(map(), c) end)
    ]
    |> Enum.zip()
    |> Enum.reduce_while(nil, fn
      {a, a}, nil -> {:cont, nil}
      {a, b}, nil when a > b -> {:halt, false}
      {a, b}, nil when a < b -> {:halt, true}
    end)
  end

  defp map do
    %{
      ?A => 12,
      ?K => 11,
      ?Q => 10,
      ?T => 8,
      ?9 => 7,
      ?8 => 6,
      ?7 => 5,
      ?6 => 4,
      ?5 => 3,
      ?4 => 2,
      ?3 => 1,
      ?2 => 0,
      ?J => -1
    }
  end

  defp type(list) do
    frequencies = list |> Enum.frequencies()
    j_cards = Map.get(frequencies, ?J, 0)

    case j_cards do
      5 ->
        [5]

      4 ->
        [5]

      3 ->
        case frequencies |> Map.values() |> Enum.sort(&>/2) do
          [3, 2] -> [5]
          [3, 1, 1] -> [4, 1]
        end

      2 ->
        case frequencies |> Map.values() |> Enum.sort(&>/2) do
          [3, 2] -> [5]
          [2, 2, 1] -> [4, 1]
          [2, 1, 1, 1] -> [3, 1, 1]
        end

      1 ->
        case frequencies |> Map.values() |> Enum.sort(&>/2) do
          [4, 1] -> [5]
          [3, 1, 1] -> [4, 1]
          [2, 2, 1] -> [3, 2]
          [2, 1, 1, 1] -> [3, 1, 1]
          [1, 1, 1, 1, 1] -> [2, 1, 1, 1]
        end

      0 ->
        frequencies
        |> Map.values()
        |> Enum.sort(&>/2)
    end
    |> do_type()
  end

  def do_type([5]), do: 10
  def do_type([4, 1]), do: 9
  def do_type([3, 2]), do: 8
  def do_type([3, 1, 1]), do: 7
  def do_type([2, 2, 1]), do: 6
  def do_type([2, 1, 1, 1]), do: 5
  def do_type([1, 1, 1, 1, 1]), do: 4

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      [hand, bid] = String.split(s, " ")
      {String.to_charlist(hand), String.to_integer(bid)}
    end)
  end
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Camel Cards&quot; - Day 7 - Advent of Code 2023 <a href="https://t.co/XHSGiV9Yko">https://t.co/XHSGiV9Yko</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1732755299600351488?ref_src=twsrc%5Etfw">December 7, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 7: Camel Cards](https://adventofcode.com/2023/day/7)を[Elixir](https://elixir-lang.org/)で解きました。
[Advent of code 2023](https://adventofcode.com/2023)は己との闘い、まさに闘魂です。

リポジトリにあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
