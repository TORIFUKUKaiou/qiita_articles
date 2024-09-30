---
title: 闘魂Elixir ーー AtCoder Beginner Contest 333(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-23T13:50:28+09:00'
id: 583ed7f7bd67406fac53
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

[AtCoder Beginner Contest 333](https://atcoder.jp/contests/abc333)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Pentagon](https://atcoder.jp/contests/abc333/tasks/abc333_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


五角形なので辺と対角線の数はそれほど多くないので全部のパターンを[Module attributes](https://hexdocs.pm/elixir/module-attributes.html)に予め定義しておきました。あとは関数のパターンマッチで、`S1S2`と`T1T2`が両方とも辺グループか対角線グループに含まれていれば`Yes`でそうでなければ`No`という寸法で解きました。

```elixir
defmodule Main do
  @sides ["AB", "BC", "CD", "DE", "EA", "AE", "ED", "DC", "CB", "BA"]
  @diagonals ["AD", "AC", "BD", "BE", "CA", "CE", "DB", "DA", "EB", "EC"]

  def main do
    s = IO.read(:line) |> String.trim()
    t = IO.read(:line) |> String.trim()
    
    solve(s, t)
    |> IO.puts()
  end
  
  def solve(s, t) when s in @sides and t in @sides, do: "Yes"
  def solve(s, t) when s in @diagonals and t in @diagonals, do: "Yes"
  def solve(_, _), do: "No"
end
```




</details>




---

# さいごに

[AtCoder Beginner Contest 333](https://atcoder.jp/contests/abc333)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
