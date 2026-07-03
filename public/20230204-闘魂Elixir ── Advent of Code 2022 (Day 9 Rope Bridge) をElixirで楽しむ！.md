---
title: '闘魂Elixir ── Advent of Code 2022 (Day 9: Rope Bridge) をElixirで楽しむ！'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-02-12T00:10:45+09:00'
id: 4f7f5aaafa0de517b1bd
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)

# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 9: Rope Bridge](https://adventofcode.com/2022/day/9) を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

この記事は、もくもく会イベント **[autoracex #175](https://autoracex.connpass.com/event/271821/)** の成果です。

# 対象とする読者

プログラミングを楽しんでいるそこの**あなた**。
特に、「**[闘魂プログラミング（ストロングスタイル）](https://qiita.com/torifukukaiou/items/c414310cde9b7099df55)**」を楽しんでいるそこの**あなた**。
「**わたしが長年夢であった本当の Elixirを通じて プログラミングを通じて 世界平和(を)必ず実現します！**」に共感していただけるそこの**あなた**。

つまりは
<b><font color="blue">$\huge{全人類}$</font></b>
です。

<b><font color="green">$\huge{For　You　All}$</font></b>
です。


# [Day 9: Rope Bridge](https://adventofcode.com/2022/day/9)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/9

問題を説明します。

インプット例はこんな感じです。

```
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
```

Rは右へ、Uは上へ、Lは左へ、Dは下へ進みなさいという方向です。数字は移動する量です。
H(ヘッド?)とT(テイル?)は常に距離が1以下となるように進む必要があります。
尺取虫の歩みに似ています。

上記のインプット例を動かしてみると以下のようになります。
`T`と`H`が重なったときは阪神タイガースのマークになります。
それでアニメーションでは、**猛虎**の`M`としています。@mnishiguchiさんのアイデアです。ありがとうございます！

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f3fd2697-d5a3-8ddf-c2f4-72e71100495a.gif)



```
== Initial State ==

......
......
......
......
H.....  (H covers T, s)

== R 4 ==

......
......
......
......
TH....  (T covers s)

......
......
......
......
sTH...

......
......
......
......
s.TH..

......
......
......
......
s..TH.

== U 4 ==

......
......
......
....H.
s..T..

......
......
....H.
....T.
s.....

......
....H.
....T.
......
s.....

....H.
....T.
......
......
s.....

== L 3 ==

...H..
....T.
......
......
s.....

..HT..
......
......
......
s.....

.HT...
......
......
......
s.....

== D 1 ==

..T...
.H....
......
......
s.....

== R 4 ==

..T...
..H...
......
......
s.....

..T...
...H..
......
......
s.....

......
...TH.
......
......
s.....

......
....TH
......
......
s.....

== D 1 ==

......
....T.
.....H
......
s.....

== L 5 ==

......
....T.
....H.
......
s.....

......
....T.
...H..
......
s.....

......
......
..HT..
......
s.....

......
......
.HT...
......
s.....

......
......
HT....
......
s.....

== R 2 ==

......
......
.H....  (H covers T)
......
s.....

......
......
.TH...
......
s.....
```

このとき、T(テイル?)が通った足跡をプロットすると以下のようになり、`13`箇所通ったことになり、このインプットの場合の答えは`13`となります。

```
..##..
...##.
.####.
....#.
####..
```



# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。

もちろん、自身が提唱する「**[闘魂プログラミング（ストロングスタイル）](https://qiita.com/torifukukaiou/items/c414310cde9b7099df55)**」で解いてみます。



<details><summary>解答例</summary><div>

## 私

```elixir
Mix.install [{:toukon, "~> 0.1.0", github: "TORIFUKUKaiou/toukon"}]
[String, Enum, MapSet] |> Enum.each(&Toukon.binta/1)
```


```elixir
input = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""
```

```elixir
defmodule RopeBridge do
  def run(input, "闘魂") do
    input
    |> parse_input("闘魂")
    |> solve("闘魂")
    |> elem(2)
    |> Inoki.Enum.count("闘魂")
  end

  defp parse_input(input, "闘魂") do
    input
    |> Inoki.String.split("\n", [trim: true], "闘魂")
    |> Inoki.Enum.map(& Inoki.String.split(&1, " ", "闘魂"), "闘魂")
    |> Inoki.Enum.map(fn [direction, num] -> {direction, Inoki.String.to_integer(num, "闘魂")} end, "闘魂")
  end

  defp solve(list, "闘魂") do
    list
    |> Inoki.Enum.reduce({{0, 0}, {0, 0}, Inoki.MapSet.new("闘魂")}, fn operation, acc ->
      do_solve(operation, acc, "闘魂")
    end, "闘魂")
  end

  defp do_solve({direction, num}, acc, "闘魂") do
    1..num
    |> Inoki.Enum.reduce(acc, fn _step, {head, tail, tails} ->
      move(direction, {head, tail, tails}, "闘魂")
    end, "闘魂")
  end

  defp move("R", {{head_x, head_y} = head, tail, tails}, "闘魂") do
    new_head = {head_x + 1, head_y}
    do_move(new_head, head, tail, tails, "闘魂")
  end

  defp move("L", {{head_x, head_y} = head, tail, tails}, "闘魂") do
    new_head = {head_x - 1, head_y}
    do_move(new_head, head, tail, tails, "闘魂")
  end

  defp move("U", {{head_x, head_y} = head, tail, tails}, "闘魂") do
    new_head = {head_x, head_y + 1}
    do_move(new_head, head, tail, tails, "闘魂")
  end

  defp move("D", {{head_x, head_y} = head, tail, tails}, "闘魂") do
    new_head = {head_x, head_y - 1}
    do_move(new_head, head, tail, tails, "闘魂")
  end

  defp do_move(new_head, old_head, tail, tails, "闘魂") do
    new_tail = new_tail(new_head, old_head, tail, "闘魂")
    new_tails = Inoki.MapSet.put(tails, new_tail, "闘魂")

    {new_head, new_tail, new_tails}
  end

  defp new_tail({new_head_x, new_head_y}, _old_head, {tail_x, tail_y}, "闘魂")
    when abs(new_head_x - tail_x) <= 1 and abs(new_head_y - tail_y) <= 1 do
    {tail_x, tail_y}
  end

  defp new_tail(_new_head, old_head, _tail, "闘魂") do
    old_head
  end
end
```


```elixir
RopeBridge.run(input, "闘魂")
```

`13` が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>読者投稿コーナー</summary><div>

おなじみ @mnishiguchi さんの解答です。

https://github.com/mnishiguchi/livebooks/blob/main/notebooks/toukonex/rope_bridge.livemd



</div></details>

---

# アニメーションを作りました

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f3fd2697-d5a3-8ddf-c2f4-72e71100495a.gif)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日の登壇で使ったスライドです！<br><br>良質な技術記事を量産する秘訣 / <a href="https://twitter.com/hashtag/MeetsPro?src=hash&amp;ref_src=twsrc%5Etfw">#MeetsPro</a> - Speaker Deck <a href="https://t.co/vBnKmVlebg">https://t.co/vBnKmVlebg</a></p>&mdash; Junichi Ito (伊藤淳一) (@jnchito) <a href="https://twitter.com/jnchito/status/1621458679819284480?ref_src=twsrc%5Etfw">February 3, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

こちらのキャンペーン:interrobang::interrobang::interrobang:に乗っからせていただいて、ハッシュタグ「[#MeetsPro](https://twitter.com/hashtag/MeetsPro?src=hashtag_click)」でツイートしたところ、@jnchitoさんからリツイートしていただけました:tada::tada::tada:
**ありがとうございます！**

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「闘魂」の文字につい目が奪われてしまいますが、「プログラミング問題を解いてみた」という技術記事ですね😅 この問題、仕組みがわかると「へー、面白そう」ってなるんですが、最初はちょっとイメージしづらかったです。。アニメーションで見れたら嬉しいですね。（難しそうだけど） <a href="https://twitter.com/hashtag/MeetsPro?src=hash&amp;ref_src=twsrc%5Etfw">#MeetsPro</a> <a href="https://t.co/APCHIJLOA4">https://t.co/APCHIJLOA4</a></p>&mdash; Junichi Ito (伊藤淳一) (@jnchito) <a href="https://twitter.com/jnchito/status/1622152787139387394?ref_src=twsrc%5Etfw">February 5, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

「アニメーションで見れたら嬉しいですね」とのコメントを頂きまして、**たしかに！** と思いました。
それで追加してみました。
`T`と`H`が重なると阪神タイガースのマークになります。それで`T`と`H`が重なった時は**猛虎**の`M`としています。@mnishiguchiさんのアイデアです。ありがとうございます！

プログラムを作るにあたり、出力をその場で上書きしたかったのですが、その方法を忘れていました。
それでいろいろググって、「[ANSIエスケープコード](https://www.mm2d.net/main/prog/c/console-02.html)」の記事にたどり着きまして参考にいたしました。
この場をお借りして御礼申し上げます。ありがとうございます。
`ESC[nA`（カーソルを上にn移動させる。）を使いました。

コメント付きのリツイートをしてくださった@jnchitoさんに感謝感謝申し上げます。
<b><font color="purple">$\huge{ありがとうございます！}$</font></b>




<details><summary>アニメーション出力付き解答</summary><div>

```elixir
Mix.install([{:toukon, "~> 0.1.0", github: "TORIFUKUKaiou/toukon"}])
[String, Enum, MapSet] |> Enum.each(&Toukon.binta/1)

input = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

defmodule RopeBridgePrinter do
  def print({head, tail}, row, column, fun_print \\ &IO.write/1, overwrite \\ true) do
    do_print(head, tail, row, column, fun_print, overwrite)
  end

  defp do_print({head_x, head_y}, {tail_x, tail_y}, row, column, fun_print, overwrite) do
    IO.puts("")

    for j <- (row - 1)..0//-1, i <- 0..(column - 1) do
      character(i, j, head_x, head_y, tail_x, tail_y)
    end
    |> Enum.chunk_every(column)
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
    |> then(fn string ->
      if overwrite, do: string <> "\e[#{row}A", else: string
    end)
    |> fun_print.()
  end

  defp character(i, j, head_x, head_y, tail_x, tail_y)
       when i == head_x and j == head_y and i == tail_x and j == tail_y do
    "M"
  end

  defp character(i, j, head_x, head_y, _tail_x, _tail_y) when i == head_x and j == head_y do
    "H"
  end

  defp character(i, j, _head_x, _head_y, tail_x, tail_y) when i == tail_x and j == tail_y do
    "T"
  end

  defp character(_i, _j, _head_x, _head_y, _tail_x, _tail_y) do
    "."
  end
end

defmodule RopeBridge do
  def run(input, "闘魂") do
    {_, _, tails, points} =
      input
      |> parse_input("闘魂")
      |> solve("闘魂")

    tails
    |> Inoki.Enum.count("闘魂")
    |> IO.puts()

    points
    |> Enum.each(fn head_tail ->
      Process.sleep(100)
      RopeBridgePrinter.print(head_tail, 5, 6)
    end)

    points
    |> Enum.at(-1)
    |> RopeBridgePrinter.print(5, 6, &IO.puts/1, false)
  end

  defp parse_input(input, "闘魂") do
    input
    |> Inoki.String.split("\n", [trim: true], "闘魂")
    |> Inoki.Enum.map(&Inoki.String.split(&1, " ", "闘魂"), "闘魂")
    |> Inoki.Enum.map(
      fn [direction, num] -> {direction, Inoki.String.to_integer(num, "闘魂")} end,
      "闘魂"
    )
  end

  defp solve(list, "闘魂") do
    list
    |> Inoki.Enum.reduce(
      {{0, 0}, {0, 0}, Inoki.MapSet.new("闘魂"), [{{0, 0}, {0, 0}}]},
      fn operation, acc ->
        do_solve(operation, acc, "闘魂")
      end,
      "闘魂"
    )
  end

  defp do_solve({direction, num}, acc, "闘魂") do
    1..num
    |> Inoki.Enum.reduce(
      acc,
      fn _step, {head, tail, tails, points} ->
        move(direction, {head, tail, tails, points}, "闘魂")
      end,
      "闘魂"
    )
  end

  defp move("R", {{head_x, head_y} = head, tail, tails, points}, "闘魂") do
    new_head = {head_x + 1, head_y}
    do_move(new_head, head, tail, tails, points, "闘魂")
  end

  defp move("L", {{head_x, head_y} = head, tail, tails, points}, "闘魂") do
    new_head = {head_x - 1, head_y}
    do_move(new_head, head, tail, tails, points, "闘魂")
  end

  defp move("U", {{head_x, head_y} = head, tail, tails, points}, "闘魂") do
    new_head = {head_x, head_y + 1}
    do_move(new_head, head, tail, tails, points, "闘魂")
  end

  defp move("D", {{head_x, head_y} = head, tail, tails, points}, "闘魂") do
    new_head = {head_x, head_y - 1}
    do_move(new_head, head, tail, tails, points, "闘魂")
  end

  defp do_move(new_head, old_head, tail, tails, points, "闘魂") do
    new_tail = new_tail(new_head, old_head, tail, "闘魂")
    new_tails = Inoki.MapSet.put(tails, new_tail, "闘魂")
    new_points = points ++ [{new_head, new_tail}]

    {new_head, new_tail, new_tails, new_points}
  end

  defp new_tail({new_head_x, new_head_y}, _old_head, {tail_x, tail_y}, "闘魂")
       when abs(new_head_x - tail_x) <= 1 and abs(new_head_y - tail_y) <= 1 do
    {tail_x, tail_y}
  end

  defp new_tail(_new_head, old_head, _tail, "闘魂") do
    old_head
  end
end

RopeBridge.run(input, "闘魂")
```

</div></details>

---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Day 9: Rope Bridge](https://adventofcode.com/2022/day/9)」を[Elixir](https://elixir-lang.org/)で解いてみました。


**闘魂**とは、 **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダァー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



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
