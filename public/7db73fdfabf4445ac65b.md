---
title: first..last//step を楽しむ（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-10T19:12:37+09:00'
id: 7db73fdfabf4445ac65b
organization_url_name: fukuokaex
slide: false
---
**浅茅生の小野のしの原忍ぶれどあまりてなどか人の恋しき**


---

Advent Calendar 2022 90日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[first..last//step](https://hexdocs.pm/elixir/Kernel.html#..///3)を楽しんでみます。

# [first..last//step](https://hexdocs.pm/elixir/Kernel.html#..///3)

`first`から`last`までのRangeを作ってくれます。
刻みは`step`で指定します。
[Elixir](https://elixir-lang.org/) 1.12 or laterです。

公式の説明をそのまま貼っておきます。

前半の3件で使っている[left in right](https://hexdocs.pm/elixir/Kernel.html#in/2)は、leftがhandの一員であるかどうかを返すマクロです。
Rangeの中にメンバーとして存在しているかどうかを確かめています。

後半の3件でつかっている[Enum.to_list/1](https://hexdocs.pm/elixir/Enum.html#to_list/1)はRangeをListに変換しています。
ここではRangeを引数にとっています。
引数はEnumerableなものであればよく、たとえばMapも引数にとれます。
この記事とは外れるし、私はこのくらいしか説明できないのでこのへんでやめておきます。

![スクリーンショット 2022-04-10 17.57.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/312af077-c477-5189-e4ce-24e9e5156d3c.png)




最後の例のようにありえない`first`から`last`へのありえない刻み方を指定した場合には、なんにもないRangeということになります。

別の例を書いてみます。

```elixir
iex> Enum.to_list(1..-3//-1) # (イ)
[1, 0, -1, -2, -3] 

iex> Enum.to_list(1..-3//1)  # (ロ) 
[]
```

`1`から`-3`に減っていくので(イ)の例のように`-1`ずつ減らすというのはあり得るわけです。
ところが(ロ)のように、Rangeが減っていく方向に進んでいるのに対して`+1`の刻みはあり得ないわけです。



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

[first..last//step](https://hexdocs.pm/elixir/Kernel.html#..///3)の説明を書きました。
私は未だ実践で使ったことはありません。
実例ありましたらぜひお便り（コメント）をお寄せください。



以上です。





