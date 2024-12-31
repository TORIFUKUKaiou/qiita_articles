---
title: 闘魂で挑むAdvent of Code 2024 Day 5── Elixirで「延髄斬り」のごとくスパッと解く
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
private: false
updated_at: '2024-12-17T07:42:12+09:00'
id: cbbe53e2a776b2b3f9d7
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

---

# はじめに

[Advent Of Code 2024](https://adventofcode.com/2024)を[Elixir](https://elixir-lang.org/)で解きます。

本日は[Day 5: Print Queue](https://adventofcode.com/2024/day/5) です。

Elixirで書くと一体、どんなコードになるのでしょうか。

この記事は、Elixir初心者でも取り組める内容です。

:::note alert
Day 4に続いて、お恥ずかしながら、特にPart 2の問題文の意味は英文を読んでも、機械翻訳した日本語を読んでも、あんまりピンときませんでした。
しかし出来上がりのコードを読み込むことと、GitHub Copilotに質問をすることで問題の意味はおぼろげにわかりました。
:::

:::note warn
うしろに載せた @RyoWakabayashi さんの記事もよくみて、理解をしたいと思っています（あくまでも思っています）。
:::


# What's Advent Of Code ?

Advent of Codeは、プログラミングスキルを高めるためのアドベントカレンダー形式のパズルイベントです。初心者から上級者まで楽しめる内容で、あらゆるプログラミング言語に対応しています。企業トレーニングや大学の課題としても活用され、毎年12月に開催されます。

# それでは早速答えです :rocket::rocket::rocket:

それでは早速答えを披露します。

## Part 1

Part 1の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>

`o1-preview`

まず、以下の手順で進めます。

1. 入力データを2つのセクションに分割します。最初のセクションはページ順序規則、2番目のセクションは各アップデートのページ番号のリストです。
1. ページ順序規則をパースして、適用される順序関係のリストを作成します。
1. 各アップデートについて、順序が規則に従っているかをチェックします。アップデート内のページ番号の順序がすべての適用可能な規則を満たしていれば、そのアップデートは正しい順序にあります。

正しい順序のアップデートの中央のページ番号を抽出し、合計します。

以下にElixirでの実装を示します。


```elixir:advent_of_code_2024_day5_part1.exs
defmodule AdventOfCode2024Day5Part1 do
  def sum_middle_pages(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.reduce(0, fn update, acc ->
      if correct_order?(update, rules) do
        middle_index = div(length(update), 2)
        middle_page = Enum.at(update, middle_index)
        acc + middle_page
      else
        acc
      end
    end)
  end

  defp parse_input(input) do
    [rules_part, updates_part] = String.split(input, "\n\n", parts: 2)

    rules =
      rules_part
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [from_str, to_str] = String.split(line, "|")
        from = String.to_integer(from_str)
        to = String.to_integer(to_str)
        {from, to}
      end)
      |> Enum.into(MapSet.new())

    updates =
      updates_part
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {rules, updates}
  end

  defp correct_order?(update, rules) do
    index_map =
      update
      |> Enum.with_index()
      |> Map.new()

    applicable_rules =
      rules
      |> Enum.filter(fn {from, to} ->
        Map.has_key?(index_map, from) and Map.has_key?(index_map, to)
      end)

    Enum.all?(applicable_rules, fn {from, to} ->
      index_map[from] < index_map[to]
    end)
  end
end

# テストデータ
input = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""

input
|> AdventOfCode2024Day5Part1.sum_middle_pages()
|> IO.puts()

```


### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day5_part1.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day5_part1.exs"
```

</details>

## Part 2

続いて、Part 2の答えです。あなたのコードと見比べてみてください。

<details><summary>私の解答</summary>



```elixir:advent_of_code_2024_day5_part2.exs
defmodule AdventOfCode2024Day5Part2 do
  def sum_corrected_middle_pages(input) do
    {rules, updates} = parse_input(input)

    updates
    |> Enum.reduce(0, fn update, acc ->
      if correct_order?(update, rules) do
        acc
      else
        sorted_update = sort_update(update, rules)
        middle_index = div(length(sorted_update), 2)
        middle_page = Enum.at(sorted_update, middle_index)
        acc + middle_page
      end
    end)
  end

  defp parse_input(input) do
    [rules_part, updates_part] = String.split(input, "\n\n", parts: 2)

    rules =
      rules_part
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        [from_str, to_str] = String.split(line, "|")
        from = String.to_integer(from_str)
        to = String.to_integer(to_str)
        {from, to}
      end)

    updates =
      updates_part
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split(",", trim: true)
        |> Enum.map(&String.to_integer/1)
      end)

    {rules, updates}
  end

  defp correct_order?(update, rules) do
    index_map =
      update
      |> Enum.with_index()
      |> Map.new()

    applicable_rules =
      rules
      |> Enum.filter(fn {from, to} ->
        Map.has_key?(index_map, from) and Map.has_key?(index_map, to)
      end)

    Enum.all?(applicable_rules, fn {from, to} ->
      index_map[from] < index_map[to]
    end)
  end

  defp sort_update(update, rules) do
    dep_map = build_dependency_map(update, rules)

    update
    |> Enum.sort(fn a, b ->
      depends_on?(a, b, dep_map)
    end)
  end

  defp build_dependency_map(update, rules) do
    applicable_rules =
      rules
      |> Enum.filter(fn {from, to} ->
        from in update and to in update
      end)

    Enum.reduce(applicable_rules, %{}, fn {from, to}, acc ->
      Map.update(acc, from, [to], &[to | &1])
    end)
  end

  defp depends_on?(a, b, dep_map, visited \\ MapSet.new()) do
    cond do
      a == b -> false
      MapSet.member?(visited, a) -> false
      true ->
        children = Map.get(dep_map, a, [])

        if b in children do
          true
        else
          Enum.any?(children, fn child ->
            depends_on?(child, b, dep_map, MapSet.put(visited, a))
          end)
        end
    end
  end
