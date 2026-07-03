---
title: 'Advent of Code 2025 Day 4: Printing Department をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-25T09:43:30+09:00'
id: 6eb8ced44e26b6a7dcca
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 4を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/f96ed31dd49717ae336b

[Advent of Code 2025 Day 4: Printing Department をRustで解いた](https://qiita.com/haw_ohnuma/items/f96ed31dd49717ae336b)

## Day 4: Printing Department
問題文は、[Day 4: Printing Department](https://adventofcode.com/2025/day/4)を読んでください。  
Part 1を汎用的につくれば、Part 2も解ける形です。私にとっては解きやすかったです。これまでのところDay 1が一番苦戦しました。個人の感想です。

eight adjacent positions = 8マス隣接。
これの意味がわかりませんでした。これがわかってからはすんなり解けました。以下の図ではっきりわかりました💡 Don't think. Feelです。

```
↖ ↑ ↗
← @ →
↙ ↓ ↘
```


私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

- グリッド上の各@（紙ロール）について、周囲8マスにある@の数をカウント
- 4個未満ならフォークリフトがアクセス可能としてカウントする
- reduce_whileで4個以上見つかった時点で早期終了し、効率化している


```elixir
defmodule AdventOfCode2025Day4Part1Solver do
  def solve(map) do
    map
    |> Enum.reduce({0, map}, &fun/2)
    |> elem(0)
  end

  def fun({{_i, _j}, ?.}, {acc, map}), do: {acc, map}
  def fun({{i, j}, ?@}, {acc, map}) do
    directions = [
      {-1, -1}, {0, -1}, {1, -1},
      {-1,  0},          {1,  0},
      {-1,  1}, {0,  1}, {1,  1}
    ]

    new_acc = directions
    |> Enum.reduce_while(0, fn {x, y}, cnt ->
      v = Map.get(map, {i + x, j + y}, ?.)
      
      (if v == ?@, do: cnt + 1, else: cnt)
      |> do_fun()
    end)
    |> Kernel.<(4)
    |> if(do: acc + 1, else: acc)

    {new_acc, map}
  end

  defp do_fun(new_cnt) when new_cnt >= 4, do: {:halt, new_cnt}
  defp do_fun(new_cnt), do: {:cont, new_cnt}
end

defmodule AdventOfCode2025Day4Part1 do
  def run(input) do
    input
    |> parse_input()
    |> AdventOfCode2025Day4Part1Solver.solve()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.put(acc, {i, j}, c)
      end)
    end)
  end
end

input = """
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

AdventOfCode2025Day4Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

- Part 1のロジックを繰り返し適用する。アクセス可能なロールを見つけたら?xでマークして削除扱いにし、再度チェック
- ロールが減ると周囲の密度が下がり、新たにアクセス可能になるロールが出現する
- 削除対象がなくなるまで再帰し、累積削除数が答え

```elixir
defmodule AdventOfCode2025Day4Part2Solver do
  def solve(map) do
    do_solve(map, 0)
  end

  defp do_solve(map, cnt) do
    removes = map |> Enum.reduce({[], map}, &fun/2) |> elem(0)
    if Enum.count(removes) == 0 do
      cnt
    else
      new_cnt = cnt + Enum.count(removes)
      new_map = removes
        |> Enum.reduce(map, fn {i, j}, acc ->
          Map.put(acc, {i, j}, ?x)
        end)

      do_solve(new_map, new_cnt)
    end
  end

  defp fun({{_i, _j}, ?.}, {acc, map}), do: {acc, map}
  defp fun({{_i, _j}, ?x}, {acc, map}), do: {acc, map}
  defp fun({{i, j}, ?@}, {acc, map}) do
    directions = [
      {-1, -1}, {0, -1}, {1, -1},
      {-1,  0},          {1,  0},
      {-1,  1}, {0,  1}, {1,  1}
    ]

    new_acc = directions
    |> Enum.reduce_while(0, fn {x, y}, cnt ->
      v = Map.get(map, {i + x, j + y}, ?.)
      
      (if v == ?@, do: cnt + 1, else: cnt)
      |> do_fun()
    end)
    |> Kernel.<(4)
    |> if(do: [{i, j} | acc], else: acc)

    {new_acc, map}
  end

  defp do_fun(new_cnt) when new_cnt >= 4, do: {:halt, new_cnt}
  defp do_fun(new_cnt), do: {:cont, new_cnt}
end

defmodule AdventOfCode2025Day4Part2 do
  def run(input) do
    input
    |> parse_input()
    |> AdventOfCode2025Day4Part2Solver.solve()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {line, i}, acc ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.put(acc, {i, j}, c)
      end)
    end)
  end
end

input = """
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
"""

AdventOfCode2025Day4Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。よかった :tada: 

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
