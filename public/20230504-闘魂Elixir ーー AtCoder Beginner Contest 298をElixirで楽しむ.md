---
title: 闘魂Elixir ーー AtCoder Beginner Contest 298をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-05-04T14:30:20+09:00'
id: 657ac73ad19fb13c0f67
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 298](https://atcoder.jp/contests/abc298)を[Elixir](https://elixir-lang.org/)で解いてみます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方は、別の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。

# [A - Job Interview](https://atcoder.jp/contests/abc298/tasks/abc298_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    s = IO.read(:line) |> String.trim()
    
    if(String.contains?(s, "o") and !String.contains?(s, "x"), do: "Yes", else: "No")
    |> IO.puts()
  end
end
```
</details>


# [B - Coloring Matrix](https://atcoder.jp/contests/abc298/tasks/abc298_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
 
    a = list_of_row(n) |> to_map(n, n)
    b = list_of_row(n) |> to_map(n, n)
 
    do_solve(a, b, n)
    |> IO.puts()
  end
 
  def do_solve(a, b, n) do
    1..n
    |> Enum.reduce_while({false, a}, fn _, {_, acc_map} ->
      rotated_a = rotate(acc_map, n, n, n)
      yes_or_no = for(i <- 1..n, j <- 1..n, Map.get(rotated_a, {i, j}) == 1, do: Map.get(b, {i, j}) == 1)
      |> Enum.all?()
 
      if yes_or_no do
        {:halt, {true, rotated_a}}
      else
        {:cont, {false, rotated_a}}
      end
    end)
    |> elem(0)
    |> if(do: "Yes", else: "No")
  end
 
  defp list_of_row(h) do
    for _ <- 1..h do
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
    end
  end
 
  defp to_map(list_of_row, h, w) do
    for i <- 1..h, j <- 1..w, row = Enum.at(list_of_row, i - 1), c = Enum.at(row, j - 1),  reduce: %{} do
      acc -> Map.update(acc, {i, j}, c, & &1)
    end
  end
 
  defp rotate(map, h, w, n) do
    for i <- 1..h, j <- 1..w, color = Map.get(map, {n + 1 - j, i}), reduce: %{} do
      acc -> Map.update(acc, {i, j}, color, & &1)
    end
  end
end
```
</details>

# [C - Cards Query Problem](https://atcoder.jp/contests/abc298/tasks/abc298_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    _n = IO.read(:line)
    q = IO.read(:line) |> String.trim() |> String.to_integer()
 
    1..q
    |> Enum.reduce({%{}, %{}, []}, fn _, {boxes, numbers, outputs} ->
      query = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
      operation(query, boxes, numbers, outputs)
    end)
    |> elem(2)
    |> Enum.reverse()
    |> Enum.join("\n")
    |> IO.puts()
  end
 
  def operation([1, number, box], boxes, numbers, outputs) do
    new_boxes = Map.update(boxes, box, [number], & [number | &1])
    new_numbers = Map.update(numbers, number, MapSet.new([box]), fn map_set -> if MapSet.member?(map_set, box), do: map_set, else: MapSet.put(map_set, box) end)
 
    {new_boxes, new_numbers, outputs}
  end
 
  def operation([2, box], boxes, numbers, outputs) do
    msg = Map.get(boxes, box) |> Enum.sort() |> Enum.join(" ")
 
    {boxes, numbers, [msg | outputs]}
  end
 
  def operation([3, number], boxes, numbers, outputs) do
    msg = Map.get(numbers, number) |> Enum.sort() |> Enum.join(" ")
 
    {boxes, numbers, [msg | outputs]}
  end
end
```

[MapSet.put/2](https://hexdocs.pm/elixir/MapSet.html#put/2)する前に、[MapSet.member?/2](https://hexdocs.pm/elixir/MapSet.html#member?/2)ですでに登録済かどうかを確認しているのは、[TLE (Time Limit Exceeded)](https://atcoder.jp/contests/abc074/glossary?lang=ja)を回避するための対策です。
[MapSet.member?/2](https://hexdocs.pm/elixir/MapSet.html#member?/2)でのチェックを入れる前は、なんと2001msと1msのタイムオーバーが発生していました。
駄目元で入れてみたら、見事パスできました :tada:


</details>


---

# さいごに

[AtCoder Beginner Contest 298](https://atcoder.jp/contests/abc298)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
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
