---
title: 「Google Recruit」をElixirでやってみる
tags:
  - Elixir
private: false
updated_at: '2021-01-11T00:50:11+09:00'
id: 0ff4356aaccc2198859e
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- @e79a93e5b7b1 さんの[Google Recruit](https://qiita.com/e79a93e5b7b1/items/bb28052be369380f7615)を[Elixir](https://elixir-lang.org/)でやってみます

# What is [Elixir](https://elixir-lang.org/) ?

> Elixir is a dynamic, functional language designed for building scalable and maintainable applications.

> Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development, embedded software, data ingestion, and multimedia processing domains across a wide range of industries.

- <font color="purple">不老不死の霊薬</font>っちいうことですよ

# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
- 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などを参考にしてください

```
$ mix new google_recruit
$ cd google_recruit
```

- いろいろファイルができますが、[Elixir](https://elixir-lang.org/)が初めての方はそんなものだとおもってください
    - 慣れると**景色に見えます** (by @kikuyuta 先生)
- 今回は1ファイルしか触りません
- プロジェクトのルートに`exp.txt`を置きました

```exp.txt
2.71828182845904523536028747135266249775
7247093699959574966967627724076630353547
5945713821785251664274274663919320030599
2181741359662904357290033429526059563073
81323286279434907632338298807531952510190
```

# 問題
- 問題文は参考にした記事中をご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
    - [Google Recruit Problem](https://qiita.com/e79a93e5b7b1/items/bb28052be369380f7615#google-recruit-problem)
        - **e(自然対数の底)の値で連続する10桁の数のうち，最初の素数をrubyで求めよ．**
    - [発展問題](https://qiita.com/e79a93e5b7b1/items/bb28052be369380f7615#%E7%99%BA%E5%B1%95%E5%95%8F%E9%A1%8C)
        - **`f(5)=__________`**
- あっ、[Ruby](https://www.ruby-lang.org/ja/)縛りなの...
- まあ、いいや[Elixir](https://elixir-lang.org/)でやろう :rocket::rocket::rocket: 
- **私には問題の意味があんまりわかりません**でしたが、参考記事の[Ruby](https://www.ruby-lang.org/ja/)プログラムを[Elixir](https://elixir-lang.org/)で書いてみたらどうなるかをやってみて、答えが同じになればそれでよしとします  

## で、四の五の言わずに書いてみる

```elixir:lib/google_recruit.ex
defmodule GoogleRecruit do
  def problem_one do
    list_of_10_digits()
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.find(&is_prime?/1)
  end

  def problem_two do
    list_of_10_digits()
    |> Enum.filter(&is_digits_sum_49?/1)
    |> Enum.at(4)
    |> Enum.join()
    |> String.to_integer()
  end

  defp list_of_10_digits do
    File.read!("exp.txt")
    |> String.replace("\n", "")
    |> String.replace(".", "")
    |> String.codepoints()
    |> Enum.chunk_every(10, 1, :discard)
  end

  defp is_prime?(n) when n in [2, 3], do: true

  defp is_prime?(n) do
    floored_sqrt =
      :math.sqrt(n)
      |> Float.floor()
      |> round

    !Enum.any?(2..floored_sqrt, &(rem(n, &1) == 0))
  end

  defp is_digits_sum_49?(digits) do
    Enum.map(digits, &String.to_integer/1)
    |> Enum.sum()
    |> Kernel.==(49)
  end
end
```

- 素数の判定は、[Ruby](https://www.ruby-lang.org/ja/)には[primeライブラリ](https://docs.ruby-lang.org/ja/3.0.0/library/prime.html)が標準添付ライブラリとして存在することを知っていますが、[Elixir](https://elixir-lang.org/)は標準にはない[^1]とおもっています
- https://gist.github.com/aditya7iyengar/2487b9ed7f70ed39aa4afec86c730665#file-n_primes_fermat_algorithm-ex-L5-L10 をおおいに参考にしました
    - てか、写しました
    - <font color="purple">$\huge{心をこめて、一文字一文字彫るように写しました}$</font>:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
        - あ、年賀状書かなきゃ

[^1]: 素数の判定について、私が**狼おっさん**になってしまっていたり、[Elixir](https://elixir-lang.org/)ではこうやるのが鉄則です、みたいなものをご存知の方がいらっしゃいましたら、ぜひご指導・ご鞭撻のほどよろしくお願いします。すぐ書き直します :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

# Run

```elixir
$ iex -S mix
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)
Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)

iex> GoogleRecruit.problem_one
7427466391

iex> GoogleRecruit.problem_two
5966290435

iex> System.halt
$
```

:tada::tada::tada:

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Enum.chunk_every/4](https://hexdocs.pm/elixir/Enum.html#chunk_every/4)くん、大活躍 :rocket::rocket::rocket: 
- [Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールは、[Elixir](https://elixir-lang.org/)において必修科目
- [String](https://hexdocs.pm/elixir/String.html#content)モジュールもよく使うでありますよ
- 今回に関していうと大部分この2つのモジュールで書き上げています
- 他は
    - [File](https://hexdocs.pm/elixir/File.html#content)モジュール
    - [Kernel](https://hexdocs.pm/elixir/Kernel.html#content)モジュール
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:

<font color="purple">ありがとナイス :flag_cn:</font>
