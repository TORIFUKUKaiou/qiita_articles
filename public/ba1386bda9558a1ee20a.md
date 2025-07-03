---
title: 闘魂Elixir ーー AtCoder Beginner Contest 395(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-03T07:56:41+09:00'
id: ba1386bda9558a1ee20a
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

# [A - Strictly Increasing?](https://atcoder.jp/contests/abc395/tasks/abc395_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」の、すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

次の2つの条件がそろった時に単調増加といえます:  

- MapSetして重複を排除した集合の要素数と元のリストの要素数が一致している
- 元のリストをソートしたものと元のリストの並び順が同じ

他にも隣同士の要素の大小比較を繰り返すことでも解けます。  


```elixir
defmodule Main do
  def main do
    IO.read(:line)
    list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(list)
    |> IO.puts()
  end

  def solve(list) do
    do_solve(MapSet.new(list) |> Enum.count(), Enum.count(list), Enum.sort(list), list)
  end

  defp do_solve(map_set_count, count, sorted_list, list) when map_set_count == count and sorted_list == list, do: "Yes"

  defp do_solve(_, _, _, _), do: "No"
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

    // 1行目は読み捨て
    let _ = lines.next();

    // 2行目を数列として読み込む
    let list: Vec<i32> = lines
        .next()
        .unwrap()
        .unwrap()
        .trim()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    println!("{}", solve(&list));
}

fn solve(list: &[i32]) -> &'static str {
    let set: HashSet<i32> = list.iter().copied().collect();
    let mut sorted = list.to_vec();
    sorted.sort();

    if set.len() == list.len() && sorted == list {
        "Yes"
    } else {
        "No"
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
