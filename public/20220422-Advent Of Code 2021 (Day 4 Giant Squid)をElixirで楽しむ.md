---
title: 'Advent Of Code 2021 (Day 4: Giant Squid)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:49:51+09:00'
id: 9d575ddcc7791593bf53
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---

**歎きつつひとりぬる夜の明くるまはいかに久しきものとかは知る**

Advent Calendar 2022 105日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 4: Giant Squid](https://adventofcode.com/2021/day/4)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-22 23.11.09.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/247f859c-a714-f8ba-1934-3e9c0afcb94d.png)



https://adventofcode.com/2021/day/4


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""
```

## Part 1

```elixir
[randoms | boards] = input
|> String.split("\n\n", trim: true)

list_of_randoms = String.split(randoms, ",") |> Enum.map(&String.to_integer/1)

list_of_boards = for i <- 0..Enum.count(boards) - 1 do
  Enum.at(boards, i)
  |> String.split("\n", trim: true)
  |> Enum.map(fn row -> String.split(row, " ", trim: true) |> Enum.map(&String.to_integer/1) end)
end

defmodule Recursion do
  def recur([], list_of_boards), do: list_of_boards

  def recur([value | tail], list_of_boards) do
    new_list_of_boards_or_answer = Enum.reduce_while(list_of_boards, [], fn board, acc ->
      new_board = draw_board(board, value)

      if bingo?(new_board) or bingo?(transpose(new_board)) do
        {:halt, answer(new_board, value)}
      else
        {:cont, acc ++ [new_board]}
      end
    end)
    
    if is_number(new_list_of_boards_or_answer) do
      new_list_of_boards_or_answer
    else
      recur(tail, new_list_of_boards_or_answer)
    end
  end

  defp draw_board(board, value) do
    Enum.reduce(board, [], fn row, acc ->
      new_row = Enum.map(row, fn 
        ^value -> 0
        v -> v
      end)

      acc ++ [new_row]
    end)
  end

  defp transpose(board) do
    for pos <- 0..4 do
      Enum.map(board, & Enum.at(&1, pos))
    end
  end

  defp bingo?(board) do
    Enum.map(board, &bingo_row?/1) |> Enum.any?(& &1)
  end

  defp bingo_row?([0, 0, 0, 0, 0]), do: true

  defp bingo_row?(_), do: false

  defp answer(board, value) do
    board
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
    |> Kernel.*(value)
  end
end

list_of_randoms
|> Recursion.recur(list_of_boards)
```

## Part 2

```elixir
[randoms | tables] = input
|> String.split("\n\n", trim: true)

list_of_randoms = String.split(randoms, ",") |> Enum.map(&String.to_integer/1)

list_of_boards = for i <- 0..Enum.count(boards) - 1 do
  Enum.at(boards, i)
  |> String.split("\n", trim: true)
  |> Enum.map(fn row -> String.split(row, " ", trim: true) |> Enum.map(&String.to_integer/1) end)
end

defmodule Recursion do
  def recur([], list_of_boards), do: list_of_boards

  def recur([value | tail], list_of_boards) do
    new_list_of_boards_or_answer = Enum.reduce_while(list_of_boards, [], fn board, acc ->
      new_board = draw_board(board, value)

      if bingo?(new_board) or bingo?(transpose(new_board)) do
        if Enum.count(list_of_boards) > 1 do
          {:cont, acc}
        else
          {:halt, answer(new_board, value)}
        end
      else
        {:cont, acc ++ [new_board]}
      end
    end)
    
    if is_number(new_list_of_boards_or_answer) do
      new_list_of_boards_or_answer
    else
      recur(tail, new_list_of_boards_or_answer)
    end
  end

  defp draw_board(board, value) do
    Enum.reduce(board, [], fn row, acc ->
      new_row = Enum.map(row, fn 
        ^value -> 0
        v -> v
      end)

      acc ++ [new_row]
    end)
  end

  defp transpose(board) do
    for pos <- 0..4 do
      Enum.map(board, & Enum.at(&1, pos))
    end
  end

  defp bingo?(board) do
    Enum.map(board, &bingo_row?/1)
    |> Enum.any?(& &1)
  end

  defp bingo_row?([0, 0, 0, 0, 0]), do: true

  defp bingo_row?(_), do: false

  defp answer(board, value) do
    board
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
    |> Kernel.*(value)
  end
end

list_of_randoms
|> Recursion.recur(list_of_boards)
```


</details>

**It works!**
**Amazing!**

私の回答は、正解を得ることができていますがなんとなくイケていない感が満載です。
後述する[José Valim](https://twitter.com/josevalim)さんのお手本はとても勉強になります。
お見逃し無く！


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

いきなり正解を書くわけではなく、少しずつ試しながら作っていって、リファクタしていくさまが[José Valim](https://twitter.com/josevalim)さんの息遣いでみれるのでとても参考になります。
私は英語をよく聞き取れてはいませんが、コードが進化していくさまをみるのはとても勉強になります。


<iframe width="891" height="501" src="https://www.youtube.com/embed/8_HGMrAZykw?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<details><summary>お手本</summary>

まだ見ていないのです :sweat_smile: 

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 4: Giant Squid](https://adventofcode.com/2021/day/4)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。
だんだん、私には難しくなってきました :sweat_smile: 

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
