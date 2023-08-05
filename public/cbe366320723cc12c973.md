---
title: FizzBuzzと1から100までの足し算をElixirで書いてみる (ElixirLS extensionをいれてみる)
tags:
  - Elixir
private: false
updated_at: '2020-06-24T00:48:36+09:00'
id: cbe366320723cc12c973
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @aaabb6211 さんの[fizzbuzzを噛み砕く](https://qiita.com/aaabb6211/items/f1ec6d32075a96598ba0)を拝見しまして、ぜひ[Elixir](https://elixir-lang.org/)で書いてみようとおもいました。
- ↑ こちらの記事にあります「**本気でそれをなしたいと思えば世界があなたに味方をしてくれる（アルケミスト）**」は、この本の一節でしょうか
    - [アルケミスト − 夢を旅した少年](https://www.amazon.co.jp/dp/404275001X)
    - ちなみに[Elixir](https://elixir-lang.org/) ーー不老不死の霊薬であるこの言語の使い手のことをアルケミスト(錬金術師)と呼ばれます
- We are the Alchemists, my friends !!!
- [Elixir](https://elixir-lang.org/)は1.10.3-otp-22 を使いました

# 書いてみる

```elixir:lib/awesome.ex
defmodule Awesome do
  # Thanks for プログラミングElixir
  def fizz_buzz(n) do
    do_fizz_buzz(rem(n, 3), rem(n, 5), n)
  end

  defp do_fizz_buzz(0, 0, _n), do: "FizzBuzz"
  defp do_fizz_buzz(0, _, _n), do: "Fizz"
  defp do_fizz_buzz(_, 0, _n), do: "Buzz"
  defp do_fizz_buzz(_, _, n), do: n

  def sum_100, do: 1..100 |> Enum.sum()
end
```
- FizzBuzzは[プログラミングElixir](https://www.amazon.co.jp/dp/4274219151) という本のおかげです

```elixir
$ iex
iex> 1..15 |> Enum.map(&Awesome.fizz_buzz/1)
[1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"]
iex> Awesome.sum_100
5050
```

# ところで
- 最近、[The Pragmatic Studio](https://pragmaticstudio.com/)という動画でプログラミングを教えてくれるサイトがありまして、いまならEarly Access!ということで無料で[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)の動画教材がみれるのでそこで学んでいます(後半部分は現時点では未公開なのですが有料になるのかも?)
    - https://pragmaticstudio.com/courses/phoenix-liveview
- そのサイトでの環境構築のおすすめVSCode extensionとして、[ElixirLS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)が紹介されていました
- さっそく素直にそれをいれてみたのですがなんと、うっすらと `@spec` なるものがみえるではありませんか！
    - [Elixir](https://elixir-lang.org/) 界では常識なのかもしれませんが、ついさっき気づいた次第です :rocket: :rocket: :rocket: 
    - うっすらのところを押すと、ソースコードに反映してくれます
    - これを自分で書く自信はない。。。

<img width="476" alt="スクリーンショット 2020-05-13 23.48.33.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/62558c58-9b8e-94bc-435b-ae1dc6d4a647.png">


Enjoy!!!
