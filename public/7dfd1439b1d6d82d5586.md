---
title: 闘魂Elixir ── Advent of code 2023 Day 5をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-06T08:55:39+09:00'
id: 7dfd1439b1d6d82d5586
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir


# はじめに

今年もいよいよやってまいりました！ :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 
[Elixir](https://elixir-lang.org/)で、[Advent of code 2023](https://adventofcode.com/2023)の問題を解いてみます。

https://adventofcode.com/2023

1日1題ずつ問題が出題されます。
実行時間は問われません。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [Day 5: If You Give A Seed A Fertilizer](https://adventofcode.com/2023/day/5)

[Day 5: If You Give A Seed A Fertilizer](https://adventofcode.com/2023/day/5)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

## 私の答え Part One

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
input = """
seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4
"""

defmodule Awesome do
  def run(input) do
    seeds = seeds(input)
    seed_to_soil_map = map(input, "seed-to-soil map:\n")
    soil_to_fertilizer_map = map(input, "soil-to-fertilizer map:\n")
    fertilizer_to_water_map = map(input, "fertilizer-to-water map:\n")
    water_to_light_map = map(input, "water-to-light map:\n")
    light_to_temperature_map = map(input, "light-to-temperature map:\n")
    temperature_to_humidity_map = map(input, "temperature-to-humidity map:\n")
    humidity_to_location_map = map(input, "humidity-to-location map:\n")

    seeds
    |> Enum.map(fn seed ->
      seed
      |> get(seed_to_soil_map)
      |> get(soil_to_fertilizer_map)
      |> get(fertilizer_to_water_map)
      |> get(water_to_light_map)
      |> get(light_to_temperature_map)
      |> get(temperature_to_humidity_map)
      |> get(humidity_to_location_map)
    end)
    |> Enum.min()
  end

  defp get(source, map) do
    case Enum.find(map, fn {source_range, _destination_range} -> source in source_range end) do
      nil ->
        source

      {source_range, destination_range} ->
        index = source - Enum.at(source_range, 0)
        Enum.at(destination_range, index)
    end
  end

  defp seeds(input) do
    input
    |> String.split("seeds:", trim: true)
    |> Enum.at(0)
    |> String.split("\n")
    |> Enum.at(0)
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp map(input, title) do
    input
    |> String.split(title, trim: true)
    |> Enum.at(1)
    |> String.split("\n\n")
    |> Enum.at(0)
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      [destination_range_start, source_range_start, range_length] =
        String.split(line, " ") |> Enum.map(&String.to_integer/1)

      Map.merge(acc, %{
        build_range(source_range_start, range_length) =>
          build_range(destination_range_start, range_length)
      })
    end)
  end

  def build_range(start, length), do: start..(start + length - 1)
end

Awesome.run(input)
```

</details>


## 私の答え Part Two

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>



```elixir
defmodule Awesome2 do
  def run(input, init \\ 0) do
    seeds = seeds(input) |> IO.inspect()
    soil_to_seed_map = map(input, "seed-to-soil map:\n")
    fertilizer_to_soil_map = map(input, "soil-to-fertilizer map:\n")
    water_to_fertilizer_map = map(input, "fertilizer-to-water map:\n")
    light_to_water_map = map(input, "water-to-light map:\n")
    temperature_to_light_map = map(input, "light-to-temperature map:\n")
    humidity_to_temperature_map = map(input, "temperature-to-humidity map:\n")
    location_to_humidity_map = map(input, "humidity-to-location map:\n")

    Stream.iterate(init, &(&1 + 1))
    |> Enum.reduce_while(nil, fn location, nil ->
      IO.inspect(location)

      seed =
        location
        |> get(location_to_humidity_map)
        |> get(humidity_to_temperature_map)
        |> get(temperature_to_light_map)
        |> get(light_to_water_map)
        |> get(water_to_fertilizer_map)
        |> get(fertilizer_to_soil_map)
        |> get(soil_to_seed_map)

      case Enum.any?(seeds, fn seed_range -> seed in seed_range end) do
        true -> {:halt, location}
        false -> {:cont, nil}
      end
    end)
  end

  defp get(source, map) do
    case Enum.find(map, fn {source_range, _destination_range} -> source in source_range end) do
      nil ->
        source

      {source_range, destination_range} ->
        index = source - Enum.at(source_range, 0)
        Enum.at(destination_range, index)
    end
  end

  defp seeds(input) do
    input
    |> String.split("seeds:", trim: true)
    |> Enum.at(0)
    |> String.split("\n")
    |> Enum.at(0)
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(2)
    |> Enum.reduce([], fn [start, length], acc ->
      acc ++ [build_range(start, length)]
    end)
  end

  defp map(input, title) do
    input
    |> String.split(title, trim: true)
    |> Enum.at(1)
    |> String.split("\n\n")
    |> Enum.at(0)
    |> String.split("\n", trim: true)
    |> Enum.reduce(%{}, fn line, acc ->
      [destination_range_start, source_range_start, range_length] =
        String.split(line, " ") |> Enum.map(&String.to_integer/1)

      Map.merge(acc, %{
        build_range(destination_range_start, range_length) =>
          build_range(source_range_start, range_length)
      })
    end)
  end

  def build_range(start, length), do: start..(start + length - 1)
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;If You Give A Seed A Fertilizer&quot; - Day 5 - Advent of Code 2023 <a href="https://t.co/6IhqheMRug">https://t.co/6IhqheMRug</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1732041497963614347?ref_src=twsrc%5Etfw">December 5, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 5: If You Give A Seed A Fertilizer](https://adventofcode.com/2023/day/5)を[Elixir](https://elixir-lang.org/)で解きました。
[Advent of code 2023](https://adventofcode.com/2023)は己との闘い、まさに闘魂です。

リポジトリにあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
