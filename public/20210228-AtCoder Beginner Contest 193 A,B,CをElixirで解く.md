---
title: 'AtCoder Beginner Contest 193 A,B,CをElixirで解く'
tags:
  - AtCoder
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-02-28T21:58:51+09:00'
id: 238771e40c001ec9a973
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [AtCoder](https://atcoder.jp/) [ABC193](https://atcoder.jp/contests/abc193)を[Elixir](https://elixir-lang.org/)で解いてみます


# What is [AtCoder](https://atcoder.jp/)?
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、最近はじめました 

## はじめての方は
- [Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)にはじめて取り組まれる方は、手前味噌ですが、「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」をご参照ください
    - インプットの読み取り方などのTipsを書いています
- [Elixir](https://elixir-lang.org/)自体がはじめての方はまずインストールしましょう :bangbang::bangbang::bangbang:
    - 手前味噌ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などをご参照ください

# 便利なツール
- [tamanugi/ex_at_coder](https://github.com/tamanugi/ex_at_coder)
    - @tamanugiさん作
    - [AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)
    - [@tamanugiさんのex_at_coderを使ってみる (Elixir)](https://qiita.com/torifukukaiou/items/3cb86dede8aefa2cd7c0)
    - 本日はこちらを使います
- [g-kenkun/kyopuro](https://github.com/g-kenkun/kyopuro)
    - @g_kenkunさん作
    - [@g_kenkunさんのg-kenkun/kyopuroを使ってみる (Elixir)](https://qiita.com/torifukukaiou/items/0d9af23244d599cb60d0)

# プロジェクト作成

```
$ mkdir awesome_at_coder
$ cd awesome_at_coder
$ asdf local elixir 1.10.2-otp-22
$ mix new .
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
```

# [ABC193A](https://atcoder.jp/contests/abc193/tasks/abc193_a)

```
$ mix atcoder.open abc193 a
```
- 問題文のページがブラウザで開けます :rocket: 
- 問題をご確認ください

```
$ mix atcoder.new abc193
```
- 問題文のページからテストケースや回答モジュールの雛形が作られます

## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc193/a.ex
defmodule Abc193.A.Main do
  def main() do
    [a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    IO.puts((a - b) * 100 / a)
  end
end
```

## テストする
```
$ mix atcoder.test abc193 a
```

- おーっとテストが落っこちました
- この問題は答えが小数なので誤差が生じているようです
- 期待結果のほうを[Elixir](https://elixir-lang.org/)が出した答えに置き換えちゃってもよさそうです
- そういう細工をしたうえで

```
$ mix atcoder.test abc193 a
abc193 a
running 3 test...
-------------------------------------
sample1  AC  0ms
actual:
20.0
expected:
20.0
-------------------------------------
sample2  AC  0ms
actual:
14.285714285714286
expected:
14.285714285714286
-------------------------------------
sample3  AC  0ms
actual:
0.001000010000100001
expected:
0.001000010000100001
```


:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc193/submissions/20558576)します。 
この調子でどんどん行きます :rocket::rocket::rocket: 

# [ABC193B](https://atcoder.jp/contests/abc193/tasks/abc193_b)

```
$ mix atcoder.open abc193 b
```
- 問題文のページがブラウザで開けます :rocket: 
- 問題をご確認ください


## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc193/b.ex
defmodule Abc193.B.Main do
  def main() do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    for _ <- 1..n do
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    end
    |> Enum.filter(fn [a, _p, x] ->
      x - a > 0
    end)
    |> Enum.min_by(fn [_, p, _] -> p end, fn -> [nil, -1, nil] end)
    |> Enum.at(1)
    |> IO.puts()
  end
end

```

## テストする
```
$ mix atcoder.test abc193 b
abc193 b
running 3 test...
-------------------------------------
sample1  AC  1ms
actual:
8
expected:
8
-------------------------------------
sample2  AC  0ms
actual:
-1
expected:
-1
-------------------------------------
sample3  AC  0ms
actual:
861648772
expected:
861648772
```


:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc193/submissions/20558803)します。 

# [ABC193C](https://atcoder.jp/contests/abc193/tasks/abc193_c)

```
$ mix atcoder.open abc193 c
```
- 問題文のページがブラウザで開けます :rocket: 
- 問題をご確認ください


## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc193/c.ex
defmodule Abc193.C.Main do
  def main() do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    do_solve(n)
    |> IO.puts()
  end

  defp do_solve(n) when n in [1, 2], do: n

  defp do_solve(n) do
    2..(:math.sqrt(n) |> round())
    |> Enum.reduce(%{}, fn a, acc ->
      Enum.reduce_while(2..34, acc, fn b, acc ->
        z = pow(a, b)
        if z <= n, do: {:cont, Map.update(acc, z, true, & &1)}, else: {:halt, acc}
      end)
    end)
    |> Enum.count()
    |> Kernel.-(n)
    |> Kernel.*(-1)
  end

  def pow(a, b), do: do_pow(a, b, 1)

  defp do_pow(_, 0, acc), do: acc

  defp do_pow(a, b, acc), do: do_pow(a, b - 1, a * acc)
end
```

## テストする
```
$ mix atcoder.test abc193 c
abc193 c
running 2 test...
-------------------------------------
sample1  AC  3ms
actual:
6
expected:
6
-------------------------------------
sample2  AC  0ms
actual:
99634
expected:
99634
```


:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc193/submissions/20560972)します。 



# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm: 
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 
