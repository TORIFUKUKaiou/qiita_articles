---
title: thenを読んでみる、見様見真似でマクロを書いて楽しむ（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-14T22:11:45+09:00'
id: e29ccaffa405ebdbc4c1
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**月見ればちぢにものこそ悲しけれわが身ひとつの秋にはあらねど**

Advent Calendar 2022 72日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Kernel.then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)の話をします。

# What's [then/2](https://hexdocs.pm/elixir/Kernel.html#then/2) ?

まずは、公式からサンプルをそのまま紹介します。

```elixir
iex> 1 |> then(fn x -> x * 2 end)
2

iex> 1 |> then(fn x -> Enum.drop(["a", "b", "c"], x) end)
["b", "c"]
```

もう少し具体的な例を示します。
よくある使いどころは、[File.write/3](https://hexdocs.pm/elixir/File.html#write/3)をパイプ演算子（[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)）でつなぐときです。

```elixir
iex> "awesome" |> then(fn content -> File.write("output.txt", content) end)
```

この例では、`File.write("output.txt", "awesome")`と書けば済みます。
`"awesome"`がなにかしらのAPI呼び出しで取得できた値だとおもってください。
そうすると、パイプ演算子（[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)）でつなぎたい気分になりませんか。

[File.write/3](https://hexdocs.pm/elixir/File.html#write/3)の引数は以下の通りです。

- 第一引数: `path`
- 第二引数: `content`
- 第三引数: `modes \\ []`

`content`のほうが第二引数だから、パイプ演算子（[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)）でつなぐときは一工夫が必要です。
一工夫の一つに、[then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)の使用があげられます。


余談ですが、[then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)のことは[Zenn](https://zenn.dev/)の記事で私は知りました。

https://zenn.dev/koga1020/articles/aafcc804b65c5a28caa7

@koga1020 さんの記事です。Thanksです。

# [then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)の実装はどうなっているのか確かめに行こう :rocket: 

![スクリーンショット 2022-03-13 22.31.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/698942ed-cf50-ca2a-3874-1e8e769d3581.png)

ドキュメント中 `</>` がリンクになっています。
迷わずおしてみましょう。

https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/kernel.ex#L2557

```elixir:
  @doc since: "1.12.0"
  defmacro then(value, fun) do
    quote do
      unquote(fun).(unquote(value))
    end
  end
```

なるほど、マクロなわけです。
小難しいことはおいておきます。
結局のところは、引数に指定された`fun`と`value`を利用して、`fun.(value)`と関数呼び出しを行っていると見ることができたらもうこっちのものです。

# オレオレマクロで、[File.write/3](https://hexdocs.pm/elixir/File.html#write/3)を呼び出すことを楽しむ


オレオレマクロを作ってみます。
[then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)は実装がシンプルで、見様見真似で書けそうです。

`file_write(content, path)`というマクロを書いてみます。

```elixir:
defmodule Hoge do
  defmacro file_write(value, file_path) do
    quote do
      File.write(unquote(file_path), unquote(value))
    end
  end

  def run do
    "awesome"
    |> file_write("output.txt")
  end
end

Hoge.run()
```

IExに、上記をペタっと貼り付けて実行してみてください。
中身が`awesome`な、`output.txt`ができていることでしょう :tada::tada::tada: 


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

今回は、[then/2](https://hexdocs.pm/elixir/Kernel.html#then/2)の実装を見に行って、見様見真似でマクロを書いてみました。
[Elixir](https://elixir-lang.org/)のドキュメント中`</>`のリンクはソースコードに飛べるので、内部実装を見てみるのも新しい発見があっておもしろいとおもいます。
楽しんでください！


Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





