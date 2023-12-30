---
title: 闘魂Elixir ── Advent of code 2023 Day 1をElixirで楽しむ
tags:
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-02T12:49:16+09:00'
id: ca63a2272c409e79a80f
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

# [Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1)

[Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1)を解いてみます。
問題はリンク先をご参照ください。



## 私の答え Part One

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
s = """
1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet
"""

f = fn s -> s |> String.to_charlist |> Enum.filter(fn c -> c in ?0..?9 end) end
f2 = fn list -> "#{Enum.at(list, 0) - ?0}#{Enum.at(list, -1) - ?0}" |> String.to_integer end
s |> String.split("\n", trim: true) |> Enum.map(& f.(&1) |> f2.()) |> Enum.sum

```

</details>


## 私の答え Part Two

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

`eighthree" is 83 and for "sevenine" is 79.`というルールが実はあります。
https://www.reddit.com/r/adventofcode/comments/1884fpl/2023_day_1for_those_who_stuck_on_part_2/

これを満たさないと本番データで正解にならないです。

```elixir
s = """
two1nine
eightwothree
abcone2threexyz
xtwone3four
4nineeightseven2
zoneight234
7pqrstsixteen
"""

f = fn s ->
  s
  |> String.replace(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"],
    fn 
      "one" -> "1e"
      "two" -> "2o"
      "three" -> "3e"
      "four" -> "4r"
      "five" -> "5e"
      "six" -> "6x"
      "seven" -> "7n"
      "eight" -> "8t"
      "nine" -> "9e"
    end)
    |> String.replace(["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"],
    fn 
      "one" -> "1e"
      "two" -> "2o"
      "three" -> "3e"
      "four" -> "4r"
      "five" -> "5e"
      "six" -> "6x"
      "seven" -> "7n"
      "eight" -> "8t"
      "nine" -> "9e"
    end)
    |> String.to_charlist |> Enum.filter(fn c -> c in ?0..?9 end) end

f2 = fn list -> "#{Enum.at(list, 0) - ?0}#{Enum.at(list, -1) - ?0}" |> String.to_integer end

s |> String.split("\n", trim: true) |> Enum.map(& f.(&1) |> f2.()) |> Enum.sum


```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Trebuchet?!&quot; - Day 1 - Advent of Code 2023 <a href="https://t.co/ypMgnkJsP7">https://t.co/ypMgnkJsP7</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1730570226239205774?ref_src=twsrc%5Etfw">December 1, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 1: Trebuchet?!](https://adventofcode.com/2023/day/1)を[Elixir](https://elixir-lang.org/)で解きました。
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
