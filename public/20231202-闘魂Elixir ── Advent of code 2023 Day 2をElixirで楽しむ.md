---
title: 闘魂Elixir ── Advent of code 2023 Day 2をElixirで楽しむ
tags:
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-02T17:46:59+09:00'
id: e4c4eb6e3f75b79bcd57
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

# [Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2)

[Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2)を解いてみます。
問題はリンク先をご参照ください。



## 私の答え Part One

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
input = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

input
|> String.split("\n", trim: true)
|> Enum.map(fn s ->
  s
  |> String.split([":", ",", ";"])
  |> tl()
  |> Enum.map(fn s ->
    Regex.named_captures(~r/(?<num>\d+) (?<color>.+)/, s)
    |> Map.update("num", 0, &String.to_integer(&1))
  end)
end)
|> Enum.with_index(1)
|> Enum.filter(fn {maps, _game} ->
  maps
  |> Enum.all?(fn
    %{"color" => "blue", "num" => num} -> num <= 14
    %{"color" => "red", "num" => num} -> num <= 12
    %{"color" => "green", "num" => num} -> num <= 13
  end)
end)
|> Enum.map(fn {_maps, game} -> game end)
|> Enum.sum()
```

</details>


## 私の答え Part Two

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>



これを満たさないと本番データで正解にならないです。

```elixir
input = """
Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
"""

input
|> String.split("\n", trim: true)
|> Enum.map(fn s ->
  s
  |> String.split([":", ",", ";"])
  |> tl()
  |> Enum.map(fn s ->
    Regex.named_captures(~r/(?<num>\d+) (?<color>.+)/, s)
    |> Map.update("num", 0, &String.to_integer(&1))
  end)
end)
|> Enum.map(fn maps ->
  Enum.reduce(maps, %{blue: 0, red: 0, green: 0}, fn
    %{"color" => "blue", "num" => num}, %{blue: max} = acc when num > max ->
      Map.put(acc, :blue, num)

    %{"color" => "red", "num" => num}, %{red: max} = acc when num > max ->
      Map.put(acc, :red, num)

    %{"color" => "green", "num" => num}, %{green: max} = acc when num > max ->
      Map.put(acc, :green, num)

    _, acc ->
      acc
  end)
  |> Map.values()
  |> Enum.product()
end)
|> Enum.sum()
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Cube Conundrum&quot; - Day 2 - Advent of Code 2023 <a href="https://t.co/iCzPz7pwL5">https://t.co/iCzPz7pwL5</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1730869215790612614?ref_src=twsrc%5Etfw">December 2, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 2: Cube Conundrum](https://adventofcode.com/2023/day/2)を[Elixir](https://elixir-lang.org/)で解きました。
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
