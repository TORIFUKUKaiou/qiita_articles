---
title: ElixirでAtCoderのABC190に参加してみる！
tags:
  - AtCoder
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-02-06T22:19:33+09:00'
id: 1e85b34719356e589805
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- 2021-01-30(土) 21:00 ~ 2021-01-30(土) 22:40 (100分)に行われた[AtCoder Beginner Contest 190](https://atcoder.jp/contests/abc190)に参加してみました
- A問題とB問題は時間内に解けました
- C問題は居残りでできました
    - なんの自慢にもなりません…… :man::man_tone1::man_tone2::man_tone3::man_tone4::man_tone5: 
- F問題までありましてまだまだ道のりは長いです
- 今回は@tamanugiさんの[ex_at_coder](https://hex.pm/packages/ex_at_coder)を使いました
    - 使い方はご本人の解説記事「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」をご参照ください
- 2021/2/1(月)に開催した[autoracex #7](https://autoracex.connpass.com/event/202612/)の成果です

# [AtCoder](https://atcoder.jp/home)について
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、昨年からはじめました
- [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)という記事にちょっとしたTipsを記載しています

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new awesome_at_coder
$ cd awesome_at_coder
```

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_at_coder, ">0.0.0"}
    ]
  end
```

```
$ mix deps.get
$ mix atcoder.new abc190
```

- `mix atcoder.new abc190`でソースコードの雛形とテストケースを自動生成してくれます:bangbang::bangbang::bangbang:

# [問題A - Very Very Primitive Game](https://atcoder.jp/contests/abc190/tasks/abc190_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc190/a.ex
defmodule Abc190.A.Main do
  def main() do
    [a, b, c] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
 
    solve(a, b, c) |> IO.puts()
  end
 
  defp solve(a, b, 0) when a > b, do: "Takahashi"
 
  defp solve(_, _, 0), do: "Aoki"
 
  defp solve(a, b, 1) when b > a, do: "Aoki"
 
  defp solve(_, _, 1), do: "Takahashi"
end
```

```
$ mix atcoder.test abc190 a
```

![スクリーンショット 2021-02-01 22.22.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/aabe8609-645e-a86f-97d7-cb711a8000b8.png)




- [提出](https://atcoder.jp/contests/abc190/submissions/19778792)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で問題を解いていきます

# [問題B - Magic 3](https://atcoder.jp/contests/abc190/tasks/abc190_b)

```elixir:lib/abc190/b.ex
defmodule Abc190.B.Main do
  def main() do
    [n, s, d] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    list_of_lists =
      1..n
      |> Enum.reduce([], fn _, acc ->
        list =
          IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

        [list | acc]
      end)

    list_of_lists
    |> Enum.reduce_while("No", fn [x, y], _ ->
      if x < s && y > d, do: {:halt, "Yes"}, else: {:cont, "No"}
    end)
    |> IO.puts()
  end
end
```

```
$ mix atcoder.test abc190 b
```

![スクリーンショット 2021-02-01 22.26.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/279267a3-1fb0-41a4-1c4c-f6e0e5b15ee5.png)


- [提出](https://atcoder.jp/contests/abc190/submissions/19787742)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Bowls and Dishes](https://atcoder.jp/contests/abc190/tasks/abc190_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir:lib/lib/abc190/c.ex
defmodule Abc190.C.Main do
  def main() do
    [_n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    ab_of_lists =
      1..m
      |> Enum.reduce([], fn _, acc ->
        list =
          IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

        [list | acc]
      end)

    k = IO.read(:line) |> String.trim() |> String.to_integer()

    cd_of_lists =
      1..k
      |> Enum.reduce([], fn _, acc ->
        list =
          IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

        [list | acc]
      end)

    product(cd_of_lists)
    |> Enum.map(fn list ->
      Enum.count(ab_of_lists, fn [a, b] ->
        a in list && b in list
      end)
    end)
    |> Enum.max()
    |> IO.puts()
  end

  def product(list_of_lists) do
    Enum.reduce(list_of_lists, [[]], fn [x, y], acc1 ->
      Enum.reduce(acc1, [], fn list, acc2 ->
        [[x | list], [y | list] | acc2]
      end)
    end)
  end
end
```

```
$ mix atcoder.test abc190 c
```

![スクリーンショット 2021-02-01 22.28.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/db516f95-d0eb-27b8-a79c-5caa9075067b.png)

- [提出](https://atcoder.jp/contests/abc190/submissions/19864680)の際にはモジュール名は`Main`にしておいてください
- この問題で苦労したのは、次の点です
- **①問題の意味を理解すること**
    - 私は本番ではこの問題を理解しようとしてたころトップの方はもうF問題まで全て解いてしまっていたようです🚀🚀🚀🚀🚀
- ②`list_of_lists`の`product`的なことがなかなか書けなかった……
    - https://docs.python.org/ja/3/library/itertools.html#itertools.product
    - ↑やつみたいなもの
    - [MapSet](https://hexdocs.pm/elixir/MapSet.html#content)を使ったせいでかえって遅くなっていた？

```elixir
iex> list_of_lists = [[1, 2], [3, 4], [5, 6]]
[[1, 2], [3, 4], [5, 6]]
=> 一番大きなListの要素数はこの例では3個。1〜16まで可変。
=> この問題は各要素のListは大きさは2と決まっている
=> 以下のようにforを使ってかけると簡単なのだが……

iex> for x <- [1, 2], y <- [3, 4], z <- [5, 6], do: [x, y, z]
[
  [1, 3, 5],
  [1, 3, 6],
  [1, 4, 5],
  [1, 4, 6],
  [2, 3, 5],
  [2, 3, 6],
  [2, 4, 5],
  [2, 4, 6]
]

iex> Abc190.C.Main.product list_of_lists
[
  [5, 4, 1],
  [6, 4, 1],
  [5, 3, 1],
  [6, 3, 1],
  [5, 4, 2],
  [6, 4, 2],
  [5, 3, 2],
  [6, 3, 2]
]
=> forの結果とは各リストの並びとか違うところもあるが、順番は気にしなくてよいので`Abc190.C.Main.product`でなんとかなった
```

- [List](https://hexdocs.pm/elixir/List.html#content)の説明にしたがって、先頭に追加していくことで`fast`になるようにしてみたつもり

```elixir
  def product(list_of_lists) do
    Enum.reduce(list_of_lists, [[]], fn [x, y], acc1 ->
      Enum.reduce(acc1, [], fn list, acc2 ->
        [[x | list], [y | list] | acc2]
      end)
      |> IO.inspect()
    end)
  end
```

- ↑のように途中に[IO.inspect](https://hexdocs.pm/elixir/IO.html#inspect/2)を挟むと動きが理解しやすいかも

```elixir
iex> Abc190.C.Main.product list_of_lists
[[1], [2]]
[[3, 2], [4, 2], [3, 1], [4, 1]]
[
  [5, 4, 1],
  [6, 4, 1],
  [5, 3, 1],
  [6, 3, 1],
  [5, 4, 2],
  [6, 4, 2],
  [5, 3, 2],
  [6, 3, 2]
]
```

## やっぱり[for/1](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)を使った別解
- [Elixir実践ガイド (impress top gearシリーズ)](https://www.amazon.co.jp/dp/4295010774) :book: を読んでいて[Kernel.apply/3](https://hexdocs.pm/elixir/Kernel.html#apply/3)を利用すると、[for/1](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)で書けることに気づきました
    - 手前味噌 [Elixir実践ガイド 読みました](https://qiita.com/torifukukaiou/items/f3cb2f932542961a993e)
- リストのサイズは、1〜16個と決まっているので、デフォルト引数を使うことで内部的には`product`関数を16個用意するをやってみました
- もっとエレガントな書き方がありましたら、大募集！！！


```elixir:lib/abc190/c.ex
defmodule Abc190.C.Main do
  def main() do
    [_n, m] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    ab_of_lists =
      1..m
      |> Enum.reduce([], fn _, acc ->
        list =
          IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

        [list | acc]
      end)

    k = IO.read(:line) |> String.trim() |> String.to_integer()

    cd_of_lists =
      1..k
      |> Enum.reduce([], fn _, acc ->
        list =
          IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

        [list | acc]
      end)

    apply(__MODULE__, :product, cd_of_lists)
    |> Enum.map(fn list ->
      Enum.count(ab_of_lists, fn [a, b] ->
        a in list and b in list
      end)
    end)
    |> Enum.max()
    |> IO.puts()
  end

  def product(
        l1,
        l2 \\ [nil, nil],
        l3 \\ [nil, nil],
        l4 \\ [nil, nil],
        l5 \\ [nil, nil],
        l6 \\ [nil, nil],
        l7 \\ [nil, nil],
        l8 \\ [nil, nil],
        l9 \\ [nil, nil],
        l10 \\ [nil, nil],
        l11 \\ [nil, nil],
        l12 \\ [nil, nil],
        l13 \\ [nil, nil],
        l14 \\ [nil, nil],
        l15 \\ [nil, nil],
        l16 \\ [nil, nil]
      ) do
    for(
      a <- l1,
      b <- l2,
      c <- l3,
      d <- l4,
      e <- l5,
      f <- l6,
      g <- l7,
      h <- l8,
      i <- l9,
      j <- l10,
      k <- l11,
      l <- l12,
      m <- l13,
      n <- l14,
      o <- l15,
      p <- l16,
      uniq: true,
      do: [a, b, c, d, e, f, g, h, i, j, k, l, m, n, o, p] |> Enum.reject(&is_nil/1)
    )
  end
end

```
- 当然、パスしています :tada::tada::tada: 
    - [提出](https://atcoder.jp/contests/abc190/submissions/19943977)


# Wrapping Up :lgtm: :qiita-fabicon: :lgtm: 🎎🎎🎎🎎🎎🎎🎎🎎🎎🎎
- 解くスピードはまだまだ全然です
    - つまり**伸びしろしかない！！！**:fire::fire::fire:
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
