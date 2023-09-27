---
title: 闘魂Elixir ーー AtCoder Beginner Contest 299をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-05-04T11:28:54+09:00'
id: 0924d1ec0b4862ef33bc
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

[AtCoder Beginner Contest 299](https://atcoder.jp/contests/abc299)を[Elixir](https://elixir-lang.org/)で解いてみます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方は、別の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。

# [A - Treasure Chest](https://atcoder.jp/contests/abc299/tasks/abc299_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    IO.read(:line) |> String.trim()
    s = IO.read(:line) |> String.trim()
    
    index1 = index(s, 0, ?|)
    index2 = index(s, index1 + 1, ?|)
    index3 = index(s, 0, ?*)
    
    answer(index1, index2, index3) |> IO.puts()
  end
  
  defp index(s, start, c) do
    s
    |> String.to_charlist
    |> Enum.slice(start..-1)
    |> Enum.find_index(& &1 == c)
    |> Kernel.+(start)
  end
  
  defp answer(index1, index2, index3) when index1 < index2 and index1 < index3 and index3 < index2 do
    "in"
  end
  
  defp answer(_, _, _), do: "out"
end
```
</details>


# [B - Trick Taking](https://atcoder.jp/contests/abc299/tasks/abc299_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [_n, t] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    cs = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    rs = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    zip = Enum.zip(cs, rs)
    head = hd(zip)
    
    zip
    |> Enum.with_index()
    |> Enum.reduce({head, 0}, fn elem, acc ->
      solve(elem, acc, t)
    end)
    |> elem(1)
    |> Kernel.+(1)
    |> IO.puts()
  end
  
  defp solve({{t, r}, index}, {{acc_c, acc_r}, acc_index}, t) when acc_c != t do
    {{t, r}, index}
  end
  
  defp solve({{t, r}, index}, {{t, acc_r}, acc_index}, t) when r > acc_r do
    {{t, r}, index}
  end
  
  defp solve({{t, r}, index}, {{t, acc_r}, acc_index}, t) when r < acc_r do
    {{t, acc_r}, acc_index}
  end
  
  defp solve({{t, r}, index}, {{acc_t, acc_r}, acc_index}, acc_t) do
    {{acc_t, acc_r}, acc_index}
  end
  
  defp solve({{c, r}, index}, {{acc_c, acc_r}, acc_index}, t) when c != acc_c and acc_c != t do
    {{acc_c, acc_r}, acc_index}
  end
  
  defp solve({{c, r}, index}, {{c, acc_r}, acc_index}, t) when c != t and r > acc_r do
    {{c, r}, index}
  end
  
  defp solve({{c, r}, index}, {{c, acc_r}, acc_index}, t) when c != t and r < acc_r do
    {{c, acc_r}, acc_index}
  end
  
  defp solve({{acc_c, acc_r}, acc_index}, {{acc_c, acc_r}, acc_index}, t) do
    {{acc_c, acc_r}, acc_index}
  end
end
```
</details>

# [C - Dango](https://atcoder.jp/contests/abc299/tasks/abc299_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    s = IO.read(:line) |> String.trim()
    
    s
    |> String.to_charlist()
    |> Enum.chunk_by(& &1 == ?-)
    |> Enum.map(& Enum.count(&1, fn c -> c == ?o end))
    |> solve()
    |> IO.puts()
  end
  
  defp solve([]), do: -1
  
  defp solve([_len]), do: -1
  
  defp solve(list), do: Enum.max(list)
end
```
</details>


---

# さいごに

[AtCoder Beginner Contest 299](https://atcoder.jp/contests/abc299)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
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
