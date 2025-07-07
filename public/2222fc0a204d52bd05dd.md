---
title: 闘魂Elixir ーー AtCoder Beginner Contest 391(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-07T07:43:33+09:00'
id: 2222fc0a204d52bd05dd
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

[AtCoder Beginner Contest 391](https://atcoder.jp/contests/abc391)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  


プログラミングという名の藝術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Seek Grid](https://atcoder.jp/contests/abc391/tasks/abc391_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のすべてを理解を理解できているのかが問われる問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

Sのすべての点を始点として、Tがすっぽり収まるのかどうかを愚直に調べ上げる実装にしました。  
こういう問題をElixirで解くのはいやな予感しかしないのですが、Mapを使うことと、繰り返しの数が 50 x 50 x 50 程度なので**TLE** はでませんでした :tada::tada::tada: 


```elixir
defmodule Main do
  def main do
    [n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    s_grid = read_grid(n)
    t_grid = read_grid(m)

    solve(s_grid, t_grid, n, m)
    |> IO.puts()
  end

  def solve(s_grid, t_grid, n, m) do
    points = for a <- 1..n, b <- 1..n, do: {a, b}

    points
    |> Enum.reduce_while(nil, fn {a, b}, nil ->
      for s_i <- a..(a + m - 1),
          s_j <- b..(b + m - 1),
          Map.get(s_grid, {s_i, s_j}) != nil,
          t_i = s_i - a + 1,
          t_j = s_j - b + 1,
          Map.get(s_grid, {s_i, s_j}) == Map.get(t_grid, {t_i, t_j}) do
          {s_i, s_j}
      end
      |> Enum.count()
      |> Kernel.==(m * m)
      |> if(do: {:halt, "#{a} #{b}"}, else: {:cont, nil})
    end)
  end

  defp read_grid(q) do
    for i <- 1..q, reduce: %{} do
      acc -> IO.read(:line)
      |> String.trim()
      |> String.to_charlist()
      |> Enum.with_index(1)
      |> Enum.reduce(acc, fn {v, j}, map ->
        Map.put(map, {i, j}, v)
      end)
    end
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

    let line = lines.next().unwrap().unwrap();
    let parts: Vec<usize> = line.trim().split_whitespace()
        .map(|s| s.parse().unwrap()).collect();
    let (n, m) = (parts[0], parts[1]);

    let s_grid = read_matrix(&mut lines, n);
    let t_grid = read_matrix(&mut lines, m);

    if let Some((a, b)) = solve(&s_grid, &t_grid, n, m) {
        println!("{} {}", a + 1, b + 1); // 出力は1-indexed
    }
}

fn read_matrix<I>(lines: &mut I, size: usize) -> Vec<Vec<char>>
where
    I: Iterator<Item = Result<String, io::Error>>,
{
    (0..size)
        .map(|_| {
            lines
                .next()
                .unwrap()
                .unwrap()
                .trim()
                .chars()
                .collect::<Vec<char>>()
        })
        .collect()
}

fn solve(
    s_grid: &Vec<Vec<char>>,
    t_grid: &Vec<Vec<char>>,
    n: usize,
    m: usize,
) -> Option<(usize, usize)> {
    for a in 0..=(n - m) {
        for b in 0..=(n - m) {
            let mut match_all = true;
            for i in 0..m {
                for j in 0..m {
                    if s_grid[a + i][b + j] != t_grid[i][j] {
                        match_all = false;
                        break;
                    }
                }
                if !match_all {
                    break;
                }
            }
            if match_all {
                return Some((a, b));
            }
        }
    }
    None
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
