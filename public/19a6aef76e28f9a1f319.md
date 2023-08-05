---
title: Nervesでcron的なことをする
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-06-16T23:16:33+09:00'
id: 19a6aef76e28f9a1f319
organization_url_name: fukuokaex
slide: false
---
（この記事は、「[#NervesJP Advent Calendar 2019](https://qiita.com/advent-calendar/2019/nervesjp)」の3日目です）
昨日は私の「[Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)」です！こちらもぜひぜひ！

# はじめに :santa_tone1:
- [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa) の続きです
- 前回はsshでNerves on Raspberry Pi 2に接続して、手動で`HelloNerves.update`を実行して、日本の任意の場所の天気予報をTwitterに[投稿](https://twitter.com/torifukukaiou/status/1195036637341683712)しました
- つぎは、cronっぽいやつを設定して、午前7:00に自動的に投稿するようにしてみます

# 結論
- [Cronex](https://github.com/jbernardo95/cronex)は、Nerves on Raspberry Pi 2 で動作しました
- **[Nerves](https://nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTでナウでヤングなクールなすごいやつ**

## 2020/6/16 追記
- [Quantum](https://github.com/quantum-elixir/quantum-core)を使いましょう

# 作品
- [TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)

# [Elixir](https://elixir-lang.org/)のcron的なもの
- [Awesome Elixir](http://awesome-elixir.ru/) で調べました

## [Quantum](https://github.com/quantum-elixir/quantum-core)
- こちらのほうが人気あるようです
- macOSでは簡単にうごきましたが、私がやった限り、Nerves on Raspberry Pi 2ではうんともすんともうごきませんでした
- おそらくこちらのIssueでうごかないよと言われている気がします
    - [Problem: Jobs don't get executed when time is set on app startup (ntp) #342](https://github.com/quantum-elixir/quantum-core/issues/342)
- ただしこちらが2019/12/3現在、OpenのようでそのうちNervesにも対応してくれるかもしれません
    - [Delayed start possible? NTP: Time set after startup #395](https://github.com/quantum-elixir/quantum-core/issues/395)

#### 2020/6/16(火) 追記
- [Nerves](https://nerves-project.org/)で[Quantum](https://github.com/quantum-elixir/quantum-core)は使えます
- @nishiuchikazuma さんの [Nervesでcronっぽい動作ができるQuantumを使って定期的にSlackにメッセージを投げた](https://qiita.com/nishiuchikazuma/items/518f208f9bb90929fd73) でその実績が記載されています
- 私のプロジェクトも[Quantum](https://github.com/quantum-elixir/quantum-core)を使うように切り替えました
    - Raspberry Pi 2で動作することを確認しました
- この当時は本当に動かなかったのか、それとも[Elixir](https://elixir-lang.org/)力が足りなくて使い方が正しくなかったのかはわかりませんが、とにかく[Nerves](https://nerves-project.org/)でも[Quantum](https://github.com/quantum-elixir/quantum-core)は使えます
    - たぶん当時は[Elixir](https://nerves-project.org/)力が足りなくて設定を間違えていたのだとおもいます。。。



## [Cronex](https://github.com/jbernardo95/cronex)
- 冒頭で述べた通り、Nerves on Raspberry Pi 2 で動作しました
- ただし、`mix.exs`の書き方をREADMEの通りにやると、runtime中に`Mix.env`を呼び出しているバージョンを`deps.get`してしまうようです
    - この場合、`Mix.env`がNerves on Raspberry Pi 2で実行できん！ で、動きません
- そのため、`Mix.env`を使わないように対応されているリビジョンを指定します
- また、とある1分以内に処理が2回実行される問題があるようです
    - [In Elixir 1.6.4 timing is not correct #14](https://github.com/jbernardo95/cronex/issues/14)
    - workaroundあります!
- [contributors](https://github.com/jbernardo95/cronex/graphs/contributors) に名を連ねています :relaxed:
  - [Fixes syntax error in Cronex.Every documentation](https://github.com/jbernardo95/cronex/commit/b8781f94faec02478dc70507ab3e08a99d5a0a53)
  - 誤記修正だけですけどね

# 対応内容

- すべての対応内容は[こちら](https://github.com/TORIFUKUKaiou/hello_nerves/commit/1bc6334297c3f65436311a32a59a687cd3b19a56)です
- 以下、ポイントを示します

```Elixir:mix.exs
  defp deps do
    [
      ...
      {:cronex, github: "jbernardo95/cronex", ref: "345b57e14667a08280d790afdfbb359f467649df"}
    ]
  end
```
- `:ref`で、`Mix.env`を使わないように対応されているリビジョンを指定しています

```Elixir:lib/hello_nerves/scheduler.ex
defmodule HelloNerves.Scheduler do
  use Cronex.Scheduler

  every :day, at: "22:00" do
    HelloNerves.update()
  end
end
```
- スケジュールの登録の仕方は、[Cronex.Every](https://hexdocs.pm/cronex/Cronex.Every.html)を参照してください
- UTCで指定しているので日本時間7:00になります

```Elixir:config/config.exs
config :cronex,
  ping_interval: 60000
```
- とある1分以内に処理が2回実行される問題への[workaround](https://github.com/jbernardo95/cronex/issues/14#issuecomment-555035517)です
- この対応は、あとで問題に気づいたのでコミットIDがちがっていて、[こちら](https://github.com/TORIFUKUKaiou/hello_nerves/commit/cbf763c98b1630b0e02a8c78b10dd34f1760e08a)と[こちら](https://github.com/TORIFUKUKaiou/hello_nerves/commit/bb4a9340a0eb5dff1e63f7f4c08e10c3a0dbd64d)になります

# ビルドしてmicroSDカードに焼く
- 詳しくは、[Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa) をご参照ください

```
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=secret
$ export TWITTER_CONSUMER_KEY=xxx
$ export TWITTER_CONSUMER_SECRET=yyy
$ export TWITTER_ACCESS_TOKEN=zzz
$ export TWITTER_ACCESS_TOKEN_SECRET=aaa
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```

- あとは、microSDカードをRaspberry Pi 2にいれて電源投入
- Nerves on Raspberry Pi 2のiexにて `HelloNerves.Scheduler.start_link` を一度実行しておけばよいです
- **注意としては、Nerves on Raspberry Pi 2のiexをexitで抜けないことです**
    - macOSの場合はiexでexitタイプしてもおこられるとおもいますが、Nerves on Raspberry Pi 2の場合はsshから抜けます
    - これはたぶん、そうじゃないかというくらいで確証はないのですが、どうもexitで抜けると、`HelloNerves.Scheduler.start_link`自体も破棄されてしまってcron的な動きをしないようにおもいます
    - これは私の経験則みたいなものです
    - はっきり言うと私は、全然わかっていません
    - `mix firmware`で何が行われて、何が出来上がっているのか、そしてそれをmicroSDに焼き込んでRaspberry Pi 2に差し込んで、電源ONするとなぜiexが起動しているのかさっぱり理解していません
    - そのへんがわかると、[Nerves](https://nerves-project.org/)では[Mix.target()](https://hexdocs.pm/mix/Mix.html#target/0)が使えない理由とか、ここであげたexitを実行したときに何が行われるのかといったあたりのことがちゃんと説明できるようになるとおもいます
    - 次はこのへんの理解、もしかしたら[Nerves](https://nerves-project.org/)というよりはもっと前のところ、コンピュータの勉強を改めてちゃんと勉強しましょうということになるのかもしれませんが、理解していきたいとおもっています
    - で、逆の言い方するとこういうことをなんとなくくらいしか知らなくても手軽にあつかえる**[Nerves](https://nerves-project.org/)は、ナウでヤングなクールなすごいやつ**だとおもっています

# 最後に
- [IoTつくるよ！2 2019/11/30(土)](https://www.tsukuruyo.net/)の[NervesJP](https://nerves-jp.connpass.com/)のブースにて、[TAKASEhideki](https://twitter.com/TAKASEhideki)先生に使っていただきました！
- ありがとうございます！
  - https://twitter.com/TAKASEhideki/status/1200660354306437120
  - https://twitter.com/TAKASEhideki/status/1200647229872041986

# 次回
次回は[zacky1972](https://qiita.com/zacky1972)先生の「[Pelemayを開発している時にわかった Nerves 対応のコツ](https://qiita.com/zacky1972/items/b2beeeb5fd8689faba84)」です！こちらも是非どうぞ～
