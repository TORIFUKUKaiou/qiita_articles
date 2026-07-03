---
title: 'Advent Of Code 2021 (Day 1: Sonar Sweep)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-18T15:06:17+09:00'
id: 90ad6ae186d9311e94b0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**君がため惜しからざりし命さへ長くもがなと思ひけるかな**

Advent Calendar 2022 102日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 1: Sonar Sweep](https://adventofcode.com/2021/day/1)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-17 21.57.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2df7c6b7-735c-689f-8987-a1b7b56f16c8.png)

私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

`input`はサンプルデータです。
ログインをすると、2000個あるインプットデータがみえます。

## Part 1

```elixir
input = """
199
200
208
210
200
207
240
269
260
263
"""

input
|> String.split() 
|> Enum.map(&String.to_integer/1)
|> Enum.reduce({nil, 0}, fn depth, {before_depth, cnt} ->
  {depth, if(before_depth < depth, do: cnt + 1, else: cnt)}
end)
|> elem(1)

```

## Part 2

```elixir
input = """
199
200
208
210
200
207
240
269
260
263
"""

input
|> String.split() 
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(3, 1, :discard)
|> Enum.map(&Enum.sum/1)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.count(fn [left, right] -> left < right end)

```

</details>

**It works!**
**Amazing!**


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)で、楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

<iframe width="942" height="530" src="https://www.youtube.com/embed/mDxJjqx5-ns" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

<details><summary>お手本</summary>

## Part 1

```elixir
input
|> String.split("\n", trim: true) 
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.count(fn [left, right] -> left < right end)
```

## Part 2

```elixir
input
|> String.split("\n", trim: true) 
|> Enum.map(&String.to_integer/1)
|> Enum.chunk_every(3, 1, :discard)
|> Enum.chunk_every(2, 1, :discard)
|> Enum.count(fn [left, right] -> Enum.sum(left) < Enum.sum(right) end)
```

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 1: Sonar Sweep](https://adventofcode.com/2021/day/1)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
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






