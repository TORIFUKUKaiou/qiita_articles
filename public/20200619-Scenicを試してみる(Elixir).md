---
title: Scenicを試してみる(Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-06-19T08:40:39+09:00'
id: 0d2c63265aa2600bddd2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Scenic](https://hexdocs.pm/scenic/welcome.html) とは、いまこの時点ではなんのことかさっぱりわかっていません
- とにかくすごいらしいという噂をいままさに行われている[ElixirConf EU Virtual](https://virtual.elixirconf.eu/)でききました
    - 私は同時間帯に行われていた @zacky1972 先生の[Pelemay Updates](https://virtual.elixirconf.eu/talks/Pelemay-Updates/)を勉強していました
- Getting Started的なものをやってみます

```
macOS 10.15.5
elixir         1.10.3-otp-23
erlang         23.0.1 
```

# 準備
0. Erlang, Elixirをインストールしましょう
  - 手前味噌な記事ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)を参考にしてください
2. [依存関係を解決しましょう](https://hexdocs.pm/scenic/install_dependencies.html)
  - macOSの場合は[Homebrew](https://brew.sh/index_ja)で以下の感じです

```console
$ brew update
$ brew install glfw3 glew pkg-config
```

# [Getting Started](https://hexdocs.pm/scenic/getting_started.html#content)の通りにやってみる

```console
$ mix archive.install hex scenic_new
$ mix scenic.new my_app
$ cd my_app
$ mix deps.get
$ mix scenic.run
```

<img width="699" alt="スクリーンショット 2020-06-19 0.09.18.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a3479423-bc6b-6fc0-a8e2-3a1096cfad8e.png">

:tada::tada::tada:

デスクトップアプリケーションがつくれるようです！

> Scenic is a client application library written directly on the Elixir/Erlang/OTP stack. With it you can build applications that operate identically across all supported operating systems, including MacOS, Ubuntu, Nerves/Linux, and more.

# 応急処置的なこと
- 上記でうまくいくらしいのですが、私は`mix scenic.run`したときに発生する以下のエラーをなかなか解決できませんでした

```
23:59:25.590 [info]  Application my_app exited: MyApp.start(:normal, []) returned an error: shutdown: failed to start child: Scenic
    ** (EXIT) shutdown: failed to start child: Scenic.ViewPort.SupervisorTop
        ** (EXIT) shutdown: failed to start child: :main_viewport
            ** (EXIT) shutdown: failed to start child: Scenic.ViewPort.Driver.Supervisor
                ** (EXIT) an exception was raised:
                    ** (ArgumentError) The module Scenic.Driver.Glfw was given as a child to a supervisor but it does not exist.
                        (elixir) lib/supervisor.ex:629: Supervisor.init_child/1
                        (elixir) lib/enum.ex:1336: Enum."-map/2-lists^map/1-0-"/2
                        (elixir) lib/supervisor.ex:615: Supervisor.init/2
                        (stdlib) supervisor.erl:295: :supervisor.init/1
                        (stdlib) gen_server.erl:374: :gen_server.init_it/2
                        (stdlib) gen_server.erl:342: :gen_server.init_it/6
                        (stdlib) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
```

- 内容としては[Scenic.Driver.Glfw can't be found when run mix scenic.run #164](https://github.com/boydm/scenic/issues/164)と類似していて以下の解決策が示されています
    - 環境変数で`MIX_TARGET`を指定していたら消しなさい
        - 私はばっちり該当します
        - [Nerves](https://nerves-project.org/)をよくあつかうので環境変数に`rpi2`を入れていました
        - 消してターミナルを起動しなおしても解決せず、、、、 (やり方悪かったのかも)
    - `$ mix deps.compile scenic_driver_glfw`するといいよ
        - やってみると、そんなの知らんよ (`** (Mix) Unknown dependency scenic_driver_glfw for environment dev`) といわれる
        - なぜだかコンパイルの対象になっていないようです
        - これは大きな前進です！
        - そして同じような問題にぶち当たったときに問題の切り分けに使えそうです！

- これらをヒントに`mix.exs`で`targets: :host`を消してみました
    - ビンゴ :tada::tada::tada: 

```elixir:mix.exs
  defp deps do
    [
      {:scenic, "~> 0.10"},
      #{:scenic_driver_glfw, "~> 0.10", targets: :host},
      {:scenic_driver_glfw, "~> 0.10"},
    ]
  end
``` 

# Wrapping Up
- この記事は[Scenic](https://hexdocs.pm/scenic/welcome.html)を「とりあえず動かしてみました」しかできていません
- そのため「何がすごいのか」という生で聞いた方たちが興奮されていた部分をお伝えすることはできていません
    - そのうち動画が公開されるとおもうのでそちらをみてみようとおもいます
- [ElixirConf EU Virtual](https://virtual.elixirconf.eu/)は2019/6/19(日本時間21:00から。プレイベントが20:00から)もあります!
- **Enjoy!**


