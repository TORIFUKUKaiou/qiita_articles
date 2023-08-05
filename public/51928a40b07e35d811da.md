---
title: 闘魂Elixir ーー AtCoder Beginner Contest 300をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-05-05T12:12:01+09:00'
id: 51928a40b07e35d811da
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 300](https://atcoder.jp/contests/abc300)を[Elixir](https://elixir-lang.org/)で解いてみます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方は、別の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。

# [A - N-choice question](https://atcoder.jp/contests/abc300/tasks/abc300_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [_n, a, b] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    index = Enum.find_index(list, fn x -> x == a + b end)
    IO.puts(index + 1)
  end
end
```
</details>


# [B - Same Map in the RPG World](https://atcoder.jp/contests/abc300/tasks/abc300_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [h, w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    a = list_of_row(h) |> Enum.map(&String.to_charlist/1) |> to_map(h, w)
    b = list_of_row(h) |> Enum.map(&String.to_charlist/1) |> to_map(h, w)
    
    for s <- 0..(h - 1), t <- 0..(w - 1) do
      for i <- 0..(h - 1), j <- 0..(w - 1) do
        Map.get(a, {rem(i - s + h, h), rem(j - t + w, w)}) == Map.get(b, {i, j})
      end
      |> Enum.all?
    end
    |> Enum.any?
    |> if(do: "Yes", else: "No")
    |> IO.puts()
  end
 
  defp list_of_row(h) do
    for _ <- 1..h do
      IO.read(:line)
      |> String.trim()
    end
  end
 
  defp to_map(list_of_row, h, w) do
    for i <- 0..(h - 1), j <- 0..(w - 1), row = Enum.at(list_of_row, i), c = Enum.at(row, j),  reduce: %{} do
      acc -> Map.update(acc, {i, j}, c, & &1)
    end
  end
end
```
</details>

# [C - Cross](https://atcoder.jp/contests/abc300/tasks/abc300_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [h, w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    c = list_of_row(h) |> Enum.map(&String.to_charlist/1) |> to_map(h, w)
 
    map = do_solve(c, h, w)
    n = min(h, w)
    for(s <- 1..n, do: Map.get(map, s, 0))
    |> Enum.join(" ")
    |> IO.puts()
  end
 
  defp do_solve(c, h, w) do
    for(i <- 0..(h - 3), j <- 0..(w - 3), do: {i, j})
    |> Enum.reduce(%{}, fn {i, j}, acc ->
      init = if Map.get(c, {i, j}) == ?#, do: 1, else: 0
      left_upper_grid = Map.get(c, {i - 1, j - 1}, ?.)
 
      if init == 0 or left_upper_grid == ?# do
        acc
      else
        cnt =
          ((i + 1)..(h - 1))
          |> Enum.with_index()
          |> Enum.reduce_while(1, fn {row, column}, acc ->
            grid = Map.get(c, {row, j + column + 1})
            if grid == ?# do
              {:cont, acc + 1}
            else
              {:halt, acc}
            end
          end)
          |> Kernel.div(2)
        Map.update(acc, cnt, 1, & &1 + 1)
      end
    end)
  end
 
  defp list_of_row(h) do
    for _ <- 1..h do
      IO.read(:line)
      |> String.trim()
    end
  end
 
  defp to_map(list_of_row, h, w) do
    for i <- 0..(h - 1), j <- 0..(w - 1), row = Enum.at(list_of_row, i), c = Enum.at(row, j),  reduce: %{} do
      acc -> Map.update(acc, {i, j}, c, & &1)
    end
  end
end
```
</details>


---

# さいごに

[AtCoder Beginner Contest 300](https://atcoder.jp/contests/abc300)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
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
