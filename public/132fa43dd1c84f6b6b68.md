---
title: 闘魂Elixir ーー 書籍『Elixir実践入門』のご紹介（書きました！）
tags:
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-05-22T11:58:10+09:00'
id: 132fa43dd1c84f6b6b68
organization_url_name: haw
slide: true
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


---

# はじめに

2024年5月21日(火)に、「[e-ZUKA Tech Night vol.62 -STORES襲来！-](https://ezukatechnight.doorkeeper.jp/events/171990)」というイベントが行われます。

本資料は、そのイベントでの私のLT(Lightning Talks)で使う資料です。
LT(Lightning Talks)とは、短いプレゼンテーションです。[^1]
[e-ZUKA Tech Night](https://ezukatechnight.doorkeeper.jp/)では、5分となっております。

(テックイベントに初参加の新入生などがいるのでLTとは何かを注釈しています。)

[^1]: テックイベントに初参加の新入生などがいるのでLTとは何かを注釈しています。

---

# 自己紹介

- 九州工業大学 情報工学部 機械システム工学科
- 学籍番号「**97**234070」(1997年に入学という意味です)
- 名乗るほどのものではございません
- [Elixir](https://elixir-lang.org/) ConfのTシャツを着てきました（USには行っていません。通販で買いました）

---

# 書籍『[Elixir実践入門](https://gihyo.jp/book/2024/978-4-297-14014-4)』

- 2024年2月24日発売
- 技術評論社さん
- 名乗るほどのものでもない私の名前「山内修」が執筆陣に並んでいます（つまりは、書きました！）

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ebf96eb4-e3ba-ebb5-8d9d-54a1b0863a36.png)

---

# What is [Elixir](https://elixir-lang.org/)?

- 関数型言語（Haskellは、関数型言語）
- Erlang VMの上で動く
- 並列処理に優れている
- 耐障害性を備えている
- アクターモデル
- Rubyの弟分

（なにを言っているのかわかりませんね）

---

# 論よりRun🚀🚀🚀

## 黒い画面編

[Docker](https://www.docker.com/)を使ってイゴかします（※西日本地域の方言で「動かします」の意です）。

```bash
docker pull hexpm/elixir:1.16.2-erlang-26.2.5-alpine-3.17.7

docker run --rm -it hexpm/elixir:1.16.2-erlang-26.2.5-alpine-3.17.7
```

コンテナが立ち上がったら、[IEx](https://hexdocs.pm/iex/1.16.2/IEx.html)という interactive shellを起動します。


```bash
/ # iex
```

---

以下のプログラムを**迷わず**打ち込んでください。
（迷わず行けよ　行けばわかるさ）

```elixir
iex> Mix.install([{:req, "~> 0.4.0"}])

iex> "https://qiita.com/api/v2/items?query=tag:Elixir"
|> Req.get!(pool_timeout: 50000, receive_timeout: 50000)
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))
```

[Req](https://github.com/wojtekmach/req)はHTTPクライアントライブラリです。

[|>](https://hexdocs.pm/elixir/1.16.2/Kernel.html#%7C%3E/2)は、パイプ演算子と呼ばれます。前の計算結果を次の関数の第1引数に入れて実行してくれます。

`Elixir`タグが付いた直近20件のQiita記事を取得するプログラムです。

---

## Livebook編

当日のデモはこちらでします。

```bash
docker run --rm -p 8080:8080 -p 8081:8081 --pull always ghcr.io/livebook-dev/livebook
```

Visit: http://localhost:8080/?token=secret

※ `secret`は実行の都度ランダムに変わりますので、実行ログをよく見てください。

New notebook

```elixir:setupセル
Mix.install([
  {:kino, "~> 0.12.3"},
  {:req, "~> 0.4.0"}
])
```

```elixir:Elixirセル
"https://dog.ceo/api/breeds/image/random"
|> Req.get!()
|> Map.get(:body)
|> Map.get("message")
|> Req.get!()
|> Map.get(:body)
#|> dbg()
```

---

迷わず実行（evalutate: 評価)してください。
いろいろな犬の絵がランダムに表示されます。


![スクリーンショット 2024-05-21 14.02.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b8923673-9bd3-c42d-fe8b-e1eddf7d3a8d.png)

---

`dbg()`を有効にすると、各関数が実行（評価）されたところまでの結果を確認できます。

![スクリーンショット 2024-05-21 14.06.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7c82dc1b-e30e-4337-7ae3-5820f4e8c9fa.png)



---

# さいごに

関数型言語を何かひとつ習得しておくと、あなたのコーディングスキルの幅を広げてくれるでしょう。
そんな方に[Elixir](https://elixir-lang.org/)はお勧めです。そして、その入門書に書籍『[Elixir実践入門](https://gihyo.jp/book/2024/978-4-297-14014-4)』をお勧めします。この本では、**基本文法の説明から丁寧に**はじめて、Web開発、機械学習、IoTへと実践を進めて行く、頼もしいガイドです。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ebf96eb4-e3ba-ebb5-8d9d-54a1b0863a36.png)

---

私たち[ハウインターナショナル](https://www.haw.co.jp/)には、私を含め書籍の著者となっている人がゴロゴロ在籍しています。
あなたのLTをお待ちしております。あなたの話をぜひ聞かせてください。

![会社紹介-2024-04-19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/da1e15a7-8c40-0a1c-a380-2fd0f493b98f.png)

---

## 編集後記

このあと、 @tsuruoka91 さん、 @mnishiguchi さんの発表が続きました。 


---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
