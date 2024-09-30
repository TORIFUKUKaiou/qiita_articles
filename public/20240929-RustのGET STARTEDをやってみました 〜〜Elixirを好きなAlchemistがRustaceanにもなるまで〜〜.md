---
title: RustのGET STARTEDをやってみました 〜〜Elixirを好きなAlchemistがRustaceanにもなるまで〜〜
tags:
  - Rust
  - Elixir
  - 闘魂
  - AdventCalendar2024
  - HAW
private: false
updated_at: '2024-09-30T16:25:23+09:00'
id: a38274023ba547aac82c
organization_url_name: haw
slide: false
ignorePublish: false
---
# はじめに

[Rust](https://www.rust-lang.org/)に入門してみました。
動機は、会社の同僚が[Rust](https://www.rust-lang.org/)でQiita記事投稿キャンペーンに応募して **最優秀賞（Apple Watch）** を獲得したからです。選出理由に[Rust](https://www.rust-lang.org/)が挙げられていました。このビッグウェーブ🌊に乗るしかありません！

https://zine.qiita.com/event/202409-paiza/

![スクリーンショット 2024-09-29 9.44.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a5268eb8-b05c-da9d-3741-b427729dc561.png)

私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです。

## 最優秀賞記事

@haw_ohnuma さんが最優秀賞（Apple Watch）を受賞した記事です。

https://qiita.com/haw_ohnuma/items/534541678945d6b33fc0

## 入賞記事

私も入賞を果たしていました。

https://qiita.com/torifukukaiou/items/966b71497f04c7fb5882

:::note info
paizaさん、Qiitaさんありがとうございます！
:::

# GET STARTED !!!

まず[トップページ](https://www.rust-lang.org/)を読んでみます。
さらっと読んでみます。
おもしろそうです。「ワクワクすっぞっ！！」

# [Getting started](https://www.rust-lang.org/learn/get-started)

https://www.rust-lang.org/learn/get-started

ページを進めます。
その通りにやればできます。

手順が古くなるかもしれませんし、公式ページの単なるコピペを書いても仕方ないので、 **できました** ということを書いておきます。

## RustとElixirの対比

微妙に異なる部分はあるのだろうとは思いますが、[Getting started](https://www.rust-lang.org/learn/get-started)の中で出てきた用語のうち、Alchemistであるそこのあなたに向けて、[Elixir](https://elixir-lang.org/)で言うところの何にあたるのかを書いておきます。

| Rust | Elixir | コメント |
|:-|:-|:-|
| cargo  | mix   | プロジェクト作ったり依存関係を解決したりビルドしたりするツール（コマンド）|
| crates  | Hex  | ライブラリ |
| Cargo.toml | mix.exs | どのライブラリを取り込むかを書きます |
| https://crates.io/  | https://hex.pm/  | ライブラリが公開されているサイト |
| Rustacean | Alchemist | 使い手のこと |
| Ferris| いない!? | 非公認のマスコット。性別不明の蟹。　|

## もちろん「完全に理解しました！」

もちろん[例の意味](https://togetter.com/li/1268851)です。
[Getting started](https://www.rust-lang.org/learn/get-started)をそのままやると以下をターミナルに表示することができます。


```text
 __________________________
< Hello fellow Rustaceans! >
 --------------------------
        \
         \
            _~^~^~_
        \) /  o o  \ (/
          '_   -   _'
          / '-----' \
```

Ferrisがしゃべってくれます。

せっかくなのでちょっと違うことをしてみます。
`Cargo.toml`を変更してみます。

まずは[Getting started](https://www.rust-lang.org/learn/get-started)の通りに書いた場合です。

```toml:Cargo.toml
[dependencies]
ferris-says = "0.3.1"
```

[ferris-says](https://crates.io/crates/ferris-says)は、ライブラリです。
変更をしてみます。

```toml:Cargo.toml
[dependencies]
ferris-says = { version = "0.3.1", features = ["clippy"] }
```

`Cargo.toml`を変更したら、迷わず実行（`cargo run`）してみましょう！

```
 __________________________
< Hello fellow Rustaceans! >
 --------------------------
        \
         \
            __
           /  \
           |  |
           @  @
           |  |
           || |/
           || ||
           |\_/|
           \___
```

キャラクターが変わりました。
Clippy、君は一体だれ！？

GitHubで質問のやりとりを見つけました。

https://github.com/rust-lang/ferris-says/issues/37

---

# さいごに

[Rust](https://www.rust-lang.org/)のGET STARTEDをやってみました。
[Elixir](https://elixir-lang.org/)から[Rust](https://www.rust-lang.org/)に入門する方のお役に立てれば幸いわい<b><font color="red">$\huge{Y}$</font></b>です。


[Elixir](https://elixir-lang.org/)で同じことをするGET STARTEDを書いてみようと思っています（あくまでも思っています）。
