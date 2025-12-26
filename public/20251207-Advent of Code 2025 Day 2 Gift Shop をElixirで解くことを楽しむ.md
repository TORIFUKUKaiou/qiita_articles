---
title: 'Advent of Code 2025 Day 2: Gift Shop をElixirで解くことを楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-25T09:46:19+09:00'
id: 74b1872c7ab3fedde968
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに
[Advent of Code 2025](https://adventofcode.com/2025) Day 2を解いてみます。  
できるだけGenerative AIsの力を使わずに解いてみます。

今年はDay 12までなのかな? あとで増えるのかな。

## GitHub
Livebookのnotebook集を公開しておきます。
[livebooks](https://github.com/TORIFUKUKaiou/livebooks)

## 参考記事

https://qiita.com/haw_ohnuma/items/3150c85fcd1d8f803a81

[Advent of Code Day 2: Gift Shop をRustで解いた](https://qiita.com/haw_ohnuma/items/3150c85fcd1d8f803a81)

## Day 2: Gift Shop
問題文は、[Day 2: Gift Shop](https://adventofcode.com/2025/day/2)を読んでください。  
数字の範囲インプットが渡されて、数字が繰り返しでていると不正IDとみなし、不正IDを検出して全部を足すという問題です。
Part 1は、半分で割ったところの前後で一致するかどうか。
Part 2は、Part 1のルールに加えて、999や565656などもあわせて検出してほしいという問題です。

私の解答は折りたたんでおきます。

### Part 1

<details><summary>Part 1</summary>

```elixir
defmodule AwesomeInvalidIDCheckerPart1 do
  def run(number) do
    charlist = number
    |> Integer.to_string() 
    |> String.to_charlist()

    maybe_invalid = charlist
    |> Enum.frequencies
    |> Enum.all?(fn {_, cnt} -> rem(cnt, 2) == 0 end)

    if maybe_invalid do
      len = Enum.count(charlist)
      head = charlist |> Enum.slice(0..(div(len, 2) - 1))
      tail = charlist |> Enum.slice(div(len, 2)..(len - 1))
      head == tail
    else
      false
    end
  end
end

defmodule AdventOfCode2025Day2Part1 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_ranges) do
    list_of_ranges
    |> Enum.reduce(0, fn range, acc ->
      range
      |> Enum.reduce(acc, fn number, acc ->
        fun(AwesomeInvalidIDCheckerPart1.run(number), number, acc)
      end)
    end)
  end

  defp fun(true, number, acc), do: number + acc
  defp fun(false, _number, acc), do: acc

  defp parse_input(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&parse/1)
  end

  defp parse(range) do
    %{"first" => first, "last" => last} = Regex.named_captures(~r/(?<first>\d+)-(?<last>\d+)/, range)
    Range.new(String.to_integer(first), String.to_integer(last))
  end
end

input = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

AdventOfCode2025Day2Part1.run(input)
```
</details>

### Part 2

<details><summary>Part 2</summary>

```elixir
defmodule AwesomeInvalidIDCheckerPart2 do
  def run(number) do
    charlist = number
    |> Integer.to_string() 
    |> String.to_charlist()

    if Enum.count(charlist) > 1 do
      1..div(Enum.count(charlist), 2)
      |> Enum.any?(fn count ->
        [head | tail] = Enum.chunk_every(charlist, count)
        Enum.all?(tail, & &1 == head)
      end)
    else
      false
    end
  end
end

defmodule AdventOfCode2025Day2Part2 do
  def run(input) do
    input
    |> parse_input()
    |> solve()
  end

  defp solve(list_of_ranges) do
    list_of_ranges
    |> Enum.reduce(0, fn range, acc ->
      range
      |> Enum.reduce(acc, fn number, acc ->
        fun(AwesomeInvalidIDCheckerPart2.run(number), number, acc)
      end)
    end)
  end

  defp fun(true, number, acc), do: number + acc
  defp fun(false, _number, acc), do: acc

  defp parse_input(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&parse/1)
  end

  defp parse(range) do
    %{"first" => first, "last" => last} = Regex.named_captures(~r/(?<first>\d+)-(?<last>\d+)/, range)
    Range.new(String.to_integer(first), String.to_integer(last))
  end
end

input = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

AdventOfCode2025Day2Part2.run(input)
```
</details>


## さいごに
今回は自力で全部解けました。力技で解けました。Part 2は本番データで誤答をだしました。以下の警告をヒントに、「あーね」と自力で修正ができました。よかった :tada: 

```elixir
warning: Range.new/2 and first..last default to a step of -1 when last < first. Use Range.new(first, last, -1) or first..last//-1, or pass 1 if that was your intention
```

Day 1とDay 2でこんな状況なので、どこまでできるかわかりませんが、たまには自分で書くこともしたほうがよさそうなので、[Advent of Code 2025](https://adventofcode.com/2025)を引き続き解いて行くことを楽しみたいと思います。

[Advent of Code 2025](https://adventofcode.com/2025)を解くことは、闘魂活動だと思います。
