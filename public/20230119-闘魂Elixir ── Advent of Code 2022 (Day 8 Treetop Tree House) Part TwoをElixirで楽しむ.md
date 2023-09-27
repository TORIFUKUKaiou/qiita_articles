---
title: >-
  闘魂Elixir ── Advent of Code 2022 (Day 8: Treetop Tree House) Part
  TwoをElixirで楽しむ
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-02-04T22:33:50+09:00'
id: 39dbba5eaad3db82e3a4
organization_url_name: fukuokaex
slide: false
ignorePublish: false
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

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) Part Twoを解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

この記事は、もくもく会イベント **[闘魂Elixir #12](https://autoracex.connpass.com/event/267956/)** の成果です。



# [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) Part Two

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/8

問題を説明します。
最初の設問をクリアすると、Part Twoを参照できるようになります。

上下左右に向かって自身の数値と同じになるか大きい数字が現れるまで個数を数えます。
それぞれの個数をかけ合わせます。
掛け算の結果が一番大きな数値を答えないというものです。
外側の数字は数えるものがない方向が存在するので無条件で0です。

![スクリーンショット 2023-01-19 21.54.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/00b5882a-ce0a-a945-8130-8bc71ee5de35.png)

たとえば2行目中央の5の場合は、以下のようになります。

- 左に行くと5とぶつかるので、`1`
- 右に行くと、1,2とすすめるので、`2`
- 上には3とすすめるので、`1`
- 下には3, 5とすすめるので、`2`

これらをかけ合わせて`4`が答えとなります。

もうひとつ例をみてみましょう。

![スクリーンショット 2023-01-19 21.58.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/927df45b-9de7-cb1e-b217-9f50c10a93e7.png)

4行目中央の5に注目します。

- 左に行くと3, 3とすすめるので、`2`
- 右に行くと、4, 9まですすめるので、`2`
- 上には3、5まですすめるので、`2`
- 下には3とすすめるので、`１`

これらをかけ合わせて`8`が答えとなります。
このインプットの場合はこの点が一番大きな数字となり、`8`が答えとなります。



# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私


```elixir
input = """
30373
25512
65332
33549
35390
"""
```

```elixir
input_with_index = input
  |> String.split("\n", trim: true)
  |> Enum.map(&String.to_charlist/1)

row_size = Enum.count(input_with_index)

[head | _] = input_with_index
column_size = Enum.count(head)

map = for i <- 0..(row_size - 1), j <- 0..(column_size - 1), into: %{} do
  height = input_with_index |> Enum.at(i) |> Enum.at(j)
  {{i, j}, height}
end

value = fn
  -1, _height, distance -> {:halt, distance}
  height, height, distance -> {:halt, distance + 1}
  other_height, height, distance when other_height > height -> {:halt, distance + 1}
  other_height, height, distance when other_height < height -> {:cont, distance + 1}
end

f_horizontal_distance = fn row, start, ending, height ->
  start..ending
  |> Enum.reduce_while(0, fn index, acc ->
    Map.get(map, {row, index}, -1)
    |> value.(height, acc)
  end)
end

f_vertical_distance = fn column, start, ending, height ->
  start..ending
  |> Enum.reduce_while(0, fn index, acc ->
    Map.get(map, {index, column}, -1)
    |> value.(height, acc)
  end)
end

for i <- 0..(row_size - 1),
    j <- 0..(column_size - 1),
    height = Map.fetch!(map, {i, j}),
    r = f_horizontal_distance.(i, j + 1, column_size, height),
    l = f_horizontal_distance.(i, j - 1, -1, height),
    t = f_vertical_distance.(j, i - 1, -1, height),
    d = f_vertical_distance.(j, i + 1, row_size, height) do
  r * l * t * d
end
|> IO.inspect()
|> Enum.max()
```




`8` が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>読者投稿コーナー</summary><div>



まだありません。


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8) Part Two」を[Elixir](https://elixir-lang.org/)で解いてみました。


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
