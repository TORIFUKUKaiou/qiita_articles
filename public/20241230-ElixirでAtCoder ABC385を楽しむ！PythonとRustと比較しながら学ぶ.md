---
title: ElixirでAtCoder ABC385を楽しむ！PythonとRustと比較しながら学ぶ
tags:
  - Python
  - Rust
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-01-07T10:01:00+09:00'
id: 5c096a9e6846beaeda3c
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

# [ユニークビジョンプログラミングコンテスト2024 クリスマス（AtCoder Beginner Contest 385）](https://atcoder.jp/contests/abc385)

今回は、[ユニークビジョンプログラミングコンテスト2024 クリスマス（AtCoder Beginner Contest 385）](https://atcoder.jp/contests/abc385)に挑戦します。

## [A - Equally](https://atcoder.jp/contests/abc385/tasks/abc385_a)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書いて、PythonとRustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc385_a.exs
defmodule Main do
  def main do
    input()
    |> solve()
    |> IO.puts()
  end

  defp input(), do: IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

  defp solve([a, b, c]) when (abs(a - b) == c) or (a + b == c) or (a == b and a == c), do: "Yes"
  defp solve([a, b, c]), do: "No"
end
```

### Python

```python:abc385_a.py
def solve(a: int, b: int, c: int) -> str:
    if abs(a - b) == c or (a + b) == c or (a == b == c):
        return "Yes"
    return "No"

def main():
    a, b, c = map(int, input().split())
    print(solve(a, b, c))

main()
```

### Rust

```rust:hello_world/src/bin/abc385_a.rs
// src/bin/abc385_a.rs
use proconio::input;

fn solve(a: i32, b: i32, c: i32) -> &'static str {
    if (a - b).abs() == c || a + b == c || (a == b && b == c) {
        "Yes"
    } else {
        "No"
    }
}

fn main() {
    input! {
        a: i32,
        b: i32,
        c: i32,
    }
    println!("{}", solve(a, b, c));
}
```

</details>


## [B - Santa Claus 1](https://atcoder.jp/contests/abc385/tasks/abc385_b)

問題文はリンク先をご参照ください。
それでは解答です。Elixirは自力で書いて、PythonとRustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc385_b.exs
defmodule Main do
  def main do
    {map, x, y, t} = input()

    {{santa_x, santa_y}, visited} = solve(map, x, y, t)

    "#{santa_x} #{santa_y} #{Enum.count(visited)}" |> IO.puts()
  end

  defp solve(map, x, y, t) do
    t
    |> Enum.reduce({{x, y}, map_set_new(Map.get(map, {x, y}), {x, y})}, fn d, {{current_x, current_y}, visited} ->
      do_move(map, current_x, current_y, d, visited)
    end)
  end

  defp do_move(?., _old_x, _old_y, new_x, new_y, visited) do
    {{new_x, new_y}, visited}
  end

  defp do_move(?@, _old_x, _old_y, new_x, new_y, visited) do
    {{new_x, new_y}, MapSet.put(visited, {new_x, new_y})}
  end

  defp do_move(?#, old_x, old_y, _new_x, _new_y, visited) do
    {{old_x, old_y}, visited}
  end

  defp do_move(map, current_x, current_y, ?U, visited) do
    new_x = current_x - 1
    new_y = current_y

    do_move(Map.get(map, {new_x, new_y}), current_x, current_y, new_x, new_y, visited)
  end

  defp do_move(map, current_x, current_y, ?D, visited) do
    new_x = current_x + 1
    new_y = current_y

    do_move(Map.get(map, {new_x, new_y}), current_x, current_y, new_x, new_y, visited)
  end

  defp do_move(map, current_x, current_y, ?L, visited) do
    new_x = current_x
    new_y = current_y - 1

    do_move(Map.get(map, {new_x, new_y}), current_x, current_y, new_x, new_y, visited)
  end

  defp do_move(map, current_x, current_y, ?R, visited) do
    new_x = current_x
    new_y = current_y + 1

    do_move(Map.get(map, {new_x, new_y}), current_x, current_y, new_x, new_y, visited)
  end

  defp map_set_new(?@, pos), do: MapSet.new([pos])
  defp map_set_new(_, _), do: MapSet.new()

  defp input do
    [h, _w, x, y] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    map = 1..h
    |> Enum.reduce(%{}, fn i, acc ->
      IO.read(:line) |> String.trim() |> String.to_charlist() |> Enum.with_index(1) |> Enum.reduce(acc, fn {c, j}, acc ->
        Map.update(acc, {i, j}, c, &(&1))
      end)
    end)

    t = IO.read(:line) |> String.trim() |> String.to_charlist()
    {map, x, y, t}
  end
end
```

