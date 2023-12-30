---
title: 闘魂Elixir ── AtCoder Beginner Contest 329のA問題をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-01T20:28:23+09:00'
id: 603034b051cb8fed3010
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir


# はじめに

[Elixir](https://elixir-lang.org/)で、[Ｓｋｙ株式会社プログラミングコンテスト2023（AtCoder Beginner Contest 329）)](https://atcoder.jp/contests/abc329)の問題を解いてみます。

https://atcoder.jp/contests/abc329

[AtCoder](https://atcoder.jp/home)とは、世界最高峰の競技プログラミングサイトです。

[Elixir](https://elixir-lang.org/)で解く際には、私が書いた「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」という記事がとても参考になるとおもいます。自画自賛です。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [A - Spread](https://atcoder.jp/contests/abc329/tasks/abc329_a)問題

今回は、[A - Spread](https://atcoder.jp/contests/abc329/tasks/abc329_a)を解いてみます。
問題はリンク先をご参照ください。

## 私の答え

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    |> String.trim() 
    |> String.codepoints()
    |> Enum.join(" ")
    |> IO.puts()
  end
end
```

</details>


# さいごに

[Ｓｋｙ株式会社プログラミングコンテスト2023（AtCoder Beginner Contest 329）)](https://atcoder.jp/contests/abc329)のA問題を解いてみました。
[AtCoder](https://atcoder.jp/home)は己との闘い、つまり闘魂です。

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
