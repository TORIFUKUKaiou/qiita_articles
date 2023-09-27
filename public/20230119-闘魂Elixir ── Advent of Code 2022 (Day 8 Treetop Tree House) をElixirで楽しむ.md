---
title: '闘魂Elixir ── Advent of Code 2022 (Day 8: Treetop Tree House) をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-01-21T22:53:24+09:00'
id: cbede299eeda0111baf1
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

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

この記事は、もくもく会イベント **[闘魂Elixir #12](https://autoracex.connpass.com/event/267956/)** の成果です。

# [Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/8

問題を説明します。

```
30373
25512
65332
33549
35390
```

上下左右に向かって自身の数値より並んでいるラインが一箇所でもあれば:ok:です。
一番外側は無条件にすべて:ok:という寸法です。




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

f_horizontal = fn row, start, ending, height ->
  start..ending
  |> Enum.map(fn index ->
    Map.get(map, {row, index}, 0)
  end)
  |> Enum.all?(& height > &1)
end

f_vertical = fn column, start, ending, height ->
  start..ending
  |> Enum.map(fn index ->
    Map.get(map, {index, column}, 0)
  end)
  |> Enum.all?(& height > &1)
end

for i <- 0..(row_size - 1),
    j <- 0..(column_size - 1),
    height = Map.fetch!(map, {i, j}),
    f_horizontal.(i, j + 1, column_size, height) or
    f_horizontal.(i, j - 1, -1, height) or
    f_vertical.(j, i - 1, -1, height) or
    f_vertical.(j, i + 1, row_size, height) do
  {i, j}
end
|> IO.inspect()
|> Enum.count()
```




`2１` が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>読者投稿コーナー</summary><div>


### @mnishiguchi さん

常連さんです。いつもお便りありがとうーーーーッ！！！　ございます。

```elixir
defmodule Treetop do
  defstruct [:input, :x_count, :y_count]

  def new(input, x_count, y_count) do
    %__MODULE__{
      input: parse_input(input),
      x_count: x_count,
      y_count: y_count
    }
  end

  def call(data) do
    hidden_points =
      data
      |> possibly_hidden_points()
      |> Enum.filter(fn {x, y} -> hidden_point?(data, {x, y}) end)
      |> length()

    data.x_count * data.y_count - hidden_points
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index(fn row, i ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index(fn value, j ->
        {{i, j}, value |> String.to_integer()}
      end)
    end)
    |> List.flatten()
    |> Map.new()
  end

  defp possibly_hidden_points(data) do
    data.input
    |> Enum.filter(fn
      {{0, _}, _} -> false
      {{_, 0}, _} -> false
      {{x, _}, _} when x == data.x_count - 1 -> false
      {{_, y}, _} when y == data.y_count - 1 -> false
      {_point, _value} -> true
    end)
    |> Enum.map(fn {point, _} -> point end)
  end

  defp hidden_point?(data, {x, y}) do
    current_value = data.input[{x, y}]

    x_left_blocked =
      (y - 1)..0
      |> Enum.reduce_while(nil, fn i, _acc ->
        hidden = data.input[{x, i}] >= current_value
        if hidden, do: {:halt, true}, else: {:cont, false}
      end)

    x_right_blocked =
      (y + 1)..(data.y_count - 1)
      |> Enum.reduce_while(nil, fn i, _acc ->
        hidden = data.input[{x, i}] >= current_value
        if hidden, do: {:halt, true}, else: {:cont, false}
      end)

    y_left_blocked =
      (x - 1)..0
      |> Enum.reduce_while(nil, fn i, _acc ->
        blocked = data.input[{i, y}] >= current_value
        if blocked, do: {:halt, true}, else: {:cont, false}
      end)

    y_right_blocked =
      (x + 1)..(data.x_count - 1)
      |> Enum.reduce_while(nil, fn i, _acc ->
        blocked = data.input[{i, y}] >= current_value
        if blocked, do: {:halt, true}, else: {:cont, false}
      end)

    x_left_blocked and x_right_blocked and
      y_left_blocked and y_right_blocked
  end
end

"""
30373
25512
65332
33549
35390
"""
|> Treetop.new(5, 5)
|> Treetop.call()
```




</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 8: Treetop Tree House](https://adventofcode.com/2022/day/8)」を[Elixir](https://elixir-lang.org/)で解いてみました。


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
