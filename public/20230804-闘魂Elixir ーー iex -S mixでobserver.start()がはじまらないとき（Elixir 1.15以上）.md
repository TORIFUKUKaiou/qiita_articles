---
title: '闘魂Elixir ーー iex -S mixで:observer.start()がはじまらないとき（Elixir 1.15以上）'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-08-05T10:02:50+09:00'
id: 79cce2cac57221c47175
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

[Elixir](https://elixir-lang.org/)という素敵な関数型言語の話をします。
[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)の話です。

```elixir
iex> :observer.start()
```

をするとなんだかカッコいいヤツが立ち上がります。
カッコいいんです。カッコいいことだけは断言します。

![スクリーンショット 2023-08-04 8.26.02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/42efe7ce-d5fa-075b-061e-3ee1b6ca8b14.png)

[Elixir](https://elixir-lang.org/) 1.15以上で、`mix new my_app`したプロジェクトで`iex -S mix`とした状態では、**[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)ができないのです**。
`iex`だけで起動したときには、[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)できます。
どんな**特殊な**環境構築をしたんだと自分を疑いたくなります。

この記事は、 @pojiro さんと @takasehideki 先生のおかげでできています。
**ありがとうーーーーッ！！！**　でございます。

# 結論

結論です。`mix.exs`に少し追記が必要です。
私が**特殊な**環境構築をしたわけではなく、1.15からはそういうものなのだそうです。

```elixir:mix.exs
defmodule MyApp.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_app,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :observer, :wx, :runtime_tools] # 変更
    ]
  end
```

これで、`iex -S mix`としたあとにちゃんと[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)ですます。
やったね:tada::tada::tada::tada:

https://stackoverflow.com/questions/76796846/can-not-start-observer-in-phx-server

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Elixir 1.15.4 で :observer.start できないはこれ<a href="https://t.co/dQprMWA41D">https://t.co/dQprMWA41D</a></p>&mdash; 衣川亮太💉💉 💉💉, ソフトウェア開発を行う Tombo Works 代表 (@pojiro3) <a href="https://twitter.com/pojiro3/status/1686961954479575040?ref_src=twsrc%5Etfw">August 3, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

@takasehideki 先生から、 @pojiro さんのツイートを教えてもらいました。
改めまして**ありがとうーーーーッ！！！**　でございます。

# さいごに

[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)の話を書きました。
[Elixir](https://elixir-lang.org/) 1.15以上で[:observer.start/0](https://www.erlang.org/doc/man/observer#start-0)ができぬぞ！　という方はお試しください。

また他に立ち上がらない原因としては、Erlangのビルド時に`wx`が足りていないとかが考えられます。
M1/M2 Macの場合は、こちらの @zacky1972 先生の記事を参考にするとよいでしょう。

https://qiita.com/zacky1972/items/c94baef2ee9379c21fa1


私の記事は**みなさまの叡智**から成り立っております。
みなさまというのはここでお名前を挙げたお三方は当然のこととして、[stack overflow](https://stackoverflow.com/questions/76796846/can-not-start-observer-in-phx-server)に書き込まれた方、そのまわりにいらっしゃる親戚、ご友人や[Elixir](https://elixir-lang.org/)の作者、技術記事を書く場を提供してくださっているQiita株式会社さま、コンピュータを発明した方、その原理を提唱された方、つまりは**全人類**に感謝です。
**ありがとうーーーーッ！！！** でございます。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
