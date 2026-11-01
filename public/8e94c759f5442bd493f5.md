---
title: 'AoC 2025 Day 12: Christmas Tree FarmをElixirで解くことを楽しむ'
tags:
  - Elixir
  - AdventofCode
  - 闘魂連鎖
  - 協議プログラミング
  - AdventCalendar2027
private: false
updated_at: '2026-10-31T18:47:14+09:00'
id: 8e94c759f5442bd493f5
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/37543ba9-6f12-41ae-9458-4917aed11879.png)


:::note info
**Qiita Advent Calendar 2026**
いよいよはじまりました :tada::tada::tada:
誰よりもこの日を待ち通しく思っています。

2025年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

## はじめに
2026年ですが、昨年できずに諦めて放置した問題から解いてみます。

[Advent of Code 2025](https://adventofcode.com/2025) Day 12を解いてみます。  
Part 1はGenerative AI(Codex, GPT-6.1 Sol 中)の力を使って解きました。
Part 2は問題を解くことはありませんでした。

昨年はDay 12までありました。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/0ffaf1bd2d3f5d462d5b

[Advent of Code 2025 Day 12: Christmas Tree Farm をRustで解いた](https://qiita.com/haw_ohnuma/items/0ffaf1bd2d3f5d462d5b)


## Day 12: Christmas Tree Farm
問題文は、[Day 12: Christmas Tree Farm](https://adventofcode.com/2025/day/12)を読んでください。  



私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>



```elixir
defmodule AdventOfCode2025Day12Part1 do
  import Bitwise

  def run(input) do
    {shapes, regions} = parse(input)
    Enum.count(regions, &fits?(&1, shapes))
  end

  defp parse(input) do
    blocks = input |> String.trim() |> String.split(~r/\r?\n\s*\r?\n/)
    {region_block, shape_blocks} = List.pop_at(blocks, -1)

    shapes =
      shape_blocks
      |> Enum.map(fn block ->
        [header | rows] = String.split(block, ~r/\r?\n/, trim: true)
        id = header |> String.trim_trailing(":") |> String.to_integer()

        cells =
          for {row, y} <- Enum.with_index(rows),
              {?#, x} <- Enum.with_index(String.to_charlist(row)),
              do: {x, y}

        {id, cells}
      end)
      |> Enum.sort_by(&elem(&1, 0))
      |> Enum.map(&elem(&1, 1))

    regions =
      region_block
      |> String.split(~r/\r?\n/, trim: true)
      |> Enum.map(fn line ->
        [w, h | counts] = Regex.scan(~r/\d+/, line) |> List.flatten()
        {String.to_integer(w), String.to_integer(h), Enum.map(counts, &String.to_integer/1)}
      end)

    {shapes, regions}
  end

  defp fits?({w, h, counts}, shapes) do
    needed =
      Enum.zip_with(shapes, counts, fn cells, count -> length(cells) * count end)
      |> Enum.sum()

    tile_size =
      shapes
      |> Enum.flat_map(fn cells -> Enum.map(cells, fn {x, y} -> max(x, y) + 1 end) end)
      |> Enum.max()

    cond do
      needed > w * h -> false
      div(w, tile_size) * div(h, tile_size) >= Enum.sum(counts) -> true
      true -> exact_fit?(shapes, counts, w, h, needed)
    end
  end

  defp orientations(cells) do
    for reflected <- [false, true], turns <- 0..3 do
      cells
      |> Enum.map(fn {x, y} ->
        point = {if(reflected, do: -x, else: x), y}
        Enum.reduce(1..turns//1, point, fn _, {a, b} -> {-b, a} end)
      end)
      |> normalize()
    end
    |> Enum.uniq()
  end

  defp normalize(cells) do
    min_x = cells |> Enum.map(&elem(&1, 0)) |> Enum.min()
    min_y = cells |> Enum.map(&elem(&1, 1)) |> Enum.min()
    cells |> Enum.map(fn {x, y} -> {x - min_x, y - min_y} end) |> Enum.sort()
  end

  defp exact_fit?(shapes, counts, w, h, needed) do
    by_cell =
      shapes
      |> Enum.with_index()
      |> Enum.reduce(%{}, fn {cells, id}, acc ->
        if Enum.at(counts, id) == 0 do
          acc
        else
          Enum.reduce(orientations(cells), acc, fn variant, acc ->
            width = variant |> Enum.map(&elem(&1, 0)) |> Enum.max() |> Kernel.+(1)
            height = variant |> Enum.map(&elem(&1, 1)) |> Enum.max() |> Kernel.+(1)

            positions =
              for y <- 0..(h - height)//1, x <- 0..(w - width)//1 do
                indices = Enum.map(variant, fn {dx, dy} -> (y + dy) * w + x + dx end)
                mask = Enum.reduce(indices, 0, fn i, mask -> mask ||| 1 <<< i end)
                {indices, mask}
              end

            Enum.reduce(positions, acc, fn {indices, mask}, acc ->
              Enum.reduce(indices, acc, fn i, acc ->
                Map.update(acc, i, [{id, mask, length(cells)}], fn list ->
                  [{id, mask, length(cells)} | list]
                end)
              end)
            end)
          end)
        end
      end)

    {result, _memo} = search(0, List.to_tuple(counts), w * h, needed, by_cell, MapSet.new())
    result
  end

  defp search(_board, _counts, _free, 0, _by_cell, memo), do: {true, memo}

  defp search(board, counts, free, needed, by_cell, memo) do
    key = {board, counts}

    if MapSet.member?(memo, key) do
      {false, memo}
    else
      cell = first_free(board, 0)

      {found, memo} =
        by_cell
        |> Map.get(cell, [])
        |> Enum.reduce_while({false, memo}, fn {id, mask, size}, {false, memo} ->
          if elem(counts, id) > 0 and (board &&& mask) == 0 do
            remaining = put_elem(counts, id, elem(counts, id) - 1)

            case search(board ||| mask, remaining, free - size, needed - size, by_cell, memo) do
              {true, memo} -> {:halt, {true, memo}}
              {false, memo} -> {:cont, {false, memo}}
            end
          else
            {:cont, {false, memo}}
          end
        end)

      {found, memo} =
        if not found and free > needed do
          search(board ||| 1 <<< cell, counts, free - 1, needed, by_cell, memo)
        else
          {found, memo}
        end

      if found, do: {true, memo}, else: {false, MapSet.put(memo, key)}
    end
  end

  defp first_free(board, cell) do
    if (board &&& 1 <<< cell) == 0, do: cell, else: first_free(board, cell + 1)
  end
end
```

```elixir
example = """
0:
###
##.
##.

1:
###
##.
.##

2:
.##
###
##.

3:
##.
###
##.

4:
###
#..
###

5:
###
.#.
###

4x4: 0 0 0 0 2 0
12x5: 1 0 1 0 2 2
12x5: 1 0 1 0 3 2
"""

AdventOfCode2025Day12Part1.run(example)
```
</details>

### Part 2


<details><summary>Part 2</summary>

No additional code is required. Collect 23 stars by completing both parts of Days 1–11 and Part 1 of Day 12, then press the button on the puzzle page to earn the final star.
</details>



## さいごに
昨年、全くできなかった問題を考えることを一切せずに、Generative AI(Codex)に相談しました。一発で正解を書いてくれました。すごいです。
なんとも情けない船出ですが、これが、Qiita Advent Calendar 2026における第一歩です。

私の場合は「競技プログラミング」ではありません。
Generative AIsと**協議**をする、「**協議プログラミング**」です。

どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、今年は[Advent of Code 2026](https://adventofcode.com/2026)を解いて行くことを楽しみたいと思います。

[Advent of Code 2026](https://adventofcode.com/2026)を解くことは、闘魂活動だと思います。
あなたもぜひお好きなプログラミング言語で解いてみてください！

![apios.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a20f8e73-ba77-4bcd-8e75-1717502aaefc.png)
