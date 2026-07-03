---
title: 'Advent Of Code 2021 (Day 11: Dumbo Octopus)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-07T00:07:22+09:00'
id: 08f6435f3d420b8afdd2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---

**いにしへの奈良の都の八重桜今日九重ににほひぬるかな**

Advent Calendar 2022 113日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 11: Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11)を[Elixir](https://elixir-lang.org/)で楽しんでみます。









https://adventofcode.com/2021/day/11


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""
```

```elixir
grid =
  for {line, row} <- Enum.with_index(String.split(input, "\n", trim: true)),
      {number, col} <- Enum.with_index(String.to_charlist(line)),
      into: %{} do
    {{row, col}, number - ?0}
  end

defmodule DumboOctopus do
  def step(grid) do
    {grid, flashes} =
      grid
      |> Enum.reduce({%{}, []}, fn
        {point, 9}, {acc_grid, acc_flashes} ->
          {Map.merge(acc_grid, %{point => 10}), [point | acc_flashes]}

        {point, number}, {acc_grid, acc_frashes} ->
          {Map.merge(acc_grid, %{point => number + 1}), acc_frashes}
      end)

    step(grid, flashes)
  end

  defp step(grid, []) do
    grid
    |> Enum.reduce({%{}, 0}, fn {point, number}, {acc_map, acc_cnt} ->
      case number >= 10 do
        true ->
          {Map.merge(acc_map, %{point => 0}), acc_cnt + 1}

        false ->
          {Map.merge(acc_map, %{point => number}), acc_cnt}
      end
    end)
  end

  defp step(grid, flashes) do
    {grid, flashes} =
      flashes
      |> Enum.reduce({grid, []}, fn {row, col}, {grid, flashes} ->
        [
          {row - 1, col},
          {row + 1, col},
          {row, col - 1},
          {row, col + 1},
          {row - 1, col - 1},
          {row - 1, col + 1},
          {row + 1, col - 1},
          {row + 1, col + 1}
        ]
        |> Enum.reduce({grid, flashes}, fn point, {acc_grid, acc_frashes} ->
          case acc_grid[point] do
            nil -> {acc_grid, acc_frashes}
            9 -> {Map.merge(acc_grid, %{point => 10}), [point | acc_frashes]}
            number -> {Map.merge(acc_grid, %{point => number + 1}), acc_frashes}
          end
        end)
      end)

    step(grid, flashes)
  end
end

print = fn grid ->
  rows = String.split(input, "\n", trim: true) |> Enum.count()
  cols = div(Enum.count(grid), rows)

  for(i <- 0..(rows - 1), j <- 0..(cols - 1), do: grid[{i, j}])
  |> Enum.chunk_every(cols)
  |> IO.inspect()
end
```



## Part 1

```elixir
Enum.reduce(1..100, {grid, 0}, fn _, {acc_grid, acc_cnt} ->
  {new_grid, cnt} = DumboOctopus.step(acc_grid)
  #print.(new_grid)
  {new_grid, acc_cnt + cnt}
end)
|> IO.inspect()
```

## Part 2

```elixir
Enum.reduce_while(Stream.iterate(1, &(&1 + 1)), {grid, 0}, fn step, {acc_grid, _} ->
  {new_grid, _cnt} = DumboOctopus.step(acc_grid)

  all_zero? =
    new_grid
    |> Map.values()
    |> Enum.all?(&(&1 == 0))

  if all_zero?, do: {:halt, {new_grid, step}}, else: {:cont, {new_grid, step}}
end)
|> IO.inspect()
```


</details>

**It works!**
**Amazing!**




# お手本

Day 11のお手本([José Valim](https://twitter.com/josevalim)さんの動画)はないようです :sunglasses:

もし存在をご存知の方はお知らせいただけますとありがたいです！ :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 11: Dumbo Octopus](https://adventofcode.com/2021/day/11)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。

**It works!**
**Amazing!**

自分で解いてみて、なんだかイマイチだなあとおもいながら、動画をみることで[José Valim](https://twitter.com/josevalim)さんに特別家庭教師をしてもらっている気に勝手になっています :sweat_smile:。
海綿が水を吸うように、[Elixir](https://elixir-lang.org/)のイケている書き方を吸収しています。
伸びしろしかありません。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



以上です。





---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)




