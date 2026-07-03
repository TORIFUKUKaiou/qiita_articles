---
title: LiveView JP#3：LiveUpload特集LT会＋ライブモブコーディング レポート
tags:
  - Elixir
  - Phoenix
  - AdventCalendar2022
private: false
updated_at: '2022-08-17T20:25:42+09:00'
id: 8c8a37e1a088c99b445b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**Twenty years from now, you will be more disappointed by the things that you didn't do than by the ones you did do, so throw off the bowlines, sail away from safe harbor, catch the trade winds in your sails. Explore, Dream, Discover.**

Advent Calendar 2022 25日目[^1]の記事です。
I'm ready for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/01/25(火)は

https://liveviewjp.connpass.com/event/234692/

**【人気で増枠】[LiveView JP](https://liveviewjp.connpass.com/)#3：LiveUpload特集LT会＋ライブモブコーディング**
が開催されました。
そのレポートです。

ワクワクとドキドキを興奮そのままに、
<font color="purple">$\huge{愛と感動}$</font>
を余すことなくお伝えします。
惜しくも参加できなかった方は雰囲気をつかんでつかんでいただいて、ぜひ次回はご参加ください。


## ハイライト

@tuchiro さんのコーナー名が決まりました :tada:

**つちろー先生が教える、WebサーバとSPAの仕組みをLiveViewで学ぶ**

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「<a href="https://twitter.com/tuchro?ref_src=twsrc%5Etfw">@tuchro</a> のモブライブコーディング」<br><br>のお時間は、3月のLiveView JP#5から、<br><br>「つちろー先生が教える、WebサーバとSPAの仕組みをLiveViewで学ぶ」<br><br>という、IT企業の新人さんに有り難い内容（と言うか、実際に弊社利用の新人育成コンテンツ）にリニューアル😆 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><a href="https://t.co/8eAj73qdor">https://t.co/8eAj73qdor</a></p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1485960554779127812?ref_src=twsrc%5Etfw">January 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



# タイムテーブル

| 時間 | 発表者 | 内容 |
|:-|:-|:-|
| 19:30-19:45  | LiveView JPオーガナイザ　@piacerex | 会の趣旨説明、カンパイ挨拶、Zoom記念撮影<br/>イントロ：LiveView入門ライブコーディング  |
| 19:45-19:55  | @torifukukaiou   | Nerves Livebookにデフォルトで入ったReq のデモ  |
| 19:55-20:05  | @the_haigo   | live_file_uploadで気をつけることとテストについて |
| 20:05-20:15  | @piacerex    | Communitexのユーザと商品で使われるLiveView Upload  |
| 20:15-21:00  | LiveView JPオーガナイザ @tuchiro   |LiveViewライブモブコーディングで何か作る  |
| 21:00-22:00  | （懇親したい方）  |   |




# 19:30

Zoomで開催しました。
**everyone, onlineでenjoyです。**

@piacerex さんは、
いつものようにNeos VRの中からZoomに参加:rocket:

定刻(乾杯まで)に、申込者数21人に対して18人が出席している!!!!

## What's [LiveView JP](https://liveviewjp.connpass.com/) ?

[LiveView JP](https://liveviewjp.connpass.com/)とは、こういう会です。
ド〜〜〜ン :tada:

![スクリーンショット 2022-01-25 19.32.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3d6a0ef8-6acd-276f-3d4e-a18b0eee5f48.png)


## アンケート

よろしければお答えください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
とのことです。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今後、私主催のイベント群は、Elixir生誕10周年の活動を残す上で「YouTubeライブ配信化」を推し進めたいな…と考えてます😌<br><br>そうするとZoom等で繋いだご本人のカメラ画像も出てしまうのですが、カメラOFFだと、メチャ寂しい絵にもなるため、どうしようかな？…と悩んでます😅<br><br>で、アンケートです😉</p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1485492192882102274?ref_src=twsrc%5Etfw">January 24, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [LiveView JP](https://liveviewjp.connpass.com/)は、28番目の[Elixir](https://elixir-lang.org/)コミュニティ

![スクリーンショット 2022-01-25 19.35.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f5a89800-73fd-b058-9939-7e25b1bf5919.png)


# 19:39

乾杯:beers:

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">LiveView JP#3、楽しかったですねー😆 <a href="https://twitter.com/hashtag/LiveViewjp?src=hash&amp;ref_src=twsrc%5Etfw">#LiveViewjp</a><br><br>LiveViewは、Elixir生誕10周年を盛り上げるに相応しい、<br><br>「Elixirにおける先端」<br><br>であり、同時に<br><br>「プロダクション採用可能／済なフィーチャ」<br><br>であるため、今シンクロいただいてる方々は、この1年を凄くワクワクして過ごせるんじゃ無いかな😉 <a href="https://t.co/D4gYU3yKPt">pic.twitter.com/D4gYU3yKPt</a></p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1485975371556462592?ref_src=twsrc%5Etfw">January 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 19:40 イントロ：LiveView入門ライブコーディング

@piacerex さんによる入門ライブコーディング:tada:
PostgreSQLを立ち上げておいてね。

## 参考: DockerでPostgreSQLを起動する

```
$ docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:13
```

`POSTGRES_USER`と　`POSTGRES_PASSWORD`の値を変更したら、あとで作る`config/dev.exs`や`config/test.exs`の値を変更してください。


## プロジェクトのセットアップ

```
$ mix local.hex
$ mix archive.install hex phx_new
$ mix phx.new basic
$ cd basic
$ mix setup
```

## ブログ機能

ブログ機能を作ります。

```
$ mix phx.gen.live Blogs Blog blogs title:string body:text
```

指示にしたがって、`lib/basic_web/router.ex`を変更

```elixir:lib/basic_web/router.ex
  scope "/", BasicWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/blogs", BlogLive.Index, :index
    live "/blogs/new", BlogLive.Index, :new
    live "/blogs/:id/edit", BlogLive.Index, :edit

    live "/blogs/:id", BlogLive.Show, :show
    live "/blogs/:id/show/edit", BlogLive.Show, :edit
  end
```


```
$ mix ecto.create
$ mix ecto.migrate
$ mix phx.server
```

※ 前の手順で、この記事の通り`mix setup`をした場合はこのときにデータベースが作られるので、`mix ecto.create`はしなくてもよいです。

はい、できあがり:rocket:

Visit: http://localhost:4000/blogs

![スクリーンショット 2022-01-25 19.44.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/13d65f41-5200-52ef-8caf-b72a772b15ef.png)


# 19:46 Nerves Livebookにデフォルトで入ったReq のデモ

@torifukukaiou 
It's me.

https://qiita.com/torifukukaiou/items/ba4e7f46f3f2c9b5a0c5

この記事で話をしました。
元の予定タイトルの話は、1/3程度に留めて、[Livebook](https://github.com/livebook-dev/nerves_livebook)に標準搭載された[Mermaid](https://mermaid-js.github.io/mermaid/#/)とウェブチカ[^2]の話をしました。

[^2]: ウェブチカの初出は、@nishiuchikazuma さんの https://speakerdeck.com/nishiuchikazuma/elixir-nervesru-men-jian-lao-naiot-edgedebaisupuroguraminguwooshou-qing-ni-nervesdetukuruuebutika-number-algyan

発表中、デモをしました。
@piacerex さんに私の家のRaspberry Pi 4(Nerves Livebook)に遠隔から接続してもらって、Lチカのプログラムを実行してもらいました:rocket:

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">私ん家から、 <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さん家のIoTデバイスをWeb上でElixir開発できる「Livebook」経由で操作できてしまった、しゅげぇ😝 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br><br>世界は拡がるなぁ😌</p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1485930504809754632?ref_src=twsrc%5Etfw">January 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 19:57 live_file_uploadで気をつけることとテストについて

@the_haigo さん

https://qiita.com/the_haigo/items/6ad00175bb3d9c15b3ee

- 上の記事の通りにやると、ファイルアップロード機能がすぐに作れちゃうよ〜
- 作りっぱなしはいかんよね、**テスト**を作ろう!!!

という大きくは2点を丁寧に解説してくださいました。


<font color="purple">$\huge{LiveViewはテストもいいぞぉ}$</font>

> seleniumとか使っていないので爆速です
> buildinだからライブラリのインストールも設定もいらない

:rocket::rocket::rocket:

# 20:10 [Communitex](https://github.com/piacerex/communitex)のユーザと商品で使われるLiveView Upload

@piacere さん

コミュニティサイトをサクっと作れるOSS「Communitex」の簡単な機能紹介と、その中のメンバー機能での画像アップロードのコード解説でした。

https://github.com/piacerex/communitex

LiveView Upload本体は、@the_haigo とほぼ同じ一方、画像をファイルとして保存せず、BASE64文字列として保存したまま、HTMLで画像表示できるテクニックが共有されました。

**BASE64エンコードされた画像ファイルをHTML表示する技**

```elixir
<img src="data:images/jpeg;base64,<%= member.image %>">
```

[LiveView](https://github.com/phoenixframework/phoenix_live_view)の実践的な話をいろいろ聞けました〜!!!


# 20:20 @tuchiro さんのモブコーディング

**無双 LiveView Time!**

あとに続く人のための[LiveView](https://github.com/phoenixframework/phoenix_live_view)の解説記事を執筆中とのことです。
記事は限定公開です。
[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)を題材に、Webとはこういうことだよを新人に伝えることを目的とされているそうです。
さらには、@tuchiroさん自身が諸事情により、Enjoy [Elixir](https://elixir-lang.org/)をここ数年出来なかったので、またEnjoyすべくキャッチアップも兼ねているという狙いがあるそうです。
一挙両得、一石二鳥とはまさにこのことです。

執筆中の内容をご説明いただきました。

生徒から質問、続出:tada::tada::tada:

- Erlang: OTP 24 のほうがいいよ(Nxで詰まってしまうだろう。24のほうが性能アップしている)
- typo: prev -> priv
- `config/runtime.exs` の話もあるとうれしい
- イベント駆動新人教育コンテンツ
- 私も文系なので基礎からわかりません…最初は何を学べばいいですか？
  - 動いたでいいやで終わらせず、実装を見に行く
  - サンプルを改造する
  - http://co-akuma.directorz.jp/blog/
  - telnet で HTTP を手動でしゃべってみる、といいですよ

**@tuchiro さんの @tuchiro さんによる、@tuchiro のためのつちろーさん無双タイム**

次回からは、
**つちろー先生が教える、WebサーバとSPAの仕組みをLiveViewで学ぶ**
というコーナー名にかわります:tada:


# 21:00 本会終了

大団円のうちに終わりました！
みんなで[ラインダンス](https://www.youtube.com/watch?v=2axs0_g1sIo)を踊って締めました。

<font color="purple">$\huge{踊りました}$</font>
:dancer::dancer_tone1::dancer_tone2::dancer_tone3::dancer_tone4::dancer_tone5:

**毎月第4火曜日に開催**

## 次回: 2022/2/22(火) 19:30-

https://liveviewjp.connpass.com/event/237625

**受け付け開始しています！　奮ってご参加ください!**

## 次々回: 2022/3/22(火) 19:30-

https://liveviewjp.connpass.com/event/237626


# 本会終了後

あとは
<font color="purple">$\huge{ムフフ💜💜💜}$</font>
です。


とてもここには書けません。
ぜひ、次回の[LiveView JP](https://liveviewjp.connpass.com/)に参加して、あなた自身で体験してみてください！！！



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:


<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

次回の[LiveView JP](https://liveviewjp.connpass.com/)の開催予定日は、
<font color="purple">$\huge{2月22日}$</font>
です。
Coming soon!!!
Don't miss it!!!

**次回のイベント案内は[コチラ](https://liveviewjp.connpass.com/event/237625/)**

https://liveviewjp.connpass.com/event/237625


Twitterのハッシュタグ**[#liveviewjp](https://twitter.com/hashtag/liveviewjp)**にご注目ください！


2022年に流行る技術予想 ーー それは、[Elixir](https://elixir-lang.org/)、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)です:rocket::rocket::rocket:

[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex(1)> Date.diff(~D[2022-05-24], ~D[2022-01-25])
119
```

:fire_engine::fire_engine::fire_engine: 

そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">次号のWEB+DB PRESSでElixirとPhoenix特集が出ます！お楽しみに！！1 <a href="https://t.co/d4hIfhIfZ1">pic.twitter.com/d4hIfhIfZ1</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1483308857019760640?ref_src=twsrc%5Etfw">January 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

---

# Zoomのチャット

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <br>zoom のチャットにいい情報があるけど残らないのがさびしい</p>&mdash; ysaito (@ysaito8015) <a href="https://twitter.com/ysaito8015/status/1485946957189238785?ref_src=twsrc%5Etfw">January 25, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ご要望にお答えして、貼っておきます。

```
19:52:03 開始 k から 皆様:
	最近Notionにも入りましたよね
19:54:20 開始 O から 皆様:
	http://cae8-2001-240-2a07-fd00-a41e-e608-f856-8cd.ngrok.io
	nerves
	
	{:ok, gpio} = Circuits.GPIO.open(18, :output)
	Circuits.GPIO.write(gpio, 1)
19:55:35 開始 A から 皆様:
	すごーーい！
19:56:10 開始 伊 から 皆様:
	公開したサービスにアクセスがあるたびに光らせたらモチベーション上がるかも知れないですね
20:09:23 開始 伊 から 皆様:
	このテストの部分だけでもliveviewに移行したくなります
20:19:57 開始 k から 皆様:
	たまにやるやつですねｗ
20:20:33 開始 t から 皆様:
	LiveView + Canvasで遊ぶときにとても良くお世話になります
20:22:28 開始 Y から 皆様:
	無双 LiveView Time!
20:29:09 開始 p から 皆様:
	つちろーさんLiveView無双タイムが、ガチの新人育成コンテンツになっとる件
20:37:08 開始 y から 皆様:
	--database sqlite3 にするとDBインストールしなくてもローカルのDBで手軽にでくる　ただしWindowsのネイティブだけハマる（Mac Ubuntuはあっさりできる）
20:42:49 開始 Y から 皆様:
	ギガが名詞になってるwww
20:42:52 開始 A から 皆様:
	私も文系なので基礎からわかりません…最初は何を学べばいいですか？
20:44:14 開始 t から 皆様:
	http://co-akuma.directorz.jp/blog/
20:44:21 開始 t から 皆様:
	とりあえずネットワークのお話とか
20:45:19 開始 y から 皆様:
	httpを理解するために、まずtelnet 80ポートを叩いてブラウザの気持ちになってみる。　実際に新人のころやってますた
20:45:35 開始 H から 皆様:
	telnet で HTTP を手動でしゃべってみる、といいですよ。
	被っちゃった
20:46:32 開始 Y から 皆様:
	あ、書籍になったやつだ
20:47:08 開始 A から 皆様:
	telnet 80ポートを叩いてブラウザの気持ちになってみる→もう少し具体的にどうすればいいでしょうか？
20:47:45 開始 y から 皆様:
	https://www.tohoho-web.com/ex/http.htm
20:48:41 開始 A から 皆様:
	プログラミング歴1週間、文系です。telnet分かりません
20:48:48 開始 K から 皆様:
	公用語じゃなかったのか、、、
20:49:00 開始 伊 から 皆様:
	HTTPに関する知識はこれ1冊手元に置いとくと良いかもですねー
	https://www.oreilly.co.jp/books/9784873119038/
20:49:08 開始 Y から 皆様:
	telnet で SMTP しゃべれましたね...
20:49:22 開始 A から 皆様:
	みなさまの叡智をいただき、ありがとうございます
20:49:23 開始 t から 皆様:
	古の技術なので telnetは気が向いたらで大丈夫です
20:49:37 開始 H から 皆様:
	SMTP, POP3, HTTP, SIP ほか、telnet ベースの text protcol
	rfc822, rfc2822 の形式。
20:49:59 開始 k から 皆様:
	真面目に答えると、これベースに改造してみるととっつきやすいかなとhttps://qiita.com/piacerex/items/6714e1440e3f25fb46a1
20:50:53 開始 伊 から 皆様:
	とほほさんで陶磁器にも入門できますよ！
	https://www.tohoho-web.com/ot/yakimono.html
20:50:57 開始 H から 皆様:
	phpだ
20:51:23 開始 H から 皆様:
	rfc2616でしょ
20:51:26 開始 Y から 皆様:
	古の技術大会ww
20:53:08 開始 t から 皆様:
	https://note.com/alicesky2127/n/n69109c8a6144
20:54:50 開始 伊 から 皆様:
	IEx.config を設定すればリストに含まれる数値が文字になるのを防げるらしいですよ
	https://bartoszgorka.com/global-customize-for-inspect-data-in-elixir
20:55:38 開始 伊 から 皆様:
	IEx.configure(inspect: [charlists: :as_lists])
20:59:38 開始 Y から 皆様:
	新人教育資料をさかなに座談会
21:00:48 開始 A から 皆様:
	つちろーさん、初歩的な質問を割り込ませてすみませんでした😅
21:00:55 開始 拓 から 皆様:
	いえいえ！
21:01:04 開始 拓 から 皆様:
	今後もよろしくお願いします！
21:01:38 開始 A から 皆様:
	よろしくお願いします！一生懸命楽しんで頑張ります！
21:02:38 開始 伊 から 皆様:
	ありがとうございました～
21:02:41 開始 K から 皆様:
	ありがとうでしたー
21:02:41 開始 A から 皆様:
	888888888
21:02:45 開始 y から 皆様:
	888888
21:02:45 開始 Y から 皆様:
	888888
21:02:49 開始 木 から 皆様:
	ありがとうございました〜
21:03:20 開始 Y から 皆様:
	ありがとうございました！今日は離脱します
21:09:34 開始 y から 皆様:
	動物のTCP/IP青い本を見るものだとおもってました
21:10:42 開始 H から 皆様:
	トラブルシュートには、ベースの仕組みを理解してなきゃね。
	tcp/ip, rfc793 読みましょ。状態遷移もあるよ。
21:13:14 開始 A から 皆様:
	Lost Technology多いです …そもそもの仕組み、コンピュータ、ネットワークの構造などを分かっておかないと詰むってことですね
21:13:49 開始 伊 から 皆様:
	テストコード無しは地獄の一丁目
21:15:23 開始 A から 皆様:
	えぇ〜〜〜〜
21:16:18 開始 伊 から 皆様:
	最後にJava書いたの5か6かなあ
21:16:48 開始 p から 皆様:
	Java 8以前で歴史が止まっちゃった人、多いよねー
21:17:23 開始 伊 から 皆様:
	最近のJavaはモダン化が一気に進んでてイケてきたイメージあります
21:18:43 開始 A から 皆様:
	楽しそう！
21:20:08 開始 y から 皆様:
	eclipseとはもうつかわないのですかね？　一つ前の仕事はこれでした
21:20:53 開始 y から 皆様:
	VB6のエディターでもすごいと思いました。
21:22:16 開始 伊 から 皆様:
	Eclipseが重すぎてNetBeansに移行して軽さに感動したっけ
21:22:27 開始 A から 皆様:
	書いた書いた、で、挫折した
21:22:57 開始 A から 皆様:
	同じ人？！
21:23:34 開始 y から 皆様:
	VSにしろeclipseにしろ2003年頃は重すぎて秀丸を使ってた。
21:25:52 開始 k から 皆様:
	Kotlin やってる友人が Java むずいって言ってましたね笑
21:30:06 開始 A から 皆様:
	楽しかったです！ありがとうございました！
21:30:31 開始 拓 から 皆様:
	お疲れ様でした〜
21:30:34 開始 A から 皆様:
	お先に失礼いたします。またお邪魔させてください。
21:30:40 開始 拓 から 皆様:
	次回もよろしくお願いします！
21:31:05 開始 伊 から 皆様:
	お疲れさまでした～

```

---


# [Elixir](https://elixir-lang.org/)

最後の最後に、[Elixir](https://elixir-lang.org/)について紹介します。

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でスイスイ、プログラミングしていくことができる素敵なプログラミング言語です
- さっそくプログラムの例を示します
- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています
- ここでは雰囲気をつかんでいただければ大丈夫です

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## もっと[Elixir](https://elixir-lang.org/)のことを知りたい方へオススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト − 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- KADOKAWA

## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
([EDI／fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com/) ＆ [LiveView JP](https://liveviewjp.connpass.com/) の @piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)



# <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方 －国内オンライン編－**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian
[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@nako_sleep_9h) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





