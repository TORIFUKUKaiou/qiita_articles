---
title: 闘魂Elixir ーー AtCoder Beginner Contest 356(B)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-11T18:10:13+09:00'
id: 0329b0a3dcd881d4592d
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

[AtCoder Beginner Contest 356](https://atcoder.jp/contests/abc356)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Nutrients ](https://atcoder.jp/contests/abc356/tasks/abc356_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

ポイントは、縦に足すところです。
TLEがでないか嫌な予感がしましたが100x100程度なので大丈夫でした。

```math
X_{i j}
```

は、Mapに格納しました。
足し算は、[for](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)の[reduce](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1-the-reduce-option)オプションを使ったのがポイントです。


```elixir
defmodule Main do
  def main do
    [n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    a_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    x_map = for i <- 1..n do
      x_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
      Enum.with_index(x_list, 1)
      |> Enum.map(fn {x, j} -> {{i, j}, x} end)
    end 
    |> List.flatten()
    |> Map.new()

    total_list = 1..m
    |> Enum.map(fn j ->
      for i <- 1..n, reduce: 0 do
        acc -> acc + x_map[{i, j}]
      end
    end)

    Enum.zip(a_list, total_list)
    |> Enum.all?(fn {a, t} -> t >= a end)
    |> if(do: "Yes", else: "No")
    |> IO.puts()
  end
end
```
</details>



---

# さいごに

[AtCoder Beginner Contest 356](https://atcoder.jp/contests/abc356)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
