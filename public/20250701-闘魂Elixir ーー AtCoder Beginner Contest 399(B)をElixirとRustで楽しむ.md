---
title: 闘魂Elixir ーー AtCoder Beginner Contest 399(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-01T19:17:53+09:00'
id: 3697c69b1a7a37a6035b
organization_url_name: fukuokaex
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

[AtCoder Beginner Contest 399](https://atcoder.jp/contests/abc399)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Ranking with Ties](https://atcoder.jp/contests/abc399/tasks/abc399_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらの基本をすべて理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


元のリストを順位で書き換えながら、処理することにしました。  
もっとスマートなやり方はあると思いますが、得点と順位が同一の場合に順位がおかしくなると思ったので、一旦、得点にはないマイナスで順位をいれることにしました。  

```elixir
defmodule Main do
  def main do
    _n = IO.read(:line) |> String.trim() |> String.to_integer()
    list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(list)
    |> IO.puts()
  end

  def solve(list) do
   MapSet.new(list)
   |> Enum.sort(:desc)
   |> Enum.reduce({list, 1}, fn p, {acc_list, r} ->
      new_acc_list = Enum.reduce(acc_list, [], fn 
        ^p, acc -> [-r | acc]
        p, acc -> [p | acc]
      end)

      k = Enum.count(new_acc_list, fn p -> p == -r end)

      {Enum.reverse(new_acc_list), r + k}
   end)
   |> elem(0)
   |> Enum.map(&(-&1))
   |> Enum.join("\n")
  end
end
```

参考: ChatGPTによる書き換え案

```elixir
defmodule Main do
  def main do
    _n = IO.read(:line) |> String.trim() |> String.to_integer()
    list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(list)
    |> IO.puts()
  end

  def solve(list) do
    list
    |> Enum.with_index()
    |> Enum.sort_by(fn {score, _idx} -> -score end)
    |> Enum.reduce({[], nil, 0, 1}, fn {score, idx}, {acc, prev_score, same_count, rank} ->
      cond do
        score == prev_score ->
          {[{idx, rank} | acc], prev_score, same_count + 1, rank}

        true ->
          {[{idx, rank + same_count} | acc], score, 1, rank + same_count}
      end
    end)
    |> elem(0)
    |> Enum.sort_by(fn {idx, _rank} -> idx end)
    |> Enum.map(fn {_idx, rank} -> rank end)
    |> Enum.join("\n")
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
use std::collections::HashSet;
use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    // 1行目（使わない）
    let _n = lines.next().unwrap().unwrap().trim().parse::<usize>().unwrap();

    // 2行目：整数リスト
    let list: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .trim()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let result = solve(list);
    for v in result {
        println!("{}", v);
    }
}

fn solve(list: Vec<i32>) -> Vec<i32> {
    let mut set: HashSet<i32> = list.iter().cloned().collect();
    let mut unique_vals: Vec<i32> = set.drain().collect();
    unique_vals.sort_by(|a, b| b.cmp(a)); // 降順にソート

    let mut acc_list = list;
    let mut r = 1;

    for p in unique_vals {
        let mut new_acc = Vec::new();
        for &x in &acc_list {
            if x == p {
                new_acc.push(-r);
            } else {
                new_acc.push(x);
            }
        }

        let k = new_acc.iter().filter(|&&x| x == -r).count();
        acc_list = new_acc;
        r += k as i32;
    }

    acc_list.into_iter().map(|x| -x).collect()
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 399](https://atcoder.jp/contests/abc399)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
