---
title: 闘魂Elixir ーー AtCoder Beginner Contest 403(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-28T23:03:04+09:00'
id: c3b2a4e60265b1920610
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

# [B - Four Hidden](https://atcoder.jp/contests/abc403/tasks/abc403_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらすべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


正規表現を使って解きました。  

```elixir
defmodule Main do
  def main do
    t = IO.read(:line) |> String.trim()
    u = IO.read(:line) |> String.trim()

    solve(t, u)
    |> IO.puts()
  end

  def solve(t, u) do
    t_len = String.length(t)
    u_len = String.length(u)

    0..(t_len - u_len)
    |> Enum.reduce_while(nil, fn start, nil ->
      {:ok, r} = String.slice(t, start, u_len) |> String.replace("?", ".") |> Regex.compile()
      if Regex.match?(r, u) do
        {:halt, true}
      else
        {:cont, nil}
      end
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
use regex::Regex;

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let t = lines.next().unwrap().unwrap();
    let u = lines.next().unwrap().unwrap();

    let result = solve(&t, &u);
    println!("{}", result);
}

fn solve(t: &str, u: &str) -> &'static str {
    let t_chars: Vec<char> = t.chars().collect();
    let u_len = u.chars().count();

    if u_len > t_chars.len() {
        return "No";
    }

    for start in 0..=t_chars.len() - u_len {
        let pattern: String = t_chars[start..start + u_len]
            .iter()
            .map(|&c| {
                if c == '?' {
                    ".".to_string()
                } else {
                    regex::escape(&c.to_string())
                }
            })
            .collect::<Vec<String>>()
            .join("");

        if let Ok(re) = Regex::new(&format!("^{}$", pattern)) {
            if re.is_match(u) {
                return "Yes";
            }
        }
    }

    "No"
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
