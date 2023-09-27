---
title: macOS Catalina(10.15.5)にasdfでElixirをインストールする
tags:
  - Elixir
private: false
updated_at: '2020-05-28T17:15:52+09:00'
id: 75fa25c55ce2f0b92496
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- `% brew install elixir` でインストールした[Elixir](https://elixir-lang.org/)で楽しんでいましたが、[asdf](https://asdf-vm.com/#/)でインストールするのがいいらしいといろいろな人から聞いていました
- [Homebrew](https://brew.sh/index_ja)でインストールした[Elixir](https://elixir-lang.org/)のままでもまあいいかとおもっていたのですが、ちょっと[Nerves](https://nerves-project.org/)という「Nerves is young, but already powers rock-solid shipping industrial products!」(若くてナウいヤツ)を試してみようといろいろみていたら、そちらでも[asdf](https://asdf-vm.com/#/)でのインストールが薦められていたので切り替えることにしました
- この記事のポイントは入手可能なバージョンの調べ方です
    - `% asdf list all erlang`
    - `% asdf list all elixir`

# 参考にした記事 |> ありがとうございます!
- [Elixirのバージョン管理環境をasdfを使って作った](https://qiita.com/nishiuchikazuma/items/b9d319732ddb540fd990)
- [elixir を asdf で環境構築する手順](https://qiita.com/Yoosuke/items/7fc0dfe100d4076dccee)
- [Nervesのインストール手順の中で紹介されているElixirのインストール手順](https://hexdocs.pm/nerves/installation.html#all-platforms)

# 手順
## 1. Command Line Toolsのインストール
```zsh

% xcode-select --install
```
- もしこれができない場合は、こちらの「[xcode-select --install で失敗した時は手動でインストールする](https://qiita.com/akidroid/items/12754cb9efa58977c8a8)」記事を参考にしてください

## 2. [Homebrew](https://brew.sh/index_ja)のインストール
- [Homebrew](https://brew.sh/index_ja)の先頭のほうに書いてあるスクリプトをターミナルに貼り付けて実行してください

```zsh
% /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### すでに[Homebrew](https://brew.sh/index_ja)をインストール済の場合 -> 更新
```
% brew update
% brew upgrade
```

### [Homebrew](https://brew.sh/index_ja)で[Elixir](https://elixir-lang.org/)をインストールしていた場合 -> [Erlang](https://www.erlang.org/)と[Elixir](https://elixir-lang.org/)をアンインストール
```zsh

% brew uninstall --force erlang elixir
```

## 3. [asdf](https://asdf-vm.com/#/)のインストールとプラグインのインストール
- 公式の説明は[こちら](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)
- 2020/05/28時点の情報です
- 記事が古い場合には、[公式](https://asdf-vm.com/#/core-manage-asdf-vm?id=install-asdf-vm)をご参照ください
- 以下、[Homebrew](https://brew.sh/index_ja)で[asdf](https://asdf-vm.com/#/)をインストールする手順を転載しておきます
- macOS Catalina(10.15.5)はzshが標準ですので、zshの手順を書いています

```zsh
% brew install asdf
```

~/.zshrcに以下を書き足す

```zsh:~/.zshrc
. $(brew --prefix asdf)/asdf.sh

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi
```

```zsh
% source ~/.zshrc
% brew install coreutils automake autoconf openssl libyaml readline libxslt libtool unixodbc unzip curl unixodbc fop
% asdf plugin-add erlang
% asdf plugin-add elixir
```

### 補足
- 以降の[Erlang](https://www.erlang.org/)のインストールのところで `fop is missing` といわれることがあったので、こちらの「[Macで複数のErlangバージョンを使い分ける（OpenSSLバージョン問題の解決方法込](https://blog.mookjp.io/blog-ja/mac%E3%81%A7%E8%A4%87%E6%95%B0%E3%81%AEerlang%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E3%82%92%E4%BD%BF%E3%81%84%E5%88%86%E3%81%91%E3%82%8Bopenssl%E3%83%90%E3%83%BC%E3%82%B8%E3%83%A7%E3%83%B3%E5%95%8F%E9%A1%8C%E3%81%AE%E8%A7%A3%E6%B1%BA%E6%96%B9%E6%B3%95%E8%BE%BC/)」を参考に、`brew install`で`unixodbc`と`fop`を指定しています
 

## 4. [Erlang](https://www.erlang.org/)のインストール
```zsh
% asdf install erlang 23.0.1
```

- `% asdf list all erlang`
- 手に入れることができるバージョンを調べることができます

### 補足(情報古い)
- 当初`% asdf install erlang 22.1` とやっていたのですが以下のエラーがでていました

```zsh
 * documentation  : 
 *                  fop is missing.
 *                  Using fakefop to generate placeholder PDF files.

Build failed.
/bin/sh: line 1: 50830 Segmentation fault: 11  erlc -W +debug_info -DUSE_ESOCK=true +inline +warn_unused_import +warn_export_vars -Werror -o../ebin hipe_rtl_arch.erl
make[3]: *** [../ebin/hipe_rtl_cleanup_const.beam] Error 139
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [../ebin/hipe_rtl_arch.beam] Error 139
/bin/sh: line 1: 50813 Segmentation fault: 11  erlc -W +debug_info -DUSE_ESOCK=true +inline +warn_unused_import +warn_export_vars -Werror -o../ebin hipe_rtl_binary.erl
make[3]: *** [../ebin/hipe_rtl_liveness.beam] Error 139
make[3]: *** [../ebin/hipe_rtl_binary.beam] Error 139
make[2]: *** [opt] Error 2
make[1]: *** [opt] Error 2
make: *** [secondary_bootstrap_build] Error 2
```
- [Build Fails on macOS 10.15 Catalina](https://github.com/asdf-vm/asdf-erlang/issues/116) という記事をみつけまして、`% asdf install erlang 22.1.4`だと「worked for me」のようで[Erlang](https://www.erlang.org/)のバージョンに強いこだわりがあるわけではないので私も「worked for me」となりました


## 5. Elixirのインストール
```zsh
% asdf install elixir 1.10.3-otp-23
```

- `% asdf list all elixir`
- 手に入れることができるバージョンを調べることができます


## 6. バージョンを指定
```zsh
% asdf global erlang 23.0.1
% asdf global elixir 1.10.3-otp-23
```

## 7. Congratulations!!!
```Elixir
% iex
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> "Hello, world"
"Hello, world"
iex(2)> 1 + 1
2
iex(3)> 1..100 |> Enum.filter(&(&1 < 5))
[1, 2, 3, 4]
```

- [Nerves](https://nerves-project.org/)への旅路はこれからです :rainbow:
- 追記: [一歩は踏み出せました](https://twitter.com/torifukukaiou/status/1191255699172384768)
