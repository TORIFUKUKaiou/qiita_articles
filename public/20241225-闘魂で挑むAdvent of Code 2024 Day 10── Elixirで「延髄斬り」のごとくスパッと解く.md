---
title: 闘魂で挑むAdvent of Code 2024 Day 10── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-26T09:58:00+09:00'
id: 388775a2958213a076d9
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

本日は[Day 10: Hoof It](https://adventofcode.com/2024/day/10) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

1. Data Structure
    - Parse input into 2D grid of heights
    - Store dimensions

1. Main Algorithm Steps
    - Find all trailheads (height 0)
    - For each trailhead:
        - Find all reachable height 9 positions
        - Score = count of reachable 9s
    - Sum all scores

1. Path Finding
    - Use BFS to find valid hiking trails
    - Only move up/down/left/right
    - Must increase height by exactly 1 each step


```elixir:advent_of_code_2024_day10_part1.exs
defmodule AdventOfCode2024Day10Part1 do
  def solve(input) do
    grid = parse_grid(input)
    dims = get_dimensions(grid)

    find_trailheads(grid)
    |> Enum.map(&count_reachable_peaks(&1, grid, dims))
    |> Enum.sum()
  end

  defp parse_grid(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
  end

  defp get_dimensions(grid) do
    {length(hd(grid)), length(grid)}
  end

  defp find_trailheads(grid) do
    for {row, y} <- Enum.with_index(grid),
        {height, x} <- Enum.with_index(row),
        height == 0,
        do: {x, y}
  end

  defp count_reachable_peaks(start, grid, dims) do
    bfs([{start, 0}], MapSet.new([start]), MapSet.new(), grid, dims)
    |> MapSet.size()
  end

  defp bfs([], _visited, peaks, _grid, _dims), do: peaks
  defp bfs([{{x, y}, height} | rest], visited, peaks, grid, dims) do
    curr_height = get_height(grid, {x, y})

    if curr_height == 9 do
      bfs(rest, visited, MapSet.put(peaks, {x, y}), grid, dims)
    else
      neighbors = get_valid_neighbors({x, y}, curr_height, grid, dims, visited)
      new_visited = Enum.reduce(neighbors, visited, &MapSet.put(&2, &1))
      new_queue = rest ++ Enum.map(neighbors, &{&1, height + 1})
      bfs(new_queue, new_visited, peaks, grid, dims)
    end
  end

  defp get_height(grid, {x, y}) do
    Enum.at(grid, y) |> Enum.at(x)
  end

  defp get_valid_neighbors({x, y}, height, grid, {width, height_limit}, visited) do
    [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
    |> Enum.filter(fn {nx, ny} ->
      nx >= 0 and nx < width and
      ny >= 0 and ny < height_limit and
      not MapSet.member?(visited, {nx, ny}) and
      get_height(grid, {nx, ny}) == height + 1
    end)
  end
end

# Test with example input
input = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
input |> AdventOfCode2024Day10Part1.solve() |> IO.puts()
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day10_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day10_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

1. Key Changes from Part 1

    - Instead of counting reachable 9s
    - Count unique paths from each trailhead
    - Each path must increase by 1 at each step

1. Algorithm Steps

    1. Find trailheads (height 0)
    1. For each trailhead:
        - Use DFS to find all possible paths
        - Track only valid paths (height increases by 1)
    1. Sum all path counts

```elixir:advent_of_code_2024_day10_part2.exs
defmodule AdventOfCode2024Day10Part2 do
  def solve(input) do
    grid = parse_grid(input)
    dims = get_dimensions(grid)

    find_trailheads(grid)
    |> Enum.map(&count_unique_paths(&1, grid, dims))
    |> Enum.sum()
  end

  defp parse_grid(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)
  end

  defp get_dimensions(grid) do
    {length(hd(grid)), length(grid)}
  end

  defp find_trailheads(grid) do
    for {row, y} <- Enum.with_index(grid),
        {height, x} <- Enum.with_index(row),
        height == 0,
        do: {x, y}
  end

  defp count_unique_paths(start, grid, dims) do
    dfs(start, grid, dims, MapSet.new([start]))
  end

  defp dfs(pos, grid, dims, visited) do
    curr_height = get_height(grid, pos)

    if curr_height == 9 do
      1
    else
      next_positions = get_valid_next_positions(pos, curr_height, grid, dims, visited)

      Enum.reduce(next_positions, 0, fn next_pos, sum ->
        sum + dfs(next_pos, grid, dims, MapSet.put(visited, next_pos))
      end)
    end
  end

  defp get_height(grid, {x, y}) do
    Enum.at(grid, y) |> Enum.at(x)
  end

  defp get_valid_next_positions({x, y}, height, grid, {width, height_limit}, visited) do
    [{x+1, y}, {x-1, y}, {x, y+1}, {x, y-1}]
    |> Enum.filter(fn {nx, ny} ->
      nx >= 0 and nx < width and
      ny >= 0 and ny < height_limit and
      not MapSet.member?(visited, {nx, ny}) and
      get_height(grid, {nx, ny}) == height + 1
    end)
  end
end

# Test with example input
input = """
89010123
78121874
87430965
96549874
45678903
32019012
01329801
10456732
"""
input |> AdventOfCode2024Day10Part2.solve() |> IO.puts()
```

### Key differences:

- Uses DFS instead of BFS
- Counts paths instead of destinations
- Returns sum of paths when reaching height 9
- Maintains visited set per path


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day10_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir advent_of_code_2024_day10_part2.exs"
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

- Day 10を解いておくれ。--- Day 10: Hoof It --- You all arrive at a Lava Production Facility on a floating island in the sky. As the others begin to search the massive industrial complex, you feel a small nose boop your leg and look down to discover a reindeer wearing a hard hat.(略)
- Thanks a lot for Part 1 answer complete!!! Part 2もお願いします。--- Part Two --- The reindeer spends a few minutes reviewing your hiking trail map before realizing something, disappearing for a few minutes, and finally returning with yet another slightly-charred piece of paper.(略)


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

https://qiita.com/RyoWakabayashi/items/f470bec3aac71ac5d41c

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
