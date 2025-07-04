---
title: 闘魂Elixir ーー AtCoder Beginner Contest 408(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-27T00:57:22+09:00'
id: bfce93257c209ae1d6dd
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

[AtCoder Beginner Contest 408](https://atcoder.jp/contests/abc408)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Timeout](https://atcoder.jp/contests/abc408/tasks/abc408_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


2行の数列の隣どうしの差を取ればよいわけです。  
先頭には、念の為、`0`を挿入しておいて、肩叩きが最初の人が間に合っているのかをチェックしています。  




```elixir
defmodule Main do
  def main do
    [_n, s] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    t_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(s, t_list)
    |> IO.puts()
  end

  def solve(s, t_list) do
    adjacent_diffs([0 | t_list])
    |> Enum.all?(fn d -> d <= s end)
    |> if(do: "Yes", else: "No")
  end

  defp adjacent_diffs(list) do
    list
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> y - x end)
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

    // 1行目の読み込み: n（使わない）と s
    let line1 = lines.next().unwrap().unwrap();
    let parts: Vec<i32> = line1
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect();
    let s = parts[1];

    // 2行目の読み込み: t_list
    let line2 = lines.next().unwrap().unwrap();
    let mut t_list: Vec<i32> = line2
        .split_whitespace()
        .map(|x| x.parse().unwrap())
        .collect();

    // 先頭に0を追加（Elixirと同じ）
    t_list.insert(0, 0);

    // 隣接差分をチェック
    let ok = t_list
        .windows(2)
        .all(|w| w[1] - w[0] <= s);

    println!("{}", if ok { "Yes" } else { "No" });
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 408](https://atcoder.jp/contests/abc408)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
