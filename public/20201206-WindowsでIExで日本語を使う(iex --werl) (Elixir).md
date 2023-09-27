---
title: WindowsでIExで日本語を使う(iex --werl) (Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-12-07T07:02:49+09:00'
id: 34406dd5b6b386f1ef9e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 6日目です。
前日は、[次の関数の第二引数なんだよなー(Elixir)](https://qiita.com/torifukukaiou/items/6d6ac7b4938b9ff5e6db) でした。

----

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか〜！
- Windowsで`IEx`を起動して日本語を使うにはどうしたらいいでしょうかー
- [Elixir](https://elixir-lang.org/) は`1.11.2`です

# 答え

```
> iex --werl
```

![iex.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f264deb5-5be9-0a28-5b2a-976acd596f58.png)

## 日本語使えない :cry: 

- `chcp 65001`は事前にしていますが、エラーがでています

![iex_ng.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2e1565a4-254f-4829-bd19-7c2fe353b9f0.png)



## `--werl` オプションを見つけたページ
- [Newbie with UnicodeConversionError - 3](https://elixirforum.com/t/newbie-with-unicodeconversionerror/3355/3)

## ヘルプでのたどり方(あとづけ)

```
> iex --help
Usage: iex [options] [.exs file] [data]

The following options are exclusive to IEx:

  --dot-iex "PATH"    Overrides default .iex.exs file and uses path instead;
                      path can be empty, then no file will be loaded
  --remsh NAME        Connects to a node using a remote shell

It accepts all other options listed by "elixir --help".
```

**ふむふむ、`elixir --help`に聞きなさいと**

```
> elixir --help
Usage: elixir [options] [.exs file] [data]

## General options

  -e "COMMAND"                 Evaluates the given command (*)
  -h, --help                   Prints this message and exits
  -r "FILE"                    Requires the given files/patterns (*)
  -S SCRIPT                    Finds and executes the given script in $PATH
  -pr "FILE"                   Requires the given files/patterns in parallel (*)
  -pa "PATH"                   Prepends the given path to Erlang code path (*)
  -pz "PATH"                   Appends the given path to Erlang code path (*)
  -v, --version                Prints Elixir version and exits

  --app APP                    Starts the given app and its dependencies (*)
  --erl "SWITCHES"             Switches to be passed down to Erlang (*)
  --eval "COMMAND"             Evaluates the given command, same as -e (*)
  --logger-otp-reports BOOL    Enables or disables OTP reporting
  --logger-sasl-reports BOOL   Enables or disables SASL reporting
  --no-halt                    Does not halt the Erlang VM after execution
  --werl                       Uses Erlang's Windows shell GUI (Windows only)

Options given after the .exs file or -- are passed down to the executed code.
Options can be passed to the Erlang runtime using $ELIXIR_ERL_OPTIONS or --erl.

## Distribution options

The following options are related to node distribution.

  --cookie COOKIE              Sets a cookie for this distributed node
  --hidden                     Makes a hidden node
  --name NAME                  Makes and assigns a name to the distributed node
  --rpc-eval NODE "COMMAND"    Evaluates the given command on the given remote node (*)
  --sname NAME                 Makes and assigns a short name to the distributed node

## Release options

The following options are generally used under releases.

  --boot "FILE"                Uses the given FILE.boot to start the system
  --boot-var VAR "VALUE"       Makes $VAR available as VALUE to FILE.boot (*)
  --erl-config "FILE"          Loads configuration in FILE.config written in Erlang (*)
  --pipe-to "PIPEDIR" "LOGDIR" Starts the Erlang VM as a named PIPEDIR and LOGDIR
  --vm-args "FILE"             Passes the contents in file as arguments to the VM

--pipe-to starts Elixir detached from console (Unix-like only).
It will attempt to create PIPEDIR and LOGDIR if they don't exist.
See run_erl to learn more. To reattach, run: to_erl PIPEDIR.

** Options marked with (*) can be given more than once.
```

# Wrapping Up :lgtm: :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5:  :lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) !!! :fire::rocket::fire::rocket::fire::rocket::rocket::rocket: 
