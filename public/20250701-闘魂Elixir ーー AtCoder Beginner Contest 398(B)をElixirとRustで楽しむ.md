---
title: 闘魂Elixir ーー AtCoder Beginner Contest 398(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-01T21:33:30+09:00'
id: 6ff7da98e2ceb6ee694b
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

[AtCoder Beginner Contest 398](https://atcoder.jp/contests/abc398)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [B - Full House 3](https://atcoder.jp/contests/abc398/tasks/abc398_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらの基本をすべて理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


7枚のカードのうち、同じ数字が何回出現するかを数えて、フルハウスになるカードの組み合わせと合致するかを調べればよいです。関数パターンマッチで解きました。  

```elixir
defmodule Main do
  def main do
    a_list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(a_list)
    |> IO.puts()
  end

  def solve(a_list) do
    Enum.frequencies(a_list)
    |> Map.values()
    |> Enum.sort()
    |> do_solve()
  end

  defp do_solve([1, 1, 2, 3]), do: "Yes"
  defp do_solve([1, 2, 4]), do: "Yes"
  defp do_solve([1, 3, 3]), do: "Yes"
  defp do_solve([2, 2, 3]), do: "Yes"
  defp do_solve([2, 5]), do: "Yes"
  defp do_solve([3, 4]), do: "Yes"
  defp do_solve(_), do: "No"
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
use std::io;

fn main() {
    // 標準入力から1行読み込む
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");

    // 空白で分割し、整数ベクタに変換
    let a_list: Vec<u32> = input
        .trim()
        .split_whitespace()
        .map(|s| s.parse().expect("Invalid number"))
        .collect();

    // 結果を出力
    println!("{}", solve(&a_list));
}

fn solve(a_list: &[u32]) -> &'static str {
    // 出現回数を数える
    let mut freq_map: HashMap<u32, u32> = HashMap::new();
    for &num in a_list {
        *freq_map.entry(num).or_insert(0) += 1;
    }

    // 出現回数の値だけを取り出してソート
    let mut freqs: Vec<u32> = freq_map.values().cloned().collect();
    freqs.sort();

    match &freqs[..] {
        [1, 1, 2, 3] |
        [1, 2, 4] |
        [1, 3, 3] |
        [2, 2, 3] |
        [2, 5] |
        [3, 4] => "Yes",
        _ => "No",
    }
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 398](https://atcoder.jp/contests/abc398)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
