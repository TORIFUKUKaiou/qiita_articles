---
title: >-
  闘魂Elixir ──
  ファイル名から拡張子を除いた`basename`や拡張子だけを取り出したいときにはPathモジュールを使いましょう（Fileモジュールではありませんよ）
tags:
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-11-26T09:49:37+09:00'
id: 0d0c62176b964fcd3812
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>



# はじめに

[Elixir](https://elixir-lang.org/)で、ファイル名から拡張子を除いた`basename`や拡張子だけを取り出したいときありますよね。
そんなときは **[Path](https://hexdocs.pm/elixir/Path.html)モジュール** を使いましょう。
[File](https://hexdocs.pm/elixir/File.html)モジュールではありませんよ、**[Path](https://hexdocs.pm/elixir/Path.html)モジュール**ですよ！　という話です。

**[Path](https://hexdocs.pm/elixir/Path.html)モジュール**とこれから仲良くなるために記録を残しておきます。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [Path](https://hexdocs.pm/elixir/Path.html)モジュール

知っている人は知っていることでしょう。`basename`や`extname`を取り出す関数が用意されているのは[Path](https://hexdocs.pm/elixir/Path.html)モジュールです。
しかしながら私はこれを知らずに[File](https://hexdocs.pm/elixir/File.html)モジュールだろうとあたりを付けてドキュメントをくまなく読んでみましたがありません。
それで自分用のスクリプトでへんなファイルも無いし、[String.split/3](https://hexdocs.pm/elixir/String.html#split/3)で雑に書くことをよくやっていました。

```elixir
[basename, ".heic"] = String.split(path, ".")
```

`basename`のほうに`.`があるような意地悪な環境下では動きそうにありません。みんなどうやってやっているのだろうなあ？　とふと疑問におもいました。

## [Path](https://hexdocs.pm/elixir/Path.html)モジュールとの出会い

[Hex](https://hex.pm)を探してみましたがそんな大掛かりなものではなさそうです。
それで次にやったのが「Ruby ファイル名 拡張子」でググることです。そうするとFileクラスが見つかって、`extname`や`basename`というメソッドを見つけました。
次に「Elixir extname basename」でググって、[Path](https://hexdocs.pm/elixir/Path.html)モジュールにたどり着いたというわけです。
ですから、先輩のRubyでまずググってみてRubyで用意されているメソッドに該当する関数を探すというのはよい方法なのではないかとおもいました。
小話です。

## [Path.basename/2](https://hexdocs.pm/elixir/Path.html#basename/2)

[Path.basename/2](https://hexdocs.pm/elixir/Path.html#basename/2)の実行例です。

```elixir
iex> Path.basename("~/foo/bar.ex", ".ex")
"bar"

iex> Path.basename("~/foo/bar.exs", ".ex")
"bar.exs"

iex> Path.basename("~/foo/bar.old.ex", ".ex")
"bar.old"
```

## [Path.extname/1](https://hexdocs.pm/elixir/Path.html#extname/1)

[Path.extname/1](https://hexdocs.pm/elixir/Path.html#extname/1)の実行例です。

```elixir
iex> Path.extname("foo.erl")
".erl"

iex> Path.extname("~/foo/bar")
""

iex> Path.extname(".gitignore")
""
```


# さいごに

ファイル名から拡張子を除いた`basename`や拡張子だけを取り出したいときには、**[Path](https://hexdocs.pm/elixir/Path.html)モジュール**を使いましょう。
[File](https://hexdocs.pm/elixir/File.html)モジュールではありませんよ、**[Path](https://hexdocs.pm/elixir/Path.html)モジュール**ですよ！　という話をしました。
Elixirでどのモジュールにあるのかわからないときは先輩のRubyのメソッド名が参考になるかもしれませんよという話をあわせて書きました。


人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
