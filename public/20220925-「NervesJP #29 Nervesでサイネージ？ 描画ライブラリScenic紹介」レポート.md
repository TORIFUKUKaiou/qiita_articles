---
title: '「NervesJP #29 Nervesでサイネージ？ 描画ライブラリScenic紹介」レポート'
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-09-25T21:33:35+09:00'
id: ed02b31a17a5c6d5066e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
Advent Calendar 2022 147日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/09/24(土)は、「[NervesJP #29 Nervesでサイネージ？ 描画ライブラリScenic紹介](https://nerves-jp.connpass.com/event/260256/)」が開催されました。

本日は定刻19:30から参加しました。

# 19:35 自己紹介

6名でまわしました。

# 19:45 @pojiro 隊長による「[Scenic on Nerves の紹介](https://docs.google.com/presentation/d/1ZaVER7yt0WdPAtGsz8epinDP_JrdSU5jjwHPg6R2ba0/edit#slide=id.p)」

資料は公開されています。

https://docs.google.com/presentation/d/1ZaVER7yt0WdPAtGsz8epinDP_JrdSU5jjwHPg6R2ba0/edit#slide=id.p


macOSでサンプルを試してみたい方は以下のようにしてください。

```
brew install glfw3 glew pkg-config
git clone https://github.com/pojiro/hello_scenic.git
cd hello_scenic
asdf install erlang 25.0.2
asdf install elixir 1.13.4-otp-25
mix local.hex
mix local.rebar
mix archive.install hex nerves_bootstrap
mix deps.get
iex -S mix
```

そもそもHomebrewとasdfのインストールは以下を参考にしてください。

- https://brew.sh/index_ja
- https://hexdocs.pm/nerves/installation.html

## asdf global 〜 が必要なのでは？

読者の方からお便りをいただきました。

[hello_scenic](https://github.com/pojiro/hello_scenic)プロジェクトには、[.tool-versions](https://github.com/pojiro/hello_scenic/blob/main/.tool-versions)ファイルが置いてあります。
中身は、

```:.tool-versions
erlang 25.0.2
elixir 1.13.4-otp-25
```

です。

このファイルがあることで

```
asdf local erlang 25.0.2
asdf local elixir 1.13.4-otp-25
```

を設定したことと同じこととなって、これらのバージョンが[hello_scenic](https://github.com/pojiro/hello_scenic)プロジェクトで使用されるという寸法となっています。

```
asdf current
```
で、その様がはっきりします。


# Report

@pojiro 隊長がずんずん奥深くへと突き進んでいきます。
@takasehideki 先生と @kikuyuta 先生がまじってときおり激論をかわします。
そのさまは、川口浩探検隊であり、朝まで生テレビを彷彿とさせるものでした。

# Twitter

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日19:30からこちら開催です！よろしくどうぞ🚀<br><br> <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://t.co/1B8Mmm7phD">https://t.co/1B8Mmm7phD</a></p>&mdash; 衣川亮太💉💉 💉, ソフトウェア開発を行う Tombo Works 代表 (@pojiro3) <a href="https://twitter.com/pojiro3/status/1573476503207432192?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> やって〼<br>今宵は <a href="https://twitter.com/pojiro3?ref_src=twsrc%5Etfw">@pojiro3</a> 隊長とともにScenicにdive!!<a href="https://t.co/M17JBBm0Pv">https://t.co/M17JBBm0Pv</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573627844877758464?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">こんなんになるはず？？ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <br>果敢にM1 Macで挑もうとしたら，まずはXcode最新版のインストールから ;D<a href="https://t.co/KOKsfe4qvW">https://t.co/KOKsfe4qvW</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573628096779288576?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">なんかおかしくなった？と思ったらこいつのせいだった;D <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <br>お次は Erlang 25.0.2 をインストールしている;D<a href="https://t.co/YKWuXJjMG3">https://t.co/YKWuXJjMG3</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573632867439366144?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">おっなんかいごいた！ on M1 Mac <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://t.co/27yXrsm5g3">pic.twitter.com/27yXrsm5g3</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573636315287265280?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">おもろかった！今宵もあざまっした！！ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573648017772924928?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>





# 次回予告

もう次回の予定が決まっています。

2022/10/22(土) 13:30〜17:00 ハンズオンです。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Nervesハンズオンやりまぁす！Elixir/Nerves初心者大歓迎！！ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://twitter.com/hashtag/kochiex?src=hash&amp;ref_src=twsrc%5Etfw">#kochiex</a><br>内容は2020年12月に開催した <a href="https://twitter.com/hashtag/Seeed?src=hash&amp;ref_src=twsrc%5Etfw">#Seeed</a> x <a href="https://twitter.com/hashtag/ALGYAN?src=hash&amp;ref_src=twsrc%5Etfw">#ALGYAN</a> ハンズオンとほぼ同じですが，今回はWebブラウザ上のみでお手軽にElixir/Nervesを体験できます． <a href="https://twitter.com/hashtag/JSSST2022?src=hash&amp;ref_src=twsrc%5Etfw">#JSSST2022</a> の再演でもあります．リピーターも復習したい方も大歓迎〜 <a href="https://t.co/cMSXq3YVW7">https://t.co/cMSXq3YVW7</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1573675693019631616?ref_src=twsrc%5Etfw">September 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

https://nerves-jp.connpass.com/event/261408/




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/09/24(土)に開催された、「[NervesJP #29 Nervesでサイネージ？ 描画ライブラリScenic紹介](https://nerves-jp.connpass.com/event/260256/)」のレポートを書きました。

次回は、[2022/10/22(土) 13:30〜17:00 NervesJP #30 LivebookでNervesハンズオン！する回](https://nerves-jp.connpass.com/event/261408/)

[Nerves Community in Japan](https://join.slack.com/t/nerves-jp/shared_invite/zt-1gz82husg-Z8vmUoE5VczAzUek5OJHVQ) Slackに**Let's join us! (れっつじょいなす)**


以上です。



