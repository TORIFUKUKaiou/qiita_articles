---
title: 闘魂Elixir ーー AtCoder Beginner Contest 337(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-19T12:44:26+09:00'
id: fd68858b6a97d596e868
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

# [B - Extended ABC](https://atcoder.jp/contests/abc337/tasks/abc337_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

1文字ずつみていけばいいので今回は再帰を使って解きました。私は再帰プログラミングを苦手としておりましたが、[Elixir](https://elixir-lang.org/)だと不思議と再帰を書けます。

問題の意味を勘違いしていて、**WA(Wrong Answer)** を数度出しました。何を勘違いしていたかというと必ず`A`、`B`、`C`が含まれていると思ったことです。`A`だけや`B`だけ、`C`だけ、`AC`や`BC`は条件に当てはまるというふうにプログラミングする必要があります。

「[AtCoder のテストケース](https://atcoder.jp/posts/20)」は公開されています。リンク先からさらにDropboxへ飛んでテストケースをダウンロードできるので、それをみて自分の勘違いに気づけました。


```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()
    
    solve(s)
    |> IO.puts()
  end
  
  def solve(s) do
    charlist = s |> String.to_charlist()
    
    do_solve(charlist, {?A, ?B, ?C})
  end
  
  def do_solve([], _), do: "Yes"
  def do_solve([?A | tail], {?A, ?B, ?C}), do: do_solve(tail, {?A, ?B, ?C})
  def do_solve([?B | tail], {?A, ?B, ?C}), do: do_solve(tail, {?B, ?C})
  def do_solve([?C | tail], {?A, ?B, ?C}), do: do_solve(tail, {?C})
  def do_solve([?B | tail], {?B, ?C}), do: do_solve(tail, {?B, ?C})
  def do_solve([?C | tail], {?B, ?C}), do: do_solve(tail, {?C})
  def do_solve([_ | _tail], {?B, ?C}), do: "No"
  def do_solve([?C | tail], {?C}), do: do_solve(tail, {?C})
  def do_solve([_ | _tail], {?C}), do: "No"
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
