---
title: 'Advent Of Code 2021 (Day 8: Seven Segment Search)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:48:03+09:00'
id: c0c55da8c6dde4bb6f1a
organization_url_name: fukuokaex
slide: false
---

**めぐりあひて見しやそれともわかぬまに雲隠れにし夜はの月かな**

Advent Calendar 2022 109日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8)を[Elixir](https://elixir-lang.org/)で楽しんでみます。


![スクリーンショット 2022-04-30 23.23.24.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a60b49b6-0589-66aa-8ad2-dc00d29e11cd.png)




https://adventofcode.com/2021/day/8


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""
```

## Part 1

```elixir
input
|> String.split("\n", trim: true)
|> Enum.reduce([], fn s, acc ->
  [_left, right] = s
  |> String.split("|")
  |> Enum.map(& String.split(&1, " ", trim: true) |> Enum.map(fn s -> String.length(s) end))

  [right | acc]
end)
|> List.flatten
|> Enum.filter(& &1 == 2 or &1 == 4 or &1 == 3 or &1 == 7)
|> Enum.count
```

## Part 2

```elixir
defmodule Recursion do
  def recur(row) do
    recur(row, %{})
  end
  
  defp recur({[], right}, map) do
    IO.inspect map
    reversed_map = map
      |> Enum.to_list()
      |> Enum.map(fn {k, v} -> {v, k} end)
      |> Map.new()
    
    [a, b, c, d] = right |> Enum.map(& reversed_map[&1])
    1000 * a + 100 * b + 10 * c + d
  end
  
  defp recur({[head | tail], right}, map) do
    do_recur({tail, right}, head, Enum.count(head), map)
  end
  
  defp do_recur({tail, right}, head, 2, map) do
    recur({tail, right}, Map.merge(map, %{1 => head}))
  end
  
  defp do_recur({tail, right}, head, 4, map) do
    recur({tail, right}, Map.merge(map, %{4 => head}))
  end
  
  defp do_recur({tail, right}, head, 3, map) do
    recur({tail, right}, Map.merge(map, %{7 => head}))
  end
  
  defp do_recur({tail, right}, head, 7, map) do
    recur({tail, right}, Map.merge(map, %{8 => head}))
  end
  
  defp do_recur({tail, right}, head, 5, map) do
    cond do
      map[1] && MapSet.subset?(map[1], head) -> recur({tail, right}, Map.merge(map, %{3 => head}))
      map[3] && map[9] && MapSet.subset?(head, map[9]) -> recur({tail, right}, Map.merge(map, %{5 => head}))
      map[3] && map[9] && !MapSet.subset?(head, map[9]) -> recur({tail, right}, Map.merge(map, %{2 => head}))
      true -> recur({tail ++ [head], right}, map)
    end
  end
  
  defp do_recur({tail, right}, head, 6, map) do
    cond do
      map[4] && MapSet.subset?(map[4], head) -> recur({tail, right}, Map.merge(map, %{9 => head}))
      map[9] && map[5] && MapSet.subset?(map[5], head) -> recur({tail, right}, Map.merge(map, %{6 => head}))
      map[9] && map[5] && !MapSet.subset?(map[5], head) -> recur({tail, right}, Map.merge(map, %{0 => head}))
      true -> recur({tail ++ [head], right}, map)
    end
  end
end


input |> String.split("\n", trim: true) |> Enum.reduce([], fn s, acc ->
  [left, right] = s
  |> String.split("|")
  |> Enum.map(& String.split(&1, " ", trim: true) |> Enum.map(fn s -> String.codepoints(s) |> MapSet.new() end))

  [{left, right} | acc]
end)
|> Enum.map(&Recursion.recur/1)
|> Enum.sum
```


</details>

**It works!**
**Amazing!**



# お手本

Day 8のお手本([José Valim](https://twitter.com/josevalim)さんの動画)があります :rocket:

<iframe width="891" height="501" src="https://www.youtube.com/embed/GWmGp5V11mk?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<details><summary>お手本</summary>

```elixir
input = """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
"""
```

# Part 1

```elixir
parsed =
  input
  |> String.split([" |\n", " | ", "\n"], trim: true) 
  |> Enum.chunk_every(2) 
  |> Enum.map(fn [input, output] -> 
    {String.split(input), String.split(output)}
  end)

parsed
|> Enum.map(fn {_input, output} -> 
  Enum.count(output, &byte_size(&1) in [2, 7, 3, 4])
end)
|> Enum.sum()
```

## Part 2

```elixir
parsed =
  input
  |> String.split([" |\n", " | ", "\n"], trim: true) 
  |> Enum.chunk_every(2) 
  |> Enum.map(fn [input, output] -> 
    {input |> String.split() |> Enum.group_by(&byte_size/1, &String.to_charlist/1),
     output |> String.split() |> Enum.map(&String.to_charlist/1)}
  end)

Enum.map(parsed, fn {input, output} ->
  %{
    2 => [one],
    3 => [seven],
    4 => [four],
    5 => two_three_five,
    6 => zero_six_nine,
    7 => [eight]
  } = input

  [nine] = Enum.filter(zero_six_nine, &match?([], four -- &1))
  [zero] = Enum.filter(zero_six_nine, &match?([], seven -- &1)) -- [nine]
  [six] = Enum.filter(zero_six_nine, &match?([_], seven -- &1))

  [three] = Enum.filter(two_three_five, &match?([], seven -- &1))
  [five] = Enum.filter(two_three_five, &match?([_], six -- &1))
  [two] = two_three_five -- [three, five]

  numbers = %{
    Enum.sort(zero) => 0,
    Enum.sort(one) => 1,
    Enum.sort(two) => 2,
    Enum.sort(three) => 3,
    Enum.sort(four) => 4,
    Enum.sort(five) => 5,
    Enum.sort(six) => 6,
    Enum.sort(seven) => 7,
    Enum.sort(eight) => 8,
    Enum.sort(nine) => 9,
  }

  [d1, d2, d3, d4] = output

  numbers[Enum.sort(d1)] * 1000 + numbers[Enum.sort(d2)] * 100 +
    numbers[Enum.sort(d3)] * 10 + numbers[Enum.sort(d4)]
end)
|> Enum.sum()
```

**美しい！　短い！**

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 8: Seven Segment Search](https://adventofcode.com/2021/day/8)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
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

---

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We appreciate this shoutout, Torifuku! <a href="https://t.co/dThmJg4CYN">pic.twitter.com/dThmJg4CYN</a></p>&mdash; ClickUp (@clickup) <a href="https://twitter.com/clickup/status/1513541411634913284?ref_src=twsrc%5Etfw">April 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 
