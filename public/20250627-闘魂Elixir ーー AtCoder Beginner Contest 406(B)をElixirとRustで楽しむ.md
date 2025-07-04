---
title: 闘魂Elixir ーー AtCoder Beginner Contest 406(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-27T22:22:34+09:00'
id: ef6ac5ffc7c741f1c999
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

[AtCoder Beginner Contest 406](https://atcoder.jp/contests/abc406)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Product Calculator](https://atcoder.jp/contests/abc406/tasks/abc406_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


Enum.reduce/3 畳み込みに大活躍してもらいました。こういうのは、私は、畳み込み一択です。  



```elixir
defmodule Main do
  def main do
    [_n, k] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    a_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(k, a_list)
    |> IO.puts()
  end

  def solve(k, a_list) do
    max = max(k)

    Enum.reduce(a_list, 1, fn
      a, acc when a * acc >= max -> 1
      a, acc -> a * acc
    end)
  end

  defp max(k) do
    str = "1" <> String.duplicate("0", k)
    String.to_integer(str)
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
use std::io;

fn main() {
    // 1行目: n, k を読み取り
    let mut line1 = String::new();
    io::stdin().read_line(&mut line1).unwrap();
    let parts: Vec<usize> = line1
        .trim()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let _n = parts[0];
    let k = parts[1];

    // 2行目: a_list を読み取り
    let mut line2 = String::new();
    io::stdin().read_line(&mut line2).unwrap();
    let a_list: Vec<u64> = line2
        .trim()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    // 計算・出力
    println!("{}", solve(k, &a_list));
}

fn solve(k: usize, a_list: &[u64]) -> u64 {
    let max = 10u64.pow(k as u32);

    a_list.iter().fold(1u64, |acc, &a| {
        if a.saturating_mul(acc) >= max {
            1
        } else {
            a * acc
        }
    })
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 406](https://atcoder.jp/contests/abc406)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
