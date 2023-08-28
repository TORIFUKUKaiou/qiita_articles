---
title: Scenic with Nerves(Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-06-24T00:43:57+09:00'
id: 3c2ff39e5a20cba3e62f
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Scenic](https://hexdocs.pm/scenic/welcome.html)は、Elixir/Erlang/OTP stackで直接書けるアプリケーションフレームワークです
- [Nerves](https://hexdocs.pm/nerves/getting-started.html)は、ElixirのIoTでナウでヤングなcoolなすごいヤツ！ です

# 準備(公式)
- [Scenic](https://hexdocs.pm/scenic/install_dependencies.html#content)
- [Nerves](https://hexdocs.pm/nerves/installation.html#content)

## 参考記事
- [Scenicを試してみる(Elixir)](https://qiita.com/torifukukaiou/items/0d2c63265aa2600bddd2)
- [ElixirでIoT#4.1：Nerves開発環境の準備（2020年4月版）](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- [ElixirでIoT#4.1.1：WSL 2でNerves開発環境を整備する](https://qiita.com/takasehideki/items/b8ea8b3455c70398178a)

## 私が使ったバージョン
```
$ asdf current
erlang 23.0.1
elixir 1.10.3-otp-23
```

- (注) 2020/6/23 時点でNervesの[公式](https://hexdocs.pm/nerves/installation.html#all-platforms)に書いてあるバージョンと異なっています
    - [@matsujirushi12](https://twitter.com/matsujirushi12)さんの「[これだ。This release updates the system to use Buildroot 2020.05 and Erlang/OTP 23.](https://twitter.com/matsujirushi12/status/1274691931608473601)」
    - ↑こちらにありますように私がやったときにも[Erlang](https://www.erlang.org/)が23を求められたので上記のバージョンでやっています

# [Getting Started with Nerves](https://hexdocs.pm/scenic/getting_started_nerves.html#content)を参考になぞってみる

```
$ mix scenic.new.nerves my_app
$ cd my_app
$ export MIX_TARGET=rpi2
```

- `mix scenic.new.nerves`したときに`config/rpi3.exs`はできてはいます
- 私はRaspberry Pi 2しかもっていない。。。
- `config/rpi2.exs`がない状態で`mix deps.get`すると、以下のエラーが発生しました

```
$ mix deps.get
** (Code.LoadError) could not load /Users/torifuku/Documents/13_Elixir/Scenic_with_Nerves/my_app/config/rpi2.exs
    (elixir 1.10.3) lib/code.ex:1397: Code.find_file/2
    (elixir 1.10.3) lib/code.ex:871: Code.eval_file/2
    (mix 1.10.3) lib/mix/config.ex:158: anonymous fn/2 in Mix.Config.__import__!/2
    (elixir 1.10.3) lib/enum.ex:2111: Enum."-reduce/3-lists^foldl/2-0-"/3
    (mix 1.10.3) lib/mix/config.ex:157: Mix.Config.__import__!/2
    (stdlib 3.12.1) erl_eval.erl:680: :erl_eval.do_apply/6
```

- 気を取り直して
- コピーすればいいのだろう、きっと！ :rocket: 

```
$ cp config/rpi3.exs config/rpi2.exs 
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```


- こんがりやきあがったmicroSDカード:fire::fire::fire:をRaspberry Pi 2に差し込んで、HDMIでテレビ:tv:とつなげてみました
- `lib/scenes/sys_info.ex`にかいてある文字列がテレビ:tv:に写りました！

```
MIX_TARGET: rpi2
MIX_ENV: dev
Scenic version: 0.10.2
```

```
Please note: because Scenic
draws over the entire screen
in Nerves, IEx has been routed
to the UART pins.
```

# Wrapping Up
- とりあえず(たぶん)、Nerves上でScenicを動かせました :rocket::rocket::rocket: 
- **Enjoy!**
