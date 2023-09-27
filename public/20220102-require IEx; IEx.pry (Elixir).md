---
title: require IEx; IEx.pry (Elixir)
tags:
  - Elixir
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-03T23:31:25+09:00'
id: e59b20caaecd22db1705
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**鞭声粛粛夜河を渡る**

Advent Calendar 2022 2日目[^2]です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^2]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2021/12/26(日)に行われた「[tokyo.ex #14](https://beam-lang.connpass.com/event/232202/)」にて、@ohr486さんが「**IEx[^1]での生活改善！**」をテーマに発表されました。
ありがとうございました！
詳しくは発表資料をご覧ください。

[^1]: https://elixir-lang.org/getting-started/introduction.html#interactive-mode

この記事では、`require IEx; IEx.pry`を使って、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)の第3引数に指定した関数がどんなふうに呼び出されるのかをデモしてみます。

https://speakerdeck.com/ohr486/iex-maniacs

発表資料のタイトルは
<font color="purple">$\huge{IEx\ maniacs}$</font>
です。

なお当日の様子は、以下をご参照ください。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日開催された tokyo.ex 14 のツイートのまとめとなります。<br>映像に関しては別途Youtubeに上がりますので、そちらが上がりましたら一緒に楽しんでいただければと思います。<a href="https://t.co/LLpOf6mNrf">https://t.co/LLpOf6mNrf</a> <a href="https://twitter.com/hashtag/tokyoex?src=hash&amp;ref_src=twsrc%5Etfw">#tokyoex</a></p>&mdash; Tech Inside Drecom (@DRECOM_TECH) <a href="https://twitter.com/DRECOM_TECH/status/1474993119427203074?ref_src=twsrc%5Etfw">December 26, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# `require IEx; IEx.pry` デモ

題材は、[AtCoder](https://atcoder.jp/home)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題にします。

> AtCoderは、オンラインで参加できるプログラミングコンテスト(競技プログラミング)のサイトです。リアルタイムのコンテストで競い合ったり、約3000問のコンテストの過去問にいつでも挑戦することが出来ます。

問題文は[リンク先]((https://atcoder.jp/contests/abc162/tasks/abc162_b))をご参照ください
例: 入力が5の場合、FizzBuzzの列は、`1,2,Fizz,4,Buzz`となり、数字だけを足し算して、7が答え



今回、デモに使用するプログラムは以下です。


```elixir
defmodule FizzBuzzSum do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> fizz_buzz_sum()
    |> IO.puts()
  end

  def fizz_buzz(n) do
    do_fizz_buzz(n, rem(n, 3), rem(n, 5))
  end

  defp do_fizz_buzz(_n, 0, 0), do: "FizzBuzz"

  defp do_fizz_buzz(_n, 0, _), do: "Fizz"

  defp do_fizz_buzz(_n, _, 0), do: "Buzz"

  defp do_fizz_buzz(n, _, _), do: n

  def fizz_buzz_sum(n) do
    1..n
    |> Enum.reduce(0, fn i, acc ->
      fizz_buzz(i)
      |> to_i()
      |> Kernel.+(acc)
    end)
  end

  defp to_i("Fizz"), do: 0

  defp to_i("Buzz"), do: 0

  defp to_i("FizzBuzz"), do: 0

  defp to_i(i), do: i
end
```

上記プログラムの解説は、

https://qiita.com/torifukukaiou/items/b82dac53c79b4ee16b98

をご参照ください。

`FizzBuzzSum.fizz_buzz_sum/1`関数を少し変形します。

```elixir
  def fizz_buzz_sum(n) do
    1..n
    |> Enum.reduce(0, fn i, acc ->
      result = 
      fizz_buzz(i)
      |> to_i()
      |> Kernel.+(acc)
      require IEx; IEx.pry

      result
    end)
  end
```

言葉で説明するより動画を見てもらったほうがより伝わるとおもいます。
YouTube動画をご覧になってくださいませ。


<iframe width="924" height="520" src="https://www.youtube.com/embed/-l7d2waBkMo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# Wrapping up :lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

あなたも「[IEx maniacs](https://speakerdeck.com/ohr486/iex-maniacs)」をご覧になって、快適な[IEx](https://hexdocs.pm/iex/1.13.1/IEx.html)ライフをぜひお楽しみください:rocket::rocket::rocket:
**@ohr486さん、ありがとうございます！**

https://hexdocs.pm/iex/1.13.1/IEx.html
