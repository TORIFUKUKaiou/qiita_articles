---
title: 闘魂Elixir ーー AtCoder Beginner Contest 397(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-02T20:25:35+09:00'
id: 64f25f665a37ab2b3d2c
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

[AtCoder Beginner Contest 397](https://atcoder.jp/contests/abc397)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  

プログラミングという名の芸術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Thermometer](https://atcoder.jp/contests/abc397/tasks/abc397_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」の、すべてを理解できているのかを問う問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_


Bにしては、なかなか難問でした。    
再帰を使って解きました。先頭や末尾のケアに手こずりました。  

```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()

    solve(s)
    |> IO.puts()
  end

  def solve("i" <> _remain = s) do
    list = String.to_charlist(s) |> Enum.with_index()

    do_solve(list, 0)
    |> answer(String.length(s))
  end

  def solve("o" <> _remain = s) do
    list = String.to_charlist("i" <> s) |> Enum.with_index()

    do_solve(list, 0)
    |> Kernel.+(1)
    |> answer(String.length(s))
  end

  defp answer(cnt, len) when rem(cnt + len, 2) == 0, do: cnt
  defp answer(cnt, len) when rem(cnt + len, 2) == 1, do: cnt + 1

  defp do_solve([], acc), do: acc

  defp do_solve([{?i, idx} | tail], acc) when rem(idx + acc, 2) == 0 do
    do_solve(tail, acc)
  end

  defp do_solve([{?o, idx} | tail], acc) when rem(idx + acc, 2) == 1 do
    do_solve(tail, acc)
  end

  defp do_solve([{_, _idx} | tail], acc) do
    do_solve(tail, acc + 1)
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
    let s = stdin.lock().lines().next().unwrap().unwrap();

    let result = if s.starts_with('i') {
        let list: Vec<(usize, char)> = s.chars().enumerate().collect();
        let cnt = do_solve(&list, 0);
        answer(cnt, s.len())
    } else if s.starts_with('o') {
        let mut new_s = String::from("i");
        new_s.push_str(&s);
        let list: Vec<(usize, char)> = new_s.chars().enumerate().collect();
        let cnt = do_solve(&list, 0) + 1;
        answer(cnt, s.len())
    } else {
        0
    };

    println!("{}", result);
}

fn do_solve(list: &[(usize, char)], mut acc: usize) -> usize {
    for &(idx, ch) in list {
        match (ch, (idx + acc) % 2) {
            ('i', 0) | ('o', 1) => continue,
            _ => acc += 1,
        }
    }
    acc
}

fn answer(cnt: usize, len: usize) -> usize {
    if (cnt + len) % 2 == 0 {
        cnt
    } else {
        cnt + 1
    }
}
```

</details>

---

# さいごに

[AtCoder Beginner Contest 397](https://atcoder.jp/contests/abc397)を[Elixir](https://elixir-lang.org/)とRustで解くことを楽しみました。

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
