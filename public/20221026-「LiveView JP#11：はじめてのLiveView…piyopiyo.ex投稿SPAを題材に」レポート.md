---
title: 「LiveView JP#11：はじめてのLiveView…piyopiyo.ex投稿SPAを題材に」レポート
tags:
  - Elixir
  - Phoenix
  - LiveView
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-11-10T20:12:29+09:00'
id: 3c7f334d8fb012b9f13d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
Advent Calendar 2022 164日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/10/25(火)は、「[LiveView JP#11：はじめてのLiveView…piyopiyo.ex投稿SPAを題材に](https://liveviewjp.connpass.com/event/262072/)」が開催されました。
この記事は、イベントのレポートです。

[Phoenix](https://www.phoenixframework.org/)とは、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しめるフレームワークです。
[LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)の説明は、「[LiveViewとpiyopiyo.exのススメ](https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume)」をご覧になってください。


# Let's get started!

定刻通り19:30に、はじまりました〜

# 資料

この記事で一番大事なところです。
ポイントです。
繰り返し書いておきます。
この記事で一番大事なところです。


## [LiveViewとpiyopiyo.exのススメ](https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume)

https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume

## [piyopiyo.exポータルチュートリアル～感想投稿サイト構築を例にLiveView+tailwindcssの基礎を学ぶ～](https://qiita.com/tuchiro/items/050e6b86afc35a843a7c)

https://qiita.com/tuchiro/items/050e6b86afc35a843a7c

## [elixirと見習い錬金術師 Discord](https://discord.gg/p7D9JpqTH7)

https://discord.gg/p7D9JpqTH7


# [LiveViewとpiyopiyo.exのススメ](https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume)

@nako_sleep_9h さんが、以下のことを丁寧に説明くださっています。

- [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)とはなんぞや
- SPA（Single Page Application）ってなんだっけ？
- [piyopiyo.ex](https://piyopiyoex.connpass.com/)ってなに？

https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume

感動の筆で書き下ろされています！
必読の書です。

以下、いくつか画面キャプチャを載せておきます。
全編は、[コチラ](https://speakerdeck.com/nako_sleep_9h/liveviewtopiyopiyo-dot-exnosusume)からご覧になってください :rocket::rocket::rocket:

![スクリーンショット 2022-10-25 19.47.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/60e08039-0ec1-4fb0-47b6-3e744f819711.png)

![スクリーンショット 2022-10-25 19.48.37.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f5b43acf-919c-de70-7e3c-bb854f792203.png)



# [piyopiyo.exポータルチュートリアル～感想投稿サイト構築を例にLiveView+tailwindcssの基礎を学ぶ～](https://qiita.com/tuchiro/items/050e6b86afc35a843a7c)

@tuchiro さんが説明してくださいました。

https://qiita.com/tuchiro/items/050e6b86afc35a843a7c

途中、質問タイムなどがありました。

### [０章～できるだけ楽して環境を準備する～](https://qiita.com/tuchiro/items/19c69865d6206135bb71)

特に印象的だったのは、開発環境の準備です。
初級者泣かせの一番詰まりやすいところです。
ここを越えないと楽しめないのです。

![スクリーンショット 2022-10-25 20.06.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c7ccbc56-95b3-f779-f25e-f197679770a3.png)

紹介されていたのは、WebIDE環境 [Replit](https://replit.com/)です。

### [１章～コマンド一発でWebアプリケーションを作ってみる～](https://qiita.com/tuchiro/items/0bbead6902fcf2372a48)

開発環境の準備が無いのでチュートリアルに沿ってあれよあれよという間にLiveViewを使用したSPAアプリケーションが出来上がっていきました。
Phoenixアプリを生成してLiveViewを導入し、MVCの実装を済ませました。

### [２章～ライブラリを使って簡単にtailwindcssを導入する～](https://qiita.com/tuchiro/items/0a1090e432ccc2ff4e9a)

ライブラリを使用して[TailwindCSS](https://tailwindcss.com/)と[daisyUI](https://daisyui.com/)をあてがいました。

### [３章～トップページをイイカンジにする～](https://qiita.com/tuchiro/items/df820f7e0c0dae873127)
トップページのロゴをLiveView JPに変更したところ、引用元の[piyopiyo.ex](https://piyopiyoex-portal.gigalixirapp.com/)ポータルのポップなデザインと絶望的に合わないので、背景色や文字色で調整を加えました。
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/677280/f2a31dc7-bc7b-396b-8aa2-67c40d2fcfb4.png)
(ちなみに二次会ではこちらのLiveView JPの新ロゴは某お菓子のキョ〇ちゃんが一部モチーフに使われているという話をコッソリ...あくまでコッソリと聞かせてもらいました。)


### [４章～トップページから画面遷移する機能を追加する～](https://qiita.com/tuchiro/items/cefd39f98d0ae295a02a)

「全部の感想を見る」のエンドポイントに遷移したときトップページを表示するよう、[mount/3](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html#c:mount/3)時にパスのパラメータを受け取ってlist_messageを呼ぶように引数を追加しました。

### [５章～faviconとページタイトルを設定する～](https://qiita.com/tuchiro/items/edba925c6eee8466e6de)

faviconとタイトルの調整をして、完成となりました。
[こちらのリポジトリ](https://github.com/TakutoYoshimura/LiveViewJPTutorial_PiyoPiyoExPortal/releases)から各章ごとの完成した断面に合わせてリリースがなされています。

# お詫び :pray::pray::pray::pray::pray:

すみません :pray::pray::pray::pray::pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:。
本当に、 すみません :pray::pray::pray::pray::pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:。
所用で20:25くらいに退出しました。
しかも無言で退出しました。繰り返します。無言です。

以降のことはわかっていません。
ぜひぜひ編集リクエストをください。

@Alicesky2127 さんから[編集リクエスト](https://qiita.com/torifukukaiou/items/3c7f334d8fb012b9f13d#comment-342b4c9c8e16c5170962)をいただきました。
ありがとうございます！



# Twitter

Twitterを拾っておきます。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">明日19:30、ElixirでリアルタイムSPAをカンタンに開発できる「LiveView」の入門イベント開催です😆<br><br>ReactやVue.jsに飽きた方<br><br>サーバエンジニアだけどフロント開発させられそうな方<br><br>フロントエンジニアでスマホ開発やAI・ML触れたい方<br><br>歓迎です💁‍♂️ <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><a href="https://t.co/6aUFXVP7df">https://t.co/6aUFXVP7df</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584527223604015104?ref_src=twsrc%5Etfw">October 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ハロウィンパーティナイト版LiveView JP＋piyopiyo.ex、1時間35分後に開幕でっすよー🥨🍾<a href="https://t.co/6aUFXVP7df">https://t.co/6aUFXVP7df</a><br><br>LiveViewは、フロント開発に慣れてても魔術めいたWeb技術ですが、いかに開発体験が良いものになるのかシェアします🕸️🕷️<br><br>ハロウィン楽しむ感じでお越しを🌛🔮 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/W4G3AF8nzI">pic.twitter.com/W4G3AF8nzI</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584830582907097088?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">『LiveView JP#11：はじめてのLiveView…piyopiyo.ex投稿SPAを題材に』<br>×<br>『piyopiyo.ex#10：感想投稿サイト1時間半で作れる？！LiveViewJPとSPA実装』<br>始まりました(^▽^)ハッピーハロウィン！<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/it6qhkTmWt">pic.twitter.com/it6qhkTmWt</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584857963642392577?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ハロウィンの掛け声…trick or thread?<br> <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a></p>&mdash; Yuichi Onodera (@mokemoke6502) <a href="https://twitter.com/mokemoke6502/status/1584858128041922561?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">LiveView JP#11＋piyopiyo.ex#10という名の、タダのハロウィンパーティ、はーじまーるよー😝 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/66qSxH1VgH">pic.twitter.com/66qSxH1VgH</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584858200788340736?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">それやー😭 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>ノリで「Happy Halloween」って言っちゃった、テヘ😅</p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584858740159057920?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">お一人目のTrick or Treatさんは、<a href="https://twitter.com/nako_sleep_9h?ref_src=twsrc%5Etfw">@nako_sleep_9h</a> さんで「LiveViewとpiyopiyo.exのススメ」😆 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>WebSocketとかSPAとか、なんか書かれてるけど、これはハロウィンパーティの催しものですよ、ハイ😋 <a href="https://t.co/sX4bbeIOGG">pic.twitter.com/sX4bbeIOGG</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584860396087046144?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">フロント側とサーバー側でテスト書き分けを意識していない…これってありがたいことだよなぁ。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/NmE9n8Ulq6">pic.twitter.com/NmE9n8Ulq6</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584860850246266880?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WebSocketってちゃんと理解してなかったことがよく分かりました(´;ω;｀)<br>説明分かりやすくてありがたかったです。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/nwrIbll1DZ">https://t.co/nwrIbll1DZ</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584862440403374080?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">お2人目のTrick or Treatさんは、 <a href="https://twitter.com/tuchro?ref_src=twsrc%5Etfw">@tuchro</a> さんで「piyopiyo.ex感想投稿サイトを作る流れでLiveViewを学ぶ」😆 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>全7本のLiveView入門者コラムというTreatを皆さんにお届け💁‍♂️ <a href="https://t.co/jReA81ixof">pic.twitter.com/jReA81ixof</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584864194746527744?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">replitからGUI経由でGithubにリモートリポジトリ作れるの便利だな。知らなかった。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/TSoYQ4Xk2F">pic.twitter.com/TSoYQ4Xk2F</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584864757555015680?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">そうか...LiveViewはフロントエンジニアの方にとってもバックエンドの技術の入門としてもとっつきやすいのか。<br>heexファイルとかまんまCSSっぽい見た目だよなぁ。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/zHt2hAKtd9">pic.twitter.com/zHt2hAKtd9</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584871086407438336?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">piyopiyo.exのポップさとLiveViewJPのロゴが絶望的にマッチしてないwww<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/21rUlnYIJt">pic.twitter.com/21rUlnYIJt</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584871493053612035?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">classタグを編集して背景色や文字色を変更。いい感じに！<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/bXWne8EH33">pic.twitter.com/bXWne8EH33</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1584872335471153152?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「piyopiyo.ex感想投稿サイトを作る流れでLiveViewを学ぶ」の後半戦😌 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>前半でDB CRUDを作った後、デザインをTailwindCSSで入れて、piyopiyo.exポータルっぽいものを作った後、カラーリング等を調整して、LiveView JPらしくてハロウィンっぽい、ダークなテイストにアレンジ😝 <a href="https://t.co/lwonEml1CF">pic.twitter.com/lwonEml1CF</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584872520918118401?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日はハロウィン仕様😍🔮 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a> <a href="https://t.co/H1Seiryo4d">pic.twitter.com/H1Seiryo4d</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584875095730028544?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">帽子無し版ハロウィン仕様🕷️🕸️🌛 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><a href="https://twitter.com/hashtag/NeosVR?src=hash&amp;ref_src=twsrc%5Etfw">#NeosVR</a> は、こういう絵を撮るとき、すんごくキレイだなー😌 <a href="https://t.co/IqpUpZzrcS">pic.twitter.com/IqpUpZzrcS</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584875935689736193?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ハロウィン仕様その2💁‍♂️ <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>ちょっちVTuber的な構図な感じ？😋 <a href="https://twitter.com/hashtag/NeosVR?src=hash&amp;ref_src=twsrc%5Etfw">#NeosVR</a> <a href="https://t.co/UwJGjiXom9">pic.twitter.com/UwJGjiXom9</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584886084735234050?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ハロウィンパーティ二次会ちう🍷 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://twitter.com/hashtag/piyopiyoex?src=hash&amp;ref_src=twsrc%5Etfw">#piyopiyoex</a><br><br>TikTokやYouTubeを見た人の購入率とか、インフルエンサーとの紐付けについてや、若者に「バッチ」「Excel」が通じないとか雑多なお喋り😝 <a href="https://t.co/wUOHmpZlDV">pic.twitter.com/wUOHmpZlDV</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1584887798846619649?ref_src=twsrc%5Etfw">October 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>





---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/10/25(火)に開催された、「[LiveView JP#11：はじめてのLiveView…piyopiyo.ex投稿SPAを題材に](https://liveviewjp.connpass.com/event/262072/)」のレポートを書きました。

[LiveView JP](https://liveviewjp.connpass.com/)では、初心者に優しいコンテンツ、イベントを今後もたくさん提供していくとのことです。

<font color="red">$\huge{ワクワク}$</font>
です。

以上です。



