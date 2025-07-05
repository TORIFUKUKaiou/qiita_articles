---
title: 闘魂Elixir ーー AtCoder Beginner Contest 393(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-05T13:21:45+09:00'
id: 2c9ea3f47c322bd7b1d3
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/tech-festa/2025

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

![ChatGPT Image 2025年6月25日 11_32_51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a80ca1b4-3ccd-40c7-945b-6c8c969727e0.png)



# はじめに

[AtCoder Beginner Contest 393](https://atcoder.jp/contests/abc393)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  


プログラミングという名の藝術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - A..B..C](https://atcoder.jp/contests/abc393/tasks/abc393_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」をすべて理解できているのかが問われる問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

文字列の長さは50文字が最長なので、考えられる間隔で3文字を取り出して、"ABC"になるのかを調べました。  
さらに愚直に左から順に、先頭を変えながら末尾まで繰り返す感じです。  
2重ループのイメージです。  

```elixir
defmodule Main do
  def main do
    map
      = IO.read(:line) |> String.trim() |> String.to_charlist() |> Enum.with_index(fn v, index -> {index, v} end) |> Map.new()
    
    n = Enum.count(map)
    
    solve(n, map)
    |> IO.puts()
  end

  def solve(n, map) do
    0..(n - 1)
    |> Enum.reduce(0, fn i, acc ->
      1..(n - 1 - i)
      |> Enum.reduce_while(acc, fn j, acc ->
        cont_or_halt = if Map.get(map, i) == ?A, do: :cont, else: :halt
        {cont_or_halt, acc + do_solve(Map.get(map, i), Map.get(map, i + j), Map.get(map, i + 2 * j))}
      end)
    end)
  end

  def do_solve(?A, ?B, ?C), do: 1
  def do_solve(_, _, _), do: 0
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
    let mut line = String::new();
    stdin.lock().read_line(&mut line).unwrap();

    let trimmed = line.trim();
    let chars: Vec<char> = trimmed.chars().collect();

    let map: HashMap<usize, char> = chars.iter().enumerate().map(|(i, &c)| (i, c)).collect();
    let n = map.len();

    let result = solve(n, &map);
    println!("{}", result);
}

fn solve(n: usize, map: &HashMap<usize, char>) -> usize {
    let mut count = 0;

    for i in 0..n {
        for j in 1..(n - i) {
            if let Some(&c1) = map.get(&i) {
                if c1 != 'A' {
                    break;
                }
                let c2 = map.get(&(i + j));
                let c3 = map.get(&(i + 2 * j));
                count += do_solve(c1, c2, c3);
            }
        }
    }

    count
}

fn do_solve(c1: char, c2: Option<&char>, c3: Option<&char>) -> usize {
    match (c1, c2, c3) {
        ('A', Some('B'), Some('C')) => 1,
        _ => 0,
    }
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
