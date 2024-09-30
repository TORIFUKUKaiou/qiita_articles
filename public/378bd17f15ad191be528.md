---
title: 闘魂Elixir ーー AtCoder Beginner Contest 354(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-14T20:25:48+09:00'
id: 378bd17f15ad191be528
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 354](https://atcoder.jp/contests/abc354)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - AtCoder Janken 2](https://atcoder.jp/contests/abc354/tasks/abc354_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

並びかえには、[Enum.sort_by/3](https://hexdocs.pm/elixir/Enum.html#sort_by/3)を使えばよいでしょう。
T mod N が何者だ？　ですが、割り算の余りですので、[rem/2](https://hexdocs.pm/elixir/Kernel.html#rem/2)を使えばよいでしょう。


```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    
    list = for _i <- 1..n do
      [s, c] = IO.read(:line) |> String.trim() |> String.split(" ")
      {s, String.to_integer(c)}
    end

    solve(n, list)
    |> IO.puts()
  end
  
  def solve(n, list) do
    t = list |> Enum.map(fn {_s, c} -> c end) |> Enum.sum()
    sorted_list = list |> Enum.sort_by(fn {s, _c} -> s end)
    t_mod_n = rem(t, n)
    
    sorted_list |> Enum.at(t_mod_n) |> elem(0)
  end
end
```




</details>




---

# さいごに

[AtCoder Beginner Contest 354](https://atcoder.jp/contests/abc354)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
