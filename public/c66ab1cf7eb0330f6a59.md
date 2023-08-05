---
title: '闘魂Elixir ── Advent of Code 2022 (Day 3: Rucksack Reorganization)をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2022-12-30T09:55:46+09:00'
id: c66ab1cf7eb0330f6a59
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>

[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)

# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/3

問題を説明します。

```
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
```

各行の文字列を半分にちょん切ります。
一行目の`vJrwpWtwJgWrhcsFMMfFFhFp`だと、`vJrwpWtwJgWr`と`hcsFMMfFFhFp`です。
そして前半部分と後半部分で共通する文字をみつけます。
一行目は、`p`です。
二行目以降も同じように処理していきます。
二行目は`L`、三行目は`P`、四行目は`v`、五行目は`t`、六行目は`s`です。

`a`は1点、`b`は2点あとはアルファベットが一個進むごとに同じように点数があがりまして、`z`が26点です。
大文字は`A`が27点、`B`が28点とつづきまして`Z`が52点という寸法です。

上記インプット例では答えは、`157`となります。





# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私

```elixir
input = """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"""

f = fn line, range ->
  String.slice(line, range)
  |> String.to_charlist()
  |> MapSet.new()
end

scores = ?a..?z |> Enum.zip(1..26) |> Kernel.++(Enum.zip(?A..?Z, 27..52)) |> Map.new()

input
|> String.split("\n", trim: true)
|> Enum.map(fn line ->
  len = String.length(line)

  f.(line, 0..(div(len, 2) - 1))
  |> MapSet.intersection(f.(line, div(len, 2)..-1))
  |> Enum.at(0)
  |> then(&Map.fetch!(scores, &1))
end)
|> Enum.sum()
```

`157`が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

<details><summary>読者投稿コーナー</summary><div>

読者の方からいただいたお便りをご紹介します。

# @mnishiguchi さん

[for](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)の使い方が巧みです。匠です。
パターンマッチも秀逸です。匠の技です。

```elixir
score = fn
  x when x in ?a..?z -> x - 96
  x when x in ?A..?Z -> x - 38
end

for row <- String.split(input, "\n", trim: true), reduce: 0 do
  sum ->
    {a, b} = String.split_at(row, div(String.length(row), 2))

    [intersection] =
      MapSet.intersection(MapSet.new(to_charlist(a)), MapSet.new(to_charlist(b)))
      |> MapSet.to_list()

    sum + score.(intersection)
end
```


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Day 3: Rucksack Reorganization](https://adventofcode.com/2022/day/3)」を[Elixir](https://elixir-lang.org/)で解いてみました。


**闘魂**とは、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

https://qiita.com/torifukukaiou/items/b6361f98194f3687a13c

https://qiita.com/torifukukaiou/items/4c35ace6db3f02ac3897

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

https://qiita.com/torifukukaiou/items/44db8a4997812518730a




---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダー！}$</font></b>
