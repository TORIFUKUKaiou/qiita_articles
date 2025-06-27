---
title: 闘魂Elixir ーー AtCoder Beginner Contest 409(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-26T14:58:19+09:00'
id: f972a16e8f616acbeb0d
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

# [B - Citation](https://atcoder.jp/contests/abc409/tasks/abc409_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、「順次」「分岐」「繰り返し」すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


なかなかハマりました。

最初は「最大値から1に順に調べていく」素直な実装を試しましたが、`A` の要素が `10 ** 9` のような大きな値を取ると、100個調べるだけでも時間がかかり、TLE（実行時間超過）になってしまいました。

Elixirだから遅いのか？と思いRustに書き換えても、同じようにTLE。

ここで、**計算量を減らすための発想の転換が必要**だと気づきました。

---

問題の条件は：

> 「x 以上の値が、x 回以上ある」

これを別の角度から見ると、こう言い換えられます：

> 「大きな値が、少なくともその数（回数）だけ存在するか？」

これをもとに、次のように解法を再構築しました。

---

### ✨ 解法の発想転換

1. `A` を**降順にソート**することで、大きい値から順に並べる
2. ソートした配列の上から `i` 番目（1-indexed）に注目すると、
   　 その位置の値 `A[i - 1]` が `i` 以上なら「`i` 個の `i` 以上の値がある」ことが分かる
3. この条件を満たす **最大の `i`** を答えとして返せばよい！

---

## ✅ 例：`A = [10, 6, 3, 2, 2, 2, 1]`（降順済）

| x (= i) | A\[i-1] | A\[i-1] ≥ x? | 条件成立？ |
| ------- | ------- | ------------ | ----- |
| 1       | 10      | 10 ≥ 1       | ✅     |
| 2       | 6       | 6 ≥ 2        | ✅     |
| 3       | 3       | 3 ≥ 3        | ✅     |
| 4       | 2       | 2 ≥ 4        | ❌     |

したがって、最大の `x` は **3**。





```elixir
defmodule Main do
  def main do
    _ = IO.read(:line)
    list =
      IO.read(:line)
      |> String.trim()
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    solve(list)
    |> IO.puts()
  end

  def solve(list) do
    list
    |> Enum.sort(:desc)
    |> Enum.with_index(1)
    |> Enum.reduce(0, fn {value, idx}, acc ->
      if value >= idx do
        idx
      else
        acc
      end
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
    let mut lines = stdin.lock().lines();

    let _n: usize = lines.next().unwrap().unwrap().trim().parse().unwrap();
    let mut list: Vec<u32> = lines
        .next()
        .unwrap()
        .unwrap()
        .split_whitespace()
        .map(|s| s.parse().unwrap())
        .collect();

    let answer = solve(&mut list);
    println!("{}", answer);
}

fn solve(list: &mut Vec<u32>) -> u32 {
    list.sort_unstable_by(|a, b| b.cmp(a)); // 降順ソート

    let mut result = 0;

    for (idx, &val) in list.iter().enumerate() {
        let x = (idx + 1) as u32;
        if val >= x {
            result = x;
        } else {
            break;
        }
    }

    result
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
