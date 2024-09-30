---
title: 闘魂Elixir ーー AtCoder Beginner Contest 355(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-12T19:56:48+09:00'
id: 6e69535e7053855dfaa4
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

[AtCoder Beginner Contest 355](https://atcoder.jp/contests/abc355)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Piano 2](https://atcoder.jp/contests/abc355/tasks/abc355_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

Aリストの要素とBリストの要素をソートします。ソート結果においてその要素がもともとどちらのリストにあったのかをチェックします。
以下のプログラムでは、アトムで`:a`ラベル、`:b`ラベルを振っているイメージです。


```elixir
defmodule Main do
  def main do
    IO.read(:line)
    list_a = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    list_b = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(list_a, list_b)
    |> IO.puts()
  end

  def solve(list_a, list_b) do
    list_a = Enum.map(list_a, fn a -> {a, :a} end)
    list_b = Enum.map(list_b, fn b -> {b, :b} end)

    sorted_list = Enum.sort_by(list_a ++ list_b, fn {v, _label} -> v end)
    
    sorted_list
    |> Enum.reduce_while({"No", nil}, fn
      {_, :a}, {"No", :a} -> {:halt, {"Yes", nil}}
      {_, label}, {_, _} -> {:cont, {"No", label}}
    end)
    |> elem(0)
  end
end
```

@zacky1972 先生の[コメント](https://qiita.com/torifukukaiou/items/6e69535e7053855dfaa4#comment-a6431340d838e1f01c34)を反映して、より美しく、簡潔で理解しやすいものになりました！！！



</details>




---

# さいごに

[AtCoder Beginner Contest 355](https://atcoder.jp/contests/abc355)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
