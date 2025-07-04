---
title: 闘魂Elixir ーー AtCoder Beginner Contest 395(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-03T21:34:59+09:00'
id: b47909534e39881b72bf
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

[AtCoder Beginner Contest 395](https://atcoder.jp/contests/abc395)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Make Target](https://atcoder.jp/contests/abc395/tasks/abc395_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」の、すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

指示の通りに実装しました。もしかしたら、計算を省けるところがあるのかもしれません。  


```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    solve(n)
    |> IO.puts()
  end

  def solve(n) do
    map = (1..n)
    |> Enum.reduce(%{}, fn i, acc ->
      j = n + 1 - i
      do_solve(i, j, acc)
    end)

    line = for i <- 1..n, j <- 1..n, s = Map.get(map, {i, j}), into: [], do: s

    Enum.chunk_every(line, n)
    |> Enum.join("\n")
  end

  defp do_solve(i, j, map) when i <= j and rem(i, 2) == 1 do
    color(i, j, map, "#")
  end

  defp do_solve(i, j, map) when i <= j and rem(i, 2) == 0 do
    color(i, j, map, ".")
  end

  defp do_solve(i, j, map) when i > j, do: map

  defp color(i, j, map, c) do
    (i..j)
    |> Enum.reduce(map, fn k, acc ->
      Map.put(acc, {i, k}, c)
      |> Map.put({j, k}, c)
      |> Map.put({k, i}, c)
      |> Map.put({k, j}, c)
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
    let n: usize = stdin.lock().lines().next().unwrap().unwrap().trim().parse().unwrap();

    let result = solve(n);
    println!("{}", result);
}

fn solve(n: usize) -> String {
    let mut grid = vec![vec![' '; n]; n];

    for i in 1..=n {
        let j = n + 1 - i;
        if i > j {
            continue;
        }
        let ch = if i % 2 == 1 { '#' } else { '.' };
        color(i, j, &mut grid, ch);
    }

    grid.iter()
        .map(|row| row.iter().collect::<String>())
        .collect::<Vec<_>>()
        .join("\n")
}

fn color(i: usize, j: usize, grid: &mut Vec<Vec<char>>, ch: char) {
    let i0 = i - 1;
    let j0 = j - 1;

    for k in i0..=j0 {
        grid[i0][k] = ch;
        grid[j0][k] = ch;
        grid[k][i0] = ch;
        grid[k][j0] = ch;
    }
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 395](https://atcoder.jp/contests/abc395)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
