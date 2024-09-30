---
title: 闘魂Elixir ーー AtCoder Beginner Contest 337(A)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-18T20:01:05+09:00'
id: cf2d09218947248e9333
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

[AtCoder Beginner Contest 337](https://atcoder.jp/contests/abc337)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Scoreboard](https://atcoder.jp/contests/abc337/tasks/abc337_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

入力値を縦に足します。とりあえず`list_of_lists`に入力値を格納しておいて、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)関数で畳み込みます。どちらのスコアが多いのかは、`if`は使わずに関数パターンマッチで算出することにしました。


```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    list_of_lists = for _ <- 1..n do
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    end
    
    solve(list_of_lists)
    |> IO.puts()
  end
  
  def solve(list_of_lists) do
    %{t: t, a: a} = list_of_lists
    |> Enum.reduce(%{t: 0, a: 0}, fn [x, y], map ->
      map
      |> Map.update(:t, 0, & &1 + x)
      |> Map.update(:a, 0, & &1 + y)
    end)
    
    do_solve(t, a)
  end
  
  def do_solve(t, a) when t == a, do: "Draw"
  def do_solve(t, a) when t > a, do: "Takahashi"
  def do_solve(_t, _a), do: "Aoki"
end

```




</details>




---

# さいごに

[AtCoder Beginner Contest 337](https://atcoder.jp/contests/abc337)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
