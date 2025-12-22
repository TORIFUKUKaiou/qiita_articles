---
title: 'Advent of Code 2025 Day 9: Movie TheaterをElixirで解くことを楽しむ'
tags:
  - Elixir
  - 協議プログラミング
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2025-12-21T20:14:49+09:00'
id: b39a34ad676979a51af1
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 9を解いてみます。  
Part 1まではGenerative AIsの力を使わずに解けました。
Part 2もサンプルデータで解くところまではできましたが、どうしても性能がでず、[Codex CLI](https://developers.openai.com/codex/cli/)の力を借りてしまいました。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/8e1195a7a3fb89bb2a49

[Advent of Code 2025 Day 9: Movie Theater をRustで解いた](https://qiita.com/haw_ohnuma/items/8e1195a7a3fb89bb2a49)

## Day 9: Movie Theater
問題文は、[Day 9: Movie Theater](https://adventofcode.com/2025/day/9)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

#### 概要
座標リストから2点を選び、その2点を対角とする矩形の最大面積を求める。

#### Awesomeモジュール
- combination/2: リストからn個の組み合わせを生成
- 再帰で「先頭を含む組み合わせ」+「先頭を含まない組み合わせ」を列挙

#### 処理の流れ
1. parse_input: 入力を[[x, y], ...]形式にパース
2. combination(list, 2): 全ての2点ペアを生成
3. area: 2点を対角とする矩形の面積を計算
   - (|x1-x2|+1) × (|y1-y2|+1)
4. Enum.reduce: 最大面積を求める

#### ポイント
- +1は両端を含むため（例: x=2〜5なら幅4）



```elixir
defmodule Awesome do
  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end

defmodule AdventOfCode2025Day9Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_lists) do
    list_of_lists
    |> Awesome.combination(2)
    |> Enum.reduce(0, fn pair, acc -> max(acc, area(pair)) end)
  end

  defp area([[x1, y1], [x2, y2]]) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
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
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
"""

AdventOfCode2025Day9Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

#### 概要
多角形の境界線上の2点を対角とし、**境界内に完全に収まる**矩形の最大面積を求める。

#### 処理の流れ
1. parse_input: 入力を頂点リストにパース
2. build_boundary_tiles: 頂点間を補間して境界線上の全タイルをMapSetで生成
3. x_to_y_min_max_map: 各x座標における境界のy範囲を計算
4. y_to_x_min_max_map: 各y座標における境界のx範囲を計算
5. solve: 2点の組み合わせを面積降順でソートし、条件を満たす最初のペアを返す

#### can_make?の判定ロジック
- 矩形の全てのx座標について、境界のy範囲が矩形のy範囲を包含するか
- 矩形の全てのy座標について、境界のx範囲が矩形のx範囲を包含するか
- 両方満たせば、矩形は境界内に収まる

#### ポイント
- Enum.reduce_while: 面積降順で探索し、最初に条件を満たしたら即終了（効率化）
- range_covers?: 外側のRangeが内側を完全に包含するか判定




```elixir
defmodule Awesome do
  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end

defmodule AdventOfCode2025Day9Part2Solver do
  def run(list_of_lists) do
    tiles_set = build_boundary_tiles(list_of_lists)

    x_to_y_min_map = build_min_map(tiles_set)
    x_to_y_max_map = build_max_map(tiles_set)
    x_to_y_min_max_map =
      Map.merge(x_to_y_min_map, x_to_y_max_map, fn _k, min_v, max_v -> min_v..max_v end)

    y_to_x_min_map =
      tiles_set
      |> Enum.map(fn [x, y] -> [y, x] end)
      |> build_min_map()

    y_to_x_max_map =
      tiles_set
      |> Enum.map(fn [x, y] -> [y, x] end)
      |> build_max_map()

    y_to_x_min_max_map =
      Map.merge(y_to_x_min_map, y_to_x_max_map, fn _k, min_v, max_v -> min_v..max_v end)

    solve(list_of_lists, x_to_y_min_max_map, y_to_x_min_max_map)
  end

  defp solve(list_of_lists, x_to_y_min_max_map, y_to_x_min_max_map) do
    list_of_lists
    |> Awesome.combination(2)
    |> Enum.sort_by(fn pair -> area(pair) end, :desc)
    |> Enum.reduce_while(nil, fn pair, nil ->
      if can_make?(pair, x_to_y_min_max_map, y_to_x_min_max_map),
        do: {:halt, area(pair)},
        else: {:cont, nil}
    end)
  end

  defp area([[x1, y1], [x2, y2]]) do
    (abs(x1 - x2) + 1) * (abs(y1 - y2) + 1)
  end

  defp can_make?([[x1, y1], [x2, y2]], x_to_y_min_max_map, y_to_x_min_max_map) do
    x_range = normalize_range(x1, x2)
    y_range = normalize_range(y1, y2)

    Enum.all?(x_range, fn x ->
      range_covers?(Map.get(x_to_y_min_max_map, x), y_range)
    end) and
      Enum.all?(y_range, fn y ->
        range_covers?(Map.get(y_to_x_min_max_map, y), x_range)
      end)
  end

  defp normalize_range(a, b) when a <= b, do: a..b
  defp normalize_range(a, b), do: b..a

  defp range_covers?(%Range{first: outer_first, last: outer_last}, %Range{first: inner_first, last:
  inner_last}) do
    outer_first <= inner_first and inner_last <= outer_last
  end

  defp range_covers?(_, _), do: false

  defp build_boundary_tiles(list_of_lists) do
    [head | _] = list_of_lists

    list_of_lists
    |> Enum.reduce({nil, nil}, &do_build_boundary_tiles/2)
    |> then(fn acc -> do_build_boundary_tiles(head, acc) end)
    |> elem(0)
  end

  defp do_build_boundary_tiles(point, {nil, nil}) do
    {MapSet.new([point]), point}
  end

  defp do_build_boundary_tiles([x, y], {map_set, [x2, y]}) do
    new_map_set =
      Range.new(min(x, x2), max(x, x2))
      |> Enum.reduce(map_set, fn xi, acc ->
        MapSet.put(acc, [xi, y])
      end)

    {new_map_set, [x, y]}
  end

  defp do_build_boundary_tiles([x, y], {map_set, [x, y2]}) do
    new_map_set =
      Range.new(min(y, y2), max(y, y2))
      |> Enum.reduce(map_set, fn yi, acc ->
        MapSet.put(acc, [x, yi])
      end)

    {new_map_set, [x, y]}
  end

  defp build_min_map(list_of_lists) do
    list_of_lists
    |> Enum.reduce(%{}, fn [base, value], acc ->
      Map.update(acc, base, value, &min(&1, value))
    end)
  end

  defp build_max_map(list_of_lists) do
    list_of_lists
    |> Enum.reduce(%{}, fn [base, value], acc ->
      Map.update(acc, base, value, &max(&1, value))
    end)
  end
end

defmodule AdventOfCode2025Day9Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_lists) do
    AdventOfCode2025Day9Part2Solver.run(list_of_lists)
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
7,1
11,1
11,7
9,7
9,5
2,5
2,3
7,3
"""

AdventOfCode2025Day9Part2.run(input)
```
</details>


## さいごに
今回、9割は自力で全部解きました。前回もやや厳しかったので、そんなものかもしれません。 
Generative AIsと**協議**をする、「**協議プログラミング**」になってきたかもしれせん。

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
