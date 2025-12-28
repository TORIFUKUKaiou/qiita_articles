---
title: 'Day 11: ReactorをElixirで解くことを楽しむ'
tags:
  - Elixir
  - 協議プログラミング
  - AdventofCode
  - 闘魂
  - AdventCalendar2026
private: false
updated_at: '2025-12-27T12:00:33+09:00'
id: d4498fe7eb6f95cb5e62
organization_url_name: null
slide: false
ignorePublish: false
---
:::note info
**Qiita Advent Calendar 2026**
2026年12月1日を目指して、スタートを切ります。 :tada::tada::tada:
誰よりもこの日を待ち通しく思っています。

2025年12月26日から首を長くして楽しみにしております。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 11を解いてみます。  
Part 1まではGenerative AIsの力を使わずに解けました。
Part 2もサンプルデータで解くところまではできましたが、どうしても性能がでず、[Codex CLI](https://developers.openai.com/codex/cli/)の力を借りてしまいました。

今年はDay 12までです。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/c3aaa3493f196f721e7d

[Advent of Code 2025 Day 11: Reactor をRustで解いた](https://qiita.com/haw_ohnuma/items/c3aaa3493f196f721e7d)


## Day 11: Reactor
問題文は、[Day 11: Reactor](https://adventofcode.com/2025/day/11)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

#### 解説

このプログラムは「木構造の葉ノード（出口）までのパス数」を数えます。

#### 問題の構造

- 各ノードが複数の子ノードを持つ木構造
- :you からスタート
- :out に到達したら1カウント
- 全ての :out への到達パス数の合計を求める

#### 解法のアプローチ

再帰で木を辿り、:out に着いたら1を返す。各ノードで子ノードの結果を合計していく。

#### 各関数の役割

- parse/1: 入力を %{ノード => [子ノードリスト]} のMapに変換
- solve(:out, _): 出口に到達 → 1を返す
- solve(nil, _): 存在しないノード → 0を返す
- solve(node, map): 子ノードを再帰的に辿り、結果を合計

#### 処理の流れ（例）

```
you → bbb → ddd → ggg → (葉)
    → eee → out ✓
    → ccc → ddd → ...
          → eee → out ✓
          → fff → out ✓
```

各 :out への到達で1がカウントされ、合計が答えになります。


```elixir
defmodule AdventOfCode2025Day11Part1 do
  def run(input) do
    input
    |> parse()
    |> then(& solve(:you, &1))
  end

  def solve(:out, _map) do
    1
  end

  def solve(nil, _map) do
    0
  end

  def solve(node, map) do
    Map.get(map, node)
    |> Enum.reduce(0, fn node, acc ->
      acc + solve(node, map)
    end)
  end

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      [key, values] = String.split(line, ":", trim: true)
      Map.put(acc, String.to_atom(key), String.split(values, " ", trim: true) |> Enum.map(&String.to_atom/1))
    end)
  end
end

example = """
aaa: you hhh
you: bbb ccc
bbb: ddd eee
ccc: ddd eee fff
ddd: ggg
eee: out
fff: out
ggg: out
hhh: ccc fff iii
iii: out
"""

AdventOfCode2025Day11Part1.run(example)
```
</details>

### Part 2


<details><summary>Part 2</summary>

#### 解説

Part 1の拡張版。「特定の2つのノードを両方通ったパスのみカウント」する問題です。

#### 問題の構造

- :svr からスタート
- :out に到達するパスのうち、:dac と :fft の両方を通ったものだけをカウント

#### 解法のアプローチ

再帰で木を辿りながら、:dac を通過したか（seen_dac）と :fft を通過したか（seen_fft）をフラグで管理。:out 到達時に両方trueなら
カウント。

#### Part 1との違い

- update_flags/3: 現在ノードが :dac か :fft ならフラグをtrueに更新
- solve(:out, _, true, true, _): 両方通過した場合のみ1を返す
- メモ化: {ノード, seen_dac, seen_fft} をキーにキャッシュして高速化

#### 処理の流れ（例）

```
svr → aaa → fft(✓) → ccc → eee → dac(✓) → fff → ggg → out ✓（両方通過）
    → bbb → tty → ccc → ddd → hub → fff → ggg → out ✗（dacのみ未通過）
```


メモ化により、同じ状態（ノード＋フラグの組み合わせ）を再計算しないため効率的です。




```elixir
defmodule AdventOfCode2025Day11Part2 do
  def run(input) do
    map = parse(input)
    {ans, _memo} = solve(:svr, map, false, false, %{})
    ans
  end

  # ---- core ----

  defp solve(:out, _map, true, true, memo), do: {1, memo}
  defp solve(:out, _map, _sd, _sf, memo), do: {0, memo}

  defp solve(node, map, seen_dac, seen_fft, memo) do
    {sd, sf} = update_flags(node, seen_dac, seen_fft)
    key = {node, sd, sf}

    case Map.fetch(memo, key) do
      {:ok, cached} ->
        {cached, memo}

      :error ->
        {sum, memo2} = sum_children(node, map, sd, sf, memo)
        {sum, Map.put(memo2, key, sum)}
    end
  end

  defp sum_children(node, map, sd, sf, memo) do
    children = Map.get(map, node, [])

    Enum.reduce(children, {0, memo}, fn child, {acc, memo_acc} ->
      {v, memo_next} = solve(child, map, sd, sf, memo_acc)
      {acc + v, memo_next}
    end)
  end

  defp update_flags(node, seen_dac, seen_fft) do
    {
      seen_dac or node == :dac,
      seen_fft or node == :fft
    }
  end

  # ---- parse ----

  defp parse(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      [key, values] = String.split(line, ":", trim: true)

      Map.put(
        acc,
        String.to_atom(key),
        values |> String.split(" ", trim: true) |> Enum.map(&String.to_atom/1)
      )
    end)
  end
end

example = """
svr: aaa bbb
aaa: fft
fft: ccc
bbb: tty
tty: ccc
ccc: ddd eee
ddd: hub
hub: fff
eee: dac
dac: fff
fff: ggg hhh
ggg: out
hhh: out
"""

AdventOfCode2025Day11Part2.run(example)
```
</details>



## さいごに
今回、Part 1は自力で全部解きました。Part 2はなんとかサンプルデータで解けるものは何日も問題の意味を考え、実装を考えあれこれ試してみました。
前回も厳しかったので、そろそろ限界のようです。 **伸びしろしかありません。** 
私の場合は「競技プログラミング」ではありません。
Generative AIsと**協議**をする、「**協議プログラミング**」です。

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！
