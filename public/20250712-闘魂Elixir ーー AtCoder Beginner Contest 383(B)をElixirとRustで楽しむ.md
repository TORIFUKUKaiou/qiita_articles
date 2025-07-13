---
title: 闘魂Elixir ーー AtCoder Beginner Contest 383(B)をElixirとRustで楽しむ
tags:
  - Rust
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-12T12:29:14+09:00'
id: c7c282bcdec9a6147039
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/tech-festa/2025

![ChatGPT Image 2025年7月12日 10_22_33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eeeae009-3577-4a87-aeba-6f6adce8d4f9.png)


<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

![ChatGPT Image 2025年6月25日 11_32_51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a80ca1b4-3ccd-40c7-945b-6c8c969727e0.png)



# はじめに

[AtCoder Beginner Contest 383](https://atcoder.jp/contests/abc383)を[Elixir](https://elixir-lang.org/)と[Rust](https://www.rust-lang.org/)で解いてみます。  

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

# [B - Humidifier 2](https://atcoder.jp/contests/abc383/tasks/abc383_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

プログラミングの基本である「順次」「分岐」「繰り返し」のすべてを理解しているのかを問われる問題です。

## Elixir

Elixirを使った私の解答です。


<details><summary>私の解答(Elixir)</summary>

_問題文を読んでいらっしゃることを前提にひとこと解説をしておきます。_

愚直にすべて計算しました。  

1. すべての`.` がある点に対して、加湿器をおいたと仮定して加湿される点を出す。
1. どこかの `.` に加湿器を置いたとして、他の`.`点にも加湿器を置いた場合に加湿される箇所が最大となる組み合わせを探し、最大値を算出する。
1. 2の中で一番大きい値を答えとする。


```elixir
defmodule Main do
  def main do
    {h, w, d, s_map} = input()

    solve(h, w, d, s_map)
    |> IO.puts()
  end

  defp solve(h, w, d, s_map) do
    count_map =
      for i <- 1..h, j <- 1..w, Map.get(s_map, {i, j}) == ?., into: %{} do
        {{i, j}, do_solve(h, w, d, s_map, i, j)}
      end

    for i <- 1..h, j <- 1..w, map_set = Map.get(count_map, {i, j}), map_set != nil do
      do_count(h, w, count_map, map_set)
    end
    |> Enum.max()
  end

  defp do_count(h, w, count_map, target_map_set) do
    for i <- 1..h, j <- 1..w, map_set = Map.get(count_map, {i, j}), map_set != nil do
      MapSet.union(target_map_set, map_set)
      |> MapSet.size()
    end
    |> Enum.max()
  end

  defp do_solve(h, w, d, s_map, target_i, target_j) do
    for i <- 1..h,
        j <- 1..w,
        Map.get(s_map, {i, j}) == ?.,
        abs(target_i - i) + abs(target_j - j) <= d,
        into: MapSet.new() do
      {i, j}
    end
  end

  defp input do
    [h, w, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    s_map =
      for i <- 1..h, reduce: %{} do
        acc ->
          IO.read(:line)
          |> String.trim()
          |> String.to_charlist()
          |> Enum.with_index(fn element, j -> {{i, j + 1}, element} end)
          |> Map.new()
          |> Map.merge(acc)
      end

    {h, w, d, s_map}
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
use std::collections::{HashMap, HashSet};
use std::io::{self, BufRead};

type Point = (usize, usize);

fn main() {
    let stdin = io::stdin();
    let mut lines = stdin.lock().lines();

    let first_line = lines.next().unwrap().unwrap();
    let mut parts = first_line.split_whitespace();
    let h: usize = parts.next().unwrap().parse().unwrap();
    let w: usize = parts.next().unwrap().parse().unwrap();
    let d: usize = parts.next().unwrap().parse().unwrap();

    let mut s_map = HashMap::new();
    for i in 1..=h {
        let line = lines.next().unwrap().unwrap();
        for (j, ch) in line.chars().enumerate() {
            s_map.insert((i, j + 1), ch);
        }
    }

    let mut count_map = HashMap::new();
    for i in 1..=h {
        for j in 1..=w {
            if *s_map.get(&(i, j)).unwrap_or(&'#') == '.' {
                let set = get_humidified(h, w, d, &s_map, i, j);
                count_map.insert((i, j), set);
            }
        }
    }

    let mut max_humidified = 0;

    for (_, set1) in &count_map {
        let mut local_max = 0;
        for (_, set2) in &count_map {
            let union: HashSet<_> = set1.union(set2).copied().collect();
            local_max = local_max.max(union.len());
        }
        max_humidified = max_humidified.max(local_max);
    }

    println!("{}", max_humidified);
}

fn get_humidified(
    h: usize,
    w: usize,
    d: usize,
    s_map: &HashMap<Point, char>,
    target_i: usize,
    target_j: usize,
) -> HashSet<Point> {
    let mut result = HashSet::new();
    for i in 1..=h {
        for j in 1..=w {
            if (target_i as isize - i as isize).abs() + (target_j as isize - j as isize).abs() <= d as isize {
                if *s_map.get(&(i, j)).unwrap_or(&'#') == '.' {
                    result.insert((i, j));
                }
            }
        }
    }
    result
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
