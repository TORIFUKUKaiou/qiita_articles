---
title: 闘魂プログラミング： ElixirとRustで楽しむAtCoder ABC392チャレンジ
tags:
  - Rust
  - Elixir
  - ポエム
  - 猪木
  - 闘魂
private: false
updated_at: '2025-02-13T10:02:32+09:00'
id: 2503dc8db8e496d6b2eb
organization_url_name: haw
slide: false
ignorePublish: false
---
:::note info
**受賞賞品到着記念記事**:tada::tada::tada:

[Qiita Advent Calendar 2024](https://qiita.com/advent-calendar/2024)において、[完走賞とQiita クリスマス大抽選キャンペーン_3等を受賞](https://blog.qiita.com/adventcalendar-2024-qiitapresents-winners/)しました。

<b><font color="red">$\huge{ありがとうーーーッ！！！}$</font></b>
ございます。

本記事は受賞賞品到着記念記事です。
:::

![2025-02-10_07-46-21_436.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/898583e8-1ac4-fd37-3c05-f66dbc2e15a2.jpeg)

（これまでいただいたQiitanたちと他のお人形さんたちもいっしょに記念撮影）


# はじめに

プログラミングのスキルを向上させるために、私は現在、[AtCoder](https://atcoder.jp/)のABC問題に挑戦しています。AtCoderは、アルゴリズムやデータ構造を中心にした問題解決能力を磨く場であり、自分との闘いでもあります。挑戦を通じてアントニオ猪木さんがおっしゃった「闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくこと」を体現する一つの活動と捉えています。


## AtCoderとは

AtCoderは、日本発のオンラインプログラミングコンテストプラットフォームで、競技プログラミングの学習や実力を試す場として多くのエンジニアや学生に利用されています。プラットフォーム上では、さまざまなレベルの問題が提供されており、初心者から上級者まで幅広く挑戦することができます。

AtCoderの主な特徴として、以下の点が挙げられます：
- **定期的なコンテスト**: 毎週開催される「AtCoder Beginner Contest (ABC)」や「AtCoder Regular Contest (ARC)」を通じて、問題解決能力を継続的に向上させることができます
- **多彩な問題**: アルゴリズム、データ構造、数学、最適化など、幅広い分野の問題が揃っています
- **ランキングとレーティング**: 参加者の成績に応じてレーティングが変動し、自分の成長を数値として確認することが可能です

特にABCは、初心者向けの問題が中心でありながら、後半の問題はやりごたえのあるものも多く、プログラミングスキルを基礎から応用まで段階的に磨けるのが魅力です。AtCoderは単なる練習の場ではなく、自己成長や目標達成のための重要なステップとして、国内外のエンジニアから高く評価されています。

## AtCoder Beginner Contest (ABC)

AtCoder Beginner Contest (ABC)についての個人の見解です。
順にレベルが上がります。

どのプログラミング言語でも共通にある「順次、分岐、繰り返し」で問題のレベルを解説してみます。

### A問題

順次、分岐で解けます。

### B問題

順次、分岐に加えて繰り返しを使います。

### C問題

順次、分岐、三重程度の多重繰り返しを使います。

---

コンテストによりその傾向は異なります。
D問題以降は競技プログラミングの訓練が必要です。訓練無しに解ける人は才能があります。うらやましい限りです。

何を「一般的」と定義するのかは諸説あると思いますが、数学的センスを必要とはしない「一般的な」プログラミングはC問題くらいまでできればなんとかなります。何の自慢にもなりませんが、私はそれで20年以上飯を喰ってきました。そして自分でも気づいている通り、それは何の自慢にもなりませんし、`html`のタグを手打ちするのが当たり前だった牧歌的な時代をだらっとすごしてきた人間の感傷かもしれません。若い人には高みを目指して欲しいと思っています。そしてそんな私を生温かい目で**鑑賞**していただければ幸いです。ポエムです。



**ここで述べたのはあくまでも個人の見解です。**

---

# [AtCoder Beginner Contest 392](https://atcoder.jp/contests/abc392)

今回は、[日本レジストリサービス（JPRS）プログラミングコンテスト2025#1（AtCoder Beginner Contest 392）](https://atcoder.jp/contests/abc392)に挑戦します。

## [A - Shuffled Equation](https://atcoder.jp/contests/abc392/tasks/abc392_a)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書きました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc392_a.exs
defmodule Main do
  def main do
    [a, b, c] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(a, b, c)
    |> IO.puts()
  end
  
  defp solve(a, b, c) when a * b == c, do: "Yes"
  defp solve(a, b, c) when a * c == b, do: "Yes"
  defp solve(a, b, c) when b * c == a, do: "Yes"
  defp solve(_a, _b, _c), do: "No"
end
```


</details>


## [B - Who is Missing?](https://atcoder.jp/contests/abc392/tasks/abc392_b)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書きました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc392_b.exs
defmodule Main do
  def main do
    [n, _m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    a_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(n, a_list)
    |> IO.puts()
  end
  
  defp solve(n, a_list) do
    new_list = Enum.to_list(1..n) -- a_list

    count = Enum.count(new_list)

    "#{count}\n#{Enum.join(new_list, " ")}"
  end
end
```




</details>



## [C - Bib](https://atcoder.jp/contests/abc392/tasks/abc392_c)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書きましたが、TLEを解決できませんでした。

入力の長さが
```math
3 \times 10^5
```
あるそうで、Elixirはきつい予感しかしませんでした。果たしてTLEが発生し、私には解決できませんでした。
論理的には合っているはずで、生成AIの力を借りてRustで書き直してもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc392_c.exs
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    p_map = IO.read(:line)
            |> String.trim()
            |> String.split(" ")
            |> Enum.map(&String.to_integer/1)
            |> Enum.with_index(fn element, index -> {index + 1, element} end)
            |> Map.new()
    q_list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    q_map1 = Enum.with_index(q_list, 1) |> Map.new()
    q_map2 = Enum.with_index(q_list, fn element, index -> {index + 1, element} end) |> Map.new()

    solve(n, q_map1, p_map, q_map2)
    |> IO.puts()
  end

  defp solve(n, q_map1, p_map, q_map2) do
    1..n
    |> Enum.reduce(%{}, fn i, acc ->
      x = Map.get(q_map1, i)
      x = Map.get(p_map, x)
      x = Map.get(q_map2, x)

      acc
      |> Map.put(i, x)
    end)
    |> Enum.sort_by(fn {i, _} -> i end)
    |> Enum.map(fn {_, v} -> v end)
    |> Enum.join(" ")
  end
end
```

残念ながら、
**TLE**がでます :sob:。 





### Rust

```rust:hello_world/src/bin/abc392_c.rs
use proconio::input;
use std::collections::HashMap;

fn main() {
    input! {
        n: usize,
        p: [usize; n],
        q: [usize; n],
    }
    
    // Create maps (1-indexed)
    let mut p_map = HashMap::new();
    let mut q_map1 = HashMap::new();
    let mut q_map2 = HashMap::new();
    
    for i in 0..n {
        p_map.insert(i + 1, p[i]);
        q_map1.insert(q[i],i + 1);
        q_map2.insert(i + 1, q[i]);
    }
    
    let mut result = Vec::new();
    for i in 1..=n {
        let mut x = q_map1[&i];         // First mapping
        x = p_map[&x];                  // Second mapping
        x = q_map2[&x];                 // Third mapping
        result.push(x);
    }
    
    println!("{}", result.iter()
        .map(|x| x.to_string())
        .collect::<Vec<_>>()
        .join(" "));
}
```

これはパスします :tada::tada::tada: 

</details>


---

# まとめ

本記事を書くことを通して得られた経験は、『闘魂とは己に打ち克つこと』という言葉の重みを再認識させてくれました。ElixirとRustという異なるアプローチを通じて、技術の融合がもたらす新たな可能性を感じることができました。今後も未知の領域へ果敢に挑戦していきます。

**あなたもお好きなプログラミング言語で、プログラミングという藝術活動を楽しんでください！**
