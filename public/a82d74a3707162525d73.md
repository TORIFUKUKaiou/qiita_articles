---
title: '闘魂Elixir ── Advent of Code 2022 (Day 2: Rock Paper Scissors)をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2022-12-30T00:49:29+09:00'
id: a82d74a3707162525d73
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>

# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```



# [Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/2

問題を説明します。

```
A Y
B X
C Z
```

じゃんけんです。
上記がインプット例です。
左の列が相手の手、右の列が自分の手です。
A = グー、B = パー、C = チョキ
X = グー、Y= パー、Z = チョキ
です。


```
グー パー
パー　グー
チョキ チョキ
```

自分（右列）の出した手による点数と勝敗による点数の２種類があります。

- グー: 1点、パー: 2点、チョキ: 3点
- 負け: 0点、引き分け: 3点、勝ち: 6点

ですから、

- 1行目(相手がグー、自分はパー)では、 `2 + 6 = 8`点
- 2行目(相手がパー、自分はグー)では、 `1 + 0 = 1`点 
- 3行目(相手がチョキ、自分はチョキ)では、 `3 + 3 = 6`点

合計15点が答えというものです。


# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。

のちほど紹介する @mnishiguchi さんの解答が秀逸です！


<details><summary>解答例</summary><div>

## 私

```elixir
input = """
A Y
B X
C Z
"""

f = fn
  {:Rock, :Rock} -> 1 + 3
  {:Rock, :Paper} -> 2 + 6
  {:Rock, :Scissors} -> 3 + 0
  {:Paper, :Rock} -> 1 + 0
  {:Paper, :Paper} -> 2 + 3
  {:Paper, :Scissors} -> 3 + 6
  {:Scissors, :Rock} -> 1 + 6
  {:Scissors, :Paper} -> 2 + 0
  {:Scissors, :Scissors} -> 3 + 3
end

map_opponent = %{"A" => :Rock, "B" => :Paper, "C" => :Scissors}
map_me = %{"X" => :Rock, "Y" => :Paper, "Z" => :Scissors}

input
|> String.split("\n", trim: true)
|> Enum.map(&String.split(&1, " "))
|> Enum.map(fn [opponent, me] ->
  f.({map_opponent[opponent], map_me[me]})
end)
|> Enum.sum()
```

15が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。




## 読者投稿コーナー

<details><summary>読者投稿コーナー</summary><div>

読者の方からいただいたお便りをご紹介します。

# @mnishiguchi さんより

[for](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)とMapの組み立て方が匠の技です。
巧みです。

```elixir
hands = %{
  ?A => :rock,
  ?B => :paper,
  ?C => :scissors,
  ?X => :rock,
  ?Y => :paper,
  ?Z => :scissors
}

scores = %{
  win: 6,
  draw: 3,
  lose: 0,
  rock: 1,
  paper: 2,
  scissors: 3
}

judge = %{
  {:rock, :scissors} => scores.lose + scores.scissors,
  {:rock, :rock} => scores.draw + scores.rock,
  {:rock, :paper} => scores.win + scores.paper,
  {:paper, :rock} => scores.lose + scores.rock,
  {:paper, :paper} => scores.draw + scores.paper,
  {:paper, :scissors} => scores.win + scores.scissors,
  {:scissors, :paper} => scores.lose + scores.paper,
  {:scissors, :scissors} => scores.draw + scores.scissors,
  {:scissors, :rock} => scores.win + scores.rock
}

for <<player1, " ", player2, "\n" <- input >>, reduce: 0 do
  acc -> acc + judge[{hands[player1], hands[player2]}]
end
```


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Day 2: Rock Paper Scissors](https://adventofcode.com/2022/day/2)」を[Elixir](https://elixir-lang.org/)で解いてみました。


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
