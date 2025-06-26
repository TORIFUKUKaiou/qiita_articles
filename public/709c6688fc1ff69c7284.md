---
title: 闘魂Elixir ーー AtCoder Beginner Contest 409(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-25T21:51:39+09:00'
id: 709c6688fc1ff69c7284
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

[AtCoder Beginner Contest 409](https://atcoder.jp/contests/abc409)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Conflict](https://atcoder.jp/contests/abc409/tasks/abc409_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


2つのリストをEnum.zip/2して、Enum.any?/2で、両者が`o`と言っているのかどうかを判定しています。  
無名関数はパターンマッチで場合分けするようにしました。
ひそかなマイブームです。

`?o`は、`"o"`をCharlist化したときに、文字`o`に対するアスキーコード111が得られるものです。  
同様に`?x`は、120です。


```elixir
defmodule Main do
  def main do
    _n = IO.read(:line)
    t = IO.read(:line) |> String.trim() |> String.to_charlist()
    a = IO.read(:line) |> String.trim() |> String.to_charlist()

    solve(t, a)
    |> IO.puts
  end

  def solve(t, a) do
    Enum.zip(t, a)
    |> Enum.any?(fn
      {?o, ?o} -> true
      {_, _} -> false
    end)
    |> if(do: "Yes", else: "No")
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

    // 1行目：使わない（_n）
    let _ = lines.next();

    // 2行目：t
    let t = lines.next().unwrap().unwrap();
    // 3行目：a
    let a = lines.next().unwrap().unwrap();

    let result = solve(&t, &a);
    println!("{}", result);
}

fn solve(t: &str, a: &str) -> &'static str {
    for (tc, ac) in t.chars().zip(a.chars()) {
        if tc == 'o' && ac == 'o' {
            return "Yes";
        }
    }
    "No"
}

```

</details>

---

# さいごに

[AtCoder Beginner Contest 409](https://atcoder.jp/contests/abc409)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
