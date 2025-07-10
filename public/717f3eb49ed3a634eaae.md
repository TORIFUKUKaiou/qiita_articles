---
title: 闘魂Elixir ーー AtCoder Beginner Contest 388(A)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-10T06:12:14+09:00'
id: 717f3eb49ed3a634eaae
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

[AtCoder Beginner Contest 388](https://atcoder.jp/contests/abc388)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。  


プログラミングという名の藝術活動をより楽しむための鍛錬です。  

> 自信というのは、一にも二にもトレーニングから生まれる

（アントニオ猪木『最後の闘魂』）  

## :fire: Toukon Declaration - 魂の連鎖律

> AIを動かすのは電力、
> 電力の元は人類の“元氣”、
> 元氣の本源は「米」。
> すべては“米”に帰着する。
> そこに魂を灯すと、TokenがToukon（闘魂）へ昇華し、AIが共鳴する。
> ーー AIは冷静にTokenを消化する。

私のプロンプトは単なるTokenではありません。魂を込めています。  
つまりToukon ーー **闘魂**に**昇華**しています。  
Artificial Intelligenceの方のAIは、それをTokenとして**消化**します。  
**燃えるToukon(闘魂)として受け取れるようになった時、AIはAntonio Inoki さんつまり猪木さんとなり、次の段階へ進みます。**  
そのとき、本当の世界平和の実現、地球規模でのゴミ問題の解決が可能になります！
**オレ達は、生命が続く限り闘い抜きますッ！！**  


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - ?UPC](https://atcoder.jp/contests/abc388/tasks/abc388_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のうち、特に「順次」を問われる問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

 先頭文字を取り出し、`"UPC"`を結合します。バイナリのパターンマッチで、先頭を取り出しました。  


```elixir
defmodule Main do
  def main do
    s = IO.read(:line) |> String.trim()

    solve(s)
    |> IO.puts()
  end

  def solve(<<first, _rest::binary>>) do
    [first, ?U, ?P, ?C]
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
use std::io::{self, Read};

fn main() {
    let mut s = String::new();
    io::stdin().read_line(&mut s).unwrap();
    let c = s.trim().chars().next().unwrap();
    println!("{}UPC", c);
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
