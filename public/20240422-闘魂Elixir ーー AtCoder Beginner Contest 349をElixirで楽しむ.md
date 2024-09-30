---
title: 闘魂Elixir ーー AtCoder Beginner Contest 349をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-04-23T11:18:56+09:00'
id: 3454a1425e677524fbff
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 349](https://atcoder.jp/contests/abc349)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。
といっても、私はC問題くらいまでしか解ける気がしません。

私達[ハウインターナショナル](https://www.haw.co.jp/)では、社名をもじって[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)という名のイベントを毎月最終金曜日に実施しています。

**HAW + Hackathon = Hawckathon!!**

[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)のテーマに競技プログラミングを選ぶメンバーもいます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。
つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Zero Sum Game](https://atcoder.jp/contests/abc349/tasks/abc349_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

問題文を読んでいることを前提にひとこと解説をしておきます。


すべての対戦結果の場合を挙げていると時間内には終わらないでしょう。
問題のタイトルがヒントになっています。
**Zero Sum Game** つまり全部足すと0ということです。
ですから、`N - 1`人までの得点を合計して、その符合（プラスかマイナス）を反転させたものがN人目の得点となります。これで全部の合計は0になるわけです。

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list
    |> solve()
    |> IO.puts()
  end
  
  def solve(list) do
    list |> Enum.sum() |> Kernel.*(-1)
  end
end
```
</details>


# [B - Commencement](https://atcoder.jp/contests/abc349/tasks/abc349_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

問題文を読んでいることを前提にひとこと解説をしておきます。

文字列の中に含まれるアルファベットの数を数え上げればよいわけです。
そういった用途に適した関数として、[Enum.frequencies/1](https://hexdocs.pm/elixir/Enum.html#frequencies/1)関数があります。本問では大活躍です。

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()

    solve(s)
    |> IO.puts()
  end
  
  def solve(s) do
    s 
    |> String.to_charlist()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.all?(fn
         2 -> true
         _ -> false
      end)
    |> if(do: "Yes", else: "No")
  end
end
```
</details>

# [C - Airport Code](https://atcoder.jp/contests/abc349/tasks/abc349_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

問題文を読んでいることを前提にひとこと解説をしておきます。

これぞ[Elixir](https://elixir-lang.org/)！　という感じで解けます。
[再帰](https://hexdocs.pm/elixir/recursion.html)と[パターンマッチ](https://hexdocs.pm/elixir/pattern-matching.html)で解きました。

余談であり、何の自慢にもなりませんが、私は学生時代から[再帰](https://hexdocs.pm/elixir/recursion.html)プログラムを書くのは苦手でした。読むのもなんとなく分かったふりをしていただけです。頭がこんがらがります。
そんな私ですが、なぜだか[Elixir](https://elixir-lang.org/)では書けてしまいます。[パターンマッチ](https://hexdocs.pm/elixir/pattern-matching.html)のおかげだとおもいます。

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim() |> String.to_charlist()
    t = IO.read(:line) |> String.trim() |> String.downcase() |> String.to_charlist()

    solve(s, t)
    |> IO.puts()
  end

  def solve(_list, 'x'), do: "Yes"

  def solve(_list, []), do: "Yes"

  def solve([], _target), do: "No"

  def solve([head | tail], [head | remain]) do
    solve(tail, remain)
  end

  def solve([_head | tail], target) do
    solve(tail, target)
  end
end
```

別の解法です。
正規表現を使って解くというものです。
文字列`s`の末尾に`"x"`をあらかじめ挿入しておくことで正規表現一発で解くことができます。
若い人に解法を教えてもらいました:sunglasses:


```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim() |> Kernel.<>("x")
    [a, b, c] = IO.read(:line) |> String.trim() |> String.downcase() |> String.codepoints()

    r = Regex.compile!("#{a}.*#{b}.*#{c}")

    if(s =~ r, do: "Yes", else: "No")
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

[AtCoder Beginner Contest 349](https://atcoder.jp/contests/abc349)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
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
