---
title: 'Advent Of Code 2021 (Day 9: Smoke Basin)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:47:32+09:00'
id: 92803b9eb4fb9b7bdf07
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---

**ありま山ゐなの笹原風吹けばいでそよ人を忘れやはする**

Advent Calendar 2022 110日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 9: Smoke Basin](https://adventofcode.com/2021/day/9)を[Elixir](https://elixir-lang.org/)で楽しんでみます。


![スクリーンショット 2022-05-05 20.59.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5264e6bf-87f0-5e05-4909-d260eacc0c11.png)





https://adventofcode.com/2021/day/9


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
2199943210
3987894921
9856789892
8767896789
9899965678
"""
```

## Part 1

```elixir
for i <- 0..(rows - 1),
    j <- 0..(columns - 1),
    value = Map.get(parsed, i, %{}) |> Map.get(j, ?9),
    up = Map.get(parsed, i - 1, %{}) |> Map.get(j, ?9),
    down = Map.get(parsed, i + 1, %{}) |> Map.get(j, ?9),
    left = Map.get(parsed, i, %{}) |> Map.get(j - 1, ?9),
    right = Map.get(parsed, i, %{}) |> Map.get(j + 1, ?9),
    value < up,
    value < down,
    value < left,
    value < right do
  value
end
|> Enum.reduce(0, fn value, acc -> value - ?0 + 1 + acc end)
|> IO.inspect()
```

## Part 2

```elixir
parsed =
  input
  |> String.split("\n", trim: true)
  |> Enum.with_index(fn element, index ->
    {index,
     element
     |> String.to_charlist()
     |> Enum.with_index(fn element, index -> {index, element} end)
     |> Map.new()}
  end)
  |> Map.new()
  |> IO.inspect()

defmodule Recursion do
  def recur({i, j}, map) do
    recur([{i, j}], map, MapSet.new())
  end

  defp recur([], _map, map_set), do: map_set

  defp recur([{i, j} = head | tail], map, map_set) do
    value = Map.get(map, i) |> Map.get(j)
    up = Map.get(map, i - 1, %{}) |> Map.get(j, 100)
    down = Map.get(map, i + 1, %{}) |> Map.get(j, 100)
    left = Map.get(map, i, %{}) |> Map.get(j - 1, 100)
    right = Map.get(map, i, %{}) |> Map.get(j + 1, 100)
    map_set = if value != ?9, do: MapSet.put(map_set, head), else: map_set

    tail
    |> do_search(value, up, {i - 1, j}, map_set)
    |> do_search(value, down, {i + 1, j}, map_set)
    |> do_search(value, left, {i, j - 1}, map_set)
    |> do_search(value, right, {i, j + 1}, map_set)
    |> recur(map, map_set)
  end

  defp do_search(list, ?9, ?9, _tuple, _map_set), do: list
  defp do_search(list, ?9, _v2, _tuple, _map_set), do: list
  defp do_search(list, _v1, ?9, _tuple, _map_set), do: list
  defp do_search(list, _v1, 100, _tuple, _map_set), do: list

  defp do_search(list, v1, v2, tuple, map_set) do
    if tuple in map_set do
      list
    else
      [tuple | list]
    end
  end
end

rows = Enum.count(parsed)
%{0 => map} = parsed
columns = Enum.count(map)

for i <- 0..(rows - 1), j <- 0..(columns - 1), uniq: true do
  Recursion.recur({i, j}, parsed)
end
|> Enum.sort_by(&Enum.count/1, :desc)
|> IO.inspect()
|> Enum.take(3)
|> Enum.map(&Enum.count/1)
|> Enum.product()
|> IO.inspect()
```


</details>

**It works!**
**Amazing!**

解けてはいますがお手本と比べると長いし、なんだかいろいろイマイチです :sweat_smile: 


# お手本

Day 9のお手本([José Valim](https://twitter.com/josevalim)さんの動画)があります :rocket:

<iframe width="864" height="486" src="https://www.youtube.com/embed/vtqNhatQCIo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<details><summary>お手本</summary>

```elixir
input = """
2199943210
3987894921
9856789892
8767896789
9899965678
"""
```

# Part 1

```elixir
grid =
  for {line, row} <- Enum.with_index(input |> String.split("\n", trim: true)),
      {number, col} <- Enum.with_index(line |> String.to_charlist()),
      into: %{} do
    {{row, col}, number - ?0}
  end

low_points =
  grid
  |> Enum.filter(fn {{row, col}, number} ->
    up = grid[{row - 1, col}]
    down = grid[{row + 1, col}]
    left = grid[{row, col - 1}]
    right = grid[{row, col + 1}]

    number < up and number < down and number < left and number < right
  end)

low_points
|> Enum.map(fn {_point, number} -> number + 1 end)
|> Enum.sum()
|> IO.inspect()
```

## Part 2

```elixir
defmodule Recursion do
  def basin(point, grid) do
    basin(MapSet.new(), point, grid)
  end

  defp basin(seen, {row, col} = point, grid) do
    if point in seen or grid[point] in [9, nil] do
      seen
    else
      seen
      |> MapSet.put(point)
      |> basin({row - 1, col}, grid)
      |> basin({row + 1, col}, grid)
      |> basin({row, col - 1}, grid)
      |> basin({row, col + 1}, grid)
    end
  end
end

low_points
|> Enum.map(fn {point, _} -> Recursion.basin(point, grid) |> MapSet.size() end)
|> Enum.sort(:desc)
|> Enum.take(3)
|> Enum.product()
|> IO.inspect()
```

**美しい！　短い！**

- [for/1](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)の使い方がうまい！
- アトムは数値よりも大小比較で必ずアトムのほうが大きくなることを巧みに利用して、範囲外の値と比較をしている
  - 詳細: https://hexdocs.pm/elixir/operators.html#term-ordering 

`number < atom < reference < function < port < pid < tuple < map < list < bitstring`

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 9: Smoke Basin](https://adventofcode.com/2021/day/9)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
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




