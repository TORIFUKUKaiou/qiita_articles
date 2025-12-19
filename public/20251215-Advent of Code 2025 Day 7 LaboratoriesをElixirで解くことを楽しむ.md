---
title: 'Advent of Code 2025 Day 7: LaboratoriesをElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-18T14:35:37+09:00'
id: 1cbf7d6ea9e4f7f82ab3
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 7を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/3ed19d1d7bc10e768f30

[Advent of Code 2025 Day 7: Laboratories をRustで解いた](https://qiita.com/haw_ohnuma/items/3ed19d1d7bc10e768f30)

## Day 7: Laboratories
問題文は、[Day 7: Laboratories](https://adventofcode.com/2025/day/7)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

- 入力を行ごとにcharlistへ変換し、上から順に処理
- Sの位置を見つけ、MapSetでビームの列位置を管理
- 各行で、ビームがスプリッター^に当たったら左右に分岐（i-1とi+1）、元の位置は削除
- MapSetなので同じ列に複数ビームが合流しても1本扱い
- スプリットするたびにカウント+1、最終的なカウントが答え

```elixir
defmodule AdventOfCode2025Day7Part1Solver do
  def solve(list_of_charlists) do
    list_of_charlists
    |> Enum.reduce({nil, 0}, &do_solve/2)
    |> elem(1)
  end

  def do_solve(charlist, {nil, 0}) do
    s_index = Enum.find_index(charlist, & &1 == ?S)
    {MapSet.new([s_index]), 0}
  end

  def do_solve(charlist, {map_set, count}) do
    Enum.reduce(map_set, {map_set, count}, fn i, {acc_map_set, acc_count} ->
      if Enum.at(charlist, i) == ?^ do
        new_map_set = acc_map_set |> MapSet.delete(i) |> MapSet.put(i - 1) |> MapSet.put(i + 1)
        {new_map_set, acc_count + 1}
      else
        {acc_map_set, acc_count}
      end
    end)
  end
end

defmodule AdventOfCode2025Day7Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_charlists), do: AdventOfCode2025Day7Part1Solver.solve(list_of_charlists)

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end
end

input = """
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
"""

AdventOfCode2025Day7Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

- Part 1と同様に上から順に処理するが、MapSetではなくMapで「列位置 => 経路数」を管理
- スプリッター^に当たると世界が分岐し、左右それぞれに経路数を引き継ぐ
- 同じ列に複数経路が合流したら経路数を加算（Map.update）
- 最終行まで処理後、全列の経路数を合計したものが答え（= 粒子が取りうる全経路の数）

```elixir
defmodule AdventOfCode2025Day7Part2Solver do
  def solve(list_of_charlists) do
    list_of_charlists
    |> Enum.reduce(nil, &do_solve/2)
    |> Map.values()
    |> Enum.sum()
  end

  def do_solve(charlist, nil) do
    s_index = Enum.find_index(charlist, & &1 == ?S)
    %{s_index => 1}
  end

  def do_solve(charlist, map) do
    Enum.reduce(map, map, fn {i, count}, acc ->
      if Enum.at(charlist, i) == ?^ do
        acc |> Map.delete(i) |> Map.update(i - 1, count, & &1 + count) |> Map.update(i + 1, count, & &1 + count)
      else
        acc
      end
    end)
  end
end

defmodule AdventOfCode2025Day7Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_charlists), do: AdventOfCode2025Day7Part2Solver.solve(list_of_charlists)

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_charlist/1)
  end
end

input = """
.......S.......
...............
.......^.......
...............
......^.^......
...............
.....^.^.^.....
...............
....^.^...^....
...............
...^.^...^.^...
...............
..^...^.....^..
...............
.^.^.^.^.^...^.
...............
"""

AdventOfCode2025Day7Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
