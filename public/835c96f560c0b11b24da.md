---
title: 闘魂Elixir ーー AtCoder Beginner Contest 297をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-05-15T18:08:08+09:00'
id: 835c96f560c0b11b24da
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 297](https://atcoder.jp/contests/abc297)を[Elixir](https://elixir-lang.org/)で解いてみます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方は、別の記事にまとめています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。

# [A - Double Click](https://atcoder.jp/contests/abc297/tasks/abc297_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [_n, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    ts = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    {success, t} = Enum.reduce_while(ts, {false, nil}, fn
      t, {false, nil} -> {:cont, {false, t}}
      t, {false, before_t} -> if t - before_t <= d, do: {:halt, {true, t}}, else: {:cont, {false, t}}
    end)
    
    answer = if success, do: t, else: -1
    IO.puts(answer)
  end
end
```
</details>


# [B - chess960](https://atcoder.jp/contests/abc297/tasks/abc297_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()
    solve(s) |> IO.puts()
  end
  
  defp solve(s) do
    b1 = find_index(s, ?B)
    b2 = find_index(s, ?B, b1 + 1)
    r1 = find_index(s, ?R)
    r2 = find_index(s, ?R, r1 + 1)
    k = find_index(s, ?K)
    
    do_solve(b1, b2, r1, r2, k)
  end
  
  defp do_solve(b1, b2, _r1, _r2, _k) when rem(b1, 2) == 0 and rem(b2, 2) == 0, do: "No"
  defp do_solve(b1, b2, _r1, _r2, _k) when rem(b1, 2) == 1 and rem(b2, 2) == 1, do: "No"
  defp do_solve(_b1, _b2, r1, r2, k) when r1 < k and k < r2, do: "Yes"
  defp do_solve(_b1, _b2, _r1, _r2, _k), do: "No"
  
  defp find_index(s, c, start_index \\ 0) do
    String.slice(s, start_index..-1)
    |> String.to_charlist()
    |> Enum.find_index(& &1 == c)
    |> Kernel.+(start_index)
  end
end
```
</details>

# [C - PC on the Table](https://atcoder.jp/contests/abc297/tasks/abc297_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

```elixir
defmodule Main do
  def main do
    [h, _w] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    1..h
    |> Enum.reduce([], fn _, acc ->
      charlist = IO.read(:line) |> String.trim() |> String.to_charlist()
      [charlist | acc]
    end)
    |> Enum.reverse()
    |> solve()
    |> IO.puts()
  end
  
  defp solve(list_of_charlist) do
    list_of_charlist
    |> Enum.map(fn charlist ->
      charlist
      |> Enum.chunk_by(& &1 == ?.)
      |> Enum.map(fn charlist ->
        if hd(charlist) == ?T do
          Enum.chunk_every(charlist, 2)
          |> Enum.map(fn
            'TT' -> "PC"
            'T' -> "T"
          end)
          |> Enum.join()
        else
          charlist
          |> List.to_string()
        end
      end)
    end)
    |> Enum.map(&Enum.join/1)
    |> Enum.join("\n")
  end
end
```
</details>

---

# 参考記事

https://qiita.com/GeekMasahiro/items/0970d7300f2bfcb28464

---

# さいごに

[AtCoder Beginner Contest 297](https://atcoder.jp/contests/abc297)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
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