### Python

```python:abc385_b.py
def do_move_cell(cell_type, old_x, old_y, new_x, new_y, visited):
    if cell_type == '.':
        return ((new_x, new_y), visited)
    elif cell_type == '@':
        visited.add((new_x, new_y))
        return ((new_x, new_y), visited)
    else:  # '#'
        return ((old_x, old_y), visited)

def do_move(grid, current_x, current_y, direction, visited):
    if direction == 'U':
        new_x, new_y = current_x - 1, current_y
    elif direction == 'D':
        new_x, new_y = current_x + 1, current_y
    elif direction == 'L':
        new_x, new_y = current_x, current_y - 1
    else:  # 'R'
        new_x, new_y = current_x, current_y + 1
    
    cell_type = grid.get((new_x, new_y))
    return do_move_cell(cell_type, current_x, current_y, new_x, new_y, visited)

def solve(grid, x, y, moves):
    pos = (x, y)
    visited = set()
    if grid.get(pos) == '@':
        visited.add(pos)
    
    for move in moves:
        pos, visited = do_move(grid, pos[0], pos[1], move, visited)
    
    return pos, visited

def main():
    h, w, x, y = map(int, input().split())
    
    grid = {}
    for i in range(1, h + 1):
        row = input()
        for j, c in enumerate(row, 1):
            grid[(i, j)] = c
    
    moves = input().strip()
    
    (santa_x, santa_y), visited = solve(grid, x, y, moves)
    print(f"{santa_x} {santa_y} {len(visited)}")

main()
```

### Rust

```rust:hello_world/src/bin/abc385_b.rs
use proconio::input;
use std::collections::{HashMap, HashSet};

#[derive(Clone, Copy, Hash, Eq, PartialEq)]
struct Pos(i32, i32);

struct Grid {
    cells: HashMap<Pos, char>,
}

impl Grid {
    fn get(&self, pos: Pos) -> Option<&char> {
        self.cells.get(&pos)
    }
}

fn do_move_cell(cell: Option<&char>, old_pos: Pos, new_pos: Pos, visited: &mut HashSet<Pos>) -> Pos {
    match cell {
        Some(&'@') => {
            visited.insert(new_pos);
            new_pos
        }
        Some(&'#') => old_pos,
        Some(_) => new_pos,  // handles '.' and any other character
        None => old_pos,
    }
}

fn do_move(grid: &Grid, current_pos: Pos, direction: char, visited: &mut HashSet<Pos>) -> Pos {
    let new_pos = match direction {
        'U' => Pos(current_pos.0 - 1, current_pos.1),
        'D' => Pos(current_pos.0 + 1, current_pos.1),
        'L' => Pos(current_pos.0, current_pos.1 - 1),
        'R' => Pos(current_pos.0, current_pos.1 + 1),
        _ => unreachable!(),
    };
    
    do_move_cell(grid.get(new_pos), current_pos, new_pos, visited)
}

fn solve(grid: &Grid, start: Pos, moves: &[char]) -> (Pos, HashSet<Pos>) {
    let mut visited = HashSet::new();
    if let Some('@') = grid.get(start) {
        visited.insert(start);
    }
    
    let final_pos = moves.iter().fold(start, |pos, &direction| {
        do_move(grid, pos, direction, &mut visited)
    });
    
    (final_pos, visited)
}

fn main() {
    input! {
        h: usize,
        _w: usize,  // prefix with underscore to suppress warning
        x: i32,
        y: i32,
        grid: [String; h],
        moves: String,
    }
    
    let mut cells = HashMap::new();
    for (i, row) in grid.iter().enumerate() {
        for (j, c) in row.chars().enumerate() {
            cells.insert(Pos(i as i32 + 1, j as i32 + 1), c);
        }
    }
    
    let grid = Grid { cells };
    let start = Pos(x, y);
    let (final_pos, visited) = solve(&grid, start, &moves.chars().collect::<Vec<_>>());
    
    println!("{} {} {}", final_pos.0, final_pos.1, visited.len());
}
```