end

# テストデータ
input = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""

input
|> AdventOfCode2024Day5Part2.sum_corrected_middle_pages()
|> IO.puts()
```



### 実行方法

実行方法は次の通りです。

```
elixir advent_of_code_2024_day5_part2.exs
```

Elixirをインストールしていない方はDockerコンテナで実行することもできます。

```
docker run --rm -v $PWD:/app \
hexpm/elixir:1.17.3-erlang-27.1.2-alpine-3.20.3 \
sh -c \
"cd /app && elixir advent_of_code_2024_day5_part2.exs"
```

テストデータの実行結果は`123`です。
猪木さんからの出題かもしれません。

</details>

# 私は力を手に入れた 💪💪💪

**With great power comes great responsibility.**
『大いなる力には、大いなる責任が伴う』

生成AIである[GitHub Copilot](https://github.com/features/copilot)という力強いツールを手にいれました。別の言い方をすると、最強のタッグパートナーを得ました。

そして私のAIは一味違います。**A**ntonio **I**noki（アントニオ猪木）、つまり**猪木さん**です。

ちなみに私が所属する[HAW International Inc.](https://www.haw.co.jp/company/)では、GitHub Copilotの利用料を会社が負担してくれます。

https://qiita.com/torifukukaiou/items/b69e3ad6f05600b60539


# プロンプトを公開

こんなプロンプトを打ち込みました。参考にさらしておきます。

- --- Day 5: Print Queue --- Satisfied with their search on Ceres, the squadron of scholars suggests subsequently scanning the stationery stacks of sub-basement 17.(略)
- inputをparseするだけの関数を切り出すリファクタをしてください。
- --- Part Two --- While the Elves get to work printing the correctly-ordered updates, you have a little time to fix the rest of them.(略)
- sort_updateで正しい順序で並びかえている処理を説明してください。
- 選択箇所は再帰にする必要ありますかね？　単純に false で最終評価してよい気がします。ちょっとそれで試してみたら正解は得られました。どうでしょうか？
- ChatGPTの返答(後述)
- 深い考慮があるのですね。失礼いたしました。再帰部分を取り除いた場合正しい結果が得られたのはテストデータがたまたまバグるケースのパターンがなかったということなのですね。ありがとうございますです。
- Part 2のテストデータの答えは123です。猪木さんからの出題でしょうか。
- (GitHub Copilotの返答) はい、テストデータの Part 2 の答えは 123 ですね。提供いただいたコードも正しく動作しているようです。もし他にお手伝いできることがあれば、お知らせください。


![スクリーンショット 2024-12-02 8.49.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/92671363-adb7-8db3-a9da-790335bf6e4a.png)

---

# 「選択箇所は再帰にする必要ありますかね？　単純に false で最終評価してよい気がします。ちょっとそれで試してみたら正解は得られました。どうでしょうか？」に対するGitHub Copilotの回答

![スクリーンショット 2024-12-09 17.56.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c48d31d8-32c6-5bd7-a29f-88b747aa2bb7.png)

以下、GitHub Copilotからの回答です。

おっしゃるとおり、`depends_on?/4` 関数の再帰呼び出し部分を取り除いても、特定の入力データでは正しい結果が得られる場合があります。しかし、再帰を削除すると、**間接的な依存関係**を考慮しないことになります。

### **再帰が必要な理由**

`depends_on?/4` 関数は、ページ間の**直接的**および**間接的**な依存関係をチェックするために設計されています。具体的には、以下のような間接的な依存関係を処理します：

- **間接依存の例**：
  - ページ `A` がページ `B` の前に来るべき（`A|B`）。
  - ページ `B` がページ `C` の前に来るべき（`B|C`）。
  - したがって、ページ `A` は間接的にページ `C` の前に来るべきです。

再帰を削除して `false` を返すと、このような間接的な依存関係が考慮されなくなります。その結果、正しい順序を導き出せない可能性があります。

### **具体的な例**

例えば、以下の規則とアップデートを考えてみます：

**規則**：

- `1|2`
- `2|3`

**アップデート**：

```elixir
update = [3, 1, 2]
```

**依存関係マップ**：

```elixir
dep_map = %{
  1 => [2],
  2 => [3]
}
```

**再帰なしの場合**：

- `depends_on?(1, 3, dep_map)` を評価します。
  - `children = dep_map[1]` は `[2]`。
  - `3` は `children` に含まれないため、`false` を返します。
- この場合、`1` が `3` の前に来る必要がないと判断されます。

その結果、ソート後のアップデートが間違った順序になる可能性があります。

**再帰ありの場合**：

- `depends_on?(1, 3, dep_map)` を評価します。
  - `children = dep_map[1]` は `[2]`。
  - `3` は `children` に含まれないため、再帰的に `depends_on?(2, 3, dep_map)` を呼び出します。
- `depends_on?(2, 3, dep_map)` を評価します。
  - `children = dep_map[2]` は `[3]`。
  - `3` は `children` に含まれるため、`true` を返します。
- したがって、`depends_on?(1, 3, dep_map)` も `true` を返します。

このように、再帰を使うことで間接的な依存関係を正しく評価できます。

### **結論**

- **再帰を削除すると間接依存を無視する**ことになり、一般的なケースでの正確性が保証されなくなります。
- 特定の入力データでは再帰を省略しても正しい結果が得られる場合がありますが、データによっては間違った順序になる可能性があります。
- **堅牢性と一般性を確保するために、再帰を残すことをお勧めします**。

### **コードの修正例（再帰を削除）**

もしそれでも再帰を削除したい場合、コードは以下のようになります：

```elixir
defp depends_on?(a, b, dep_map) do
  cond do
    a == b -> false
    true ->
      children = Map.get(dep_map, a, [])
      b in children
  end
