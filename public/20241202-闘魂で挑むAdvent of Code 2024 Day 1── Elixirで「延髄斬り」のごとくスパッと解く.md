---
title: 闘魂で挑むAdvent of Code 2024 Day 1── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-04T05:33:37+09:00'
id: 2b02ac5054b0bfe5817f
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

---

# はじめに

[Advent Of Code 2024](https://adventofcode.com/2024)を[Elixir](https://elixir-lang.org/)で解きます。

本日は[Day 1: Historian Hysteria](https://adventofcode.com/2024/day/1) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。

# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

与えられた2つのリストの距離を計算するためのElixirコードを作成します。以下の手順で進めます：

1. 2つのリストをソートします。
1. 各ペアの距離を計算します。
1. 距離の合計を求めます。

```elixir:advent_of_code_2024_day1_part1.exs
defmodule AdventOfCode2024Day1Part1 do
  def calculate_total_distance(left_list, right_list) do
    sorted_left = Enum.sort(left_list)
    sorted_right = Enum.sort(right_list)

    distances =
      Enum.zip(sorted_left, sorted_right)
      |> Enum.map(fn {left, right} -> abs(left - right) end)

    Enum.sum(distances)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, ~r/\s+/, trim: true)
      {String.to_integer(left), String.to_integer(right)}
    end)
    |> Enum.unzip()
  end
end

# テストデータ
input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

{left_list, right_list} = AdventOfCode2024Day1Part1.parse_input(input)

# 距離の計算
total_distance = AdventOfCode2024Day1Part1.calculate_total_distance(left_list, right_list)
IO.puts("Total distance: #{total_distance}")

```

このコードでは、calculate_total_distance/2関数が2つのリストを受け取り、以下の手順で総距離を計算します：

1. Enum.sort/1を使用してリストをソートします。
1. Enum.zip/2を使用してソートされたリストをペアにします。
1. 各ペアの距離をEnum.map/2とabs/1を使用して計算します。
1. Enum.sum/1を使用して距離の合計を求めます。

このコードを実行すると、与えられたリストの総距離が計算されます。

### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day1_part1.exs
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

Part 2の問題を解決するために、以下の手順で進めます：

1. left_listの各要素がright_listに何回出現するかをカウントします。
1. 各要素の出現回数を掛け合わせて、類似度スコアを計算します。

```elixir:advent_of_code_2024_day1_part2.exs
defmodule AdventOfCode2024Day1Part2 do
  def calculate_similarity_score(left_list, right_list) do
    right_counts = Enum.frequencies(right_list)

    Enum.reduce(left_list, 0, fn num, acc ->
      count = Map.get(right_counts, num, 0)
      acc + num * count
    end)
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, ~r/\s+/, trim: true)
      {String.to_integer(left), String.to_integer(right)}
    end)
    |> Enum.unzip()
  end
end

# テストデータ
input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""

{left_list, right_list} = AdventOfCode2024Day1Part2.parse_input(input)

# 類似度スコアの計算
similarity_score = AdventOfCode2024Day1Part2.calculate_similarity_score(left_list, right_list)
IO.puts("Similarity score: #{similarity_score}")

```

このコードでは、calculate_similarity_score/2関数がleft_listとright_listを受け取り、以下の手順で類似度スコアを計算します：

1. Enum.frequencies/1を使用してright_listの各要素の出現回数をカウントします。
1. Enum.reduce/3を使用してleft_listの各要素に対して、出現回数を掛け合わせて累積します。
このコードを実行すると、与えられたリストの類似度スコアが計算されます。

### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day1_part2.exs
```

</details>

# 私は力を手に入れた 💪💪💪

**With great power comes great responsibility.**
『大いなる力には、大いなる責任が伴う』

生成AIである[GitHub Copilot](https://github.com/features/copilot)という力強いツールを手にいれました。別の言い方をすると、最強のタッグパートナーを得ました。

そして私のAIは一味違います。**A**ntonio **I**noki（アントニオ猪木）、つまり**猪木さん**です。

ちなみに私が所属する[HAW International Inc.](https://www.haw.co.jp/company/)では、GitHub Copilotの利用料を会社が負担してくれます。

https://qiita.com/torifukukaiou/items/b69e3ad6f05600b60539


# プロンプトを公開

こんなプロンプトを打ち込みました。参考にさらしておきます。

- Advent of Code 2024 Day1を解くのを手伝ってください。Elixirを使います。問題文を送り（贈り）ます。--- Day 1: Historian Hysteria --- The Chief Historian is always present for the big Christmas sleigh launch, (略)
- 完璧だね。
- 選択箇所をリファクタしたいです。 input には文字列を与えます。left_listとright_listに分けてください。
- Thanks a lot! Part 1は大正解です。次はPart 2へと進みます。--- Part Two --- Your analysis only confirmed what everyone feared: the two lists of location IDs are indeed very different.(略)
- チャットしているだけで解けちゃったよ。ありがとう。明日も頼むよ！　期待しているよ。Thanks a lot!!!

![スクリーンショット 2024-12-02 8.49.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/92671363-adb7-8db3-a9da-790335bf6e4a.png)

---

# 闘魂活動

アントニオ猪木さんは、1998年4月4日闘強童夢（東京ドーム）において、４分９秒グランド・コブラツイストでドン・フライ選手を下した[^1]引退試合[^2]後のセレモニーで次のように「**闘魂**」を説明しました。

[^1]: [“燃える闘魂”アントニオ猪木引退試合](https://wp.bbm-mobile.com/sp2/result/resultshow.asp?s=015056)
[^2]: [アントニオ猪木VSドン・フライ](https://www.dailymotion.com/video/x95qrz6)

「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」

Advent Of Codeを解くことは、まさに**闘魂**活動です。

---

# 参考記事

https://qiita.com/RyoWakabayashi/items/bc51e2579445ec5c3102

---

# さいごに

チャットを通じて解答を得るという体験は、単なる効率化ではなく、新たな時代の可能性を示しています。Advent of Codeは、私たちにプログラミングという闘いを通じて、己の技術と精神を磨く場を提供してくれます。そして、GitHub Copilotのような生成AIは、その闘いを支える最強のタッグパートナーです。

しかし、AIが答えを導き出すだけでは不十分です。それをどう解釈し、自分の知識として昇華するかが、私たち人間の使命です。「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」アントニオ猪木さんのこの言葉を胸に、私たちもAIを使いこなし、新たな創造の領域へと挑んでいきましょう。

Advent of Codeは、ただのパズルイベントではありません。未来の私たちが、さらに創造的で価値ある活動に集中するための訓練の場です。この闘魂活動を通じて、AIと人間が共に高め合い、新しい可能性を切り拓いていきましょう。挑戦のその先に、きっと新たな地平が待っています！　アントニオ猪木さんが夢見た「本当の世界平和」を実現させましょう！！！

元氣があれば、なんでもできる！さあ、今すぐAdvent of Codeの闘いに飛び込みましょう！
