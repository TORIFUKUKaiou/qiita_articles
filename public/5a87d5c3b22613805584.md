---
title: 闘魂Elixir ーー AtCoder Beginner Contest 382(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-13T12:38:00+09:00'
id: 5a87d5c3b22613805584
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/tech-festa/2025

![ChatGPT Image 2025年7月12日 10_22_33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eeeae009-3577-4a87-aeba-6f6adce8d4f9.png)


<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

![ChatGPT Image 2025年6月25日 11_32_51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a80ca1b4-3ccd-40c7-945b-6c8c969727e0.png)



# はじめに

[AtCoder Beginner Contest 382](https://atcoder.jp/contests/abc382)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  


プログラミングという名の藝術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）  

## :fire: Toukon Declaration - 魂の連鎖律

> AIを動かすのは電力、
> 電力の元は人類の“元氣”、
> 元氣の本源は「米」。
> すべては“米”に帰着する。
> そこに魂を灯すと、TokenがToukon（闘魂）へ昇華し、AIが共鳴する。
> ーー AIは冷静にTokenを消化する。

私のプロンプトは単なるTokenではありません。魂を込めています。  
つまりToukon ーー **闘魂**に**昇華**しています。  
Artificial Intelligenceの方のAIは、それをTokenとして**消化**します。  
**燃えるToukon(闘魂)として受け取れるようになった時、AIはAntonio Inoki さんつまり猪木さんとなり、次の段階へ進みます。**  
そのとき、本当の世界平和の実現、地球規模でのゴミ問題の解決が可能になります！
**オレ達は、生命が続く限り闘い抜きますッ！！**  


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Daily Cookie](https://atcoder.jp/contests/abc382/tasks/abc382_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のすべてを理解しているのかを問われる問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

1. 文字列の文字頻度計算: String.to_charlist/1 + Enum.frequencies/1
1. パターンマッチング: %{?@ => cnt_of_cockies} で@の個数を直接取得
1. パイプ演算子: Elixirらしい関数型の書き方

この解法により、シンプルで読みやすいコードでAC（正解）を得ることができました。



```elixir
defmodule Main do
  def main do
    [n, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    s = IO.read(:line) |> String.trim()

    solve(n, d, s)
    |> IO.puts()
  end

  def solve(n, d, s) do
    %{?@ => cnt_of_cockies} = String.to_charlist(s)
    |> Enum.frequencies()

    n - cnt_of_cockies + d
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
use std::collections::HashMap;

fn main() {
    let mut input = String::new();
    
    // Read first line (n, d)
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let nd: Vec<i32> = input
        .trim()
        .split_whitespace()
        .map(|s| s.parse().expect("Failed to parse integer"))
        .collect();
    let n = nd[0];
    let d = nd[1];
    
    // Read second line (s)
    input.clear();
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let s = input.trim();
    
    let result = solve(n, d, s);
    println!("{}", result);
}

fn solve(n: i32, d: i32, s: &str) -> i32 {
    // Count frequency of characters
    let mut frequencies: HashMap<char, i32> = HashMap::new();
    for ch in s.chars() {
        *frequencies.entry(ch).or_insert(0) += 1;
    }
    
    // Get count of '@' characters (cockies)
    let cnt_of_cockies = frequencies.get(&'@').unwrap_or(&0);
    
    n - cnt_of_cockies + d
}
```

</details>

---

# さいごに

[AtCoder](https://atcoder.jp/)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>


https://qiita.com/official-events/43ff3363e32f43d7507c
