---
title: 闘魂で挑むAdvent of Code 2024 Day 3── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-14T09:44:31+09:00'
id: 8e49e6ac1aa39f869a84
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

本日は[Day 3: Mull It Over](https://adventofcode.com/2024/day/3) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。

# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

まず、与えられた入力から有効な mul(X,Y) 命令を抽出し、それらの結果を合計する関数を作成します。以下のステップで進めます。

1. 正規表現を使用して有効な mul(X,Y) 命令を抽出します。
1. 抽出した命令から数値を取り出し、掛け算を行います。
1. 結果を合計します。

以下にElixirコードを示します。



```elixir:advent_of_code_2024_day3_part1.exs
defmodule AdventOfCode2024Day3Part1 do
  def sum_valid_multiplications(input) do
    regex = ~r/mul\((\d+),(\d+)\)/

    regex
    |> Regex.scan(input)
    |> Enum.map(fn [_, x, y] -> String.to_integer(x) * String.to_integer(y) end)
    |> Enum.sum()
  end
end

# テストデータ
input = """
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
"""

input
|> AdventOfCode2024Day3Part1.sum_valid_multiplications()
|> IO.puts()
```

このコードでは、sum_valid_multiplications/1 関数が入力データを解析し、有効な mul(X,Y) 命令を抽出してその結果を合計します。正規表現を使用して有効な命令を抽出し、各命令の結果を計算して合計します。


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day3_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day3_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

Part 2では、do() と don't() の指示を処理し、mul 命令が有効か無効かを判断する必要があります。以下のステップで進めます。

1. 入力データをスキャンして、do() と don't() の指示を処理します。
1. mul 命令が有効か無効かを判断し、有効な場合のみ結果を計算します。

以下にElixirコードを示します。


```elixir:advent_of_code_2024_day3_part2.exs
defmodule AdventOfCode2024Day3Part2 do
  def sum_valid_multiplications(input) do
    regex_mul = ~r/mul\((\d+),(\d+)\)/
    regex_do = ~r/do\(\)/
    regex_dont = ~r/don't\(\)/

    input
    |> String.split(~r/(?=mul\(|do\(\)|don't\(\))/)
    |> Enum.reduce({true, 0}, fn segment, {enabled, sum} ->
      cond do
        Regex.match?(regex_do, segment) ->
          {true, sum}

        Regex.match?(regex_dont, segment) ->
          {false, sum}

        enabled and Regex.match?(regex_mul, segment) ->
          [[_, x, y]] = Regex.scan(regex_mul, segment)
          {enabled, sum + String.to_integer(x) * String.to_integer(y)}

        true ->
          {enabled, sum}
      end
    end)
    |> elem(1)
  end
end

# テストデータ
input = """
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
"""

input
|> AdventOfCode2024Day3Part2.sum_valid_multiplications()
|> IO.puts()
```

このコードでは、sum_valid_multiplications/1 関数が入力データを解析し、do() と don't() の指示を処理して mul 命令が有効か無効かを判断します。有効な mul 命令の結果のみを合計します。


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day3_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day3_part2.exs"
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

- Day3 たのんだよ。--- Day 3: Mull It Over --- (略)
- 実行エラーがでました。fixしてください。
- String.scan/2 というのはElixirにはありません。
- 引数の順序が逆です。
- パイプ演算子を使って、書き直してみてください。
- unexpected token: "$" (column 193, code point U+0024) なんだろうね？
- Part2 も頼みます。--- Part Two --- (略)
- 今日も正解を得られました。ありがとう！


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

https://qiita.com/RyoWakabayashi/items/31fb38f1899069a74ecd

---

# GitHub

GitHubにもリポジトリ[livebooks](https://github.com/TORIFUKUKaiou/livebooks)をあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

---


# さいごに

チャットを通じて解答を得るという体験は、単なる効率化ではなく、新たな時代の可能性を示しています。Advent of Codeは、私たちにプログラミングという闘いを通じて、己の技術と精神を磨く場を提供してくれます。そして、GitHub Copilotのような生成AIは、その闘いを支える最強のタッグパートナーです。

しかし、AIが答えを導き出すだけでは不十分です。それをどう解釈し、自分の知識として昇華するかが、私たち人間の使命です。「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」アントニオ猪木さんのこの言葉を胸に、私たちもAIを使いこなし、新たな創造の領域へと挑んでいきましょう。

Advent of Codeは、ただのパズルイベントではありません。未来の私たちが、さらに創造的で価値ある活動に集中するための訓練の場です。この闘魂活動を通じて、AIと人間が共に高め合い、新しい可能性を切り拓いていきましょう。挑戦のその先に、きっと新たな地平が待っています！　アントニオ猪木さんが夢見た「本当の世界平和」を実現させましょう！！！

元氣があれば、なんでもできる！さあ、今すぐAdvent of Codeの闘いに飛び込みましょう！
