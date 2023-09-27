---
title: 闘魂Elixir ーー AtCoder Beginner Contest 296をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-05-27T18:18:00+09:00'
id: c2d1f4b9d2f7f30d1b69
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

[AtCoder Beginner Contest 296](https://atcoder.jp/contests/abc296)を[Elixir](https://elixir-lang.org/)で解いてみます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方は、別の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。

# [A - Alternately](https://atcoder.jp/contests/abc296/tasks/abc296_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    IO.read(:line)
 
    IO.read(:line)
    |> String.trim()
    |> String.to_charlist()
    |> solve()
    |> IO.puts()
  end
 
  defp solve(charlist) do
    Enum.reduce_while(charlist, nil, fn
      p, nil -> {:cont, p}
      ?F, ?M -> {:cont, ?F}
      ?F, ?F -> {:halt, nil}
      ?M, ?F -> {:cont, ?M}
      ?M, ?M -> {:halt, nil}
    end)
    |> if(do: "Yes", else: "No")
  end
end
```
</details>


# [B - Chessboard](https://atcoder.jp/contests/abc296/tasks/abc296_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    {i, j} = 
    1..8
    |> Enum.reduce_while({nil, nil}, fn index, _acc ->
      column = IO.read(:line)
      |> String.trim()
      |> String.to_charlist()
      |> Enum.find_index(& &1 == ?*)
      
      if column do
        {:halt, {index, column}}
      else
        {:cont, {nil, nil}}
      end
    end)
    
    a = Enum.zip(0..7, ?a..?h) |> Map.new() |> Map.get(j) |> List.wrap() |> List.to_string()
    b = Enum.zip(1..8, 8..1) |> Map.new() |> Map.get(i)
    
    IO.puts "#{a}#{b}"
  end
end
```
</details>

# [C - Gap Existence](https://atcoder.jp/contests/abc296/tasks/abc296_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [_n, x] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    map = for(x <- list, into: %{}, do: {x, true})
      
    list
    |> Enum.reduce_while(nil, fn ai, _acc ->
      aj = ai - x
      index = Map.get(map, aj)
 
      if index do
        {:halt, true}
      else
        {:cont, false}
      end
    end)
    |> if(do: "Yes", else: "No")
    |> IO.puts()
  end
end
```
</details>

---

# 参考記事

https://qiita.com/GeekMasahiro/items/0970d7300f2bfcb28464

---

# さいごに

[AtCoder Beginner Contest 296](https://atcoder.jp/contests/abc296)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
C問題まで解きました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
