---
title: 'Advent of Code 2025 Day 8: PlaygroundをElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-25T09:42:23+09:00'
id: 379c98472fe8cb25d8a3
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 8を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/87ab951d706511776ccc

[Advent of Code 2025 Day 8: Playground をRustで解いた](https://qiita.com/haw_ohnuma/items/87ab951d706511776ccc)

## Day 8: Playground
問題文は、[Day 8: Playground](https://adventofcode.com/2025/day/8)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

- 3D空間のジャンクションボックス（接続箱）を、距離が近い順にn回繋いでいく
- 全ペアの二乗距離を計算しソート
- Union-Find的にMapSetでグループ管理：
  - 両方が別グループ → 合体（MapSet.union）
  - 片方だけグループにいる → そこに追加
  - どちらもいない → 新規グループ作成
- n回接続後、グループサイズ上位3つの積が答え


```elixir
defmodule Awesome do
  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end

defmodule AdventOfCode2025Day8Part1Solver do
  def run(list_of_lists, n) do
    sorted_list_of_lists = sort(list_of_lists)
    Enum.at(sorted_list_of_lists, -1)

    0..(n - 1)
    |> Enum.reduce([], fn i, acc ->
      [point1, point2] = Enum.at(sorted_list_of_lists, i)

      index1 = Enum.find_index(acc, fn set -> point1 in set end)
      index2 = Enum.find_index(acc, fn set -> point2 in set end)

      cond do
        index1 && index2 && index1 != index2 ->
          # 両方別グループにいる → 合体
          set1 = Enum.at(acc, index1)
          set2 = Enum.at(acc, index2)
          merged = MapSet.union(set1, set2)
          acc |> List.delete_at(max(index1, index2)) |> List.delete_at(min(index1, index2)) |> then(&[merged | &1])
  
        index1 ->
          List.update_at(acc, index1, &MapSet.put(&1, point2))
  
        index2 ->
          List.update_at(acc, index2, &MapSet.put(&1, point1))
  
        true ->
          [MapSet.new([point1, point2]) | acc]
      end
    end)
    |> Enum.sort_by(&Enum.count/1, :desc)
    |> Enum.take(3)
    |> Enum.map(&Enum.count/1)
    |> Enum.product()
  end

  defp sort(list_of_lists) do
    list_of_lists
    |> Awesome.combination(2)
    |> Enum.sort_by(fn points ->
      Enum.zip_with(points, fn [a, b] -> (a - b) ** 2 end)
      |> Enum.sum()
    end)
  end
end

defmodule AdventOfCode2025Day8Part1 do
  def run(input, n \\ 1000) do
    input
    |> parse_input()
    |> solve(n)
  end

  defp solve(list_of_lists, n) do
    AdventOfCode2025Day8Part1Solver.run(list_of_lists, n)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end

input = """
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
"""

AdventOfCode2025Day8Part1.run(input, 10)
```
</details>

### Part 2

<details><summary>Part 2</summary>

- 全箱が1つの回路になるまで繋ぎ続ける
- 初期状態で全箱を個別のMapSetとして用意（Enum.map(list, &MapSet.new([&1]))）
- 距離が近い順に合体していき、グループ数が1になった瞬間でreduce_whileを停止
- 最後に繋いだペアのX座標同士の積が答え


```elixir
defmodule AdventOfCode2025Day8Part2Solver do
  def run(list_of_lists) do
    acc = Enum.map(list_of_lists, & MapSet.new([&1]))

    list_of_lists
    |> sort()
    |> Enum.reduce_while({acc, nil}, fn [point1, point2], {acc, nil} ->

      index1 = Enum.find_index(acc, fn set -> point1 in set end)
      index2 = Enum.find_index(acc, fn set -> point2 in set end)

      cond do
        index1 && index2 && index1 != index2 ->
          # 両方別グループにいる → 合体
          set1 = Enum.at(acc, index1)
          set2 = Enum.at(acc, index2)
          merged = MapSet.union(set1, set2)
          new_acc = acc |> List.delete_at(max(index1, index2)) |> List.delete_at(min(index1, index2)) |> then(&[merged | &1])

          if Enum.count(new_acc) == 1 do
            [x1, _, _] = point1
            [x2, _, _] = point2
            {:halt, {new_acc, x1 * x2}}
          else
            {:cont, {new_acc, nil}}
          end

        index1 ->
          {:cont, {List.update_at(acc, index1, &MapSet.put(&1, point2)), nil}}
  
        index2 ->
          {:cont, {List.update_at(acc, index2, &MapSet.put(&1, point1)), nil}}
      end
    end)
    |> elem(1)
  end

  defp sort(list_of_lists) do
    list_of_lists
    |> Awesome.combination(2)
    |> Enum.sort_by(fn points ->
      Enum.zip_with(points, fn [a, b] -> (a - b) ** 2 end)
      |> Enum.sum()
    end)
  end
end

defmodule AdventOfCode2025Day8Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_lists) do
    AdventOfCode2025Day8Part2Solver.run(list_of_lists)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end
end

input = """
162,817,812
57,618,57
906,360,560
592,479,940
352,342,300
466,668,158
542,29,236
431,825,988
739,650,466
52,470,668
216,146,977
819,987,18
117,168,530
805,96,715
346,949,466
970,615,88
941,993,340
862,61,35
984,92,344
425,690,689
"""

AdventOfCode2025Day8Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
