---
title: 闘魂で挑むAdvent of Code 2024 Day 4── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-14T09:44:09+09:00'
id: 9037a3bb0efd68c9ecc8
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

本日は[Day 4: Ceres Search](https://adventofcode.com/2024/day/4) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。

:::note alert
記事執筆時点で、筆者は問題文の意味をよくわかっておりません。よってコードが何をしているのかをさっぱり理解していません。記事を書いてから理解したいと思っています(あくまでも思っています)。新しい感覚です。愛を感じます。
:::

:::note warn
うしろに載せた @RyoWakabayashi さんの記事もよくみて、理解をしたいと思っています（あくまでも思っています）。
不思議な感じです。意味もわからないのにチャットだけで正解コードを手に入れてしまいました。
:::


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

まず、与えられた文字列から "XMAS" をすべての方向（水平、垂直、斜め、逆方向）で見つける関数を作成します。以下のステップで進めます。

1. 入力データを行ごとに分割します。
1. 各行、列、斜め方向に "XMAS" を検索します。
1. 見つかった "XMAS" の数を合計します。

以下にElixirコードを示します。


```elixir:advent_of_code_2024_day4_part1.exs
defmodule AdventOfCode2024Day4Part1 do
  def count_xmas(input) do
    grid = parse_input(input)
    directions = [
      {1, 0},  # 水平
      {0, 1},  # 垂直
      {1, 1},  # 斜め（右下）
      {1, -1}, # 斜め（右上）
      {-1, 0}, # 水平（逆）
      {0, -1}, # 垂直（逆）
      {-1, -1},# 斜め（左上）
      {-1, 1}  # 斜め（左下）
    ]

    Enum.reduce(0..(length(grid) - 1), 0, fn row, acc ->
      Enum.reduce(0..(length(grid) - 1), acc, fn col, acc2 ->
        acc2 + Enum.reduce(directions, 0, fn {dx, dy}, acc3 ->
          acc3 + if match_xmas?(grid, row, col, dx, dy), do: 1, else: 0
        end)
      end)
    end)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp match_xmas?(grid, row, col, dx, dy) do
    word = "XMAS"
    Enum.all?(0..3, fn i ->
      r = row + i * dx
      c = col + i * dy
      r >= 0 and r < length(grid) and c >= 0 and c < length(grid) and Enum.at(grid, r) |> Enum.at(c) == String.at(word, i)
    end)
  end
end

# テストデータ
input = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""

input
|> AdventOfCode2024Day4Part1.count_xmas()
|> IO.puts()
```

このコードでは、count_xmas/1 関数が入力データを解析し、すべての方向で "XMAS" を検索してその数を返します。parse_input/1 関数は入力データを行ごとに分割し、match_xmas?/5 関数は指定された方向に "XMAS" が存在するかどうかを確認します。


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day4_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day4_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

Part 2では、"X-MAS" の形で2つの "MAS" を見つける必要があります。各 "MAS" は前後どちらの向きでも構いません。以下のコードで解決します。

```elixir:advent_of_code_2024_day4_part2.exs
defmodule AdventOfCode2024Day4Part2 do
  def count_xmas(input) do
    grid = parse_input(input)
    size = length(grid)

    Enum.reduce(1..(size - 2), 0, fn row, acc ->
      Enum.reduce(1..(size - 2), acc, fn col, acc2 ->
        acc2 + if match_x_mas?(grid, row, col), do: 1, else: 0
      end)
    end)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp match_x_mas?(grid, row, col) do
    mas_variants = [["M", "A", "S"], ["S", "A", "M"]]

    Enum.any?(mas_variants, fn mas1 ->
      Enum.any?(mas_variants, fn mas2 ->
        match_arms?(grid, row, col, mas1, mas2)
      end)
    end)
  end

  defp match_arms?(grid, row, col, mas1, mas2) do
    [mas1_positions, mas2_positions] = [
      [{-1, -1}, {0, 0}, {1, 1}],
      [{-1, 1}, {0, 0}, {1, -1}]
    ]

    match_arm?(grid, row, col, mas1, mas1_positions) and
      match_arm?(grid, row, col, mas2, mas2_positions)
  end

  defp match_arm?(grid, row, col, [m, a, s], deltas) do
    Enum.zip([m, a, s], deltas)
    |> Enum.all?(fn {char, {dx, dy}} ->
      x = row + dx
      y = col + dy
      in_bounds?(grid, x, y) and Enum.at(grid, x) |> Enum.at(y) == char
    end)
  end

  defp in_bounds?(grid, x, y) do
    x >= 0 and y >= 0 and x < length(grid) and y < length(Enum.at(grid, 0))
  end
end

# 使用例
input = """
MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX
"""

input
|> AdventOfCode2024Day4Part2.count_xmas()
|> IO.puts()
```

このコードでは、グリッドの各位置で "X-MAS" パターンをチェックし、見つかった数をカウントしています。

### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day4_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day4_part2.exs"
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

- Day 4よろしく。--- Day 4: Ceres Search --- "Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!(略)
- Part 2もたのむよ。--- Part Two --- The Elf looks quizzically at you. Did you misunderstand the assignment?(略)


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

https://qiita.com/RyoWakabayashi/items/53012bffad0de552ce8d


https://qiita.com/RyoWakabayashi/items/1cf1f65e6cd394ada32d

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
