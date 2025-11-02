---
title: 'Advent of Code 2024 Day 8をElixirで解く: Resonant Collinearity'
tags:
  - Elixir
  - AOC
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-01T15:25:52+09:00'
id: e260e0e3e457d4d45302
organization_url_name: null
slide: false
ignorePublish: false
---
:::note info
**Qiita Advent Calendar 2025**
今年もこの季節がいよいよ始まりました :tada::tada::tada:
誰よりもこの日を待ちわびていたと自負しております。

2024年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

https://qiita.com/advent-calendar/2025


## はじめに
2024年のAdvent of Code (AoC) [Day 8:Resonant Collinearity](https://adventofcode.com/2024/day/8)を肩慣らしにElixirで解いてみます。昨年の私は10題目まで問いていますが、なぜだかNo.8を飛ばしていました。

[Codex CLI](https://developers.openai.com/codex/cli/)の全面協力により、正解を導きました。
今年のAoCの強い味方です。
問題文をパスして、Elixirで解きたいと伝えたくらいです。よくやってくれました :tada::tada::tada: 


## 問題概要（Resonant Collinearity）

周波数ごとにアンテナが散らばったグリッドから、条件を満たす「アンチノード」を数える幾何パズルです。この記事では問題の要点と、Elixirの標準ライブラリだけで実装したシンプルな解法を紹介します。

- 入力は文字グリッド。`a`〜`z`、`A`〜`Z`、`0`〜`9`がアンテナの周波数、`.`は空きスペース。
- 同じ周波数のアンテナ2個が一直線上に並び、片方がもう片方の2倍の距離に位置する点を「アンチノード」と呼ぶ。
- どのアンテナペアも、条件を満たすと左右に1つずつアンチノードが生まれる。
- アンチノードの位置がグリッド外の場合は無視。
- 異なる周波数のアンテナどうしは無関係。アンチノードは既存のアンテナと座標が重なってもよい。
- グリッド内に現れる「ユニークな」アンチノードの個数を数えるのがPart 1のゴール。

## 解法の着眼点
1. グリッドを走査して「周波数 -> 座標リスト」のマップを作る。
2. 各周波数ごとに座標リストから全ての順序付きペアを列挙する。
3. ペア `(p1, p2)` の差分ベクトル `d = p2 - p1` を求め、アンチノード候補を `p1 - d`（p1の手前側）と `p2 + d`（p2の奥側）として計算する。
4. グリッド外の候補は捨て、残った座標を `MapSet` に積み上げて重複を排除する。
5. 最後に `MapSet.size/1` でユニークなアンチノード数を得る。

ペアを「順序付き」で扱うことで、1回のループで両側のアンチノードを拾えます。ベクトル計算のみに絞れば、複雑な幾何判定は不要です。

## 実装コード
```elixir
defmodule AdventOfCode2024Day8Part1 do
  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    grid =
      input
      |> String.split("\n", trim: true)

    height = length(grid)
    width = grid |> hd() |> String.length()

    frequencies =
      grid
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn
          {".", _col}, acc -> acc
          {freq, col}, acc -> Map.update(acc, freq, [{row, col}], &[{row, col} | &1])
        end)
      end)

    frequencies
    |> Enum.reduce(MapSet.new(), fn {_freq, coords}, antinodes ->
      coords
      |> Enum.reduce(antinodes, fn {r1, c1}, set ->
        coords
        |> Enum.reduce(set, fn {r2, c2}, acc ->
          if r1 == r2 and c1 == c2 do
            acc
          else
            dr = r2 - r1
            dc = c2 - c1

            [{r1 - dr, c1 - dc}, {r2 + dr, c2 + dc}]
            |> Enum.reduce(acc, fn candidate, inner_acc ->
              if in_bounds?(candidate, height, width),
                do: MapSet.put(inner_acc, candidate),
                else: inner_acc
            end)
          end
        end)
      end)
    end)
    |> MapSet.size()
  end

  defp in_bounds?({row, col}, height, width) do
    row >= 0 and row < height and col >= 0 and col < width
  end
end
```

アプリケーションに組み込む場合は `mix new aoc2024` などでプロジェクトを作り、上記モジュールを `lib/` 配下に置いてください。標準ライブラリのみで完結しているので追加依存は不要です。

## 実行例
AoCのサンプル入力をそのままヒアドキュメントで用意し、`iex -S mix` から実行します。

```elixir
iex> input = """
...> ............
...> ........0...
...> .....0......
...> .......0....
...> ....0.......
...> ......A.....
...> ............
...> ............
...> ........A...
...> .........A..
...> ............
...> ............
...> """
iex> AdventOfCode2024Day8Part1.solve(input)
14
```

サンプル通り `14` が返ってきたら成功です。本番入力でも同じように入力文字列を用意して `solve/1` を呼び出すだけでカウントできます。

## Part 2: Resonant Harmonicsへの対応
Part 2では「同じ周波数のアンテナが一直線上に2つ以上存在する座標はすべてアンチノード」と定義が拡張されました。したがって、アンテナが並ぶ最小ステップ（差分ベクトルを最大公約数で割った最小単位）で格子点をたどり、グリッド内にある地点をすべて拾い上げる必要があります。アンテナ自身も条件を満たすので自動的にアンチノード扱いになります。

### 実装コード（Part 2）
```elixir
defmodule AdventOfCode2024Day8Part2 do
  @spec solve(String.t()) :: non_neg_integer()
  def solve(input) do
    grid =
      input
      |> String.split("\n", trim: true)

    height = length(grid)
    width = grid |> hd() |> String.length()

    frequencies =
      grid
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {line, row}, acc ->
        line
        |> String.graphemes()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn
          {".", _col}, acc -> acc
          {freq, col}, acc -> Map.update(acc, freq, [{row, col}], &[{row, col} | &1])
        end)
      end)

    frequencies
    |> Enum.reduce(MapSet.new(), fn {_freq, coords}, antinodes ->
      coords_with_idx = Enum.with_index(coords)

      Enum.reduce(coords_with_idx, antinodes, fn {{r1, c1}, idx1}, set ->
        Enum.reduce(coords_with_idx, set, fn
          {{_r2, _c2}, idx2}, acc when idx2 <= idx1 ->
            acc

          {{r2, c2}, _idx2}, acc ->
            dr = r2 - r1
            dc = c2 - c1
            step_divisor = Integer.gcd(abs(dr), abs(dc))
            step = {div(dr, step_divisor), div(dc, step_divisor)}

            extend_line(acc, {r1, c1}, step, height, width)
        end)
      end)
    end)
    |> MapSet.size()
  end

  defp extend_line(set, {r, c}, {dr, dc}, height, width) do
    set
    |> put_along({r - dr, c - dc}, {-dr, -dc}, height, width)
    |> MapSet.put({r, c})
    |> put_along({r + dr, c + dc}, {dr, dc}, height, width)
  end

  defp put_along(set, {r, c} = point, {dr, dc}, height, width) do
    if in_bounds?(point, height, width) do
      set
      |> MapSet.put(point)
      |> put_along({r + dr, c + dc}, {dr, dc}, height, width)
    else
      set
    end
  end

  defp in_bounds?({row, col}, height, width) do
    row >= 0 and row < height and col >= 0 and col < width
  end
end
```

### 実行例（Part 2）
先ほどと同じサンプルに対してPart 2のルールを適用すると、アンチノードは34個になります。

```elixir
iex> AdventOfCode2024Day8Part2.solve(input)
34
```

## ハマりポイントと対処
- **グリッド外の座標チェックを忘れがち**：`in_bounds?/3` を用意して早めに弾く。
- **同じペアを二重に扱う**：順序付きペアを列挙し、`MapSet` で去重することで悩みを解消。
- **同じアンテナを比較してしまう**：`if r1 == r2 and c1 == c2` で早期にスキップし、警告と無駄な計算を防ぐ。
- **Part 2の最小ステップ計算**：`Integer.gcd/2` で差分を正規化し、`extend_line/4` で両方向にたどると取りこぼしがない。
- **入力末尾の改行**：`String.split/3` に `trim: true` を渡して余計な空行を排除。

## おわりに
ベクトル計算に落とし込むと、Advent of Codeらしい幾何パズルもElixirのイテレーションで素直に表現できます。Part 2 まで視界に入れておけば、最小ステップで格子上をなぞるだけで自然と拡張ルールも処理できます。

[Livebook](https://livebook.dev/)で使用できる[TORIFUKUKaiou/livebooks](https://github.com/TORIFUKUKaiou/livebooks)を絶賛公開中です！

**迷わず書けよ 書けばわかるさ！闘魂を込めて。** 🔥
