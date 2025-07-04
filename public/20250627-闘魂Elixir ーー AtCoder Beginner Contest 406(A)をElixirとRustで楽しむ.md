---
title: 闘魂Elixir ーー AtCoder Beginner Contest 406(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-27T22:10:29+09:00'
id: 1aa96a2f2d4ea7b671ee
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

# [A - Not Acceptable](https://atcoder.jp/contests/abc406/tasks/abc406_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、主に「順次」と「分岐」を理解できているのかを問う問題です。入力値が横に長いので、「繰り返し」の要素もあります。  

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


関数パターンマッチとガード節で解きました。  



```elixir
defmodule Main do
  def main do
    [a, b, c, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(a, b, c, d)
    |> IO.puts()
  end

  def solve(a, _b, c, _d) when a > c, do: "Yes"
  def solve(a, b, c, d) when a == c and b >= d, do: "Yes"
  def solve(_a, _b, _c, _d), do: "No"
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
    // 入力行を取得
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("読み込み失敗");

    // スペースで分割して整数に変換
    let nums: Vec<i32> = input
        .trim()
        .split_whitespace()
        .map(|s| s.parse().expect("数値に変換できません"))
        .collect();

    let a = nums[0];
    let b = nums[1];
    let c = nums[2];
    let d = nums[3];

    // 判定と出力
    println!("{}", solve(a, b, c, d));
}

fn solve(a: i32, b: i32, c: i32, d: i32) -> &'static str {
    if a > c {
        "Yes"
    } else if a == c && b >= d {
        "Yes"
    } else {
        "No"
    }
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
