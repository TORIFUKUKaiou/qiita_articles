---
title: 'Advent of Code 2025 Day 3: Lobby をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-08T21:28:41+09:00'
id: 3e2474bab10c21bd4fd5
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 3を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/2fe92f55d2608d545248

[Advent of Code 2025 Day 3: Lobby をRustで解いた](https://qiita.com/haw_ohnuma/items/2fe92f55d2608d545248)

## Day 3: Lobby
問題文は、[Day 3: Lobby](https://adventofcode.com/2025/day/3)を読んでください。  
Part 1を汎用的につくれば、Part 2も解ける形です。私にとっては解きやすかったです。これまでのところDay 1が一番苦戦しました。個人の感想です。

私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

各行の数字列から「2桁の数」を作ります。ルールは：
- **十の位**: 最後の1文字を除いた範囲から最大値を選ぶ
- **一の位**: 十の位で選んだ位置より右側から最大値を選ぶ

全行の合計が答えです。

```elixir
defmodule AdventOfCode2025Day3Part1Solver do
  def run(list_of_lists) do
    list_of_lists
    |> Enum.reduce(0, fn list, acc ->
      upper = Enum.slice(list, 0..-2//1) |> Enum.max()
      uppser_index = Enum.find_index(list, & &1 == upper)
      lower = Enum.slice(list, (uppser_index + 1)..-1//1) |> Enum.max()

      acc + upper * 10 + lower
    end)
  end
end

defmodule AdventOfCode2025Day3Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_lists) do
    AdventOfCode2025Day3Part1Solver.run(list_of_lists)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
  end

  defp parse(line) do
    line
    |> String.to_charlist()
    |> Enum.map(& &1 - ?0)
  end
end

input = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

AdventOfCode2025Day3Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

各行の数字列から「12桁の数」を作ります。ルールは：
- **最上位桁**: 最後の11文字を除いた範囲から最大値を選ぶ
- **次の桁**: 前の桁で選んだ位置より右側（かつ残り桁数分を確保）から最大値を選ぶ
- これを12回繰り返す

全行の合計が答えです。

Part 1の2桁版を12桁に拡張した問題。12..1//-1 で桁数をカウントダウンしながら、各桁の最大値とそのインデックスを追跡しています。

```elixir
defmodule AdventOfCode2025Day3Part2Solver do
  def run(list_of_lists) do
    list_of_lists
    |> Enum.reduce(0, fn list, acc ->
      12..1//-1
      |> Enum.reduce({0, -1}, 
        fn i, {acc, index} ->
          {max, new_index} = Enum.slice(list, (index + 1)..-i//1) |> find_max()
          {(10 ** (i - 1)) * max + acc, new_index + index + 1} 
      end)
      |> elem(0)
      |> Kernel.+(acc)
    end)
    
  end

  defp find_max(list) do
    max = Enum.max(list)
    index = Enum.find_index(list, & &1 == max)
    {max, index}
  end
end

defmodule AdventOfCode2025Day3Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_lists) do
    AdventOfCode2025Day3Part2Solver.run(list_of_lists)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
  end

  defp parse(line) do
    line
    |> String.to_charlist()
    |> Enum.map(& &1 - ?0)
  end
end

input = """
987654321111111
811111111111119
234234234234278
818181911112111
"""

AdventOfCode2025Day3Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
