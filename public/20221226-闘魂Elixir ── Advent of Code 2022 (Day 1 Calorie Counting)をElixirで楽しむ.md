---
title: '闘魂Elixir ── Advent of Code 2022 (Day 1: Calorie Counting)をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2022-12-30T01:07:23+09:00'
id: fd24ce36eae1358658ad
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>


# はじめに

闘魂と[Elixir](https://elixir-lang.org/)が出会いました。
闘魂 meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

**本日2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 1: Calorie Counting](https://adventofcode.com/2022/day/1)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```



# [Day 1: Calorie Counting](https://adventofcode.com/2022/day/1)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/1

問題を説明します。

```
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
```

上記がインプット例です。
何もない空行のところが区切りで、連続する数字の和の最大のものを答えなさいという問題です。

連続する数字を足してみると、以下のようになります。

```
6000

4000

11000

24000

10000
```

上記インプット例の場合では最大は`24000`で、これが答えとなります。

英語をよく読むと、エルフだとかカロリーだとかいろいろ書いてありますが要はこの記事で書いた通りのことが問題文であります。


# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。


<details><summary>解答例</summary><div>

## 私

```elixir
input = """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""

f = fn 
  "" -> ""
  s -> String.to_integer(s)
end

sum = fn 
  [""] -> 0
  list -> Enum.sum(list)
end

input
|> String.split("\n")
|> Enum.map(f)
|> Enum.chunk_by(& &1 == "")
|> Enum.map(sum)
|> Enum.max()
```


あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



</div></details>



# 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>お便り</summary><div>

## @mnishiguchi さん

@mnishiguchi さんからお便りをいただきました。ありがとうございます！
ポイントは、`\n\n`でスプリットしているところです。

```elixir
input
|> String.split("\n\n", trim: true)
|> Enum.map(fn numbers_str ->
  numbers_str
  |> String.split(~r/\d+\b/, include_captures: true, trim: true)
  |> Enum.filter(&(&1 =~ ~r/\d+/))
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end)
|> Enum.max()
```

## @zacky1972 先生

コメント欄に解答を投稿してくださっています。
先生お得意の並列処理での解法です。

</div></details>

---

# さいごに

**本日2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**
この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Day 1: Calorie Counting](https://adventofcode.com/2022/day/1)」を[Elixir](https://elixir-lang.org/)で解いてみました。


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






---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダー！}$</font></b>
