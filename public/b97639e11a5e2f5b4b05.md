---
title: 闘魂Elixir ーー AtCoder Beginner Contest 340(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-18T09:05:05+09:00'
id: b97639e11a5e2f5b4b05
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

[AtCoder Beginner Contest 340](https://atcoder.jp/contests/abc340)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Append](https://atcoder.jp/contests/abc340/tasks/abc340_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

プログラムでは先頭に追加していっています。この問題を解く上では先頭に追加しても末尾に追加しても解けるので、先頭に追加する方が速いという[Elixir](https://elixir-lang.org/)のリストの性質を使っています。リストのインデックスは０オリジンであることを思い出してください。

```elixir
defmodule Main do
  def main do
    q = IO.read(:line) |> String.trim() |> String.to_integer()
    
    queries = for _i <- 1..q do
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    end
    
    solve(queries)
    |> IO.puts()
  end
  
  def solve(queries) do
    queries
    |> Enum.reduce({[], []}, fn
      [1, x], {a_list, list} -> {[x | a_list], list}
      [2, k], {a_list, list} -> {a_list, [Enum.at(a_list, k - 1) | list]}
    end)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join("\n")
  end
end
```




</details>




---

# さいごに

[AtCoder Beginner Contest 340](https://atcoder.jp/contests/abc340)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
