---
title: 'Advent Of Code 2021 (Day 5: Hydrothermal Venture)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:49:26+09:00'
id: 872e28ca5c8bb3a48951
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---

**忘れじの行く末まではかたければ今日を限りの命ともがな**

Advent Calendar 2022 106日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

![スクリーンショット 2022-04-22 23.09.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f1b43ec5-d7e4-32f3-4ba0-289878905009.png)



https://adventofcode.com/2021/day/5


私はGitHubでログインしました。

# 私の回答

私の回答です。


<details><summary>私の回答</summary>

```elixir
input = """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
"""
```

## Part 1

```elixir
String.split(input, "\n", trim: true)
|> Enum.map(& String.split(&1, " -> "))
|> Enum.map(fn [s, e] -> {String.split(s, ","), String.split(e, ",")} end)
|> Enum.map(fn {[x1, y1], [x2, y2]} -> {{String.to_integer(x1), String.to_integer(y1)}, {String.to_integer(x2), String.to_integer(y2)}} end)
|> Enum.filter(fn {{x1, y1}, {x2, y2}} -> x1 == x2 or y1 == y2 end)
|> Enum.flat_map(fn
  {{x1, y1}, {x1, y2}} -> Enum.map(y1..y2, & {x1, &1}) 
  {{x1, y1}, {x2, y1}} -> Enum.map(x1..x2, & {&1, y1})
end)
|> Enum.reduce(%{}, fn coordinate, acc ->
  Map.update(acc, coordinate, 1, & &1 + 1)
end)
|> Enum.filter(fn {_, cnt} -> cnt > 1 end)
|> Enum.count()
```

## Part 2

```elixir
String.split(input, "\n", trim: true)
|> Enum.map(& String.split(&1, " -> "))
|> Enum.map(fn [s, e] -> {String.split(s, ","), String.split(e, ",")} end)
|> Enum.map(fn {[x1, y1], [x2, y2]} -> {{String.to_integer(x1), String.to_integer(y1)}, {String.to_integer(x2), String.to_integer(y2)}} end)
|> Enum.filter(fn {{x1, y1}, {x2, y2}} -> x1 == x2 or y1 == y2 or (abs(x1 - x2) == abs(y1 - y2)) end)
|> Enum.flat_map(fn
  {{x1, y1}, {x1, y2}} -> Enum.map(y1..y2, & {x1, &1}) 
  {{x1, y1}, {x2, y1}} -> Enum.map(x1..x2, & {&1, y1})
  {{x1, y1}, {x2, y2}} -> Enum.zip(x1..x2, y1..y2)
end)
|> Enum.reduce(%{}, fn coordinate, acc ->
  Map.update(acc, coordinate, 1, & &1 + 1)
end)
|> Enum.filter(fn {_, cnt} -> cnt > 1 end)
|> Enum.count()
```


</details>

**It works!**
**Amazing!**

私の回答は、正解を得ることができていますがなんとなくイケていない感が満載です。
メモリ使いすぎかも。
後述する[José Valim](https://twitter.com/josevalim)さんのお手本はとても勉強になります。
お見逃し無く！


# お手本

[José Valim](https://twitter.com/josevalim)さんが[Livebook](https://github.com/livebook-dev/livebook)楽しまれている動画があります。
[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)の作者です！

いきなり正解を書くわけではなく、少しずつ試しながら作っていって、リファクタしていくさまが[José Valim](https://twitter.com/josevalim)さんの息遣いでみれるのでとても参考になります。
私は英語をよく聞き取れてはいませんが、コードが進化していくさまをみるのはとても勉強になります。


<iframe width="891" height="501" src="https://www.youtube.com/embed/K6SFEoRaTNE?list=PLNP8vc86_-SOV1ZEvX_q9BLYWL586zWnF" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


<details><summary>お手本</summary>

まだ見ていないのです :sweat_smile: 

</details>

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5)を[[Elixir](https://elixir-lang.org/)で楽しんでみました。
Day 25まであるので引き続き楽しんでいきたいとおもいます。
メモリ使いすぎ感はありますが、 [Day 5: Hydrothermal Venture](https://adventofcode.com/2021/day/5)はスッキリ解けました。:sweat_smile: 

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
