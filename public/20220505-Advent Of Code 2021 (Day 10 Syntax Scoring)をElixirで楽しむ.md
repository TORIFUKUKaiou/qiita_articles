---
title: 'Advent Of Code 2021 (Day 10: Syntax Scoring)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:46:59+09:00'
id: a94c0561e395883c0991
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---

**やすらはで寝なましものをさ夜ふけてかたぶくまでの月を見しかな**

Advent Calendar 2022 111日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 10: Syntax Scoring](https://adventofcode.com/2021/day/10)を[Elixir](https://elixir-lang.org/)で楽しんでみます。


![スクリーンショット 2022-05-05 21.06.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7d6f05ea-cf06-a19f-a155-4aa944a0efb2.png)






https://adventofcode.com/2021/day/10


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
"""
```

```elixir
defmodule Recursion do
  def recur(list) do
    recur(list, [])
  end

  defp scores([], stack) do
    stack
    |> Enum.reverse()
    |> Enum.reduce(0, fn point, acc ->
      5 * acc + point
    end)
  end

  defp scores([?( | tail], stack), do: scores(tail, [1 | stack])
  defp scores([?[ | tail], stack), do: scores(tail, [2 | stack])
  defp scores([?{ | tail], stack), do: scores(tail, [3 | stack])
  defp scores([?< | tail], stack), do: scores(tail, [4 | stack])

  defp recur([], stack), do: {:incorrect, scores(stack, [])}

  defp recur([head | tail], stack) when head in [?(, ?[, ?{, ?<], do: recur(tail, [head | stack])

  defp recur([?) | tail], [?( | stack]), do: recur(tail, stack)

  defp recur([?) | _tail], _stack), do: {:corrupted, 3}

  defp recur([?] | tail], [?[ | stack]), do: recur(tail, stack)

  defp recur([?] | _tail], _stack), do: {:corrupted, 57}

  defp recur([?} | tail], [?{ | stack]), do: recur(tail, stack)

  defp recur([?} | _tail], _stack), do: {:corrupted, 1197}

  defp recur([?> | tail], [?< | stack]), do: recur(tail, stack)

  defp recur([?> | _tail], _stack), do: {:corrupted, 25137}
end
```

## Part 1

```elixir
input
|> String.split("\n", trim: true)
|> Enum.map(fn line ->
  line
  |> String.to_charlist()
  |> Recursion.recur()
end)
|> Enum.reduce(0, fn
  {:corrupted, score}, acc -> acc + score
  {:incorrect, _score}, acc -> acc
end)
|> IO.inspect()
```

## Part 2

```elixir
scores =
  input
  |> String.split("\n", trim: true)
  |> Enum.map(fn line ->
    line
    |> String.to_charlist()
    |> Recursion.recur()
  end)
  |> Enum.reduce([], fn
    {:corrupted, _score}, acc -> acc
    {:incorrect, score}, acc -> [score | acc]
  end)
  |> Enum.sort()
  |> IO.inspect()

scores
|> Enum.at(div(Enum.count(scores), 2))
|> IO.inspect()
```


</details>

**It works!**
**Amazing!**




# お手本

Day 10のお手本([José Valim](https://twitter.com/josevalim)さんの動画)はないようです :sunglasses:

もし存在をご存知の方はお知らせいただけますとありがたいです！ :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 10: Syntax Scoring](https://adventofcode.com/2021/day/10)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
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




