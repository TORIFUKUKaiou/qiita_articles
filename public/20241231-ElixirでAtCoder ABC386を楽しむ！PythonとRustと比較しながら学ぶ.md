---
title: ElixirでAtCoder ABC386を楽しむ！PythonとRustと比較しながら学ぶ
tags:
  - Python
  - Rust
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-01-07T10:00:39+09:00'
id: 7165cacc80823c3a0aee
organization_url_name: haw
slide: false
ignorePublish: false
---
# はじめに

プログラミングのスキルを向上させるために、私は現在、[AtCoder](https://atcoder.jp/)のABC問題に挑戦しています。AtCoderは、アルゴリズムやデータ構造を中心にした問題解決能力を磨く場であり、自分との闘いでもあります。挑戦を通じてアントニオ猪木さんがおっしゃった「闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくこと」を体現する一つの活動と捉えています。

今回の取り組みでは、得意な[Elixir](https://elixir-lang.org/)を使って自力で正解を導き出すことを第一目標としています。そして、その解答を生成AIである[GitHub Copilot](https://github.com/features/copilot)の助けを借りて、PythonとRustに変換し、それぞれの言語での書き方を比較しながら学んでいます。これにより、Elixirの強みを再確認すると同時に、PythonやRustの基本構文や考え方を吸収し、近々これらの言語を使用する場面に備えたいと考えています。

学習を続ける上で、単なる文法や基礎の勉強は退屈に感じることがあります。そのため、ABC問題という実践的な課題に取り組むことで、楽しさを感じながら知識を深める工夫をしています。繰り返し取り組むことで、最終的にPythonやRustでコードを書けるようになるのではないかという目論見を持っていますが、結果がどうなるかはまだわかりません。それでも「とりあえずやってみる」という精神で挑戦を続けています。

この取り組みを通じて、単にプログラミングスキルを磨くだけでなく、自分の成長を実感できる過程を楽しみたいと思っています。そのドラマにお付き合いください。

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

### A問題

順次、分岐で解けます。

### B問題

順次、分岐に加えて繰り返しを使います。

### C問題

順次、分岐、三重程度の多重繰り返しを使います。

---

コンテストによりその傾向は異なります。
D問題以降は競技プログラミングの訓練が必要です。訓練無しに解ける人は才能があります。うらやましいです。

何を「一般的」と定義するのかは諸説あると思いますが、数学的センスを必要とはしない「一般的な」プログラミングはC問題くらいまでできればなんとかなります。何の自慢にもなりませんが、私はそれで20年以上飯を喰ってきました。そして自分でも気づいている通り、それは何の自慢にもなりませんし、`html`のタグを手打ちするのが当たり前だった牧歌的な時代をだらっとすごしてきた人間の感傷かもしれません。若い人には高みを目指して欲しいと思っています。そしてそんな私を生温かい目で**鑑賞**していただければ幸いです。コラムです。



**ここで述べたのはあくまでも個人の見解です。**

---

# [AtCoder Beginner Contest 386](https://atcoder.jp/contests/abc386)

今回は、[AtCoder Beginner Contest 386](https://atcoder.jp/contests/abc386)に挑戦します。

## [A - Full House 2](https://atcoder.jp/contests/abc386/tasks/abc386_a)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書いて、PythonとRustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc386_a.exs
defmodule Main do
  def main do
    input()
    |> solve()
    |> IO.puts()
  end

  defp solve(list) do
    list
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> do_solve()
  end

  defp do_solve([2, 2]), do: "Yes"
  defp do_solve([1, 3]), do: "Yes"
  defp do_solve(_list), do: "No"

  defp input do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
  end
end
```

### Python

```python:abc386_a.py
from collections import Counter

def solve(numbers):
    counts = sorted(Counter(numbers).values())
    return "Yes" if counts in ([2, 2], [1, 3]) else "No"

def main():
    numbers = list(map(int, input().split()))
    print(solve(numbers))

main()
```

### Rust

```rust:hello_world/src/bin/abc386_a.rs
use proconio::input;
use std::collections::HashMap;

fn solve(numbers: Vec<i32>) -> &'static str {
    let mut freq = HashMap::new();
    for &n in numbers.iter() {
        *freq.entry(n).or_insert(0) += 1;
    }

    let mut counts: Vec<i32> = freq.values().cloned().collect();
    counts.sort_unstable();

    match counts.as_slice() {
        [2, 2] | [1, 3] => "Yes",
        _ => "No",
    }
}

fn main() {
    input! {
        numbers: [i32; 4],
    }
    println!("{}", solve(numbers));
}
```

</details>


## [B - Calculator](https://atcoder.jp/contests/abc386/tasks/abc386_b)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書いて、PythonとRustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc386_b.exs
defmodule Main do
  def main do
    input()
    |> solve()
    |> IO.puts()
  end

  defp solve(charlist) do
    charlist
    |> Enum.reduce({0, false}, fn c, {cnt, pending} ->
      case {c, pending} do
        {?0, false} -> {cnt, true}
        {?0, true} -> {cnt + 1, false}
        {_, false} -> {cnt + 1, false}
        {_, true} -> {cnt + 2, false}
      end
    end)
    |> then(fn
      {cnt, true} -> cnt + 1
      {cnt, false} -> cnt
    end)
  end

  defp input do
    IO.read(:line) |> String.trim() |> String.to_charlist()
  end
end
```

### Python

```python:abc386_b.py
def solve(s: str) -> int:
    cnt = 0
    pending = False
    
    for c in s:
        if c == '0':
            if not pending:
                pending = True
            else:
                cnt += 1
                pending = False
        else:
            if not pending:
                cnt += 1
            else:
                cnt += 2
                pending = False
    
    return cnt + (1 if pending else 0)

def main():
    s = input().strip()
    print(solve(s))


main()
```

### Rust

```rust:hello_world/src/bin/abc386_b.rs
use proconio::input;

fn solve(s: &str) -> i32 {
    let (count, pending) = s.chars().fold((0, false), |(cnt, pending), c| {
        match (c, pending) {
            ('0', false) => (cnt, true),
            ('0', true) => (cnt + 1, false),
            (_, false) => (cnt + 1, false),
            (_, true) => (cnt + 2, false),
        }
    });
    
    count + if pending { 1 } else { 0 }
}

fn main() {
    input! {
        s: String,
    }
    println!("{}", solve(&s));
}
```


</details>



## [C - Operate 1](https://atcoder.jp/contests/abc386/tasks/abc386_c)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書いて、PythonとRustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc386_c.exs
defmodule Main do
  def main do
    {s_map, t_map} = input()

    solve(s_map, Enum.count(s_map), t_map, Enum.count(t_map))
    |> IO.puts()
  end

  defp solve(s_map, s_len, t_map, t_len) when s_len == t_len do
    s_map
    |> Enum.reduce_while(0, fn {index, element}, acc ->
      cond do
        acc >= 2 -> {:halt, acc}
        Map.get(t_map, index) == element -> {:cont, acc}
        true -> {:cont, acc + 1}
      end
    end)
    |> Kernel.<(2)
    |> if(do: "Yes", else: "No")
  end

  defp solve(s_map, s_len, t_map, t_len) when s_len + 1 == t_len do
    do_solve(t_map, s_map)
  end

  defp solve(s_map, s_len, t_map, t_len) when s_len == t_len + 1 do
    do_solve(s_map, t_map)
  end

  defp solve(_s_map, _s_len, _t_map, _t_len), do: "No"

  defp do_solve(long_map, short_map) do
    long_map
    |> Enum.sort_by(fn {index, _} -> index end)
    |> Enum.reduce_while(0, fn {index, element}, acc ->
      target_index = if acc == 0, do: index, else: index - 1
      cond do
        acc >= 2 -> {:halt, acc}
        Map.get(short_map, target_index) == element -> {:cont, acc}
        Map.get(short_map, target_index) != element -> {:cont, acc + 1}
      end
    end)
    |> Kernel.<(2)
    |> if(do: "Yes", else: "No")
  end

  defp input do
    1 = IO.read(:line) |> String.trim() |> String.to_integer()
    s_map = IO.read(:line) |> String.trim() |> String.to_charlist() |> to_map()
    t_map = IO.read(:line) |> String.trim() |> String.to_charlist() |> to_map()

    {s_map, t_map}
  end

  defp to_map(list) do
    list
    |> Enum.with_index(fn element, index -> {index, element} end)
    |> Map.new()
  end
end
```

### Python

```python:abc386_c.py
def solve(s: str, t: str) -> str:
    # Check length differences
    if abs(len(s) - len(t)) > 1:
        return "No"
    
    # Equal length case
    if len(s) == len(t):
        diff_count = sum(1 for i in range(len(s)) if s[i] != t[i])
        return "Yes" if diff_count < 2 else "No"
    
    # One character difference case
    long_str, short_str = (s, t) if len(s) > len(t) else (t, s)
    diff_count = 0
    j = 0
    
    for i in range(len(long_str)):
        if j < len(short_str):
            if long_str[i] != short_str[j]:
                diff_count += 1
                if diff_count >= 2:
                    return "No"
                if len(long_str) > len(short_str):
                    continue
            j += 1
        else:
            diff_count += 1
            
    return "Yes" if diff_count < 2 else "No"

def main():
    _ = int(input())  # N is not used
    s = input().strip()
    t = input().strip()
    print(solve(s, t))

main()
```



### Rust

```rust:hello_world/src/bin/abc386_c.rs
use proconio::input;

fn solve(s: &str, t: &str) -> &'static str {
    match (s.len(), t.len()) {
        (s_len, t_len) if s_len == t_len => {
            let diff_count = s.chars().zip(t.chars())
                .filter(|(s_char, t_char)| s_char != t_char)
                .count();
            if diff_count < 2 { "Yes" } else { "No" }
        },
        (s_len, t_len) if s_len.abs_diff(t_len) == 1 => {
            let (long, short) = if s_len > t_len { 
                (s.chars().collect::<Vec<_>>(), t.chars().collect::<Vec<_>>())
            } else { 
                (t.chars().collect::<Vec<_>>(), s.chars().collect::<Vec<_>>())
            };
            
            let mut diff_count = 0;
            let mut short_idx = 0;
            
            for &long_char in long.iter() {
                if short_idx >= short.len() {
                    diff_count += 1;
                    break;
                }
                
                if long_char != short[short_idx] {
                    diff_count += 1;
                    if diff_count >= 2 {
                        return "No";
                    }
                    continue;
                }
                short_idx += 1;
            }
            "Yes"
        },
        _ => "No"
    }
}

fn main() {
    input! {
        _: usize,
        s: String,
        t: String,
    }
    println!("{}", solve(&s, &t));
}
```

</details>


---

# まとめ

AtCoderのABC問題をElixirで解き、さらにPythonとRustで比較しながら学ぶ取り組みは、プログラミングスキルの向上だけでなく、それぞれの言語の特徴を理解する良い機会となります。今回の取り組みを通じて、以下のような成果や学びが得られました：

- **Elixirの強みを再確認**  
  Elixirはそのシンプルで直感的な構文のおかげで、問題のロジックをわかりやすく表現できました。特にパターンマッチングや関数型プログラミングの特性が、問題解決の助けになりました。

- **Pythonの柔軟性と簡潔さ**  
  Pythonでは、直感的にコードを記述できるため、素早く問題に取り組むことができました。また、データ処理や繰り返し構文の扱いやすさが際立っていました。

- **Rustの安全性と高パフォーマンス**  
  Rustでは、型の厳格さとメモリ管理の明確さが求められる分、問題を解く過程で深い思考が必要でした。これにより、コードの安全性と効率を意識する良い訓練になりました。

また、この取り組みを通じて「闘魂とは己に打ち克つこと」という精神を再認識し、楽しみながら成長する姿勢を持つことの重要性を実感しました。Elixirを軸に据えることで、自分の得意分野を活かしつつ新しい言語に挑戦するという学びのプロセスは、非常に充実感のあるものでした。

これからもAtCoderを活用しながら、新しい言語や技術への挑戦を続けていきたいと思います。読者の皆様も、ぜひ自分自身のプログラミングの旅を楽しみながら、新しい挑戦に取り組んでみてください！
