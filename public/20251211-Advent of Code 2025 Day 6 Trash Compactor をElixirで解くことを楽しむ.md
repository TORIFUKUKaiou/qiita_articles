---
title: 'Advent of Code 2025 Day 6: Trash Compactor をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-25T09:43:14+09:00'
id: e6fe419ab7f8929eb737
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 6を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/e3a2e48fcae28e139aa5

[Advent of Code 2025 Day 6: Trash Compactor をRustで解いた](https://qiita.com/haw_ohnuma/items/e3a2e48fcae28e139aa5)

## Day 6: Trash Compactor
問題文は、[Day 6: Trash Compactor](https://adventofcode.com/2025/day/6)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

入力例：
```
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
```


最終行が演算子（* or +）、それ以外が数値の行列。各列ごとに縦方向の数値を集め、対応する演算
子で計算。1列目は 123*45*6=33210、2列目は 328+64+98=490。全列の結果を足し合わせて答え。


```elixir
defmodule AdventOfCode2025Day6Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve({operations, list_of_lists}) do
    0..(Enum.count(operations) - 1)
    |> Enum.reduce(0, fn i, acc ->
      numbers = 0..(Enum.count(list_of_lists) - 1)
      |> Enum.map(fn j ->
        list_of_lists |> Enum.at(j) |> Enum.at(i)
      end)

      if Enum.at(operations, i) == "+" do
        Enum.sum(numbers) + acc
      else
        Enum.product(numbers) + acc
      end
    end)
  end

  defp parse_input(input) do
    [operations | numbers] = input
    |> String.split("\n", trim: true)
    |> Enum.reverse()

    operations = String.split(operations, " ", trim: true)

    list_of_lists = Enum.reduce(numbers, [], fn line, acc ->
      list = line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer/1)

      [list | acc]
    end)

    {operations, list_of_lists}
  end
end

input = """
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
"""

AdventOfCode2025Day6Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

入力例：
```
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
```

- 入力は最終行に演算子（*/+）、その上に数字が並ぶ表を想定し、行末の空白も含めてトリムせずに処理します
- parse_input/1で最終行の演算子を分離し、残りの行を列単位で縦読みして整数リストの配列に組み立てます（空白列は区切り扱い）
- 縦読み時は各列を上から下へ読み込み、スペースを除外してList.to_integer/1で数値化。空白列が現れるまでの数値を1グループとしてまとめます
- solve/1では演算子リストと数値リストをEnum.zip/2で対応付け、*ならその列の積、+なら和を取り、すべて合計して結果を返します。


```elixir
defmodule AdventOfCode2025Day6Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve({operations, list_of_lists}) do
    Enum.zip(operations, list_of_lists)
    |> Enum.reduce(0, fn 
      {"*", list}, acc -> acc + Enum.product(list)
      {"+", list}, acc -> acc + Enum.sum(list)
    end)
  end

  defp parse_input(input) do
    [operations | numbers] = input
    |> String.split("\n", trim: true)
    |> Enum.reverse()

    operations = String.split(operations, " ", trim: true)

    chunk_fun = fn charlist, acc ->
      if Enum.all?(charlist, & &1 == ?\s) do
        {:cont, acc, []}
      else
        num = charlist |> Enum.reject(& &1 == ?\s) |> List.to_integer()
        {:cont, [num | acc]}
      end
    end

    after_fun = fn
      acc -> {:cont, acc, []}
    end

    list_of_lists = 
      numbers 
      |> Enum.reverse() 
      |> Enum.map(&String.to_charlist/1)
      |> Enum.zip_with(& &1)
      |> Enum.chunk_while([], chunk_fun, after_fun)

    {operations, list_of_lists}
  end
end

input = """
123 328  51 64 
 45 64  387 23 
  6 98  215 314
*   +   *   +  
"""

AdventOfCode2025Day6Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
