---
title: 'Enjoy Elixir #008 AtCoderを解いてみる'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T12:06:50+09:00'
id: 98f875ee4d0f4038b5a2
organization_url_name: fukuokaex
slide: true
ignorePublish: false
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/7/21(火)の回](https://kfieyaruki.connpass.com/event/183531/)
- 今日は以下を学びます
    - [AtCorder](https://atcoder.jp/?lang=ja)を解いてみます
    - いろいろな問題を解いてみるといろいろと文法を覚えたり、公式ドキュメントの確認に抵抗がなくなっていくとおもいます
- A journey of a thousand miles begins with a single step.
- この記事は[Elixir](https://elixir-lang.org/)を触るのがはじめてという方に向けて書いています
- elixir         1.10.4-otp-23
- erlang         23.0.1

----
# もくじ
[001 mix new, iex -S mix, mix format](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af)
|> [002 型](https://qiita.com/torifukukaiou/items/1f5789dbd05498be1132)
|> [003 Pattern matching](https://qiita.com/torifukukaiou/items/47b088f6c44ccf213226)
|> [004 Modules and functions](https://qiita.com/torifukukaiou/items/2b6f30db0a7d37c4f139)
|> [005 Pipe operator and Enum module](https://qiita.com/torifukukaiou/items/70a350cfc45d0eb58371)
|> [006 HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)
|> [007 Flow](https://qiita.com/torifukukaiou/items/eb1aa2c8842adfc40637)
|> [008 AtCoderを解いてみる](https://qiita.com/torifukukaiou/items/98f875ee4d0f4038b5a2)
|> [999 Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a)

----
# 準備

```console
$ mix new hello_at_coder
$ cd hello_at_coder
```


----
# [A - Payment](https://atcoder.jp/contests/abc173/tasks/abc173_a)

- 問題文はリンク先をご確認ください

```elixir:lib/main.ex
defmodule Main do
  def main do
    IO.gets("")
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  @doc ~S"""
  Solve

  ## Examples

      iex> Main.solve(1900)
      100
      iex> Main.solve(3000)
      0

  """
  def solve(n) do
    1..10
    |> Enum.reduce_while(0, fn _, payment ->
      if payment < n, do: {:cont, payment + 1000}, else: {:halt, payment}
    end)
    |> Kernel.-(n)
  end
end
```

----

```elixir:test/hello_at_coder_test.exs
defmodule HelloAtCoderTest do
  use ExUnit.Case
  doctest HelloAtCoder
  doctest Main # add
```

----

- 愚直にn円以上となるように千円札を集めて、その合計金額からn円を引くという方法で解きました
- `Main.solve/1`のコメントは[Doctest](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるテストになっています :rocket::rocket::rocket: 
    - 解答のキモの部分だけテストを作って、その前後で入力と出力を[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でつなぐとよいでしょう
- エントリーポイントと言えばいいですかね、[AtCoder](https://atcoder.jp/?lang=ja)を[Elixir](https://elixir-lang.org/)で解きたい場合には`Main.main/0`から実行されます

----

## 実行
```elixir
$ mix test
...

Finished in 0.07 seconds
2 doctests, 1 test, 0 failures

Randomized with seed 687098
```



----
# 提出 :tada::tada::tada: 

[提出 #15335013](https://atcoder.jp/contests/abc173/submissions/15335013)
<img width="929" alt="スクリーンショット 2020-07-20 22.19.12.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3eb254f8-479a-ed5d-fecc-f0478688dfc1.png">

----

# Wrapping Up
- 今日のポイントは、[Doctest](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)です
- [AtCoder](https://atcoder.jp/?lang=ja)を解く時には`Main.main/0`を用意します
    - ちなみに私は何の自慢にもなりませんが、このA問題を解くのはそれほど時間はかかりませんでしたが、C問題あたりからはめちゃくちゃ時間がかかっています :sweat: 
- 次回は、何にしようかな(ネタ検討中)
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- **Enjoy!!!**
