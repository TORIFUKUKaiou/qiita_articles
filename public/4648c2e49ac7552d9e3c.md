---
title: '闘魂Elixir ── Advent of Code 2022 (Day 4: Camp Cleanup)をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2022-12-31T11:05:14+09:00'
id: 4648c2e49ac7552d9e3c
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
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/4

問題を説明します。

```
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
```

各行は`,`で区切られています。
`-`は前後で数字が並んでいます。
たとえば一行目は`2-4,6-8`ですので、`2,3,4`と`6,7,8`とみるわけです。
今回は、2つの数字列がどちらかに完全に含まれている行が何行あるかを数えなさいという問題です。
一行ずつ調べてみます。

- 一行目は`2-4,6-8`: `2,3,4`と`6,7,8` -> No
- 二行目は`2-3,4-5`: `2,3`と`4,5` -> No
- 三行目は`5-7,7-9`: `5,6,7`と`7,8,9` -> No
- 四行目は`2-8,3-7`: `2,3,4,5,6,7,8`と`3,4,5,6,7` -> Yes
- 五行目は`6-6,4-6`: `6`と`4,5,6` -> Yes
- 六行目は`2-6,4-8`: `2,3,4,5,6`と`4,5,6,7,8` -> No

上記インプット例では答えは、`2`となります。

インプットの数字は2桁の数字が使われることがあります。
例: `10-50,0-99` -> Yesです。



# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私

```elixir
input = """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
"""

f = fn lines, delimiter, func ->
  lines
  |> Enum.map(fn s ->
    s
    |> String.split(delimiter)
    |> func.()
  end)
end

input
|> String.split("\n", trim: true)
|> f.(",", fn lines ->
  f.(lines, "-", fn [a, b] ->
    Range.new(String.to_integer(a), String.to_integer(b))
  end)
end)
|> Enum.filter(fn [r1, r2] ->
  if Range.size(r1) < Range.size(r2) do
    Enum.all?(r1, & &1 in r2)
  else
    Enum.all?(r2, & &1 in r1)
  end
end)
|> Enum.count()
```

`2`が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



# 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>読者投稿コーナー</summary><div>



## @mnishiguchi san

ガード節が巧みです。
匠の技です。

また私の解答では[Range](https://hexdocs.pm/elixir/Range.html)を使っていますが、大小比較さえできればよいので、@mnishiguchi さんの解答のほうが余計なものを作らない点で優れているようにおもいます。

投稿（とうこん 闘魂）ありがとうーーーーッ！　ございます。

```elixir
parse_row = fn row -> 
  row |> String.split(["-", ","]) |> Enum.map(& String.to_integer/1)
end

judge = fn
  [a1, a2, b1, b2] when a1 in b1..b2 and a2 in b1..b2 -> true
  [a1, a2, b1, b2] when b1 in a1..a2 and b2 in a1..a2 -> true
  [_, _, _, _] -> false
end

input
|> String.split("\n", trim: true)
|> Enum.reduce(0, fn row, acc ->
  if row |> parse_row.() |> judge.() do
    acc + 1
  else
    acc
  end
end)
```


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 4: Camp Cleanup](https://adventofcode.com/2022/day/4)」を[Elixir](https://elixir-lang.org/)で解いてみました。


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
