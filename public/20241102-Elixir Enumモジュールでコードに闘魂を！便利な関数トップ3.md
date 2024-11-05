---
title: Elixir Enumモジュールでコードに闘魂を！便利な関数トップ3
tags:
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-11-05T11:23:13+09:00'
id: 70e47983b517fbe8d516
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

![DALL·E 2024-11-02 14.24.45 - .jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/159a9f74-8d96-f40a-aef4-b06d8b40a941.jpeg)


# はじめに

[Elixir](https://elixir-lang.org/)の[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールは、リストやマップなどのコレクションを扱う際に非常に便利です。本記事では、日常のプログラムで役立つ[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2), [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2), [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)の3つの関数を例を交えながら解説します。それぞれの関数はElixirのコードをシンプルかつ効率的に書くために欠かせない存在です。
独断と偏見ですがよく使います！

# 1. `Enum.map/2`でリストの要素を変換する

`Enum.map/2`はリスト内の各要素を順番に処理し、新しいリストを生成する関数です。使い方は、変換したいリストと処理を行う無名関数を渡すだけです。

### 例: 値を2倍にする

以下のコードはリスト内の値を2倍に変換します。

```elixir
list = [1, 2, 3, 4]
new_list = Enum.map(list, fn x -> x * 2 end)
```

### 実行結果

実行結果は次のようになります。

```elixir
[2, 4, 6, 8]
```

### 解説

`Enum.map/2`は、リストの要素ごとに無名関数`fn x -> x * 2 end`を適用し、新しいリストを返しています。このように簡潔に変換処理を行えるため、データの加工に便利です。

ちなみに無名関数は`& &1 * 2`とも書けます。この書き方もよく見かけるので覚えておくとよいでしょう。


---

# 2. `Enum.filter/2`で条件に合う要素を選択する

`Enum.filter/2`は、リストの要素の中から指定した条件に合う要素だけを抽出する関数です。リストとフィルターを行う無名関数を渡すと、新しいリストが返ってきます。

### 例: 偶数だけを抽出する

以下のコードは、リストの中から偶数のみを抽出します。

```elixir
list = [1, 2, 3, 4, 5, 6]
even_list = Enum.filter(list, fn x -> rem(x, 2) == 0 end)
```

### 実行結果

実行結果は次のようになります。

```elixir
[2, 4, 6]
```

### 解説

`Enum.filter/2`は、各要素を無名関数`fn x -> rem(x, 2) == 0 end`で偶数かどうかを確認し、条件を満たす（つまり偶数である）要素だけをリストに残しています。条件に合うデータだけを取り出したいときに非常に便利です。

---

# 3. `Enum.reduce/3`でリストを畳み込む

[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)はElixirの最初の鬼門です。専門家の間では畳み込みと呼ばれます。
`Enum.reduce/3`は、リストの全ての要素を他の表現へ畳み込む関数です。これまでみてきた`Enum.map/2`と`Enum.filter/2`はリストが得られていました。それに対して`Enum.reduce/3`は、初期値と処理を行う関数を渡すことで、他の型のデータを作ることができます。

### 例: リスト内の要素の出現回数を数える

以下のコードでは、リスト内の要素(アトム)の出現回数を数えてマップを返しています。

```elixir
list = [:inoki, :baba, :inoki, :baba, :inoki]
Enum.reduce(list, %{}, fn e, acc -> Map.update(acc, e, 1, & &1 + 1) end)
```

### 実行結果

実行結果は次のようになります。

```elixir
%{inoki: 3, baba: 2}
```


### 解説

ここでは、`Enum.reduce/3`に初期値として空のマップ`%{}`と無名関数`fn e, acc -> Map.update(acc, e, 1, & &1 + 1)`を渡し、リスト内の要素を次々と数えています。
無名関数の第1引数`e`はリストの要素です。第2引数の`acc`はアキュムレータと呼ばれるもので直前までの無名関数の評価結果です。最初は初期値の空のマップ`%{}`が入っています。具体的には以下のように更新されていきます。

| Index | e | acc | 評価結果 |
|:-:|:-:|:-:|:-:|
| 0  | `:inoki`  | `%{}`  | `%{inoki: 1}` |
| 1  | `:baba`  | `%{inoki: 1}`  |`%{inoki: 1, baba: 1}` |
| 2  | `:inoki`  | `%{inoki: 1, baba: 1}`  |`%{inoki: 2, baba: 1}` |
| 3  | `:baba`  | `%{inoki: 2, baba: 1}` |`%{inoki: 2, baba: 2}` |
| 4  | `:inoki`  | `%{inoki: 2, baba: 2}` |`%{inoki: 3, baba: 2}` |


[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)は、集約処理や合計計算などに役立つ関数です。

ちなみにこの例と同じことは、[Enum.frequencies/1](https://hexdocs.pm/elixir/Enum.html#frequencies/1)一発でできることを付記しておきます。


---

# どうやって実行するんだー！？　バカヤローって方へ

GitHubのアカウントをお持ちの方へお手軽な方法を示しておきます。
[PhoenixアプリケーションをGitHub Codespaces上で開発する方法](https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92)で紹介した[GitHub Codespaces](https://github.co.jp/features/codespaces)を使うという方法です。

https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92

記事中で紹介している[phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer)を使うと、ElixirがインストールされたUbuntuコンテナが立ち上がるので、Ubuntu上で直接開発をしているかのように操作ができます。`iex`コマンドでREPL(Read-Eval-Print Loop)が立ち上がるのでこの記事のコード例をぜひ試してください。

![スクリーンショット 2024-11-02 14.11.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/303ee996-0b65-30c9-9b75-08d297b96f7a.png)


---

# まとめ

Elixirの`Enum`モジュールには、データ操作をシンプルにしてくれる便利な関数が揃っています。今回紹介した`Enum.map/2`, `Enum.filter/2`, `Enum.reduce/3`は特に日常的によく使うデータ処理や変換に不可欠な存在です。

**一手一手に闘魂を込めて、シンプルで力強いコードを書いていきましょう！**

