---
title: 'Advent of Code 2025 Day 10: FactoryをElixirで解くことを楽しむ'
tags:
  - Elixir
  - 協議プログラミング
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2026-01-15T16:45:17+09:00'
id: 9610888667a08551b8b8
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 10を解いてみます。  
Part 1まではGenerative AIsの力を使わずに解けました。
Part 2もサンプルデータで解くところまではできましたが、どうしても性能がでず、[Codex CLI](https://developers.openai.com/codex/cli/)の力を借りてしまいました。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/321a4507b9e98890afdb

[Advent of Code 2025 Day 10: Factory をRustで解いた](https://qiita.com/haw_ohnuma/items/321a4507b9e98890afdb)

本番データでもすごく高速に計算が完了します！　感動ものです :tada::tada::tada: 

## Day 10: Factory
問題文は、[Day 10: Factory](https://adventofcode.com/2025/day/10)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

#### 解説

このプログラムは「ボタンを押してパターンを作る」パズルを解きます。

#### 問題の構造

- 目標パターン（例: ##.#）が与えられる
- 複数のボタンがあり、各ボタンは特定の位置をトグル（.⇔#）する
- 最小何個のボタンを押せばパターンが完成するかを求める

#### 解法のアプローチ

1. ボタン1個の組み合わせから順に試す
2. 選んだボタンを全て押した結果がパターンと一致するか確認
3. 一致したらその個数が答え

#### 各モジュールの役割

- Awesome.combination/2: n個選ぶ組み合わせを列挙
- AdventOfCode2025Day10Part1Solver: 1個、2個...と増やしながら最小解を探索
- do_solve/2: 選んだボタンを押した結果を計算し、パターンと比較
- AdventOfCode2025Day10Part1: 入力パースとエントリーポイント

#### ポイント

トグル操作なので、同じ位置を偶数回押すと元に戻る。組み合わせを小さい順に試すことで、最小のボタン数を効率的に見つけています。



```elixir
defmodule Awesome do
  def combination(_, 0), do: [[]]
  def combination([], _), do: []

  def combination([x | xs], n) do
    for(y <- combination(xs, n - 1), do: [x | y]) ++ combination(xs, n)
  end
end

defmodule AdventOfCode2025Day10Part1Solver do
  def run(list) do
    Enum.reduce(list, [], &solve/2)
    |> Enum.sum()
  end

  defp solve({pattern, buttons}, acc) do
    Range.new(1, Enum.count(buttons))
    |> Enum.reduce_while(nil, fn i, nil ->
      Awesome.combination(buttons, i)
      |> Enum.any?(fn selected_buttons -> do_solve(selected_buttons, pattern) end)
      |> if(do: {:halt, i}, else: {:cont, nil})
    end)
    |> List.wrap()
    |> Kernel.++(acc)
  end

  defp do_solve(selected_buttons, pattern) do
    init = String.duplicate(".", String.length(pattern)) |> String.to_charlist()
    
    selected_buttons
    |> Enum.reduce(init, fn list, acc ->
      Enum.reduce(list, acc, fn i, acc ->
        List.update_at(acc, i, fn 
          ?. -> ?#
          ?# -> ?.
        end)
      end)
    end)
    |> List.to_string()
    |> Kernel.==(pattern)    
  end
end

defmodule AdventOfCode2025Day10Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list), do: AdventOfCode2025Day10Part1Solver.run(list)

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line =
      case String.split(line, "{", parts: 2) do
        [left, _] -> left
        [left] -> left
      end

    [_, pattern] = Regex.run(~r/\[([.#]+)\]/, line)
    buttons =
      Regex.scan(~r/\(([^)]*)\)/, line)
      |> Enum.map(fn [_, inside] ->
        inside
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {pattern, buttons}
  end
end

input = """
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
"""

AdventOfCode2025Day10Part1.run(input)
```
</details>

### Part 2

以下はサンプルデータでは正答を得られますが、本番データでは計算が終わりません :sob: 

<details><summary>Part 2</summary>



#### 解説

Part 2は「各位置に目標値がある」パズルです。

#### 問題の構造

- 各位置に目標の数値（joltage_levels）が与えられる（例: {3, 2, 1}）
- 各ボタンは特定の位置に+1する（トグルではなく加算）
- 全位置が目標値になるまでの最小ボタン押下回数を求める

#### 現在の解法

各ボタンを0〜max_value回押す全組み合わせを総当たりで試しています。asがカウンター（各ボタンの押下回数）で、update_asで1ずつイン
クリメントしながら全探索。

#### 非効率な理由

ボタンがn個、最大値がmの場合、探索空間は (m+1)^n 通り。例えばボタン10個・最大値5なら約6000万通り、ボタン20個なら天文学的数字に
なります。

#### 改善の方向性

この問題は本質的に「線形方程式系」です。各ボタンの押下回数を変数とすると、目標値を満たす最小の総和を求める問題になります。

- 貪欲法やBFS/DFSで枝刈りしながら探索
- 行列演算（ガウス消去法的アプローチ）
- 動的計画法

総当たりから脱却するには、数学的な構造を活用した解法への転換が必要です。



```elixir
defmodule AdventOfCode2025Day10Part2Solver do
  def run(list) do
    list
    |> Enum.reduce([], &solve/2)
    |> Enum.sum()
  end

  def solve({joltage_levels, buttons}, acc) do
    max_value = Enum.max(joltage_levels)
    count_of_press = do_solve(joltage_levels, buttons, max_value, 0, List.duplicate(0, Enum.count(buttons)), List.duplicate(0, Enum.count(joltage_levels)), buttons, 100_000_000)

    [count_of_press | acc]
  end

  defp do_solve(joltage_levels, [], max_value, _index, as, acc, buttons, count_of_press) do
    if Enum.all?(as, & &1 == max_value) do
      count_of_press
    else
      if joltage_levels == acc do
        new_count_of_press = min(Enum.sum(as), count_of_press)
        updated_as = update_as(as, max_value)
        do_solve(joltage_levels, buttons, max_value, 0, updated_as, List.duplicate(0, Enum.count(joltage_levels)), buttons, new_count_of_press)
      else
        updated_as = update_as(as, max_value)
        do_solve(joltage_levels, buttons, max_value, 0, updated_as, List.duplicate(0, Enum.count(joltage_levels)), buttons, count_of_press)
      end
    end
  end

  defp do_solve(joltage_levels, [head | tail], max_value, index, as, acc, buttons, count_of_press) do
    new_acc = 
      head
      |> Enum.map(& &1 * Enum.at(as, index))
      |> Enum.zip_with(acc, fn x, y -> x + y end)
    
    do_solve(joltage_levels, tail, max_value, index + 1, as, new_acc, buttons, count_of_press)
  end

  defp update_as(as, max_value) do
    base = max_value + 1

    as
    |> Enum.reverse()
    |> inc_rev(base)
    |> Enum.reverse()
  end

  # 末尾（revの先頭）から+1して、baseで繰り上げ
  defp inc_rev([], _base), do: []

  defp inc_rev([d | rest], base) do
    if d + 1 < base do
      [d + 1 | rest]
    else
      [0 | inc_rev(rest, base)]
    end
  end
end


defmodule AdventOfCode2025Day10Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list), do: AdventOfCode2025Day10Part2Solver.run(list)

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    line =
      case String.split(line, "]", parts: 2) do
        [_left, right] -> right
        [right] -> right
      end

    joltage_levels =
      Regex.run(~r/{(.+)}/, line)
      |> Enum.at(1)
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)
    buttons =
      Regex.scan(~r/\(([^)]*)\)/, line)
      |> Enum.map(fn [_, inside] ->
        inside
        |> String.split(",", trim: true)
        |> Enum.reduce(List.duplicate(0, Enum.count(joltage_levels)), fn n, acc ->
          index = String.to_integer(n)
          List.replace_at(acc, index, 1)
        end)
      end)

    {joltage_levels, buttons}
  end
end

input = """
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
"""

AdventOfCode2025Day10Part2.run(input)
```
</details>

### Part 2 with Codex

[Codex CLI](https://developers.openai.com/codex/cli/)に書いてもらったものを貼っておきます。

<details><summary>Part 2 Codex</summary>

```elixir
defmodule AdventOfCode2025Day10Part2SolverCodex do
  @max 9_223_372_036_854_775_807

  def run(list) do
    list
    |> Enum.map(&solve_line/1)
    |> Enum.sum()
  end

  defp solve_line({target, buttons}) do
    solve(buttons, target)
  end

  defp solve(buttons, target) do
    m = length(buttons)

    n =
      case List.flatten(buttons) do
        [] -> 0
        flat -> Enum.max(flat) + 1
      end

    table = build_table(n, m, buttons, target)
    {table, pivot_cols} = gauss(table, m)
    pivot_set = MapSet.new(pivot_cols)

    free_cols =
      if m == 0 do
        []
      else
        for col <- 0..(m - 1), not MapSet.member?(pivot_set, col), do: col
      end

    lim = Enum.sum(target)
    table = Enum.map(table, &List.to_tuple/1)
    free_cols = List.to_tuple(free_cols)
    pivot_cols = List.to_tuple(pivot_cols)

    dfs(0, List.duplicate(0, m), 0, table, free_cols, pivot_cols, lim, @max, m)
  end

  defp build_table(n, m, buttons, target) do
    base = List.duplicate(List.duplicate(0, m + 1), n)

    base =
      Enum.with_index(base)
      |> Enum.map(fn {row, idx} ->
        List.replace_at(row, m, Enum.at(target, idx))
      end)

    Enum.reduce(Enum.with_index(buttons), base, fn {button, col_idx}, acc ->
      Enum.reduce(button, acc, fn row_idx, acc2 ->
        List.update_at(acc2, row_idx, fn row ->
          List.replace_at(row, col_idx, 1)
        end)
      end)
    end)
  end

  defp gauss(table, var_count) do
    cond do
      var_count == 0 ->
        {table, []}

      table == [] ->
        {table, []}

      true ->
        n = length(table)
        last_col = var_count

        {table, _rank, pivots} =
          Enum.reduce(0..(var_count - 1), {table, 0, []}, fn col, {table, rank, pivots} ->
            case find_pivot(table, rank, col) do
              nil ->
                {table, rank, pivots}

              pivot_row ->
                table = swap_rows(table, rank, pivot_row)
                pivot_val = table |> Enum.at(rank) |> Enum.at(col)
                table = eliminate(table, rank, col, pivot_val, n, last_col)
                {table, rank + 1, pivots ++ [col]}
            end
          end)

        {table, pivots}
    end
  end

  defp find_pivot(table, start_row, col) do
    table
    |> Enum.drop(start_row)
    |> Enum.with_index(start_row)
    |> Enum.find_value(fn {row, idx} ->
      if Enum.at(row, col) != 0, do: idx, else: nil
    end)
  end

  defp swap_rows(table, i, i), do: table

  defp swap_rows(table, i, j) do
    row_i = Enum.at(table, i)
    row_j = Enum.at(table, j)

    table
    |> List.replace_at(i, row_j)
    |> List.replace_at(j, row_i)
  end

  defp eliminate(table, rank, col, pivot, n, _last_col) do
    if rank + 1 >= n do
      table
    else
      pivot_row = Enum.at(table, rank)
      pivot_t = List.to_tuple(pivot_row)

      Enum.reduce((rank + 1)..(n - 1), table, fn row_idx, acc ->
        row = Enum.at(acc, row_idx)
        val = Enum.at(row, col)

        if val == 0 do
          acc
        else
          g = gcd(pivot, val)
          t = div(val, g)
          tt = div(pivot, g)

          new_row =
            row
            |> Enum.with_index()
            |> Enum.map(fn {cell, j} ->
              if j < col do
                cell
              else
                cell * tt - elem(pivot_t, j) * t
              end
            end)

          List.replace_at(acc, row_idx, new_row)
        end
      end)
    end
  end

  defp dfs(idx, now, nowsum, table, free_cols, pivot_cols, lim, best, var_count) do
    cond do
      nowsum >= best ->
        best

      idx == tuple_size(free_cols) ->
        case back_solve(now, table, pivot_cols, var_count) do
          {:ok, filled} ->
            min(best, Enum.sum(filled))

          :invalid ->
            best
        end

      true ->
        col = elem(free_cols, idx)

        Enum.reduce(0..lim, best, fn c, acc_best ->
          new_sum = nowsum + c

          if new_sum >= acc_best do
            acc_best
          else
            new_now = List.replace_at(now, col, c)
            dfs(idx + 1, new_now, new_sum, table, free_cols, pivot_cols, lim, acc_best, var_count)
          end
        end)
    end
  end

  defp back_solve(now, table, pivot_cols, var_count) do
    rank = tuple_size(pivot_cols)

    if rank == 0 do
      {:ok, now}
    else
      result =
        Enum.reduce_while((rank - 1)..0//-1, now, fn row_idx, acc ->
          col = elem(pivot_cols, row_idx)
          row = Enum.at(table, row_idx)
          right = elem(row, var_count)

          right =
            if col + 1 <= var_count - 1 do
              Enum.reduce((col + 1)..(var_count - 1), right, fn j, acc2 ->
                acc2 - elem(row, j) * Enum.at(acc, j)
              end)
            else
              right
            end

          tm = elem(row, col)
          val = if tm != 0 and rem(right, tm) == 0, do: div(right, tm), else: nil

          cond do
            tm == 0 and right != 0 ->
              {:halt, :invalid}

            tm == 0 ->
              {:cont, acc}

            rem(right, tm) != 0 ->
              {:halt, :invalid}

            val < 0 ->
              {:halt, :invalid}

            true ->
              {:cont, List.replace_at(acc, col, val)}
          end
        end)

      case result do
        :invalid -> :invalid
        updated -> {:ok, updated}
      end
    end
  end

  defp gcd(a, b) do
    Integer.gcd(abs(a), abs(b))
  end
end

defmodule AdventOfCode2025Day10Part2Codex do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list), do: AdventOfCode2025Day10Part2SolverCodex.run(list)

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_line/1)
  end

  defp parse_line(line) do
    target =
      Regex.run(~r/{([^}]+)}/, line)
      |> Enum.at(1)
      |> String.split(",", trim: true)
      |> Enum.map(&String.to_integer/1)

    buttons =
      Regex.scan(~r/\(([^)]*)\)/, line)
      |> Enum.map(fn [_, inside] ->
        inside
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {target, buttons}
  end
end

input = """
[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
[...#.] (0,2,3,4) (2,3) (0,4) (0,1,2) (1,2,3,4) {7,5,12,7,2}
[.###.#] (0,1,2,3,4) (0,3,4) (0,1,2,4,5) (1,2) {10,11,11,5,10,5}
"""

AdventOfCode2025Day10Part2Codex.run(input)
```

</details>


## さいごに
今回、Part 1は自力で全部解きました。Part 2はなんとかサンプルデータで解けるものは何日も問題の意味を考え、実装を考えあれこれ試してみました。
前回も厳しかったので、そろそろ限界のようです。 **伸びしろしかありません。** 
Generative AIsと**協議**をする、「**協議プログラミング**」になってきたかもしれせん。

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