</details>



## [C - Illuminate Buildings](https://atcoder.jp/contests/abc385/tasks/abc385_c)

問題文はリンク先をご参照ください。
それでは解答です。どう解くのか考えるのが面倒くさくなって、解説に載っていたPythonの答えをみてElixirに置き換えをしました。Rustは生成AIに作ってもらいました。

<details><summary>私の解答</summary>

### Elixir

```elixir:abc385_c.exs
defmodule Main do
  def main do
    {n, hs} = input()

    solve(n, hs)
    |> IO.puts()
  end

  defp solve(n, hs) do
    Enum.reduce(0..(n - 1), 0, fn i, acc ->
      current_height = Map.get(hs, i)

      Enum.reduce(1..(n - i), acc, fn w, acc ->
        Enum.reduce_while(1..n, 1, fn _, cnt ->
          if i + cnt * w > n - 1 or acc >= n - i or acc >= div(n - i, w) + 1 or current_height != Map.get(hs, i + cnt * w) do
            {:halt, cnt}
          else
            {:cont, cnt + 1}
          end
        end)
        |> max(acc)
      end)
    end)
  end

  defp input do
    n =
      IO.read(:line)
      |> String.trim()
      |> String.to_integer()

    hs =
      IO.read(:line)
      |> String.trim()
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index(fn element, index -> {index, element} end)
      |> Map.new()

    {n, hs}
  end
end

Main.main()
```

### Python

```python:abc385_c.py
N=int(input())
H=list(map(int,input().split()))
ans=1
for i in range(N):
  for w in range(1,N-i):
    cnt=1
    while i+cnt*w<N and ans < N-i and (ans < (N-i // w) + 1) and H[i]==H[i+cnt*w]:
      cnt+=1
    ans=max(ans,cnt)
print(ans)
```



### Rust

```rust:hello_world/src/bin/abc385_c.rs
use proconio::input;
use std::collections::HashMap;

fn count_sequence(heights: &HashMap<usize, i32>, i: usize, w: usize, n: usize, ans: usize) -> usize {
    let target = heights.get(&i).unwrap();
    let mut cnt = 1;
    
    while i + cnt * w < n 
        && ans < n - i 
        && ans < (n - i) / w + 1 
        && heights.get(&(i + cnt * w)).map_or(false, |h| h == target) {
        cnt += 1;
    }
    cnt
}

fn solve(n: usize, heights: HashMap<usize, i32>) -> usize {
    let mut ans = 1;
    
    for i in 0..n {
        for w in 1..n-i {
            ans = ans.max(count_sequence(&heights, i, w, n, ans));
        }
    }
    ans
}

fn main() {
    input! {
        n: usize,
        h: [i32; n],
    }
    
    let heights: HashMap<usize, i32> = h.into_iter()
        .enumerate()
        .collect();
    
    println!("{}", solve(n, heights));
}
```

</details>


---

# 参考

AtCoderをElixirで楽しむ場合の参考にしてください。
インプットの読み取り方とアウトプットの出力の仕方、プログラムのエントリーポイントについて解説しています。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

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

