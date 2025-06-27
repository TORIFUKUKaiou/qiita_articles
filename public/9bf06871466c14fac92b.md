---
title: 闘魂Elixir ーー AtCoder Beginner Contest 410(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-27T00:41:03+09:00'
id: 9bf06871466c14fac92b
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

![ChatGPT Image 2025年6月25日 11_32_51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a80ca1b4-3ccd-40c7-945b-6c8c969727e0.png)



# はじめに

[AtCoder Beginner Contest 410](https://atcoder.jp/contests/abc410)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Reverse Proxy](https://atcoder.jp/contests/abc410/tasks/abc410_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


Enum.reduce/3に大活躍してもらいました。  
無名関数はガード節で場合分けするのを多用しました。別関数で切り出した方が見通しはよくなるかもしれません。


```elixir
defmodule Main do
  def main do
    [n, q] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    x_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, q, x_list)
    |> IO.puts()
  end

  def solve(n, q, x_list) do
    box = 1..n |> Enum.reduce(%{}, fn i, acc -> Map.put(acc, i, 0) end)

    x_list
    |> Enum.reduce({[], box}, fn
      0, {list, acc_box} ->
        min = Enum.reduce(acc_box, {n, q}, fn 
          {i, count}, {acc_i, acc_count} when count == acc_count -> {min(i, acc_i), acc_count}
          {i, count}, {_acc_i, acc_count} when count < acc_count -> {i, count}
          {_i, _count}, {acc_i, acc_count} -> {acc_i, acc_count}
        end)
        |> elem(0)

        {[min | list], Map.update(acc_box, min, 1, &(&1 + 1))}
      x, {list, acc_box} -> {[x | list], Map.update(acc_box, x, 1, &(&1 + 1))}
    end)
    |> elem(0)
    |> Enum.reverse()
    |> Enum.join(" ")
  end
end
```




</details>

---

## Rust

RustはAI先生のお力をお借りして、Elixirのコードを置き換えてもらいました。
私は、Rustを勉強中です。万年勉強中です。闘魂にゴールはない。いつまでも挑戦中です。

<details><summary>私の解答(Rust)</summary>

```rust
use std::collections::HashMap;
use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    // 1行目：nとq
    let first_line = lines.next().unwrap().unwrap();
    let mut first_iter = first_line.trim().split_whitespace();
    let n: usize = first_iter.next().unwrap().parse().unwrap();
    let _q: usize = first_iter.next().unwrap().parse().unwrap(); // qは使わない

    // 2行目：x_list
    let x_line = lines.next().unwrap().unwrap();
    let x_list: Vec<usize> = x_line
        .trim()
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect();

    let result = solve(n, &x_list);
    println!("{}", result);
}

fn solve(n: usize, x_list: &[usize]) -> String {
    let mut counts: HashMap<usize, usize> = (1..=n).map(|i| (i, 0)).collect();
    let mut output: Vec<usize> = Vec::new();

    for &x in x_list {
        if x == 0 {
            // 最小カウントかつ番号が最小のものを探す
            let min_entry = counts
                .iter()
                .min_by_key(|&(i, count)| (*count, *i))
                .map(|(i, _)| *i)
                .unwrap();
            *counts.get_mut(&min_entry).unwrap() += 1;
            output.push(min_entry);
        } else {
            *counts.entry(x).or_insert(0) += 1;
            output.push(x);
        }
    }

    output
        .into_iter()
        .map(|num| num.to_string())
        .collect::<Vec<_>>()
        .join(" ")
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 410](https://atcoder.jp/contests/abc410)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
