---
title: 闘魂Elixir ── Advent of code 2023 Day 6をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-07T10:16:00+09:00'
id: a87f442d35b7c6b11dd9
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

# [Day 6: Wait For It](https://adventofcode.com/2023/day/6)

[Day 6: Wait For It](https://adventofcode.com/2023/day/6)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

## 私の答え Part 1

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
input = """
Time:      7  15   30
Distance:  9  40  200
"""

defmodule Awesome do
  def run(input) do
    races(input)
    |> Enum.map(fn {time, distance} -> solve(time, distance) end)
    |> Enum.product()
  end

  defp solve(time, distance) do
    1..time
    |> Enum.filter(fn t ->
      speed = t
      left_time = time - t
      left_time * speed > distance
    end)
    |> Enum.count()
  end

  defp races(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      s
      |> String.split(":")
      |> Enum.at(-1)
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
    |> Enum.zip()
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
    [time, distance] = races(input)

    solve(time, distance)
  end

  defp solve(time, distance) do
    1..time
    |> Enum.filter(fn t ->
      speed = t
      left_time = time - t
      left_time * speed > distance
    end)
    |> Enum.count()
  end

  defp races(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      s
      |> String.split(":")
      |> Enum.at(-1)
      |> String.split(" ", trim: true)
      |> Enum.join()
      |> String.to_integer()
    end)
  end
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I&#39;ve completed &quot;Wait For It&quot; - Day 6 - Advent of Code 2023 <a href="https://t.co/SKB9MIWbCa">https://t.co/SKB9MIWbCa</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1732569213137834115?ref_src=twsrc%5Etfw">December 7, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 6: Wait For It](https://adventofcode.com/2023/day/6)を[Elixir](https://elixir-lang.org/)で解きました。
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
