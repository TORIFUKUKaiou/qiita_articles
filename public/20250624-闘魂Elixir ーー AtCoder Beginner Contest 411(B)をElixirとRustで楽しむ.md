---
title: 闘魂Elixir ーー AtCoder Beginner Contest 411(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-27T00:42:04+09:00'
id: 6219ab0c6b962cb20ce5
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

[AtCoder Beginner Contest 411](https://atcoder.jp/contests/abc411)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Distance Table](https://atcoder.jp/contests/abc411/tasks/abc411_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


[Enum.reduce/3](https://hexdocs.pm/elixir/1.18.4/Enum.html#reduce/3)（畳み込み）を使って、解きました。


```elixir
defmodule Main do
  def main do
    IO.read(:line)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list
    |> solve()
    |> Enum.join("\n")
    |> IO.puts()
  end

  def solve(list) do
    [_ | tail] = list
    do_solve(tail, [cumulative_sums(list)])
  end

  def do_solve([], result), do: result |> Enum.reverse

  def do_solve(list, result) do
    [_ | tail] = list
    do_solve(tail, [cumulative_sums(list) | result])
  end

  def cumulative_sums(list) do
    Enum.reduce(list, [], 
      fn d, [] -> [d]
         d, [head | tail] -> [head + d, head | tail]
      end)
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
use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    // 1行目（使わない）
    let _ = lines.next();

    // 2行目（整数リスト）
    let list: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .trim()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let results = solve(&list);

    for line in results {
        println!("{}", line);
    }
}

fn solve(list: &[i32]) -> Vec<String> {
    let mut results = Vec::new();
    let mut slice = list;

    while !slice.is_empty() {
        results.push(cumulative_sums(slice));
        slice = &slice[1..];
    }

    results
}

fn cumulative_sums(list: &[i32]) -> String {
    let mut acc = Vec::new();

    for &x in list {
        if let Some(&last) = acc.last() {
            acc.push(last + x);
        } else {
            acc.push(x);
        }
    }

    acc.iter()
        .map(|n| n.to_string())
        .collect::<Vec<_>>()
        .join(" ")
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 411](https://atcoder.jp/contests/abc411)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
