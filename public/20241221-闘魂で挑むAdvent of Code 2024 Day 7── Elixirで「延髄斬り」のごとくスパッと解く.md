---
title: 闘魂で挑むAdvent of Code 2024 Day 7── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-24T09:38:45+09:00'
id: 99abccaab0b1807aee8a
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

本日は[Day 7: Bridge Repair](https://adventofcode.com/2024/day/7) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

`o1(preview)`

以下の手順で問題を解決します。

1. 入力を解析し、テスト値と数値リストを抽出します。
2. 各方程式について、すべての演算子の組み合わせ（+ と *）を生成します。
3. 左から順に評価し、テスト値と一致するか確認します。
4. テスト値と一致する方程式のテスト値を合計します。


以下にElixirコードを示します。


```elixir:advent_of_code_2024_day7_part1.exs
defmodule AdventOfCode2024Day7Part1 do
  def total_calibration_result(input) do
    input
    |> parse_input()
    |> Enum.filter(fn {target, numbers} ->
      valid_equation?(target, numbers)
    end)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, ":")
      target = String.trim(left) |> String.to_integer()
      numbers = String.split(right) |> Enum.map(&String.to_integer/1)
      {target, numbers}
    end)
  end

  defp valid_equation?(target, numbers) do
    operators = [:+, :*]

    operator_permutations(length(numbers) - 1, operators)
    |> Enum.any?(fn ops ->
      evaluate_expression(numbers, ops) == target
    end)
  end

  defp operator_permutations(0, _operators), do: [[]]

  defp operator_permutations(n, operators) do
    for op <- operators,
        rest <- operator_permutations(n - 1, operators) do
      [op | rest]
    end
  end

  defp evaluate_expression([first | rest_numbers], operators) do
    Enum.zip(rest_numbers, operators)
    |> Enum.reduce(first, fn {num, op}, acc ->
      apply_operation(acc, op, num)
    end)
  end

  defp apply_operation(a, :+, b), do: a + b
  defp apply_operation(a, :*, b), do: a * b
end

# 使用例
input = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""

input |> AdventOfCode2024Day7Part1.total_calibration_result() |> IO.puts()
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day7_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day7_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

`o1(preview)`

Part 2では、新たに連結演算子 `||` が追加されます。連結演算子は左辺と右辺の数字を結合して1つの数値にします。例えば、`12 || 345` は `12345` になります。演算の評価順序は引き続き左から順です。

これにより、連結演算子を含めた3つの方程式が新たに可能になります。

**手順**

1. 入力を解析して、テスト値と数値リストを抽出します。
2. 各方程式について、すべての演算子の組み合わせ（`+`、`*`、`||`）を生成します。
3. 演算子の組み合わせごとに、左から順に評価し、テスト値と一致するか確認します。
4. テスト値と一致する方程式のテスト値を合計します。

```elixir:advent_of_code_2024_day7_part2.exs
defmodule AdventOfCode2024Day7Part2 do
  def total_calibration_result(input) do
    input
    |> parse_input()
    |> Enum.filter(fn {target, numbers} ->
      valid_equation?(target, numbers)
    end)
    |> Enum.map(fn {target, _} -> target end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      [left, right] = String.split(line, ":")
      target = String.trim(left) |> String.to_integer()
      numbers = String.split(right) |> Enum.map(&String.to_integer/1)
      {target, numbers}
    end)
  end

  defp valid_equation?(target, numbers) do
    operators = [:+, :*, :||]

    operator_permutations(length(numbers) - 1, operators)
    |> Enum.any?(fn ops ->
      evaluate_expression(numbers, ops) == target
    end)
  end

  defp operator_permutations(0, _operators), do: [[]]

  defp operator_permutations(n, operators) do
    for op <- operators,
        rest <- operator_permutations(n - 1, operators) do
      [op | rest]
    end
  end

  defp evaluate_expression([first | rest_numbers], operators) do
    Enum.zip(rest_numbers, operators)
    |> Enum.reduce(first, fn {num, op}, acc ->
      apply_operation(acc, op, num)
    end)
  end

  defp apply_operation(a, :+, b), do: a + b
  defp apply_operation(a, :*, b), do: a * b
  defp apply_operation(a, :||, b) do
    String.to_integer("#{a}#{b}")
  end
end

# 使用例
input = """
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
"""

input |> AdventOfCode2024Day7Part2.total_calibration_result() |> IO.inspect()
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day7_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day7_part2.exs"
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

- --- Day 7: Bridge Repair --- The Historians take you to a familiar rope bridge over a river in the middle of a jungle. The Chief isn't on this side of the bridge, though; maybe he's on the other side?（略）
- --- Part Two --- (略)


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

https://qiita.com/RyoWakabayashi/items/bcb5bba71f3a06e79c52

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
