---
title: 闘魂で挑むElixirのPipeオペレーターで流れるようなコードを書く！
tags:
  - Elixir
  - Pipeline
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-11-05T11:24:49+09:00'
id: f99bad9a9ed0dee02ba1
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

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>  
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>  
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>  
<b><font color="red">$\huge{ことだと思います。}$</font></b>

![DALL·E 2024-11-02 23.51.35 - .jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/de2c0331-9925-0078-5300-b3fc12ed91fa.jpeg)


---

# はじめに

[Elixir](https://elixir-lang.org/)の醍醐味であるPipeオペレーター（[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)）を使えば、コードをまるで風車の流れのようにスムーズに書くことができます。猪木さんの言う「風車の理論」です。複数の処理を連結し、意図が伝わりやすいシンプルなコードを実現できるこの手法に、猪木イズムの「闘魂」を注ぎ込み、力強いコードの書き方を学びましょう！

# 1. Pipeオペレーターの基本

**「闘魂とは己に打ち克つこと。そして、闘いを通じて己の魂を磨いていくこと！」**

Pipeオペレーターは、直前の処理結果を次の関数の最初の引数として渡す記法です。これにより、コードが一行一行つながり、データが流れるように変換されていくのです。

例えば、以下のようなコードがあります。

```elixir
list = [1, 2, 3, 4]

# Pipeオペレーターなしのコード
Enum.map(Enum.filter(list, fn x -> rem(x, 2) == 0 end), fn x -> x * 2 end)

# Pipeオペレーターを使ったコード
list
|> Enum.filter(fn x -> rem(x, 2) == 0 end)
|> Enum.map(fn x -> x * 2 end)
```

Pipeオペレーターを使うことで、コードが上から下へと自然な流れをもって読みやすくなります。
ちなみに評価結果はどちらも`[4, 8]`となります。
リストの中から偶数の要素だけを残して、各要素を2倍するというプログラムです。
言葉で説明した通りにプログラムの構造もそうなっています。

# 2. Pipeオペレーターの流れを掴む基本的な使い方

**「道を切り開くのは闘魂だ！」**

Pipeオペレーターを使いこなすには、関数の結果を次の関数に繋げる感覚を身につけることが大切です。以下に簡単な例を見てみましょう。

### 例: 複数のデータ変換を行う

例として、複数のデータ変換を行ってみます。

```elixir
"   Elixir "
|> String.trim()
|> String.upcase()
|> String.replace("ELIXIR", "闘魂")
```

### 実行結果

```elixir
"闘魂"
```

この例では、以下の処理がPipeオペレーターで連結されています。

1. [String.trim/1](https://hexdocs.pm/elixir/String.html#trim/1)で余分な空白を削除
2. [String.upcase/1](https://hexdocs.pm/elixir/String.html#upcase/2)で大文字に変換
3. [String.replace/3](https://hexdocs.pm/elixir/String.html#replace/4)で特定の文字列を「闘魂」に置換

Pipeオペレーターで次々とデータを変換することで、コードが一貫して読みやすく、意図が明確になります。

# 3. より複雑なPipeオペレーターの活用例

**「歩みを止めるな。己の力で道を拓け！」**

Pipeオペレーターは、単純なデータ変換だけでなく、複雑なロジックの連結にも利用できます。例えば、以下のようなデータ集計を行う場合もPipeオペレーターが役立ちます。

### 例: 複数の処理を連結してデータを集計する

例として、複数の処理を連結してデータを集計します。

```elixir
orders = [
  %{id: 1, item: "Apple", quantity: 10, price: 100},
  %{id: 2, item: "Banana", quantity: 5, price: 50},
  %{id: 3, item: "Cherry", quantity: 8, price: 120}
]

orders
|> Enum.map(fn order -> Map.put(order, :total_price, order.quantity * order.price) end)
|> Enum.filter(fn order -> order.total_price >= 500 end)
|> Enum.map(& &1.item)
```

### 実行結果

```elixir
["Apple", "Cherry"]
```

### 解説

この例では、注文リストを以下の処理で集計しています。

1. 各注文に`total_price`キーを追加し、合計金額を計算
2. 合計金額が500以上の注文のみを抽出
3. 抽出した注文のアイテム名のみを取得

Pipeオペレーターを用いることで、各ステップがデータの変換を通じて直感的に読みやすくなり、意図が一貫して伝わるコードに仕上がります。

# 4. ケーススタディ：テキスト処理のPipeオペレーター応用

**「危ぶむなかれ！」**

Pipeオペレーターを活用すると、複雑なテキスト処理もスムーズに行えます。以下に、テキストデータを整形して、特定のパターンにマッチする単語を抽出する例を示します。

### 例: テキストのクリーニングと単語抽出

例として、テキストのクリーニングと単語抽出を行います。

```elixir
text = "Elixir is powerful. Elixir is fun. Programming in Elixir is a joy!"

text
|> String.downcase()
|> String.replace(~r/[^\w\s]/, "")
|> String.split()
|> Enum.filter(fn word -> String.length(word) > 3 end)
|> Enum.uniq()
```

### 実行結果

```elixir
["elixir", "powerful", "programming"]
```

### 解説

このプログラムでは、以下の処理が連結されています。

1. [String.downcase/1](https://hexdocs.pm/elixir/String.html#downcase/2)でテキストを小文字に変換
2. 正規表現で句読点を削除
3. テキストを単語に分割
4. 単語の長さが3文字を超えるものだけを抽出
5. 重複を排除

Pipeオペレーターにより、テキストの変換が自然な流れで連結され、複雑な処理も簡潔に表現できます。

# [dbg](https://hexdocs.pm/elixir/Kernel.html#dbg/2)マクロ

IExで次のように実行してみてください。

```elixir
iex> (
text
|> String.downcase()
|> String.replace(~r/[^\w\s]/, "")
|> String.split()
|> Enum.filter(fn word -> String.length(word) > 3 end)
|> Enum.uniq()
|> dbg()
)
```

## 実行結果

途中の変換の様子がわかる出力を得られます。

```elixir
text #=> "Elixir is powerful. Elixir is fun. Programming in Elixir is a joy!"
|> String.downcase() #=> "elixir is powerful. elixir is fun. programming in elixir is a joy!"
|> String.replace(~r/[^\w\s]/, "") #=> "elixir is powerful elixir is fun programming in elixir is a joy"
|> String.split() #=> ["elixir", "is", "powerful", "elixir", "is", "fun", "programming", "in",
 "elixir", "is", "a", "joy"]
|> Enum.filter(fn word -> String.length(word) > 3 end) #=> ["elixir", "powerful", "elixir", "programming", "elixir"]
|> Enum.uniq() #=> ["elixir", "powerful", "programming"]

["elixir", "powerful", "programming"]
```

---

# どうやって実行するんだー！？　バカヤロー！って方へ

GitHubのアカウントをお持ちの方へお手軽な方法を示しておきます。
[PhoenixアプリケーションをGitHub Codespaces上で開発する方法](https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92)で紹介した[GitHub Codespaces](https://github.co.jp/features/codespaces)を使うという方法です。

https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92

記事中で紹介している[phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer)を使うと、ElixirがインストールされたUbuntuコンテナが立ち上がるので、Ubuntu上で直接開発をしているかのように操作ができます。`iex`コマンドでREPL(Read-Eval-Print Loop)が立ち上がるのでこの記事のコード例をぜひ試してください。

![スクリーンショット 2024-11-02 14.11.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/303ee996-0b65-30c9-9b75-08d297b96f7a.png)

---

# まとめ

Pipeオペレーターを使いこなせば、データがまるでよく回る風車のように流れる一貫したコードが書けます。複数の処理を連結し、闘魂を込めた力強いコードを目指しましょう。

**「流れるように書けよ、書けばわかるさ！」**
