---
title: 'Advent Of Code 2021 (Day 6: Lanternfish)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:49:01+09:00'
id: b254ae720e17ee86f276
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---

**滝の音は絶えて久しくなりぬれど名こそ流れてなほ聞こえけれ**

Advent Calendar 2022 107日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 6: Lanternfish](https://adventofcode.com/2021/day/6)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-23 0.47.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7499756b-3ed4-02d4-693d-445deaa12677.png)




https://adventofcode.com/2021/day/6


私はGitHubでログインしました。

# 私の回答

私の回答です。
今回は割とすんなり解けた気がします。
問題の意味がわかるまで英文と格闘していました。


<details><summary>私の回答</summary>

```elixir
input = "3,4,3,1,2"
```

## Part 1

```elixir
internal_timers =
  input 
  |> String.split(",", trim: true) 
  |> Enum.map(&String.to_integer/1) 
  |> Enum.reduce(%{}, fn internal_timer, acc -> 
    Map.update(acc, internal_timer, 1, & &1 + 1)
  end)

defmodule Recursion do
  def recur(internal_timers, 0), do: internal_timers

  def recur(internal_timers, day) do
    internal_timers
    |> Enum.reduce(%{}, fn 
      {0, value}, acc -> {0, value}, acc -> Map.merge(acc, %{6 => value, 8 => value}, fn _k, v1, v2 -> v1 + v2 end)
      {internal_timer, value}, acc -> Map.update(acc, internal_timer - 1, value, & &1 + value)
    end)
    |> recur(day - 1)
  end
end


Recursion.recur(internal_timers, 80)
|> Map.values()
|> Enum.sum()
```

## Part 2

```elixir
internal_timers =
  input 
  |> String.split(",", trim: true) 
  |> Enum.map(&String.to_integer/1) 
  |> Enum.reduce(%{}, fn internal_timer, acc -> 
    Map.update(acc, internal_timer, 1, & &1 + 1)
  end)

defmodule Recursion do
  def recur(internal_timers, 0), do: internal_timers

  def recur(internal_timers, day) do
    internal_timers
    |> Enum.reduce(%{}, fn 
      {0, value}, acc -> {0, value}, acc -> Map.merge(acc, %{6 => value, 8 => value}, fn _k, v1, v2 -> v1 + v2 end)
      {internal_timer, value}, acc -> Map.update(acc, internal_timer - 1, value, & &1 + value)
    end)
    |> recur(day - 1)
  end
end


Recursion.recur(internal_timers, 256)
|> Map.values()
|> Enum.sum()
```

Mapを使ったのが吉でした。
当初Listを使っていたところ、ものすごく処理時間がかかっていました。
メモリもたくさんつかっていたようです。


</details>

**It works!**
**Amazing!**


後述する[José Valim](https://twitter.com/josevalim)さんのお手本はとても勉強になります。
お見逃し無く！


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

いきなり正解を書くわけではなく、少しずつ試しながら作っていって、リファクタしていくさまが[José Valim](https://twitter.com/josevalim)さんの息遣いでみれるのでとても参考になります。
私は英語をよく聞き取れてはいませんが、コードが進化していくさまをみるのはとても勉強になります。


<iframe width="891" height="501" src="https://www.youtube.com/embed/9kunVfIyJt0?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<details><summary>お手本</summary>

## Part 1

```elixir
input = "3,4,3,1,2"

fishes = input |> String.split(",") |> Enum.map(&String.to_integer/1)

defmodule Recursion do
  def recur(fishes) do
    recur(fishes, [])
  end

  defp recur([0 | fishes], children), do: [6 | recur(fishes, [8 | children])]
  defp recur([fish | fishes], children), do: [fish - 1 | recur(fishes, children)]
  defp recur([], children), do: Enum.reverse(children)
end

1..80
|> Enum.reduce(fishes, fn _, fishes -> Recursion.recur(fishes) end)
|> length()
```


## Part 2

```elixir
input = "3,4,3,1,2"

fishes = input |> String.split(",") |> Enum.map(&String.to_integer/1)

defmodule Recursion2 do
  def recur({day0, day1, day2, day3, day4, day5, day6, day7, day8}) do
    {day1, day2, day3, day4, day5, day6, day7 + day0, day8, day0}
  end
end

frequencies = Enum.frequencies(fishes) |> IO.inspect()
amounts = Enum.map(0..8, fn i -> frequencies[i] || 0 end) |> List.to_tuple()

1..256
|> Enum.reduce(amounts, fn _, amounts -> Recursion2.recur(amounts) end)
|> Tuple.sum()

```


</details>


**お手本は感動です！！！**
しびれます！

@kts_h さんがRubyでの実装をしてくださいました！

https://qiita.com/torifukukaiou/items/b254ae720e17ee86f276#comment-7d0f65302b7d712e55df


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 6: Lanternfish](https://adventofcode.com/2021/day/6)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。
私にとっては、Day 3、Day 4の方が難しかった印象です。

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
