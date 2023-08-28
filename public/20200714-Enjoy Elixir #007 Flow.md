---
title: 'Enjoy Elixir #007 Flow'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T12:05:11+09:00'
id: eb1aa2c8842adfc40637
organization_url_name: fukuokaex
slide: true
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/7/14(火)の回](https://kfieyaruki.connpass.com/event/182722/)
- 今日は以下を学びます
    - [Flow](https://github.com/dashbitco/flow)
- A journey of a thousand miles begins with a single step.
- この記事は[Elixir](https://elixir-lang.org/)を触るのがはじめてという方に向けて書いています

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
$ mix new hello_flow
$ cd hello_flow
```

----
# 依存関係の解消

- [Flow](https://github.com/dashbitco/flow)

> Flow allows developers to express computations on collections, similar to the Enum and Stream modules, although computations will be executed in parallel using multiple GenStages.

```elixir:mix.exs
  defp deps do
    [
      {:flow, "~> 1.0"}
    ]
  end
```

```
$ mix deps.get
```

----
# Flowをつかわずに単語の数を数えてみる

```elixir:lib/word_count.ex
defmodule WordCount do
  @path "testfile.txt"

  def run do
    File.stream!(@path)
    |> Enum.flat_map(&String.split(&1, " "))
    |> Enum.map(&String.trim/1)
    |> Enum.reduce(%{}, fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
  end
end
```

- `testfile.txt`は、[Faker](https://github.com/faker-ruby/faker)でつくりました
    - [Faker::TvShows::SiliconValley](https://github.com/faker-ruby/faker/blob/master/doc/tv_shows/silicon_valley.md)を利用しました
    - [Silicon Valley](https://www.hbo.com/silicon-valley)



## 実行
```elixir
$ curl -o testfile.txt https://firebase.torifuku-kaiou.tokyo/testfile.txt

$ iex -S mix

iex> :timer.tc WordCount, :run, []
{21064536,
 %{
   "Russ" => 19354,
   "whole" => 18160,
   "prove" => 18346,
 ...
 }}
```

----
# Flowを使って単語の数を数えてみる

```elixir:lib/word_count.ex
defmodule WordCount do
  @path "testfile.txt"

  def run_with_flow do
    File.stream!(@path)
    |> Flow.from_enumerable()
    |> Flow.partition()
    |> Flow.flat_map(&String.split(&1, " "))
    |> Flow.map(&String.trim/1)
    |> Flow.reduce(fn -> %{} end, fn word, acc ->
      Map.update(acc, word, 1, &(&1 + 1))
    end)
    |> Enum.into(%{})
  end
end
```

## 実行

```elixir
iex> recompile

iex> :timer.tc WordCount, :run_with_flow, []
{7952146,
 %{
   "Russ" => 19354,
   "whole" => 18160,
   "prove" => 18346,
 ...
 }}

iex> 7952146 / 21064536
0.37751346623538257
```

- 処理時間が速くなっている:rocket::rocket::rocket:

----

# Wrapping Up
- 今日のポイントは、[Flow](https://github.com/dashbitco/flow)を使うと速くなります
- すごく乱暴にいいますけど、[Enum](https://hexdocs.pm/elixir/Enum.html#content)で書いたプログラムをとにかく[Flow](https://github.com/dashbitco/flow)と書き直す感じのお手軽さで速くなります
- 次回は、[AtCoderを解いてみます](https://qiita.com/torifukukaiou/items/98f875ee4d0f4038b5a2)
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- **Enjoy!!!**