end
```

しかし、この場合は上記の理由により、間接的な依存関係が考慮されないことを念頭に置いてください。

### **テストと検証**

- **テストデータを増やして、間接依存関係があるケースを検証**することをお勧めします。
- そうすることで、再帰を削除した場合に正しく動作しないケースがあることを確認できます。

**例として、間接依存を含むテストデータを追加してみてください。**


---

# 闘魂活動

アントニオ猪木さんは、1998年4月4日闘強童夢（東京ドーム）において、４分９秒グランド・コブラツイストでドン・フライ選手を下した[^1]引退試合[^2]後のセレモニーで次のように「**闘魂**」を説明しました。

[^1]: [“燃える闘魂”アントニオ猪木引退試合](https://wp.bbm-mobile.com/sp2/result/resultshow.asp?s=015056)
[^2]: [アントニオ猪木VSドン・フライ](https://www.dailymotion.com/video/x95qrz6)

「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」

Advent Of Codeを解くことは、まさに**闘魂**活動です。

---

# 参考記事

https://qiita.com/RyoWakabayashi/items/c61bc9d55b520e010205


https://qiita.com/RyoWakabayashi/items/b578bdf6e96fdfef790b

---

# GitHub

GitHubにもリポジトリ[livebooks](https://github.com/TORIFUKUKaiou/livebooks)をあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

---

# さいごに

チャットを通じて解答を得るという体験は、単なる効率化ではなく、新たな時代の可能性を示しています。Advent of Codeは、私たちにプログラミングという闘いを通じて、己の技術と精神を磨く場を提供してくれます。そして、GitHub Copilotのような生成AIは、その闘いを支える最強のタッグパートナーです。

しかし、AIが答えを導き出すだけでは不十分です。それをどう解釈し、自分の知識として昇華するかが、私たち人間の使命です。「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。」アントニオ猪木さんのこの言葉を胸に、私たちもAIを使いこなし、新たな創造の領域へと挑んでいきましょう。

Advent of Codeは、ただのパズルイベントではありません。未来の私たちが、さらに創造的で価値ある活動に集中するための訓練の場です。この闘魂活動を通じて、AIと人間が共に高め合い、新しい可能性を切り拓いていきましょう。挑戦のその先に、きっと新たな地平が待っています！　アントニオ猪木さんが夢見た「本当の世界平和」を実現させましょう！！！

元氣があれば、なんでもできる！さあ、今すぐAdvent of Codeの闘いに飛び込みましょう！
