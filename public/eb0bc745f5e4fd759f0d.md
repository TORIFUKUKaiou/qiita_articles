---
title: '闘魂Elixir ── Advent of Code 2022 (Day 6: Tuning Trouble) Part TwoをElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-01-09T22:12:42+09:00'
id: eb0bc745f5e4fd759f0d
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

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) Part Twoを解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) Part Two

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/6

問題を説明します。
最初の設問をクリアすると、Part Twoを参照できるようになります。

```
mjqjpqmgbljsphdztnvjfqwrcgsmlb
```

先頭から14文字ずつ見ていって、すべてに重複がない部分文字列はどこにあるのかを調べなさいという問題です。
解答は部分文字列の末尾の文字が元の文字列の先頭から数えて何文字目にあるのかを数えなさいというものです。

Part 1が4個だったのに対して、Part 2は14個になっています。
何のことを言っているかわからない方がいらっしゃるとおもいますので、Part 1の記事を貼っておきます。

https://qiita.com/torifukukaiou/items/e545a0dd92d06237b2c5

この場合の答えは2回目のmの出現位置ですので、`19`が答えです。

本番のデータは、4095文字あります。



# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私

私にとっては、[Day 5](https://adventofcode.com/2022/day/5)のほうが難しかったです。
再帰を使いました。
本当は、[Charlists](https://hexdocs.pm/elixir/1.14.2/List.html#module-charlists)の要素数が4以下になったときにどうするんだというガードがいる気がしますが、そこはインプットデータが保証してくれているようで考慮から外しています。

```elixir
input = 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
```

```elixir
defmodule Awesome2 do
 def solve([{head, _} | tail]) do
   list = Enum.take(tail, 13)

   list
   |> Enum.map(fn {a, _} -> a end)
   |> Kernel.++([head])
   |> Enum.uniq()
   |> Enum.count()
   |> Kernel.>=(14)
   |> if(do: list |> Enum.at(-1) |> elem(1), else: solve(tail))
 end
end

input |> Enum.with_index(1) |> Awesome2.solve()
```




`19` が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

<details><summary>読者投稿コーナー</summary><div>

読者の方からいただいたお便りをご紹介します。

まだありません。


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 6: Tuning Trouble](https://adventofcode.com/2022/day/6) Part Two」を[Elixir](https://elixir-lang.org/)で解いてみました。


**闘魂**とは、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダァー！}$</font>


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
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
