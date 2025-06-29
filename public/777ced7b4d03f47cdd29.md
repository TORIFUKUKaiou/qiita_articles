---
title: 闘魂Elixir ーー AtCoder Beginner Contest 403(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-28T22:31:42+09:00'
id: 777ced7b4d03f47cdd29
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/tech-festa/2025/tech-sprint

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

![ChatGPT Image 2025年6月25日 11_32_51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a80ca1b4-3ccd-40c7-945b-6c8c969727e0.png)



# はじめに

[AtCoder Beginner Contest 403](https://atcoder.jp/contests/abc403)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Odd Position Sum](https://atcoder.jp/contests/abc403/tasks/abc403_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらすべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


[Enum.with_index/2](https://hexdocs.pm/elixir/Enum.html#with_index/2)を使って、奇数番目か偶数番目かを判別しました。  


```elixir
defmodule Main do
  def main do
    _n  = IO.read(:line)
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  def solve(list) do
    list
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn
      {a, index}, acc when rem(index, 2) == 1 -> a + acc
      {_a, _index}, acc -> acc
    end)
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

    // 最初の行（_n）を読み飛ばす
    let _n = lines.next();

    // 2行目を取得して整数リストに変換
    if let Some(Ok(line)) = lines.next() {
        let nums: Vec<i32> = line
            .split_whitespace()
            .filter_map(|s| s.parse().ok())
            .collect();

        // solve関数で奇数番目の和を計算して出力
        let result = solve(&nums);
        println!("{}", result);
    }
}

fn solve(nums: &[i32]) -> i32 {
    nums.iter()
        .enumerate()
        .filter(|(i, _)| (i + 1) % 2 == 1) // 1-based indexの奇数番目
        .map(|(_, &val)| val)
        .sum()
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 403](https://atcoder.jp/contests/abc403)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>


https://qiita.com/official-events/4f7ac46e5cd6c03f1397
