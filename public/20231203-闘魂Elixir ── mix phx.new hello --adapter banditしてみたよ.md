---
title: 闘魂Elixir ── mix phx.new hello --adapter banditしてみたよ
tags:
  - Elixir
  - Phoenix
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-04T14:00:22+09:00'
id: 70933c4b4e041d3d9ac0
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

[Elixir](https://elixir-lang.org/)の[アドベントカレンダー](https://qiita.com/advent-calendar/2023/elixir)を楽しんでいます。

https://qiita.com/piacerex/items/0c6ffb235e1146c38302#bandit

[Bandit](https://github.com/mtrudel/bandit)が[Phoenix](https://www.phoenixframework.org/)に標準搭載されたとのことを @piacerex さんの記事で知りました。

[Bandit](https://github.com/mtrudel/bandit)については以下の記事のようにLINEボットアプリ制作で使ったことがあります。

https://qiita.com/torifukukaiou/items/05255dc857ddd5a695ee

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# mix phx.new hello --adapter bandit

`mix phx.new hello --adapter bandit`というふうにした場合に、[Bandit](https://github.com/mtrudel/bandit)が採用されます。
`--adapter`オプションを指定しない場合のデフォルトは[cowboy](https://github.com/elixir-plug/plug_cowboy)です。

# `--adapter bandit`を付けて実行した場合と付けずに実行した場合の違いについて

`mix.exs`と`config/config.ex`の2箇所です。

```diff:mix.exs
-     {:plug_cowboy, "~> 2.5"}
      {:bandit, ">= 0.0.0"}
```

```diff:config/config.ex
config :hello, HelloWeb.Endpoint,
  url: [host: "localhost"],
- adapter: Phoenix.Endpoint.Cowboy2Adapter,
  adapter: Bandit.PhoenixAdapter,
```

この情報があれば、古いプロジェクトをアップグレードしてなおかつ[Bandit](https://github.com/mtrudel/bandit)に載せ替えることもできそうですね！
（アップグレードはそれなりにたいへんです）

# さいごに

`mix phx.new hello --adapter bandit`を試してみました。
`--adapter bandit`を付けて実行した場合と付けずに`mix phx.new`を実行した場合の差を示しました。

---

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
