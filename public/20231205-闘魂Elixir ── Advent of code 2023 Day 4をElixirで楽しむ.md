---
title: 闘魂Elixir ── Advent of code 2023 Day 4をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-05T23:25:26+09:00'
id: ece3f4bc2948ca4ac7e4
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

# [Day 4: Scratchcards](https://adventofcode.com/2023/day/4)

[Day 4: Scratchcards](https://adventofcode.com/2023/day/4)を解いてみます。
問題はリンク先をご参照ください。



## 私の答え Part One

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
input = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""

input
|> String.split("\n", trim: true)
|> Enum.map(fn s ->
  [winning_numbers, numbers] =
    s
    |> String.split(":")
    |> Enum.at(-1)
    |> String.split("|")
    |> Enum.map(fn nums ->
      String.split(nums, " ", trim: true) |> Enum.map(&String.to_integer/1) |> MapSet.new()
    end)

  count = MapSet.intersection(winning_numbers, numbers) |> Enum.count()
  if count > 0, do: 2 ** (count - 1), else: 0
end)
|> Enum.sum()
```

</details>


## 私の答え Part Two

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>





```elixir
input = """
Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
"""


matchings =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn s ->
    [winning_numbers, numbers] =
      s
      |> String.split(":")
      |> Enum.at(-1)
      |> String.split("|")
      |> Enum.map(fn nums ->
        String.split(nums, " ", trim: true) |> Enum.map(&String.to_integer/1) |> MapSet.new()
      end)

    MapSet.intersection(winning_numbers, numbers) |> Enum.count()
  end)

matchings
|> Enum.with_index()
|> Enum.reduce(List.duplicate(1, Enum.count(matchings)), fn {count, index}, acc ->
  num_of_cards = Enum.at(acc, index)

  acc
  |> Enum.with_index()
  |> Enum.map(fn {current_num_of_cards, i} ->
    cond do
      count > 0 and index < i and i <= index + count -> current_num_of_cards + num_of_cards
      true -> current_num_of_cards
    end
  end)
end)
|> Enum.sum()
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I&#39;ve completed &quot;Scratchcards&quot; - Day 4 - Advent of Code 2023 <a href="https://t.co/KzOZKf4H7O">https://t.co/KzOZKf4H7O</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1731837043406459266?ref_src=twsrc%5Etfw">December 5, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 4: Scratchcards](https://adventofcode.com/2023/day/4)を[Elixir](https://elixir-lang.org/)で解きました。
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
