---
title: hello_nervesのNervesをupgradeする (Elixir)
tags:
  - Elixir
  - Nerves
  - autoracex
private: false
updated_at: '2021-12-22T07:50:09+09:00'
id: 3113250e7920eee756cc
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/advent-calendar/2021/nervesjp

カレンダー2の
2021/12/01の回です。

# はじめに
[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

**ところでみなさん、[Nerves](https://www.nerves-project.org/)アプリのバージョンアップってどうやってやっていますか:interrobang::interrobang::interrobang:**

① https://hexdocs.pm/nerves/updating-projects.html#content を参照して、がんばる
② Railsのbin/rails app:updateみたいな〜　コマンドは無い
**③ プロジェクトのルートで`mix nerves.new .`する**

この記事では③でやってみます。
対象のプロジェクトは

https://github.com/TORIFUKUKaiou/hello_nerves

です。
いろいろなものをごった煮しているプロジェクトです。
複雑に入り組んだ現代社会の縮図であり、私自身の人生なのかもしれません。
もちろん複雑に入り組んだ現代社会に鋭いメスはいれていません。

[hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)は、[Nerves](https://www.nerves-project.org/) `1.5.1`のときにプロジェクトを新規作成して、その後もできるだけ追いかけて、本日[Nerves](https://www.nerves-project.org/) `1.7.13`にしました。
`hello_nerves`というプロジェクト名は、[公式ガイドのサンプルプロジェクト名](https://hexdocs.pm/nerves/getting-started.html#creating-a-new-nerves-app)をそのままを使いつづけています。

# Let's get started:rocket::rocket::rocket:

まずは、[Elixir](https://elixir-lang.org/)、Erlangを新しくしておきます。

```
$ asdf list all erlang
$ asdf install erlang 24.2
$ asdf local erlang 24.2
$ asdf list all elixir
$ asdf install elixir 1.13.1-otp-24
$ asdf local elixir 1.13.1-otp-24
$ asdf reshim
```

https://hexdocs.pm/nerves/getting-started.html#content

に従って必要なものをインストールしておきます。
一回、Gitコミットしておきます。

```
$ mix local.hex
$ mix local.rebar
$ mix archive.install hex nerves_bootstrap
```

`mix nerves.new .`

```
$ mix nerves.new .
```

`overwrite? [Yn]`と聞かれたら、とりあえず元気よく`Y`と答えて上書きしておきます。
その後、`git status`をしてみます。

```
$ git status
```

変更ファイルの一覧は以下の通りです。

```
On branch upgrade-nerves
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   .gitignore
	modified:   README.md
	modified:   config/config.exs
	modified:   config/target.exs
	modified:   lib/hello_nerves.ex
	modified:   lib/hello_nerves/application.ex
	modified:   mix.exs
	modified:   rel/vm.args.eex
	modified:   rootfs_overlay/etc/iex.exs
```

あとは、`git diff`コマンドを駆使してひとつひとつのファイルにどうするかを決めていきます。

## 俺のファイルをそのまま使う

```
$ git restore .gitignore
$ git restore README.md
```

## こんな変更しらねーし。触ったおぼえねーし。

::: note warn
言葉が過ぎました。
申し訳ありありません :bow::bow_tone1::bow_tone2::bow_tone3::bow_tone4::bow_tone5:
私のちっぽけな頭の中でおもったことをそのまま書いてしまいました。
自戒の意味を込めてタイトルはそのままにしておきます。
:::

::: note
コラム

自戒という言葉で思い出しました。
「しかみ像」と呼ばれる、一風かわった徳川家康公の肖像画のことです。

徳川家康公は武田信玄勢に三方ヶ原の戦いでやぶれ、命からがら居城へ逃げ帰ります。
そのときの恐怖はすさまじく脱糞をしてしまいます。
要は、:poop:を漏らしたということです。
さすがは家康公、ただ漏らしただけでは終わらせません。

この時の家康の苦渋に満ちた表情を写した肖像画（しかみ像）が残っており、これは自身の戒めのために描かせたものと伝えられる（三方ヶ原の戦い）。（ウィキペディア)

https://jikugen.exblog.jp/9012286/
:::

感謝の気持ちでありがたく取り込ませていただきます:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

`mix nerves.new .`で新しく作られたものをそのまま採用

```
$ git add rel/vm.args.eex
$ git add rootfs_overlay/etc/iex.exs
```

## 手動でマージ

- config/config.exs
- lib/hello_nerves/application.ex
- mix.exs
    - 自分で追加した各Hexのバージョンは https://hex.pm/ をみて最新バージョンにしておきます

あとは

```
$ export MIX_TARGET=rpi2
$ mix deps.get
$ mix test
$ mix format
```

`test`なんてロクに書いていないので、`mix test`は単なるポーズです。
ビルドしてラズパイ2でイゴかします[^1]。

[^1]: 「動かします」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

```
$ mix firmware
$ mix upload nerves-rpi2.local
```

:tada::tada::tada::tada::tada:
イゴいた、イゴいた :rocket::rocket::rocket:

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm: 

プロジェクトのルートで`mix nerves.new .`をやって、あとはゴニョゴニョやって、Nervesをupgradeしました。
もっといいやり方がありましたら教えてください:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
