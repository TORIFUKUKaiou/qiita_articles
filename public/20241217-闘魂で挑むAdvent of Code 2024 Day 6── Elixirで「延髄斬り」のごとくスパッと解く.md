---
title: 闘魂で挑むAdvent of Code 2024 Day 6── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-19T07:28:36+09:00'
id: 003456237a7c91503992
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

本日は[Day 6: Guard Gallivant](https://adventofcode.com/2024/day/6) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

`Claude 3.5 Sonnet (Preview)`

まず、以下の手順で実装します。

1. 入力を解析してグリッドを作成。
2. ガードの開始位置と向きを特定。
3. ガードの移動をシミュレート。
   * 前方に障害物またはマップ外の場合、右に90度回転。
   * それ以外の場合、前進。
   * 訪れた位置を記録。
4. ガードがマップから出るまで繰り返す。
5. 訪れた位置の総数を返す。

以下にElixirでの実装を示します。


```elixir:advent_of_code_2024_day6_part1.exs
defmodule AdventOfCode2024Day6Part1 do
  def count_visited_positions(input) do
    grid = parse_input(input)
    {guard_pos, dir_index} = find_guard(grid)
    visited = MapSet.new([guard_pos])
    grid_size = {length(grid), length(Enum.at(grid, 0))}
    directions = [{0, -1}, {1, 0}, {0, 1}, {-1, 0}]  # 上、右、下、左

    {_, _, visited_positions} =
      simulate(grid, guard_pos, dir_index, visited, grid_size, directions)

    MapSet.size(visited_positions)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp find_guard(grid) do
    direction_map = %{
      "^" => 0,  # 上
      ">" => 1,  # 右
      "v" => 2,  # 下
      "<" => 3   # 左
    }

    Enum.with_index(grid)
    |> Enum.reduce_while(nil, fn {row, y}, _ ->
      Enum.with_index(row)
      |> Enum.find_value(fn {cell, x} ->
        case Map.get(direction_map, cell) do
          nil -> nil
          dir_index -> {{x, y}, dir_index}
        end
      end)
      |> case do
        nil -> {:cont, nil}
        result -> {:halt, result}
      end
    end)
  end

  defp simulate(grid, {x, y}, dir_index, visited, {height, width}, directions) do
    dir = Enum.at(directions, dir_index)
    {dx, dy} = dir
    nx = x + dx
    ny = y + dy

    cond do
      nx < 0 or nx >= width or ny < 0 or ny >= height ->
        # マップ外に出た
        {{x, y}, dir_index, visited}

      Enum.at(Enum.at(grid, ny), nx) == "#" ->
        # 障害物があるので右に90度回転
        new_dir_index = rem(dir_index + 1, 4)
        simulate(grid, {x, y}, new_dir_index, visited, {height, width}, directions)

      true ->
        # 前進
        new_visited = MapSet.put(visited, {nx, ny})
        simulate(grid, {nx, ny}, dir_index, new_visited, {height, width}, directions)
    end
  end
end

# 使用例
input = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

input |> AdventOfCode2024Day6Part1.count_visited_positions() |> IO.puts()
```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day6_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day6_part1.exs"
```

</details>

## Part 2


続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

`Claude 3.5 Sonnet (Preview)`

Part 2では、ガードがループに陥るような障害物の設置位置をすべて特定する必要があります。以下の手順で実装します。

1. 入力からグリッドを解析します。
2. ガードの開始位置と方向を特定します。
3. 障害物を設置できるすべての位置（ガードの開始位置と既存の障害物を除く）を取得します。
4. 各可能な位置に障害物を追加し、ガードがループに陥るかをシミュレートします。
5. ガードがループする場合、その位置をカウントします。



```elixir:advent_of_code_2024_day6_part2.exs
defmodule AdventOfCode2024Day6Part2 do
  def count_obstruction_positions(input) do
    grid = parse_input(input)
    {guard_pos, guard_dir_index} = find_guard(grid)
    grid_size = {length(grid), length(Enum.at(grid, 0))}
    directions = [{0, -1}, {1, 0}, {0, 1}, {-1, 0}]  # 上、右、下、左

    # 設置可能な位置（ガードの開始位置と既存の障害物を除く）
    possible_positions = for y <- 0..(length(grid) - 1),
                             x <- 0..(length(Enum.at(grid, 0)) - 1),
                             Enum.at(Enum.at(grid, y), x) == ".",
                             {x, y} != guard_pos,
                             do: {x, y}

    # 各位置に障害物を設置し、ループするかチェック
    possible_positions
    |> Enum.filter(fn obstruction_pos ->
      new_grid = put_obstruction(grid, obstruction_pos)
      simulate_with_loop_detection(new_grid, guard_pos, guard_dir_index, grid_size, directions)
    end)
    |> Enum.count()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  defp find_guard(grid) do
    direction_map = %{
      "^" => 0,  # 上
      ">" => 1,  # 右
      "v" => 2,  # 下
      "<" => 3   # 左
    }

    Enum.with_index(grid)
    |> Enum.reduce_while(nil, fn {row, y}, _ ->
      Enum.with_index(row)
      |> Enum.find_value(fn {cell, x} ->
        case Map.get(direction_map, cell) do
          nil -> nil
          dir_index -> {{x, y}, dir_index}
        end
      end)
      |> case do
        nil -> {:cont, nil}
        result -> {:halt, result}
      end
    end)
  end

  defp put_obstruction(grid, {x, y}) do
    List.update_at(grid, y, fn row ->
      List.update_at(row, x, fn _ -> "#" end)
    end)
  end

  defp simulate_with_loop_detection(grid, guard_pos, dir_index, grid_size, directions) do
    visited = MapSet.new()
    simulate_loop(grid, guard_pos, dir_index, grid_size, directions, visited)
  end

  defp simulate_loop(grid, {x, y} = pos, dir_index, {height, width}, directions, visited) do
    if MapSet.member?(visited, {pos, dir_index}) do
      # ループ検出
      true
    else
      dir = Enum.at(directions, dir_index)
      {dx, dy} = dir
      nx = x + dx
      ny = y + dy

      cond do
        nx < 0 or nx >= width or ny < 0 or ny >= height ->
          # マップ外に出た
          false

        Enum.at(Enum.at(grid, ny), nx) == "#" ->
          # 障害物があるので右に90度回転
          new_dir_index = rem(dir_index + 1, 4)
          simulate_loop(grid, pos, new_dir_index, {height, width}, directions, MapSet.put(visited, {pos, dir_index}))

        true ->
          # 前進
          simulate_loop(grid, {nx, ny}, dir_index, {height, width}, directions, MapSet.put(visited, {pos, dir_index}))
      end
    end
  end
end

# 使用例
input = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

input |> AdventOfCode2024Day6Part2.count_obstruction_positions() |> IO.puts()
```



### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day6_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day6_part2.exs"
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

- Day 6をElixirで解くのを手伝ってください。--- Day 6: Guard Gallivant --- (略)
- Great!!! Part 2もお願いします！--- Part Two --- (略)

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

https://qiita.com/RyoWakabayashi/items/5d86e73950b199d0c97d


https://qiita.com/RyoWakabayashi/items/26af90614aefa7244cd2

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
