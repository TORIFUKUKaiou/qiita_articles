---
title: 闘魂Elixir ーー AtCoder Beginner Contest 400(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-30T23:29:49+09:00'
id: 4ca3af6f9195c7024a19
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

[AtCoder Beginner Contest 400](https://atcoder.jp/contests/abc400)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Sum of Geometric Series](https://atcoder.jp/contests/abc400/tasks/abc400_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらの基本をすべて理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


合計に条件があるため、Enum.reduce_while/3 を使いました。  
べき乗計算は、 `**` を使いました。  
`**`はガード節には使えなかったので、別の関数`do_solve/1`にわけてガード節で、上限値を超えた場合、上限値以内の場合の場合分けを実装しました。  

```elixir
defmodule Main do
  @max 10 ** 9

  def main do
    [n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, m)
    |> IO.puts()
  end

  def solve(n, m) do
    (0..m)
    |> Enum.reduce_while(0, fn
      i, acc -> do_solve(n ** i + acc)
    end)
  end

  defp do_solve(acc) when acc <= @max, do: {:cont, acc}
  defp do_solve(_acc), do: {:halt, "inf"}
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

const MAX: u64 = 1_000_000_000;

fn main() {
    // 入力を受け取る
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");

    // nとmに分割して整数に変換
    let parts: Vec<u64> = input
        .trim()
        .split_whitespace()
        .map(|s| s.parse().expect("Invalid number"))
        .collect();

    let n = parts[0];
    let m = parts[1];

    // 結果を出力
    println!("{}", solve(n, m));
}

fn solve(n: u64, m: u64) -> String {
    let mut acc: u64 = 0;

    for i in 0..=m {
        match n.checked_pow(i as u32).and_then(|val| acc.checked_add(val)) {
            Some(new_acc) if new_acc <= MAX => acc = new_acc,
            _ => return "inf".to_string(),
        }
    }

    acc.to_string()
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 400](https://atcoder.jp/contests/abc400)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
