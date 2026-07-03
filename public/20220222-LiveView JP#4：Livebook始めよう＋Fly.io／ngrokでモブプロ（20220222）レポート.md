---
title: LiveView JP#4：Livebook始めよう＋Fly.io／ngrokでモブプロ（2022/02/22）レポート
tags:
  - Elixir
  - LiveView
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-24T19:29:25+09:00'
id: 5d393e293eac3759dca0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**田子の浦にうちいでて見れば白たへの富士の高嶺に雪は降りつつ**

Advent Calendar 2022 53日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。


[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

本日2022/02/22(金)は

https://liveviewjp.connpass.com/event/237625/

**【更に増枠】LiveView JP#4：Livebook始めよう＋Fly.io／ngrokでモブプロ**
が開催されました。
そのレポートです。

ワクワクとドキドキを興奮そのままに、
<font color="purple">$\huge{愛と感動}$</font>
を余すことなくお伝えします。
惜しくも参加できなかった方は雰囲気をつかんでつかんでいただいて、ぜひ次回はご参加ください。
参加した方は、公開されている資料のリンクなどを貼っておりますので、ふりかえりにご活用ください。





## 次回

次回は**2022月3月22日(火) 19:30-21:00**の予定です。
すでに案内がでています！！！

**LiveView JP#5：多人数タイプゲームで盛り上がろう＋LiveView SPA学ぶ**

https://liveviewjp.connpass.com/event/237626/




## 資料集

https://qiita.com/torifukukaiou/items/d1f2e8e3ec2869566b93

https://zenn.dev/ito_shigeru/articles/33012711b32605

https://qiita.com/piacerex/items/533d26c81bada4741422


----

# 19:35

Zoomで開催しました。
**everyone, onlineでenjoyです。**

乾杯しました :beers::beers::beers: 

![スクリーンショット 2022-02-22 19.41.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f8078e00-9c4f-6b46-e604-7ebd91dba3ba.png)

## [WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127)

2022/02/24(木)に発売される **[WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127)** の案内がありました。
Livebookの土台である、LiveViewさらにはそのベースである[Phoenix](https://www.phoenixframework.org/)の特集が組まれています。

https://gihyo.jp/magazine/wdpress/archive/2022/vol127

さらに、2022/03/08(火)には、執筆者全員を呼んで、**こたつで座談会**です。

https://fukuokaex.connpass.com/event/239094/

## [LiveView JP](https://liveviewjp.connpass.com/)の紹介

[LiveView JP](https://liveviewjp.connpass.com/)とは、このような会です。

![スクリーンショット 2022-02-22 19.38.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a74c44ba-4061-c61b-53fe-e7b380dcd74b.png)


## 偶数月は[Livebook](https://github.com/livebook-dev/livebook)

偶数月は、[Livebook](https://github.com/livebook-dev/livebook)を取り扱います。
[Livebook](https://github.com/livebook-dev/livebook)の動かし方は以下の通りです。

```
git clone https://github.com/livebook-dev/livebook.git
cd livebook
mix deps.get --only prod
MIX_ENV=prod mix phx.server
[Livebook] Application running at http://localhost:8080/?token=[token]
```

Visit: http://localhost:8080/?token=[token]

あとは、`New notebook`して試しに以下のコードを実行してみてください！

```elixir
Mix.install([{:kino, "~> 0.3.1"}, {:download, "~> 0.0.4"}])

Download.from("https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png")
|> elem(1)
|> File.read!
|> Kino.Image.new(:jpeg)
```

![スクリーンショット 2022-02-22 22.15.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7952fb2d-a9a2-c052-fc80-8f65bbc197ef.png)




# 19:45 @torifukukaiou 

レポートを書いている本人のLTです。

こちらの資料を使って説明しました。

https://qiita.com/torifukukaiou/items/d1f2e8e3ec2869566b93

おもに以下の点を説明しました

- とりあえずローカルで[Livebook](https://github.com/livebook-dev/livebook)を動かすには、Dockerを使うのがおすすめです
- [fly.io](https://fly.io/)へのデプロイ簡単です
    - https://fly.io/launch/livebook
- `Welcome to Livebook` コンテンツのデモ
- 私の感じ方、ざっくりとした説明

私の感じ方、ざっくりとした説明をご紹介します。

|  | 私の感じ方、ざっくりとした説明 |
|:-|:-|
| [Elixir](https://elixir-lang.org/)  | 世俗派関数型言語[^2]。なんとなく知らない間にゆるふわで「アタシ、関数型言語でプログラミングしちゃってました」 てな具合にプログラミングを楽しめます。 |
| [Phoenix](https://www.phoenixframework.org/)  | Webアプリケーションの開発を楽しめます  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view)  | 高性能なバックエンド開発もリッチなフロントエンド開発も[Elixir](https://elixir-lang.org/)一本で楽しめます！  |
| [Livebook](https://github.com/livebook-dev/livebook)  | [Jupyter](https://jupyter.org/)に相当するもの。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションの代表例ともいうべき金字塔。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションのお手本であり、最高峰。  |
|[Nerves](https://www.nerves-project.org/)| [Elixir](https://elixir-lang.org/)でIoTを楽しめるフレームワークです。(誤解を恐れずにいえば)[Nerves](https://www.nerves-project.org/)は、[Elixir](https://elixir-lang.org/)専用OSです!!! sshで中に入ったら`iex>`~~しかできません~~だけができて**一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:**　|
|[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) |[Livebook](https://github.com/livebook-dev/livebook)は、[Nerves](https://www.nerves-project.org/)の上でイゴきます[^3]|

[^2]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

[^3]: 「動きます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^4]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^4]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# 20:00 @iyanayatudaze さん

**LivebookでLive記事執筆**

Livebookを使って実行結果を確かめながら作成した記事を、技術記事投稿サイトへ**LT中にLiveで投稿する**という内容でした。

LT中に作成、投稿された記事はこちらです。

https://zenn.dev/ito_shigeru/articles/33012711b32605

これは生のライブでみると**とても興奮**する出し物でした。

見逃した方にこの興奮をお伝えするのは難しい。
いや〜、本当に良かった！
興奮した！
LiveView、Livebook、LT中にLive記事投稿 ーー **幾重にも十重二十重にLiveが飛び交っていました**。
**Liveの大盤振る舞いです。**
**Liveの大運動会、Liveのデパートです！！！**

![スクリーンショット 2022-02-22 20.11.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cf665f19-299a-2a9a-27f8-8f69ab95a25c.png)
![スクリーンショット 2022-02-22 20.12.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f47ee23d-1ff1-9c6c-caec-c35283eda2bf.png)

Notebookのタイトル横の３点リーダからExportです:rocket::rocket::rocket:


# 20:15 @piacerex さん

https://qiita.com/piacerex/items/533d26c81bada4741422

「[「JupyterNotebook + NumPyでサクッと画像加工するノリ」をElixir Livebookでやってみた（lennaさんのバージョンアップもあるよ）](https://qiita.com/piacerex/items/533d26c81bada4741422)」の記事をLiveで解説を加えながら、実演していただきました。


![スクリーンショット 2022-02-22 20.36.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/633f628f-339e-287d-002e-8ebcbfbecf58.png)


# 20:30-21:00 Livebookライブモブコーディングをみんなで体験する

[ngrok](https://ngrok.com/)を使って、@piacerex さんのローカルマシンで動かしている[Livebook](https://github.com/livebook-dev/livebook)にみんなでアクセスして、モブプログラミングを楽しむという内容でした。

[ngrok](https://ngrok.com/)とは、

> Spend more time programming. One command for an instant, secure URL to your localhost server through any NAT or firewall.

![スクリーンショット 2022-02-22 22.45.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4fc5912a-78d3-b289-2a1a-59b514881ce1.png)

です。
[ngrok](https://ngrok.com/)が払い出してくれたURLにアクセスすると、めぐりめぐってローカルマシンにつながります。

[ngrok](https://ngrok.com/)を利用して、@piacerex さんのローカルマシンで動かしている[Livebook](https://github.com/livebook-dev/livebook)にみんなでアクセスして、モブプログラミングを楽しみました。

## Twitterでの反応

以下、モブプログラミングの様子をTwitterから拾ってみます。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Livebookを使った20名以上同時モブプログラミングをイベント内で実行してみたけど、メチャクチャ楽しいねッ😆 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br><br>私のローカルPC上のLivebookをngrokでインターネット共有し、そこに全員が入る形で実現した😉<br><br>VSCode LiveShareを上回る実用面があり、入門者ガイドとかもキッチリできそう😌 <a href="https://t.co/M9m9xJ82vr">pic.twitter.com/M9m9xJ82vr</a></p>&mdash; piacere (love Elixir&amp;Gravity＋仮想世界創造機構) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1496105396880416769?ref_src=twsrc%5Etfw">February 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br>20人ぐらいで<a href="https://twitter.com/piacere_ex?ref_src=twsrc%5Etfw">@piacere_ex</a>さんのPCにアタックする会ｗ <a href="https://t.co/55nphMwhKL">pic.twitter.com/55nphMwhKL</a></p>&mdash; ymn (@ymnbuild) <a href="https://twitter.com/ymnbuild/status/1496095874279165952?ref_src=twsrc%5Etfw">February 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">みんなでわちゃわちゃ編集＆実行できて面白い！ <a href="https://t.co/XwF9w7T3mq">pic.twitter.com/XwF9w7T3mq</a></p>&mdash; myasu🍊2/26,27虹4th,3/5水6th (@etcinitd) <a href="https://twitter.com/etcinitd/status/1496090925470461952?ref_src=twsrc%5Etfw">February 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">このカオス感！とても楽しかった！！ <a href="https://t.co/nK1MJncPrP">https://t.co/nK1MJncPrP</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1496107421840048129?ref_src=twsrc%5Etfw">February 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

20名程が参加して、
<font color="purple">$\huge{ワチャワチャ、}$</font>
<font color="purple">$\huge{キャハハ、}$</font>
<font color="purple">$\huge{ウフフ}$</font>
していました。

これもライブで参加した人だけが感じられるライブ感でした。
楽しかった〜〜〜
Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
したぜ〜〜〜



# 21:00 本会終了

21:00くらいに一旦、本会は終了しました。


以降は懇親会です。
内容は
<font color="purple">$\huge{ムフフ💜💜💜}$</font>
です。

とてもここには書けません。
ぜひ、次回の[「【増枠】LiveView JP#5：多人数タイプゲームで盛り上がろう＋LiveView SPA学ぶ」](https://liveviewjp.connpass.com/event/237626/)に参加して、あなた自身で体験してみてください！！！






---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>
<font color="purple">$\huge{Enjoy\ Livebook🚀}$</font>

2022/02/22(火)に開催された[**【更に増枠】LiveView JP#4：Livebook始めよう＋Fly.io／ngrokでモブプロ**](https://liveviewjp.connpass.com/event/237625/)のレポートをお届けしました。
次回も楽しみです！！！



## 次回

次回の[NervesJP](https://nerves-jp.connpass.com/)の開催予定日は、
<font color="purple">$\huge{3月22日}$</font>
です。
Coming soon!!!
Don't miss it!!!

https://liveviewjp.connpass.com/event/237626/

すでに申し込みを開始しています:rocket::rocket::rocket:



Twitterのハッシュタグ[**#liveviewjp**](https://twitter.com/hashtag/liveviewjp)にご注目ください！



---

# 編集後記

本日2022/02/22は、2(にゃん)が続くとのことで、[猫の日](https://twitter.com/hashtag/%E7%8C%AB%E3%81%AE%E6%97%A5)です。

私のアイコンは猫のつもりです。
名前は、名乗るほどのものではありませんが、Honeko（ホネコ）と言います。
Hon(本) + neko(ネコ) = Honeko（ホネコ）です。
名乗るほどのものではありません。

![スクリーンショット 2022-02-22 23.11.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b8d23e36-fa4b-9fc4-f8a4-86a18faf091b.png)

妻がペイントで描いて、私がペンキ機能？　でドボッと色を塗った共同作業です。

次の[猫の日](https://twitter.com/hashtag/%E7%8C%AB%E3%81%AE%E6%97%A5)は、200年後の2222/02/22でしょうか。
私は常識的にはもうこの世にはいません。
ただ輪廻転生みたいな話でまた(まだ!?)いるかもしれないし、Elixir、Phoenixにより長寿の秘訣を手に入れているかもしれません。
Elixirは不老不死の霊薬です。
Phoenixは不死鳥です。
**We are the Alchemists, my friends!!!** ーー この精神が受け継がれ、世界文化がますます進展していることを祈念します。
200年後のあなた（アルミン）に読んでもらえることを切に願います。
 

---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-22])
91
```


そうそう！
2月24日発売予定の[WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)をはじめられたばかりの方も、腕におぼえがある方も、どんなものなのかなあと様子見をきめこんでいる方も、
つまりは
<font color="purple">$\huge{全人類のみなみなさま！！！}$</font>
**お手にとって、お楽しみください!!!**


<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [fukuoka.ex特別編:WEB+DB PRESS vol127 Phoenix特集こたつで座談会](https://fukuokaex.connpass.com/event/239094/)

https://fukuokaex.connpass.com/event/239094/

https://gihyo.jp/magazine/wdpress/archive/2022/vol127

出版記念イベントが開催されます。
ぜひご参加ください。

**2022/03/08(火) 19:30 〜 21:00**
**この本を多くの方に知っていただき、出版という ”おめでたい” イベントを、執筆陣全員と皆さまで、ぜひ同じこたつに入ってのんびり座談会するかのように楽しんでいただきたいと思います。**


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
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@kn339264) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)

# [Elixir](https://elixir-lang.org/)のイベント情報

@koga1020 さんが作成されたイベントカレンダーがあります。
[https://elixir-jp-calendar.fly.dev/](https://elixir-jp-calendar.fly.dev/)

https://elixir-jp-calendar.fly.dev/

気になるイベントにはぜひ参加してみましょう!!!

上記サイトの解説記事は[こちら](https://zenn.dev/koga1020/articles/6e67765cc53539)です。

https://zenn.dev/koga1020/articles/6e67765cc53539


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)


---



