---
title: 闘魂Elixir ーー AtCoder Beginner Contest 344(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-15T21:57:14+09:00'
id: 799d9511d1d3f1372367
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

[AtCoder Beginner Contest 344](https://atcoder.jp/contests/abc344)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Delimiter](https://atcoder.jp/contests/abc344/tasks/abc344_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

珍しい問題かもしれません。
入力の読み込みを0が出現したときに打ち切ればよいわけです。
私は、[https://hexdocs.pm/elixir/1.17.0/Enum.html#reduce_while/3](Enum.reduce_while/3)関数を解法の骨格に据えました。

```elixir
defmodule Main do
  def main do
    (1..(10 ** 9))
    |> Enum.reduce_while([], fn _, acc ->
      a = IO.read(:line) |> String.trim() |> String.to_integer()
      do_solve(a, acc)
    end)
    |> Enum.join("\n")
    |> IO.puts()
  end
  
  defp do_solve(0, list), do: {:halt, [0 | list]}
  defp do_solve(a, list), do: {:cont, [a | list]}
end
```




</details>




---

# さいごに

[AtCoder Beginner Contest 344](https://atcoder.jp/contests/abc344)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
