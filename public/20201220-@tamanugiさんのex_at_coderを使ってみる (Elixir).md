---
title: '@tamanugiさんのex_at_coderを使ってみる (Elixir)'
tags:
  - AtCoder
  - Elixir
private: false
updated_at: '2020-12-25T01:43:51+09:00'
id: 3cb86dede8aefa2cd7c0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は、「[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)」 **24日目**です。
前日は「[「動的計画法を使う問題をElixirで関数型っぽく解いてみる」のFibonacci3をガード節を使って書き直してみる](https://qiita.com/torifukukaiou/items/5cb11e04d3041b6ac3ca)」でした。


---

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang:
- @tamanugiさんが、[AtCoder](https://atcoder.jp/)をやるのに便利なHexを作られましたので使ってみたいとおもいます
    - [AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d) -- [Elixir Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir)
    - [ex_at_coder](https://hex.pm/packages/ex_at_coder)

## What is [AtCoder](https://atcoder.jp/)?
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、最近はじめました

# プロジェクト作成

```
$ mkdir awesome_at_coder
$ cd awesome_at_coder
$ asdf local elixir 1.10.2-otp-22
$ mix new .
```
- 2020/12/20現在、[AtCoder](https://atcoder.jp/)で使える[Elixir](https://elixir-lang.org/)のバージョンが`1.10.2`なのであわせています
    - あ、私は[asdf](https://asdf-vm.com/#/)でバージョンの切り替えを行っています

```elixir:mix.exs
  defp deps do
    [
      {:ex_at_coder, ">0.0.0"}
    ]
  end
```

```
$ mix deps.get
```

- 準備は整いました :tada::tada::tada:

# https://atcoder.jp/contests/abc185 をやってみます

```
$ mix atcoder.new abc185

==> awesome_at_coder
* creating lib/abc185
* creating lib/abc185/a.ex
* creating lib/abc185/test_case
* creating lib/abc185/test_case/a.yml
* creating lib/abc185/b.ex
* creating lib/abc185/test_case/b.yml
* creating lib/abc185/c.ex
* creating lib/abc185/test_case/c.yml
* creating lib/abc185/d.ex
* creating lib/abc185/test_case/d.yml
* creating lib/abc185/e.ex
* creating lib/abc185/test_case/e.yml
* creating lib/abc185/f.ex
* creating lib/abc185/test_case/f.yml
✨ Generate code for abc185
👍 Good Luck
```

- すごい! すごい! 
- 問題ページからテストケースが作成されたっぽい
- 今回は使っていませんが、以下の機能があります
    - ログインができる
        - 今回は過去問なのでログインしませんでした
        - 詳しくは[AtCoder用のmixタスクを作ってみた -- ログイン](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d#%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3) をご参照ください
    - 提出用ファイルの雛形を自分の好みにカスタマイズすることができる
        - 詳しくは[AtCoder用のmixタスクを作ってみた -- 提出用コードの作成](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d#%E6%8F%90%E5%87%BA%E7%94%A8%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AE%E4%BD%9C%E6%88%90) をご参照ください
- とりあえずA問題のテストを実施してみます


```elixir
$ mix atcoder.test abc185 a
abc185 a
running 2 test...
-------------------------------------
sample1  WA  0ms
actual:

expected:
3
-------------------------------------
sample2  WA  0ms
actual:

expected:
1
```

# [A - ABC Preparation](https://atcoder.jp/contests/abc185/tasks/abc185_a)を解く
- ここからは自分の力を信じてがんばるしかありません
- がんばってみましょう 💪
- 問題文はリンク先をご参照ください

## 問題をブラウザで開くコマンド :rocket::rocket::rocket:

```
mix atcoder.open abc185 a
...
==> browser_launcher
warning: the dependency :browser_launcher requires Elixir "~> 1.11" but you are running on v1.10.2
Compiling 1 file (.ex)
Generated browser_launcher app
...
✨ Open URL for abc185 a
```

- これは貢献のチャンスか:interrobang:

## ひとりごと
<details><summary>自分で解きたい人はみないでください</summary>
ふむふむ、4つ整数を読み取って最小のものを答えにすればいいのだな
こんな感じだな
![スクリーンショット 2020-12-20 20.53.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/89d88436-cef7-ea4d-a853-09ef0cf12592.png)
コードスニペット貼るとうまく折りたたまれなかったので画像です
</details> 

## ソースコードができたらもう一回テストしてみましょう

```elixir
$ mix atcoder.test abc185 a
abc185 a
running 2 test...
-------------------------------------
sample1  AC  0ms
actual:
3
expected:
3
-------------------------------------
sample2  AC  0ms
actual:
1
expected:
1
```

- やったね :tada::tada::tada:
- これで自信をもって提出できます :rocket::rocket::rocket:

# 提出
- モジュール名を`Abc185.A.Main` => `Main`に変えて提出
- ここ手動でコピペしちゃいました
    - いまのところは、それでよいのですよね:interrobang:
    - 提出用コマンドがありましたらごめんなさい:relaxed:
- [提出結果](https://atcoder.jp/contests/abc185/submissions/18909882)
    - やったね :tada::tada::tada:

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- すごいです！　便利です！
- 問題文をスクレイピングして自動でテストケース作ってくれて<font color="purple">ありがとナイス:flag_cn:</font>です
    - スクレイピングしてテストケース作成しているのは、たぶん: https://github.com/tamanugi/ex_at_coder/blob/6975990d2c188039722df9e00050087462d2a0c7/lib/ex_at_coder/repo.ex このへん
- 私は「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」という記事を書いたことがあります
    - この記事では[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書いて解いていきましょう！　みたいなことを**すゝめ**ています
    - 手動で作っています
    - 私は、**いつも手動です**
    - **いつもいつもいつも手動です**
    - [AtCoder](https://atcoder.jp/)をやったことある人ならわかるとおもいますが、コピペで[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書くにはつらいInputやOutputがあるわけです
    - それでもコピペでできるので、いつも同じことを繰り返していました
- こんなところをちょっと立ち止まって自動化してみよう！ という発想ができることがうらやましいです
    - 私はこういうことがそもそも思いつかない頭の回路になっているようです :japanese_ogre:
    - 育っててきた環境が違うから好き嫌いは否めない セロリが好きだったりするのね :microphone::microphone::microphone:
    - @kentaro さんのブラウザを開くことをタスクにするプルリクが採用されています！
    - [`mix atcoder.open`タスクを追加します #1](https://github.com/tamanugi/ex_at_coder/pull/1)
    - **私はなんの疑問も持たずにブラウザを手動でダブルクリックしていました**
    - [browser_launcher](https://hex.pm/packages/browser_launcher) こんなHexあったんだー　とおもってのぞきにいったら、これは@kentaro さん作でした！
    - 期せずして、私にはやっぱりこういう発想ができないことが証明されました :rocket::rocket::rocket: 
- そして思いついた不便を解消することを実現されている! 
    - ただただすごいです！
- [tamanugi/ex_at_coder](https://github.com/tamanugi/ex_at_coder)のソースコードは斜め読みくらいしかできていませんが、キレイに書かれていてやっていることはだいたいわかった(何、目線:sunglasses::interrobang:)ので、これからも使っていってもしなにかあったら[Issues](https://github.com/tamanugi/ex_at_coder/issues)をあげるとともにできることなら改善案もご提案したいとおもっています :rocket::rocket::rocket: (もしなにかあったら)
    - **おもっています** (あくまでも、**おもっています**)
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:
