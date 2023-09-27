---
title: Elixir 標準modulesの追加
tags:
  - Elixir
private: false
updated_at: '2019-09-29T15:15:05+09:00'
id: 073204626e04aa123ae1
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- 2019/9/29(日)
- [tokyo.ex#13 elixir本体ソースコードもくもくリード会](https://beam-lang.connpass.com/event/148476/) に参加
    - [fukuoka.ex#30:tokyo.exとコラボ、Elixir本体コード読込会（リモートのみ）](https://fukuokaex.connpass.com/event/148581/)
    - こちらに参加
- はじめにすごく丁寧な説明がありました!
- ありがとうございます!
    - Elixirのソースコードとの向き合い方
    - Makeの解説

# 資料
- ありがとうございます :bow: :bow: :bow: 
- https://twitter.com/hayabusa333/status/1178172246591885312
  - [@hayabusa333](https://twitter.com/hayabusa333) さま
- https://twitter.com/ohrdev/status/1178150005544144897
  - [@ohrdev](https://twitter.com/ohrdev) さま

# 作業
- MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)を使用
- [Homebrew](https://brew.sh/index_ja)でelixir 1.9.1がインストールされていた
- その他にもXCodeとかがインストールされていたのでコンパイルに必要なものはあらかじめ揃っていたようにおもう

```
$ git clone https://github.com/elixir-lang/elixir.git
$ git checkout -b feature/awesome v1.9.1
```

# 変更したソースコード
```txt:VERSION
1.9.1-awesome
```
- ↑↑↑ ルートディレクトリに `VERSION` というファイルがあるので書き換え

```Elixir:lib/elixir/lib/awesome.ex
defmodule Awesome do
  def greet() do
    "Although I am not not not the most important, My name is Awesome.\nYou call me Osamu.\n@torifukukaiou is my Twitter account.\nYes, I was born to love Elixir!!!\nHow wonderful life is while Elixir is in the world!!!"
  end
end
```
- ↑↑↑ ファイルを追加
- 追加しただけ！

# ビルド
```
$ make
```
- 私は事前に `make test` していたせいか？　なんかエラーがでたので `make clean` しました

# 実行

<img width="919" alt="スクリーンショット 2019-09-29 15.09.49.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5c035eb1-4748-0eaf-28d4-f1f271c676c0.png">

- バージョンかわったし、Awesomeというmoduleを追加できました！


