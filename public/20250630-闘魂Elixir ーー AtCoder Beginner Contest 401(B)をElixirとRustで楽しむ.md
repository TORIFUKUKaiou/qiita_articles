---
title: 闘魂Elixir ーー AtCoder Beginner Contest 401(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-30T07:53:44+09:00'
id: f8ee3972c096d10f1cbb
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

[AtCoder Beginner Contest 401](https://atcoder.jp/contests/abc401)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Unauthorized](https://atcoder.jp/contests/abc401/tasks/abc401_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」を、すべて理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


①`login`状態であるかどうかによってカウントが変わる、②アクセスするページによってカウントがかわる の2点から、Enum.reduce/3 を使い、Accumulatorには、それまでのカウントと現在状態をタプルで持たせました。  

```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    s_list = for _ <- 1..n do
      IO.read(:line)
      |> String.trim()
    end

    solve(s_list)
    |> IO.puts()
  end

  def solve(list) do
    Enum.reduce(list, {0, false}, fn
      "login", {acc_count, _acc_state} -> {acc_count, true}
      "logout", {acc_count, _acc_state} -> {acc_count, false}
      "private", {acc_count, true} -> {acc_count, true}
      "private", {acc_count, false} -> {acc_count + 1, false}
      _, {acc_count, acc_state} -> {acc_count, acc_state}
    end)
    |> elem(0)
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

    // 1行目：n
    let n: usize = lines
        .next()
        .unwrap()
        .unwrap()
        .trim()
        .parse()
        .expect("Failed to parse n");

    // 次のn行：コマンド
    let s_list: Vec<String> = lines
        .take(n)
        .map(|line| line.unwrap().trim().to_string())
        .collect();

    let result = solve(&s_list);
    println!("{}", result);
}

fn solve(list: &[String]) -> i32 {
    let mut acc_count = 0;
    let mut acc_state = false;

    for cmd in list {
        match cmd.as_str() {
            "login" => acc_state = true,
            "logout" => acc_state = false,
            "private" if !acc_state => acc_count += 1,
            "private" => {} // acc_state == true → 無視
            _ => {} // その他コマンド → 状態維持
        }
    }

    acc_count
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 401](https://atcoder.jp/contests/abc401)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
