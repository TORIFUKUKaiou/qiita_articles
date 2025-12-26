---
title: 'Advent of Code 2025 Day 1: Secret Entrance をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-25T09:45:56+09:00'
id: c35348d85b328eddaa14
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 1を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/c0868e2ffed61a7d947a

[Advent of Code Day 1: Secret Entrance をRustで解いた](https://qiita.com/haw_ohnuma/items/c0868e2ffed61a7d947a)

## Day 1: Secret Entrance
問題文は、[Day 1: Secret Entrance](https://adventofcode.com/2025/day/1)を読んでください。  
円形のダイヤルを右に左にとまわす問題です。Part 1は、0に止まる回数をカウントし、Part 2は0を通過する回数をカウントします。

私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

```elixir
defmodule AdventOfCode2025Day1Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end
  
  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
  end

  defp solve(list) do
    list
    |> Enum.reduce([50], &rotate/2)
    |> Enum.count(& &1 == 0)
  end

  defp rotate({:left, number}, [current | _] = acc) do
    new_current = normalize(current - number)
    [new_current | acc]
  end

  defp rotate({:right, number}, [current | _] = acc) do
    new_current = normalize(current + number)
    [new_current | acc]
  end

  defp normalize(number) when number > 99, do: normalize(number - 100)
  defp normalize(number) when number < 0, do: normalize(100 + number)
  defp normalize(number), do: number

  defp parse(<<"L", number::binary>>), do: {:left, String.to_integer(number)}
  defp parse(<<"R", number::binary>>), do: {:right, String.to_integer(number)}
end

input = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

AdventOfCode2025Day1Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

```elixir
defmodule AdventOfCode2025Day1Part2 do
  def run(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse/1)
    |> Enum.reduce({[50], 0}, &rotate/2)
    |> elem(1)
  end

  defp rotate({:left, number}, {[current | _] = list, count}) do
    {new_current, new_count} = move(current, -number)
    {[new_current | list], count + new_count}
  end

  defp rotate({:right, number}, {[current | _] = list, count}) do
    {new_current, new_count} = move(current, number)
    {[new_current | list], count + new_count}
  end

  defp move(0, distance) when distance < 0 do
    {normalize(distance), div(distance, 100) * -1}
  end

  defp move(current, distance) when (current + distance) == 0 do
    {0, 1}
  end

  defp move(current, distance) when distance < 0 and (current + distance) < 0 do
    {normalize(current + distance), div(current + distance, 100) * -1 + 1}
  end

  defp move(current, distance) when distance < 0 do
    {normalize(current + distance), div(current + distance, 100) * -1}
  end

  defp move(current, distance) do
    {normalize(current + distance), div(current + distance, 100)}
  end

  defp normalize(number) when number > 99, do: normalize(number - 100)
  defp normalize(number) when number < 0, do: normalize(100 + number)
  defp normalize(number), do: number

  defp parse(<<"L", num::binary>>), do: {:left, String.to_integer(num)}
  defp parse(<<"R", num::binary>>), do: {:right, String.to_integer(num)}
end

input = """
L68
L30
R48
L5
R60
L55
L1
L99
R14
L82
"""

AdventOfCode2025Day1Part2.run(input)
```
</details>


## さいごに
Part 1は自分の力だけで解けました :tada: 
Part 2は、小さな量のサンプルデータだと通るのだけれども本番のデータでは解答とあわず苦戦しました。（こういうのが特に困る :sweat:）特に左まわりのところのエッジケースでのケア漏れがありました。デバッグにはGenerative AIs([Codex CLI](https://developers.openai.com/codex/cli/)、[Kiro CLI](https://kiro.dev/cli/))の力を利用しました。やっぱりもうGenerative AIsが欠かせないものになっています。

Day 1でこんな状況なので、どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
