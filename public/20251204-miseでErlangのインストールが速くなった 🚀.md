---
title: "miseでErlangのインストールが速くなった \U0001F680"
tags:
  - Erlang
  - Elixir
  - 闘魂
  - mise
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-04T21:15:16+09:00'
id: f9884c0c71f2cc817fa6
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに
[mise](https://mise.jdx.dev/)で[Elixir](https://elixir-lang.org/)、[Erlang](https://www.erlang.org/)のバージョン管理をする人が増えています。Elixirを楽しむためにはErlangのインストールは避けては通れません。

以前は、[asdf](https://asdf-vm.com/)推しの方が多かったように思います。私は、[mise](https://mise.jdx.dev/)を使いはじめました。Erlangのインストールが、asdfを使っていたころと比べて格段に速くなったのでそのことを書いておきます。

## miseは何と読むの？
そもそも、[mise](https://mise.jdx.dev/)はどう読むのでしょうか。公式ページに答えがあります。

https://mise.jdx.dev/about.html のページによりますと、`pronounced "meez"`だそうです。
カタカナで表記すると、 **ミーズ** でよろしいでしょうか。

## Erlangのインストールが速くなった 🚀
ビルド済のバイナリをダウンロードしているからです。asdfでは、ソースコードを自マシンでビルドしていました。そしてビルドに必要なものを揃えたり、設定したりするのが一苦労必要でした。miseはできあがりのバイナリをダウンロードしているので速いわけです。

https://github.com/jdx/mise/blob/5f2805813056ded286636995309766c86204ea6c/src/plugins/core/erlang.rs#L122-L132

hex.pm とは、みなさんが`mix deps.get`するときに知らずしらずのうちにお世話になっているはずのあのサーバです。

https://elixir-lang.org/install.sh という、[Phoenix Express](https://hexdocs.pm/phoenix/up_and_running.html#phoenix-express)の中から利用されているスクリプトがあります。 `https://elixir-lang.org/` の直下においてあるのです。その `install.sh` の中にも、 `url="https://builds.hex.pm/builds/otp/${arch}/ubuntu-${lts}/$otp_tgz"`なるものが見え、`hex.pm`は文字通り由緒正しきものです。

## さいごに
Erlangのインストールが速くて、詰まらなくなったのは感動です。きっとダウンロードしているのだろうとあたりをつけ、どこからダウンロードしているのだろうと気になって調べてみました。由緒正しきところからの贈りものでした。アドベントカレンダーとひっかけると、最高のクリスマスプレゼントでした。
