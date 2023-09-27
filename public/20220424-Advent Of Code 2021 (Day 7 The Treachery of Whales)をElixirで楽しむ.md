---
title: 'Advent Of Code 2021 (Day 7: The Treachery of Whales)をElixirで楽しむ'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-05-06T23:48:33+09:00'
id: 4cfc93b4b2339e28ec88
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---

**あらざらむこの世のほかの思ひ出に今ひとたぴのあふこともがな**

Advent Calendar 2022 108日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[Advent Of Code 2021](https://adventofcode.com/2021) [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7)を[Elixir](https://elixir-lang.org/)で楽しんでみます。


![スクリーンショット 2022-04-24 23.12.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/479b9dbc-4920-8ca4-51f2-0e301f444e3b.png)



https://adventofcode.com/2021/day/7


私はGitHubでログインしました。

# 私の回答

私の回答です。
解けるには解けましたが、効率が悪いし、メモリをたくさん使っているようにおもいます。

<details><summary>私の回答</summary>

```elixir
input = "3,4,3,1,2"
```

## Part 1

```elixir
list = input |> String.split(",", trim: true) |> Enum.map(&String.to_integer/1)

count = Enum.count(list)
max = Enum.max(list)

0..max |> Enum.reduce(count * max, fn pos, min_fuel ->
  {largers, smallers} = Enum.split_with(list, & &1 >= pos)
  fuel = Enum.sum(largers) - pos * Enum.count(largers) + pos * Enum.count(smallers) - Enum.sum(smallers)
  if fuel < min_fuel, do: fuel, else: min_fuel
end)
```

## Part 2

```elixir
0..max |> Enum.reduce(Enum.sum(1..max) * count, fn pos, min_fuel ->
  fuel = Enum.reduce(list, 0, fn i, acc -> Enum.sum(0..abs(i - pos)) + acc end)
  if fuel < min_fuel, do: fuel, else: min_fuel
end)
```


</details>

**It works!**
**Amazing!**



# お手本

Day 7のお手本([José Valim](https://twitter.com/josevalim)さんの動画)はありませんでした :sob: 

Day 8はまた再びありました。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Advent Of Code 2021](https://adventofcode.com/2021) [Day 7: The Treachery of Whales](https://adventofcode.com/2021/day/7)を[Elixir](https://elixir-lang.org/)で楽しんでみました。
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
