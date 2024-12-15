---
title: 闘魂で挑むAdvent of Code 2024 Day 2── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-14T09:44:53+09:00'
id: ff73c4b079871b788b4c
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

本日は[Day 2: Red-Nosed Reports](https://adventofcode.com/2024/day/2) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。

# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

まず、レポートを解析して安全なレポートの数を数えるための関数を作成します。以下のステップで進めます。

1. 入力データを行ごとに分割します。
1. 各行をスペースで分割して数値のリストに変換します。
1. 各レポートが安全かどうかを判定する関数を作成します。
1. 安全なレポートの数を数えます。

```elixir:advent_of_code_2024_day2_part1.exs
defmodule AdventOfCode2024Day2Part1 do
  def count_safe_reports(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, " ") |> Enum.map(fn x -> String.to_integer(x) end))
    |> Enum.filter(&safe_report?/1)
    |> length()
  end

  defp safe_report?(report) do
    differences = Enum.chunk_every(report, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)
    increasing = Enum.all?(differences, &(&1 in 1..3))
    decreasing = Enum.all?(differences, &(&1 in -3..-1))
    increasing or decreasing
  end
end

# テストデータ
input = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

IO.puts AdventOfCode2024Day2Part1.count_safe_reports(input)
```

このコードでは、count_safe_reports/1関数が入力データを解析し、安全なレポートの数を返します。safe_report?/1関数は各レポートが安全かどうかを判定します。

### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day2_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day2_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

Part 2では、1つのレベルを取り除くことで安全なレポートにできる場合も考慮する必要があります。以下のステップで進めます。

1. 元のレポートが安全かどうかを確認します。
1. 安全でない場合、各レベルを1つずつ取り除いて安全かどうかを確認します。

```elixir:advent_of_code_2024_day2_part2.exs
defmodule AdventOfCode2024Day2Part2 do
  def count_safe_reports(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line -> String.split(line, " ") |> Enum.map(&String.to_integer/1) end)
    |> Enum.filter(&safe_report_with_dampener?/1)
    |> length()
  end

  defp safe_report_with_dampener?(report) do
    safe_report?(report) or Enum.any?(0..(length(report) - 1), fn i ->
      safe_report?(List.delete_at(report, i))
    end)
  end

  defp safe_report?(report) do
    differences = Enum.chunk_every(report, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)
    increasing = Enum.all?(differences, &(&1 in 1..3))
    decreasing = Enum.all?(differences, &(&1 in -3..-1))
    increasing or decreasing
  end
end

# テストデータ
input = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

IO.puts AdventOfCode2024Day2Part2.count_safe_reports(input)
```

このコードでは、safe_report_with_dampener?/1関数が1つのレベルを取り除いた場合の安全性も考慮してレポートが安全かどうかを判定します。

### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day2_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day2_part2.exs"
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

- 今日はAdvent Of Code 2024 Day 2を解いていくよ。手伝ってください。Elixirを使います。問題を載せます。--- Day 2: Red-Nosed Reports --- Fortunately, the first location The Historians want to search isn't a long walk from the Chief Historian's office. (略)
- 概ねいいね。一旦マージするよ。問題をみつけているからそれはまたあとで指摘します。
- 増減幅は1..3や-3..-1 とは限らないはずです。単純にプラスなのかマイナスなのかで判定するとよいでしょう。
- 2回目のEnum.map ではキャプチャを使わずに無名関数で書いてください。
- ちょっと伝わらなかったので自分で書きますね。
- 隣接する 2 つのレベルは、少なくとも 1から最大 3まで異なります。 という条件がありました。元のコードがあっていたね。選択部分を提案してください。
- 合格したよ！　ありがとう！
- Day2 Part2もよろしくたのむよ！ --- Part Two --- The engineers are surprised by the low number of safe reports until they realize they forgot to tell you about the Problem Dampener. (略)
- Part 2も合っています！　ありがとう。あすのDay 3もたのむよ！


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

https://qiita.com/RyoWakabayashi/items/3c3c0710f6a9229f46b0



---


# さいごに

チャットを通じて解答を得るという体験は、単なる効率化ではなく、新たな時代の可能性を示しています。Advent of Codeは、私たちにプログラミングという闘いを通じて、己の技術と精神を磨く場を提供してくれます。そして、GitHub Copilotのような生成AIは、その闘いを支える最強のタッグパートナーです。

しかし、AIが答えを導き出すだけでは不十分です。それをどう解釈し、自分の知識として昇華するかが、私たち人間の使命です。「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」アントニオ猪木さんのこの言葉を胸に、私たちもAIを使いこなし、新たな創造の領域へと挑んでいきましょう。

Advent of Codeは、ただのパズルイベントではありません。未来の私たちが、さらに創造的で価値ある活動に集中するための訓練の場です。この闘魂活動を通じて、AIと人間が共に高め合い、新しい可能性を切り拓いていきましょう。挑戦のその先に、きっと新たな地平が待っています！　アントニオ猪木さんが夢見た「本当の世界平和」を実現させましょう！！！

元氣があれば、なんでもできる！さあ、今すぐAdvent of Codeの闘いに飛び込みましょう！
