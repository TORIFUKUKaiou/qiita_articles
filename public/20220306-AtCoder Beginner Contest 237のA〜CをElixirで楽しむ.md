---
title: AtCoder Beginner Contest 237のA〜CをElixirで楽しむ
tags:
  - AdventCalendar
  - AtCoder
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2022-03-06T13:37:57+09:00'
id: 64c12bea833a5d7c2c0b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**みちのくの忍ぶもぢずり誰ゆゑに乱れそめにしわれならなくに**


---

Advent Calendar 2022 63日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今日は[AtCoder Beginner Contest 237](https://atcoder.jp/contests/abc237)を[Elixir](https://elixir-lang.org/)で楽しんでみます。

# What's [AtCoder](https://atcoder.jp/home)?

ご存知の方が多いとおもいますが、リンクの紹介かねがね、そもそも[AtCoder](https://atcoder.jp/home)って何よ？　を説明します。

> AtCoderは、オンラインで参加できるプログラミングコンテスト(競技プログラミング)のサイトです。リアルタイムのコンテストで競い合ったり、約3000問のコンテストの過去問にいつでも挑戦することが出来ます。

https://atcoder.jp/home

# [Elixir](https://elixir-lang.org/)での解き方

どの問題も一定の形式があります。
それは、入力を受け取って、演算して、出力するという形式の問題を解いていきます。
問題に挑むことで、プログラミングの基礎を身につけることができます。

具体的にどんなふうに書けばよいかについては下記の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

動画:video_camera:を撮っています。
雰囲気をつかんでください。

<iframe width="1148" height="646" src="https://www.youtube.com/embed/9TQXQtY1oQY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# [AtCoder Beginner Contest 237](https://atcoder.jp/contests/abc237)

https://atcoder.jp/contests/abc237

楽しんでいきます！！！

## [A - Not Overflow](https://atcoder.jp/contests/abc237/tasks/abc237_a)

問題は、[リンク](https://atcoder.jp/contests/abc237/tasks/abc237_a)先をご参照ください。

https://atcoder.jp/contests/abc237/tasks/abc237_a

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  @pow_2_32 Enum.reduce(1..31, 1, fn _, acc -> 2 * acc end)
  @max @pow_2_32 - 1
  @min @pow_2_32 * -1
 
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
 
    n
    |> solve()
    |> IO.puts()
  end
  
  def solve(n) when @min <= n and n <= @max, do: "Yes"
  
  def solve(_), do: "No"
end
```

</details>

## [B - Matrix Transposition](https://atcoder.jp/contests/abc237/tasks/abc237_b)

問題は、[リンク](https://atcoder.jp/contests/abc237/tasks/abc237_b)先をご参照ください。

https://atcoder.jp/contests/abc237/tasks/abc237_b

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    map_of_maps = Enum.reduce(0..(n-1), {0, %{}}, fn i, {i, acc} ->
        map =
          IO.read(:line)
          |> String.trim()
          |> String.split(" ")
          |> Enum.map(&String.to_integer/1)
          |> Enum.with_index
          |> Enum.map(fn {element, index} -> {index, element} end)
          |> Map.new()
 
        {i + 1, Map.merge(acc, %{i => map})}
      end)
      |> elem(1)
    
    for(x <- 0..(m-1), y <- 0..(n-1), do: map_of_maps[y][x])
    |> Enum.chunk_every(n)
    |> Enum.map(& Enum.join(&1, " "))
    |> Enum.join("\n")
    |> IO.puts()
  end
end
```

</details>

## [C - kasaka](https://atcoder.jp/contests/abc237/tasks/abc237_c)

問題は、[リンク](https://atcoder.jp/contests/abc237/tasks/abc237_c)先をご参照ください。

https://atcoder.jp/contests/abc237/tasks/abc237_c

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()
 
    do_solve(s)
    |> IO.puts
  end
 
  defp do_solve(s) do
    list = String.codepoints(s)
    left = not_a_index(list)
    right = not_a_index(Enum.reverse(list))
 
    do_solve(left, right, list)
  end
 
  defp not_a_index(list) do
    not_a_index = Enum.find_index(list, & &1 != "a")
    if not_a_index == nil do
      Enum.count(list)
    else
      not_a_index
    end
  end
 
  defp do_solve(left, right, _list) when left > right, do: "No"
 
  defp do_solve(left, right, list) do
    right = Enum.count(list) - right - 1
    {left, right} = if left < right, do: {left, right}, else: {right, left}
 
    center = Enum.slice(list, left..right)
    do_solve(center, Enum.reverse(center))
  end
 
  defp do_solve(s, s), do: "Yes"
  defp do_solve(_s, _t), do: "No"
end
```

</details>



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

本日は、[AtCoder Beginner Contest 237](https://atcoder.jp/contests/abc237)を[Elixir](https://elixir-lang.org/)で楽しんでみました。

なんの自慢にもなりませんが、C問題は正解となるまでにめちゃくちゃ時間がかかっています。
一晩ぐっすり寝て、解き方をおもいついて、**それでもまだ抜けがあって**、微調整を加えてやっと正解にたどり着きました。
文字通り、本当に**たどり着いた**感でいっぱいです。
朝日を浴びながら満足感でいっぱいです。

同時にオレはまだまだこんなものでではないともおもいます。
[AtCoder](https://atcoder.jp/home)に取り組むことで「オレって全然まだまだだな」という謙虚な気持ちになれます。
「[情けないよで たくましくもある](https://www.youtube.com/watch?v=3djg2YAblk8)」なのです。

つまり、
<font color="purple">$\huge{伸びしろしかない🚀}$</font>
ということです。



以上です。





