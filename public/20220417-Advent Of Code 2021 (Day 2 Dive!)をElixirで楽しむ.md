---
title: 'Advent Of Code 2021 (Day 2: Dive!)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:50:49+09:00'
id: 2dfdf6164abecaa6c71f
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**かくとだにえやはいぶきのさしも草さしも知らじなもゆる思ひを**

Advent Calendar 2022 103日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 2: Dive!](https://adventofcode.com/2021/day/2)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-17 23.43.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ae54bc93-a667-6d27-306b-02b6a7786829.png)

https://adventofcode.com/2021/day/2


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

`input`はサンプルです。
ログインをすると、たくさんあるインプットデータがみえます。


## Part 1

```elixir
input = """
forward 5
down 5
forward 8
up 3
down 8
forward 2
"""

v = input
|> String.split
|> Enum.chunk_every(2)
|> Enum.reduce(%{}, fn [key, value], acc -> 
  Map.update(acc, key, String.to_integer(value), & &1 + String.to_integer(value))
end)

(v["down"] - v["up"]) * v["forward"]

```

## Part 2

```elixir
v = input
|> String.split
|> Enum.chunk_every(2)
|> Enum.map(fn [key, value] -> {key, String.to_integer(value)} end)
|> Enum.reduce(%{"forward" => 0, "aim" => 0, "depth" => 0}, fn
  {"forward", v}, acc -> Map.update(acc, "forward", v, & &1 + v) |> Map.update("depth", v * acc["aim"], & &1 + v * acc["aim"])
  {"down", v}, acc -> Map.update(acc, "aim", v, & &1 + v)
  {"up", v}, acc -> Map.update(acc, "aim", -v, & &1 - v)
end
)

v["forward"] * v["depth"]

```

</details>

**It works!**
**Amazing!**


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

<iframe width="942" height="530" src="https://www.youtube.com/embed/1rFlhFbJ1_s?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<details><summary>お手本</summary>

## Part 1

```elixir
input
|> String.split("\n", trim: true)
|> Enum.reduce({_depth = 0, _position = 0}, fn
  "forward " <> number, {depth, position} ->
    {depth, String.to_integer(number) + position}
  "down " <> number, {depth, position} ->
    {String.to_integer(number) + depth, position}
  "up " <> number, {depth, position} ->
    {-String.to_integer(number) + depth, position}
end)
|> then(fn {depth, position} -> depth * position end)
```

## Part 2

```elixir
input
|> String.split("\n", trim: true)
|> Enum.reduce({_depth = 0, _position = 0, _aim = 0}, fn
  "forward " <> number, {depth, position, aim} ->
    number = String.to_integer(number)
    {depth + aim * number, number + position, aim}
  "down " <> number, {depth, position, aim} ->
    {depth, position, aim + String.to_integer(number)}
  "up " <> number, {depth, position, aim} ->
    {depth, position, aim - String.to_integer(number)}
end)
|> then(fn {depth, position, _aim} -> depth * position end)
```

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 2: Dive!](https://adventofcode.com/2021/day/2)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。

**It works!**
**Amazing!**

自分で解いてみて、動画をみて[José Valim](https://twitter.com/josevalim)さんに特別家庭教師をしてもらっている気に勝手になっています :sweat_smile:。

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






