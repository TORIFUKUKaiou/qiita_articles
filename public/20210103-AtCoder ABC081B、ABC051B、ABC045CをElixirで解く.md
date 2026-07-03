---
title: 'AtCoder ABC081B、ABC051B、ABC045CをElixirで解く '
tags:
  - Elixir
private: false
updated_at: '2021-01-03T14:34:30+09:00'
id: f736f4f0d47963ec86a9
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [AtCoder](https://atcoder.jp/) [ABC081B](https://atcoder.jp/contests/abc081/tasks/abc081_b)、[ABC051B](https://atcoder.jp/contests/abc051/tasks/abc051_b)、[ABC045C](https://atcoder.jp/contests/abc045/tasks/arc061_a)を[Elixir](https://elixir-lang.org/)で解いてみます

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

# [ABC081B](https://atcoder.jp/contests/abc081/tasks/abc081_b)

```
$ mix atcoder.open abc081 b
```
- 問題文のページがブラウザで開かれます :rocket: 
- 問題をご確認ください

```
$ mix atcoder.new abc081
```
- 問題文のページからテストケースや回答モジュールの雛形が作られます

## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc081/b.ex
defmodule Abc081.B.Main do
  use Bitwise

  def main() do
    IO.read(:line)
    list = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    0..1_000_000_000
    |> Enum.reduce_while({0, list}, fn _, {acc_cnt, acc_list} ->
      case has_odd?(acc_list) do
        true -> {:halt, {acc_cnt, acc_list}}
        false -> {:cont, {acc_cnt + 1, do_something(acc_list)}}
      end
    end)
    |> elem(0)
    |> IO.puts()
  end

  defp has_odd?(list) do
    Enum.any?(list, &((&1 &&& 1) == 1))
  end

  defp do_something(list) do
    Enum.map(list, &(&1 >>> 1))
  end
end
```

## テストする
```
$ mix atcoder.test abc081 b
abc081 b
running 3 test...
-------------------------------------
sample1  AC  1ms
actual:
2
expected:
2
-------------------------------------
sample2  AC  0ms
actual:
0
expected:
0
-------------------------------------
sample3  AC  0ms
actual:
8
expected:
8
```
:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc081/submissions/19175603)します。 

---

# [ABC051B](https://atcoder.jp/contests/abc051/tasks/abc051_b)

```
$ mix atcoder.open abc051 b
```
- 問題文のページがブラウザで開かれます :rocket: 
- 問題をご確認ください

```
$ mix atcoder.new abc051
```
- 問題文のページからテストケースや回答モジュールの雛形が作られます

## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc051/b.ex
defmodule Abc051.B.Main do
  def main() do
    [k, s] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    # for(x <- 0..k, y <- 0..k, z = s - x - y, z >= 0, z <= k, do: 1)
    # |> Enum.sum()
    # |> IO.puts()

    0..k
    |> Enum.reduce(0, fn x, acc ->
      Enum.filter(0..k, fn y ->
        z = s - x - y
        z >= 0 && z <= k
      end)
      |> Enum.count()
      |> Kernel.+(acc)
    end)
    |> IO.puts()
  end
end
```

- [for/1](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#for/1)を使って書くと短くかけますが、`MLE(Memory Limit Exceeded)`になっちゃったのでパスするように書きかえました

## テストする
```
$ mix atcoder.test abc051 b
abc051 b
running 2 test...
-------------------------------------
sample1  AC  0ms
actual:
6
expected:
6
-------------------------------------
sample2  AC  0ms
actual:
1
expected:
1
```
:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc051/submissions/19176236)します。 

---

# [ABC045C](https://atcoder.jp/contests/abc045/tasks/arc061_a)

```
$ mix atcoder.open abc045 c
```
- 問題文のページがブラウザで開かれます :rocket: 
- 問題をご確認ください

```
$ mix atcoder.new abc045
```
- 問題文のページからテストケースや回答モジュールの雛形が作られます

## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc045/c.ex
defmodule Abc045.C.Main do
  use Bitwise

  def main() do
    s = IO.read(:line) |> String.trim() |> String.to_integer()
    digits = Integer.digits(s)
    length = Enum.count(digits)

    1..pow(2, length - 1)
    |> Enum.map(fn bit ->
      0..(length - 2)
      |> Enum.reduce([], fn i, acc ->
        case bit &&& 1 <<< i do
          0 -> ["" | acc]
          _ -> ["+" | acc]
        end
      end)
    end)
    |> Enum.map(fn pluses ->
      Enum.with_index(pluses)
      |> Enum.reduce(Enum.intersperse(digits, ""), fn {plus, i}, acc ->
        List.update_at(acc, 2 * i + 1, fn _ -> plus end)
      end)
    end)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&Code.eval_string/1)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sum()
    |> IO.puts()
  end

  def pow(x, y), do: pow(x, y, 1)

  defp pow(_x, 0, acc), do: acc

  defp pow(x, y, acc), do: pow(x, y - 1, x * acc)
end
```


## テストする
```
$ mix atcoder.test abc045 c
abc045 c
running 2 test...
-------------------------------------
sample1  AC  0ms
actual:
176
expected:
176
-------------------------------------
sample2  AC  24ms
actual:
12656242944
expected:
12656242944
```
:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc045/submissions/19177752)します。 

# Wrapping Up 🎍🎍🎍🎍🎍
- 私は、めちゃくちゃ時間かけて解いています :sweat_smile: 
- 問題は[問題解決力を鍛える!アルゴリズムとデータ構造](https://www.amazon.co.jp/dp/4065128447) :book: 第3章の章末問題に挙げられていたものをチョイスしました
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 
