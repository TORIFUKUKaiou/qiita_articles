---
title: 'ElixirでABC162のA,B,C問題を解いてみる！'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-11-15T12:24:23+09:00'
id: b8081d6fd52f849a6bb7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

- [Elixir](https://elixir-lang.org/)でやってみました


# 問題
- [AtCoder Beginner Contest 162](https://atcoder.jp/contests/abc162)
- A〜Cまで解いてみます
- 今回は[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書いていません

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Lucky 7](https://atcoder.jp/contests/abc162/tasks/abc162_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir
defmodule Main do
  def main do
    IO.read(:line) |> String.trim() |> String.contains?("7") |> if(do: "Yes", else: "No") |> IO.puts
  end
end
```

- [提出](https://atcoder.jp/contests/abc162/submissions/17687750)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で以下、B問題、C問題を解いていきます

# [問題B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)

```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    1..n |> Enum.reduce(0, fn i, acc -> if rem(i,3) == 0 or rem(i,5) == 0, do: acc, else: acc + i end) |> IO.puts()
  end
end
```

- [提出](https://atcoder.jp/contests/abc162/submissions/17687605)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Sum of gcd of Tuples (Easy)](https://atcoder.jp/contests/abc162/tasks/abc162_c)
- 問題文はリンク先をご参照くださいませ :bow:


```elixir
defmodule Main do
  def main do
    k = IO.read(:line) |> String.trim() |> String.to_integer()
    list = for i <- 1..k, j <- 1..k, do: Integer.gcd(i, j)
    1..k |> Enum.flat_map(fn i -> Enum.map(list, & Integer.gcd(&1, i)) end) |> Enum.sum |> IO.puts
  end
end
```


- [提出](https://atcoder.jp/contests/abc162/submissions/17693015)の際にはモジュール名は`Main`にしておいてください
- タイムアウトになるかなあと心配しましたがセーフ(1689 ms)でした
- [Integer.gcd/2](https://hexdocs.pm/elixir/Integer.html#gcd/2)は最大公約数(The greatest common divisor)を計算してくれます


# Wrapping Up :qiita-fabicon: 
- A〜Cは自力でいけました！ :smile:
- 問題みてiexでちょっとためして行けそうだったので`Main`モジュールをこさえて人間コンパイル? のみ通して直接提出してみました
    - それで今回は[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)は書いていません
        - 言い訳にはならない?
    - コンパイルエラーださずに`AC`取れました
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
