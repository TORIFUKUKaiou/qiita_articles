---
title: 闘魂で挑むAdvent of Code 2024 Day 9── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-24T09:38:24+09:00'
id: afa90599e7c84eb3234d
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

---

# はじめに

[Advent Of Code 2024](https://adventofcode.com/2024)を[Elixir](https://elixir-lang.org/)で解きます。

本日は[Day 9: Disk Fragmenter](https://adventofcode.com/2024/day/9) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

### コードの主な機能

1. **parse_disk/1**

   * 入力文字列を2文字ずつ区切って処理
   * 最初の数字はファイルサイズ、次の数字は空き容量
   * ファイルIDは0から順番に割り当て
   * 結果は `{:file, id}` と `:free` のリスト

2. **compact/1**

   * 右端のファイルから左端の空き領域へ移動を繰り返す
   * 移動可能なブロックがなくなるまで再帰的に実行

3. **find_move/1**

   * 次に移動すべきファイルと移動先を特定
   * 右端のファイルと左端の空き領域のペアを返す

4. **rightmost_file_after_free/1**と**leftmost_free/1**

   * 移動元のファイル位置と移動先の空き領域位置を探索

5. **calculate_checksum/1**

   * 各ファイルの位置×IDの総和を計算

### 処理の流れ

1. 入力例 "12345" の場合:

   ```
   入力: "12345"
   解析後: [file(0), free, free, file(1), free, free, free, free, file(2), free, free, free, free, free]
   圧縮後: [file(0), file(2), file(1), free, free, free, free, free, free, free, free, free, free, free]
   ```

2. チェックサム計算:

   * 各ファイルの位置×IDを合計
   * 空き領域は計算に含めない

このコードは、ファイルシステムの断片化を解消し、ファイルを左側に寄せる処理を実装しています。


```elixir:advent_of_code_2024_day9_part1.exs
defmodule AdventOfCode2024Day9Part1 do
  def solve(input) do
    input
    |> String.trim()
    |> parse_disk()
    |> compact()
    |> calculate_checksum()
  end

  defp parse_disk(input) do
    input
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> Enum.flat_map(fn {[file_size | rest], file_id} ->
      space_size = if rest == [], do: 0, else: hd(rest)
      file_blocks = List.duplicate({:file, file_id}, file_size)
      space_blocks = List.duplicate(:free, space_size)
      file_blocks ++ space_blocks
    end)
  end

  defp compact(blocks) do
    case find_move(blocks) do
      nil -> blocks
      {from, to} ->
        blocks
        |> List.update_at(to, fn :free -> Enum.at(blocks, from) end)
        |> List.update_at(from, fn _ -> :free end)
        |> compact()
    end
  end

  defp find_move(blocks) do
    case rightmost_file_after_free(blocks) do
      nil -> nil
      file_pos ->
        case leftmost_free(blocks) do
          nil -> nil
          free_pos when free_pos < file_pos -> {file_pos, free_pos}
          _ -> nil
        end
    end
  end

  defp rightmost_file_after_free(blocks) do
    blocks
    |> Enum.with_index()
    |> Enum.reverse()
    |> Enum.find_value(fn
      {{:file, _}, idx} ->
        if Enum.any?(blocks, &(&1 == :free)), do: idx
      _ -> nil
    end)
  end

  defp leftmost_free(blocks) do
    blocks
    |> Enum.with_index()
    |> Enum.find_value(fn
      {:free, idx} -> idx
      _ -> nil
    end)
  end

  defp calculate_checksum(blocks) do
    blocks
    |> Enum.with_index()
    |> Enum.reduce(0, fn
      {{:file, id}, pos}, sum -> sum + (pos * id)
      _, sum -> sum
    end)
  end
end

# Test with sample input
input = "2333133121414131402"
AdventOfCode2024Day9Part1.solve(input) |> IO.puts()
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day9_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day9_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

### 主な変更点

Part 1との違いは、個別のブロックではなくファイル全体を一度に移動する点です。

### コードの構造

1. **データ構造**

   * `{id, size, position}` のタプルでファイルを表現
   * `id`: ファイルID
   * `size`: ファイルサイズ
   * `position`: 開始位置

2. **parse_input/1 と parse_blocks/3**

   ```elixir
   # 入力例: "12345" の場合
   # [{0,1,0}, {1,3,3}, {2,5,7}] のような形式に変換
   ```

3. **compact/1**

   * ファイルをIDの降順にソート
   * 各ファイルを左側の最も近い空き領域へ移動を試みる

4. **try_move_file/2**

   * ファイル全体が収まる空き領域を探す
   * 現在位置より左側にある場合のみ移動

5. **find_space/3**

   * MapSetを使用して使用中の領域を管理
   * ファイルサイズ分の連続した空き領域を探索

6. **checksum/1**

   * 各ファイルの位置×IDの総和を計算
   * ファイル内の各ブロックについて計算

### 処理の流れ例

```
入力: "12345"
1. 初期状態: 0..111....22222
2. ID=2から処理: 022111....2..
3. ID=1から処理: 022111222....
```

このアプローチにより、Part 1よりも効率的なディスク最適化が可能になります。

```elixir:advent_of_code_2024_day9_part2.exs
defmodule AdventOfCode2024Day9Part2 do
  def solve(input) do
    disk = parse_input(input)
    compact(disk) |> checksum()
  end

  defp parse_input(input) do
    input
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.with_index()
    |> parse_blocks([], 0)
  end

  defp parse_blocks([], acc, _), do: Enum.reverse(acc)
  defp parse_blocks([{[size, space], id} | rest], acc, pos) do
    block = {id, size, pos}
    parse_blocks(rest, [block | acc], pos + size + space)
  end
  defp parse_blocks([{[size], id} | rest], acc, pos) do
    block = {id, size, pos}
    parse_blocks(rest, [block | acc], pos + size)
  end

  defp compact(disk) do
    disk
    |> Enum.sort_by(&elem(&1, 0), :desc)
    |> Enum.reduce(disk, &try_move_file(&1, &2))
  end

  defp try_move_file(file, disk) do
    {id, size, pos} = file
    case find_space(disk, size, pos) do
      nil -> disk
      new_pos when new_pos < pos ->
        disk
        |> Enum.map(fn
          {^id, s, _} -> {id, s, new_pos}
          other -> other
        end)
      _ -> disk
    end
  end

  defp find_space(disk, size, max_pos) do
    occupied = MapSet.new(
      for {_, s, p} <- disk,
          i <- p..(p + s - 1),
          do: i
    )

    0..max_pos
    |> Enum.find(fn start ->
      Enum.all?(start..(start + size - 1), &(!MapSet.member?(occupied, &1)))
    end)
  end

  defp checksum(disk) do
    for {id, size, pos} <- disk,
        p <- pos..(pos + size - 1),
        reduce: 0 do
      acc -> acc + (p * id)
    end
  end
end

# Test with sample input
input = "2333133121414131402"
IO.puts AdventOfCode2024Day9Part2.solve(input)
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day9_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day9_part2.exs"
```


</details>

# 私は力を手に入れた 💪💪💪

**With great power comes great responsibility.**
『大いなる力には、大いなる責任が伴う』

生成AIである[GitHub Copilot](https://github.com/features/copilot)という力強いツールを手にいれました。別の言い方をすると、最強のタッグパートナーを得ました。

そして私のAIは一味違います。**A**ntonio **I**noki（アントニオ猪木）、つまり**猪木さん**です。

ちなみに私が所属する[HAW International Inc.](https://www.haw.co.jp/company/)では、GitHub Copilotの利用料を会社が負担してくれます。

https://qiita.com/torifukukaiou/items/b69e3ad6f05600b60539


# プロンプトを公開

こんなプロンプトを打ち込みました。参考にさらしておきます。

- --- Day 9: Disk Fragmenter --- Another push of the button leaves you in the familiar hallways of some friendly amphipods! Good thing you each somehow got your own personal mini submarine. The Historians jet away in search of the Chief, mostly by driving directly into walls.(略)
- --- Part Two --- Upon completion, two things immediately become clear. First, the disk definitely has a lot more contiguous free space, just like the amphipod hoped. Second, the computer is running much more slowly! Maybe introducing all of that file system fragmentation was a bad idea?(略)


![スクリーンショット 2024-12-02 8.49.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/92671363-adb7-8db3-a9da-790335bf6e4a.png)



---

# 闘魂活動

アントニオ猪木さんは、1998年4月4日闘強童夢（東京ドーム）において、４分９秒グランド・コブラツイストでドン・フライ選手を下した[^1]引退試合[^2]後のセレモニーで次のように「**闘魂**」を説明しました。

[^1]: [“燃える闘魂”アントニオ猪木引退試合](https://wp.bbm-mobile.com/sp2/result/resultshow.asp?s=015056)
[^2]: [アントニオ猪木VSドン・フライ](https://www.dailymotion.com/video/x95qrz6)

「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」

Advent Of Codeを解くことは、まさに**闘魂**活動です。

---

# 参考記事

https://qiita.com/RyoWakabayashi/items/53012bffad0de552ce8d


https://qiita.com/RyoWakabayashi/items/1cf1f65e6cd394ada32d

---

# GitHub

GitHubにもリポジトリ[livebooks](https://github.com/TORIFUKUKaiou/livebooks)をあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

---


# さいごに

チャットを通じて解答を得るという体験は、単なる効率化ではなく、新たな時代の可能性を示しています。Advent of Codeは、私たちにプログラミングという闘いを通じて、己の技術と精神を磨く場を提供してくれます。そして、GitHub Copilotのような生成AIは、その闘いを支える最強のタッグパートナーです。

しかし、AIが答えを導き出すだけでは不十分です。それをどう解釈し、自分の知識として昇華するかが、私たち人間の使命です。「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」アントニオ猪木さんのこの言葉を胸に、私たちもAIを使いこなし、新たな創造の領域へと挑んでいきましょう。

Advent of Codeは、ただのパズルイベントではありません。未来の私たちが、さらに創造的で価値ある活動に集中するための訓練の場です。この闘魂活動を通じて、AIと人間が共に高め合い、新しい可能性を切り拓いていきましょう。挑戦のその先に、きっと新たな地平が待っています！　アントニオ猪木さんが夢見た「本当の世界平和」を実現させましょう！！！

元氣があれば、なんでもできる！さあ、今すぐAdvent of Codeの闘いに飛び込みましょう！
