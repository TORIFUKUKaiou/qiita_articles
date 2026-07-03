---
title: AtCoder Beginner Contest 114 CをElixirで解く
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-02-28T21:44:38+09:00'
id: a389b4f79a87dcc2b8fd
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [AtCoder](https://atcoder.jp/) [ABC114C](https://atcoder.jp/contests/abc114/tasks/abc114_c)を[Elixir](https://elixir-lang.org/)で解いてみます
- 2021/03/01(月)開催予定の[autoracex #N](https://autoracex.connpass.com/event/205317/)という[Elixir](https://elixir-lang.org/)のもくもく会での成果とします

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

# [ABC114C](https://atcoder.jp/contests/abc114/tasks/abc114_c)

```
$ mix atcoder.open abc114 c
```
- 問題文のページがブラウザで開かれます :rocket: 
- 問題をご確認ください

```
$ mix atcoder.new abc114
```
- 問題文のページからテストケースや回答モジュールの雛形が作られます

## ソースコードを書く
- 自分を信じてがんばって解きましょう

```elixir:lib/abc114/c.ex
defmodule Abc114.C.Main do
  def main() do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    digits = Integer.to_string(n) |> String.codepoints() |> Enum.count()

    numbers(digits)
    |> Enum.filter(&(&1 <= n))
    |> Enum.count()
    |> IO.puts()
  end

  defp numbers(digits) do
    1..digits
    |> Enum.reduce([[]], fn _, list_of_lists ->
      Enum.reduce(list_of_lists, [], fn list, acc ->
        [[3 | list], [5 | list], [7 | list], list | acc]
      end)
    end)
    |> Enum.filter(fn list ->
      Enum.any?(list, &(&1 == 3)) and Enum.any?(list, &(&1 == 5)) and Enum.any?(list, &(&1 == 7))
    end)
    |> Enum.map(fn list ->
      Enum.join(list) |> String.to_integer()
    end)
    |> MapSet.new()
  end
end
```

## テストする
```
$ mix atcoder.test abc114 c
```

![スクリーンショット 2021-02-21 20.38.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e1ad96b4-2bcb-5159-8150-543ac94efe13.png)


:tada::tada::tada:

自信をもって提出しましょう。
提出の際にはモジュール名を`Main`にして[提出](https://atcoder.jp/contests/abc114/submissions/20374218)します。 

---


# Wrapping Up 🎍🎍🎍🎍🎍
- 私は、めちゃくちゃ時間かけて解いています :sweat_smile: 
- 問題は[問題解決力を鍛える!アルゴリズムとデータ構造](https://www.amazon.co.jp/dp/4065128447) :book: 第4章の章末問題に挙げられていたものをチョイスしました
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 
