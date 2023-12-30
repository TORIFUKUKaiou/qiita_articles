---
title: 闘魂Elixir ── Advent of code 2023 Day 9をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-10T05:31:14+09:00'
id: f8678c95055087be503f
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

# [Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9)

[Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

今回は普通に問いてできました。法則みたいなものが見つかると早いです。正確に言うとたぶんこうかなあと適当に加算、減算をしたらうまくいきました。

## 私の答え Part 1

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>


```elixir
input = """
0 3 6 9 12 15
1 3 6 10 15 21
10 13 16 21 30 45
"""

defmodule Awesome do
  def run(input) do
    parse(input)
    |> solve()
  end

  defp solve(list_of_lists) do
    list_of_lists
    |> Enum.map(fn list ->
      list
      |> steps()
      |> do_solve()
    end)
    |> Enum.sum()
  end

  defp steps(list) do
    Stream.iterate(0, & &1)
    |> Enum.reduce_while([list], fn 0, [head | _] = acc ->
      new_list = step(head)
      {step_halt_or_cont(new_list), [new_list | acc]}
    end)
  end

  defp step(list) do
    list
    |> Enum.reduce({nil, []}, fn
      n, {nil, []} -> {n, []}
      n, {before, acc} -> {n, [n - before | acc]}
    end)
    |> elem(1)
    |> Enum.reverse()
  end

  defp all_zero?(list) do
    list
    |> Enum.all?(&(&1 == 0))
  end

  defp step_halt_or_cont(list) do
    case all_zero?(list) do
      true -> :halt
      false -> :cont
    end
  end

  defp do_solve(list_of_lists) do
    list_of_lists
    |> Enum.reduce(0, fn list, acc ->
      acc + Enum.at(list, -1)
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      s
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
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
    |> solve()
  end

  defp solve(list_of_lists) do
    list_of_lists
    |> Enum.map(fn list ->
      list
      |> steps()
      |> Enum.reverse()
      |> do_solve()
    end)
    |> Enum.sum()
  end

  defp steps(list) do
    Stream.iterate(0, & &1)
    |> Enum.reduce_while([list], fn 0, [head | _] = acc ->
      new_list = step(head)
      {step_halt_or_cont(new_list), [new_list | acc]}
    end)
  end

  defp step(list) do
    list
    |> Enum.reduce({nil, []}, fn
      n, {nil, []} -> {n, []}
      n, {before, acc} -> {n, [n - before | acc]}
    end)
    |> elem(1)
    |> Enum.reverse()
  end

  defp all_zero?(list) do
    list
    |> Enum.all?(&(&1 == 0))
  end

  defp step_halt_or_cont(list) do
    case all_zero?(list) do
      true -> :halt
      false -> :cont
    end
  end

  defp do_solve([first_list | tail_list_of_lists]) do
    tail_list_of_lists
    |> Enum.with_index(1)
    |> Enum.reduce(Enum.at(first_list, 0), fn {list, index}, acc ->
      case rem(index, 2) do
        1 -> acc - Enum.at(list, 0)
        0 -> acc + Enum.at(list, 0)
      end
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn s ->
      s
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end)
  end
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Mirage Maintenance&quot; - Day 9 - Advent of Code 2023 <a href="https://t.co/h6MIg7Tsop">https://t.co/h6MIg7Tsop</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1733468829538537783?ref_src=twsrc%5Etfw">December 9, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 9: Mirage Maintenance](https://adventofcode.com/2023/day/9)を[Elixir](https://elixir-lang.org/)で解きました。
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
