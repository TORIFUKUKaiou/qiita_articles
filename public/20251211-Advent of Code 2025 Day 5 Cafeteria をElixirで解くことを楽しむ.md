---
title: 'Advent of Code 2025 Day 5: Cafeteria をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-11T08:53:41+09:00'
id: 52fa3cc49068dd6e48e5
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 5を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/9a2ae842958095dc9a53

[Advent of Code 2025 Day 5: Cafeteria をRustで解いた](https://qiita.com/haw_ohnuma/items/9a2ae842958095dc9a53)

## Day 4: Day 5: Cafeteria 
問題文は、[Day 5: Cafeteria ](https://adventofcode.com/2025/day/5)を読んでください。  
Part 1は割とすんなりできました。Part 2は簡単に書けた解法では、本番データでは結果がなかなかでてこなかったので一工夫してみました。


私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

- 入力を「範囲リスト」と「IDリスト」にパース。各IDが範囲のいずれかに含まれるかを`Enum.any?`でチェック
- `id in range`で`Range`内判定し、含まれるIDの数をカウントして答えとする
- 正規表現の名前付きキャプチャで範囲の開始・終了を抽出している


```elixir
defmodule AdventOfCode2025Day5Part1 do
  def run(input) do
    input
    |> parse_input()
    |> do_solve()
  end

  defp do_solve({ids, ranges}) do
    ids
    |> Enum.reduce(0, fn id, acc ->
      Enum.any?(ranges, fn range ->
        id in range
      end)
      |> if(do: acc + 1, else: acc)
    end)
  end

  defp parse_input(input) do
    [
      ranges,
      [""],
      ids,
      [""]
    ] = input
        |> String.split("\n")
        |> Enum.chunk_by(& &1 == "")
    
    ranges = Enum.map(ranges, fn range ->
              %{"first" => first, "last" => last} = Regex.named_captures(~r/(?<first>\d*)-(?<last>\d*)/, range)
              Range.new(String.to_integer(first), String.to_integer(last))
             end)
  
    ids = Enum.map(ids, &String.to_integer/1)
    
    {ids, ranges}
  end
end

test = """
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

AdventOfCode2025Day5Part1.run(test)
```
</details>

### Part 2

<details><summary>Part 2</summary>

- 重なり合う範囲をマージして、最終的な範囲の合計サイズを求める
- `Range.disjoint?`で重なり判定し、重なる範囲があれば`min..max`で統合
- 重なりがなくなるまで再帰的にマージを繰り返し、全範囲の`Range.size`の合計が答え

当初は、`MapSet`に数字を展開して格納することを繰り返すプログラムを書きました。短いテストデータでは答えをだせたのですが、データ量が大きくなるとElixirではこういう操作は性能が悪いのでなかなか実行がおわりませんでした。それで発想をかえて、範囲どうしをマージすることを繰り返す解法にしてみました。



```elixir
defmodule AdventOfCode2025Day5Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve({_ids, ranges}) do
    do_solve(ranges, 0, ranges)
    |> Enum.map(&Range.size/1)
    |> Enum.sum()
  end

  defp do_solve([], _offset, ranges), do: ranges

  defp do_solve([head | tail], offset, ranges) do
    if Enum.all?(tail, fn range -> Range.disjoint?(head, range) end) do
      do_solve(tail, offset + 1, ranges)
    else
      index = Enum.find_index(tail, fn range -> Range.disjoint?(head, range) == false end) + 1 + offset
      f1..l1//_ = Enum.at(ranges, index)
      f2..l2//_ = head
      new_ranges = List.replace_at(ranges, index, min(f1, f2)..max(l1, l2)) |> List.delete_at(offset)
      do_solve(new_ranges, 0, new_ranges)
    end
  end

  defp parse_input(input) do
    [
      ranges,
      [""],
      ids,
      [""]
    ] = input
        |> String.split("\n")
        |> Enum.chunk_by(& &1 == "")
    
    ranges = Enum.map(ranges, fn range ->
              %{"first" => first, "last" => last} = Regex.named_captures(~r/(?<first>\d*)-(?<last>\d*)/, range)
              Range.new(String.to_integer(first), String.to_integer(last))
             end)
  
    ids = Enum.map(ids, &String.to_integer/1)
    
    {ids, ranges}
  end
end

test = """
3-5
10-14
16-20
12-18

1
5
8
11
17
32
"""

AdventOfCode2025Day5Part2.run(test)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
