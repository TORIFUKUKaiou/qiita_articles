---
title: 闘魂Elixir ── Advent of code 2023 Day 8をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-09T09:58:27+09:00'
id: def2390e9b725d4b2b98
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

# [Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8)

[Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

Part 1は普通にやったら解けて、Part 2は普通にやったら30分実行しても終わらないプログラムになってしまいひと工夫が必要でした。
あー、そういえばPart 1もはじまりが`AAA`ということを理解できていませんでした。先頭行からだとおもいこんでいました。
２つともどうやって解決したかというと他の方の解答（Python）を見て解決しました。

https://github.com/Timmoth/AdventOfCode2023/tree/main/day08

この場をお借りして御礼申し上げます。
**ありがとうーーーーッ！！！** ございます。

## 私の答え Part 1

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>


```elixir
input = """
RL

AAA = (BBB, CCC)
BBB = (DDD, EEE)
CCC = (ZZZ, GGG)
DDD = (DDD, DDD)
EEE = (EEE, EEE)
GGG = (GGG, GGG)
ZZZ = (ZZZ, ZZZ)
"""


defmodule Awesome do
  def run(input) do
    instructions = parse_instructions(input)
    nodes = parse_nodes(input)

    solve(instructions, nodes)
  end

  defp solve(instructions, nodes) do
    Stream.cycle(instructions)
    |> Enum.reduce_while({"AAA", 0}, fn instruction, {node, acc} ->
      new_node = get_in(nodes, [node, instruction])
      {halt_or_cont(new_node), {new_node, acc + 1}}
    end)
    |> elem(1)
  end

  defp halt_or_cont("ZZZ"), do: :halt
  defp halt_or_cont(_), do: :cont

  defp parse_instructions(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.at(0)
    |> String.to_charlist()
  end

  defp parse_nodes(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.at(1)
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn s, acc ->
      key = String.slice(s, 0, 3)
      l = String.slice(s, 7, 3)
      r = String.slice(s, 12, 3)

      Map.merge(acc, %{key => %{?L => l, ?R => r}})
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

末尾が`Z`でおわる文字列のパターンマッチについては以下の記事の知見を活かしています。

[闘魂Elixir ── "闘魂"とは<<0xE99798::24, 0xE9ad82::24>>である](https://qiita.com/torifukukaiou/items/9574f4411c3954fa4f9b)



```elixir
input = """
LR

11A = (11B, XXX)
11B = (XXX, 11Z)
11Z = (11B, XXX)
22A = (22B, XXX)
22B = (22C, 22C)
22C = (22Z, 22Z)
22Z = (22B, 22B)
XXX = (XXX, XXX)
"""

defmodule Awesome2 do
  def run(input) do
    instructions = parse_instructions(input)
    nodes = parse_nodes(input)

    solve(instructions, nodes)
  end

  defp solve(instructions, nodes) do
    nodes
    |> Enum.filter(fn {node, _} -> String.ends_with?(node, "A") end)
    |> Enum.map(fn {node, _} ->
      Stream.cycle(instructions)
      |> Enum.reduce_while({node, 0}, fn instruction, {current_node, acc} ->
        new_node = get_in(nodes, [current_node, instruction])
        {halt_or_cont(new_node), {new_node, acc + 1}}
      end)
      |> elem(1)
    end)
    |> Enum.reduce(1, &lcm/2)
  end

  defp lcm(a, b), do: div(a * b, Integer.gcd(a, b))

  defp halt_or_cont(<<_, _, ?Z>>), do: :halt
  defp halt_or_cont(_), do: :cont

  defp parse_instructions(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.at(0)
    |> String.to_charlist()
  end

  defp parse_nodes(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.at(1)
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn s, acc ->
      key = String.slice(s, 0, 3)
      l = String.slice(s, 7, 3)
      r = String.slice(s, 12, 3)

      Map.merge(acc, %{key => %{?L => l, ?R => r}})
    end)
  end
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Haunted Wasteland&quot; - Day 8 - Advent of Code 2023 <a href="https://t.co/vOUUHHmkiO">https://t.co/vOUUHHmkiO</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1733069333537202578?ref_src=twsrc%5Etfw">December 8, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 8: Haunted Wasteland](https://adventofcode.com/2023/day/8)を[Elixir](https://elixir-lang.org/)で解きました。
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
