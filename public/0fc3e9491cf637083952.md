---
title: 闘魂Elixir ーー AtCoder Beginner Contest 404(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-28T22:05:43+09:00'
id: 0fc3e9491cf637083952
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

[AtCoder Beginner Contest 404](https://atcoder.jp/contests/abc404)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Not Found](https://atcoder.jp/contests/abc404/tasks/abc404_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、これらすべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


[MapSet](https://hexdocs.pm/elixir/MapSet.html)モジュールを使いました。  
[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)で、答えの候補が見つかったら探索を打ち切ることにしました。  



```elixir
defmodule Main do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  def solve(s) do
    s
    |> String.to_charlist()
    |> MapSet.new()
    |> do_solve()
  end

  defp do_solve(map_set) do
    (?a..?z)
    |> Enum.reduce_while(nil, fn c, nil ->
      if MapSet.member?(map_set, c), do: {:cont, nil}, else: {:halt, c}
    end)
    |> List.wrap()
    |> List.to_string()
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
    // 入力を受け取る
    let stdin = io::stdin();
    let s = stdin.lock().lines().next().unwrap().unwrap();

    // solve 関数で処理
    let result = solve(&s);
    println!("{}", result);
}

fn solve(s: &str) -> String {
    // 入力文字列の各文字を HashSet に追加（重複排除）
    let set: HashSet<char> = s.chars().collect();

    // a〜z の中で最初に出現していない文字を探す
    for c in 'a'..='z' {
        if !set.contains(&c) {
            return c.to_string();
        }
    }

    // 全ての文字が含まれていた場合は空文字を返す（必要に応じて"None"などに変更可）
    String::new()
}

```

</details>

---

# さいごに

[AtCoder Beginner Contest 404](https://atcoder.jp/contests/abc404)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
