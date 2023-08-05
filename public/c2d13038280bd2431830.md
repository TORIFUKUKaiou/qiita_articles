---
title: >-
  [Elixir] System.get_env/2で読みだした環境変数をModule
  attributeに入れておいて一度実行したあと、環境変数を書き換えてもModule
  attributeの値が変わらないなあとおもったら、それ再コンパイルが必要
tags:
  - Elixir
private: false
updated_at: '2020-10-17T11:38:47+09:00'
id: c2d13038280bd2431830
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 2020/10/17(土)に行われた[【オンライン】kokura.ex#14：Elixirもくもく会～入門もあるよ（9:30~）祝１周年！](https://fukuokaex.connpass.com/event/191857/)に参加して書きました
    - @im_miolab さん、ありがとうございます！
    - 2019/01/25(金)に行われた[kokura.ex#1：小倉Elixirコミュニティ発足【セッション／LTと懇親会】](https://fukuokaex.connpass.com/event/116855/)に参加してから私は[Elixir](https://elixir-lang.org/)と出会いました
    - 当日は`brew install elixir`でインストールした[Elixir](https://elixir-lang.org/)でIExで`Hello, world`だけ行った経験だけでしたが、思い切ってLTをした思い出があります
- 標題の件で何度もあれれ？　となったのでいい加減同じことで詰まらないように記事にしておきます

# インストール
- まずは[Elixir](https://elixir-lang.org/)をインストールしましょう
- 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください

# mix new
- 適当にプロジェクトを作ります

```
$ mix new hello_env
* creating README.md
* creating .formatter.exs
* creating .gitignore
* creating mix.exs
* creating lib
* creating lib/hello_env.ex
* creating test
* creating test/test_helper.exs
* creating test/hello_env_test.exs

Your Mix project was created successfully.
You can use "mix" to compile it, test it, and more:

    cd hello_env
    mix test

Run "mix help" for more commands.
```

# [System.get_env/2](https://hexdocs.pm/elixir/System.html#get_env/2)で環境変数を読み出して[Module attribute](https://elixir-lang.org/getting-started/module-attributes.html)に格納しておくモジュールを作ります

```elixir:lib/hello_env.ex
defmodule HelloEnv do
  @greet System.get_env("AWESOME_ENVIRONMENT_VARIABLE")

  def greet do
    @greet
  end
end

```

# 環境変数を設定します
- 私はAppleに言われるままにzshを使っています
- お使いの環境にあわせていい感じのファイルに書いてください(~/.profileや~/.bash_profile等)

```zsh:.zshenv
export AWESOME_ENVIRONMENT_VARIABLE="I was born to love Elixir."
```

# 実行します

```elixir
$ source ~/.zshenv
$ cd hello_env
$ iex -S mix      
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)
Generated hello_env app
Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> HelloEnv.greet
"I was born to love Elixir."
```

- いいね :thumbsup: 

# `AWESOME_ENVIRONMENT_VARIABLE`を変えたくなりました

- IExを終わらせます

```
iex(2)> System.halt
```

- 環境変数を変更します

```zsh:.zshenv
export AWESOME_ENVIRONMENT_VARIABLE="I was born to love Elixir. We are the Alchemists, my friends."
```


```elixir
$ source ~/.zshenv
$ iex -S mix      
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>  HelloEnv.greet  
"I was born to love Elixir."
```

- あれ！？、変更内容が反映されていないなあ

## 解決法①

```elixir
iex(2)> recompile force: true
Compiling 1 file (.ex)
Generated hello_env app
:ok
iex(3)> HelloEnv.greet      
"I was born to love Elixir. We are the Alchemists, my friends.
```

## 解決法②

```elixir
$ source ~/.zshenv
$ mix clean
$ iex -S mix      
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)
Generated hello_env app
Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> HelloEnv.greet
"I was born to love Elixir. We are the Alchemists, my friends."
```

## 解決法③(ダサいけどいつも私がやっていたこと)
- `lib/hello_env.ex`がコンパイルエラーを起こすように変なことをしておく

```elixir
iex -S mix
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)

== Compilation error in file lib/hello_env.ex ==
** (SyntaxError) lib/hello_env.ex:24: unexpected token: end
    (elixir 1.10.4) lib/kernel/parallel_compiler.ex:304: anonymous fn/4 in Kernel.ParallelCompiler.spawn_workers/7
```
- コンパイルが通るようにする

```elixir
iex -S mix
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Compiling 1 file (.ex)
Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> HelloEnv.greet
"I was born to love Elixir. We are the Alchemists, my friends."
```

# Wrapping Up :qiitan: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :lgtm::lgtm::lgtm: 
