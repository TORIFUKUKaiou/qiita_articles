---
title: 'NervesJP #23 2月18日 mix upload ライブ調査回（2022/02/18）レポート |> NervesJP探検隊 結成記念回！！！'
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-22T22:34:08+09:00'
id: e167810d20035f23be4c
organization_url_name: fukuokaex
slide: false
---
**不幸にして意気地のない上司についたときは新しいアイデアは上司に黙って、まず、ものをつくれ**

Advent Calendar 2022 49日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

本日2022/02/18(金)は

https://nerves-jp.connpass.com/event/236900/

**NervesJP #23 2月18日 mix upload ライブ調査回**
が開催されました。
そのレポートです。

ワクワクとドキドキを興奮そのままに、
<font color="purple">$\huge{愛と感動}$</font>
を余すことなくお伝えします。
惜しくも参加できなかった方は雰囲気をつかんでつかんでいただいて、ぜひ次回はご参加ください。
参加した方は、公開されている資料のリンクなどを貼っておりますので、ふりかえりにご活用ください。

[mix upload](https://github.com/nerves-project/ssh_subsystem_fwup/blob/main/lib/mix/tasks/upload.ex)を深く掘っていく回です。




## 次回

次回は**2022月3月吉日 19:30-21:00**の予定です。



## ハイライト

らしさ。
<font color="purple">$\huge{NervesJPらしさ}$</font>
が全面に出た良い回でした。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">まぁこんな感じも <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> らしさってコトでみなさん楽しんでもらえてたようで良かったです．昼に寝れたら良い夢が見れるかも？？</p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1494829941472776192?ref_src=twsrc%5Etfw">February 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<font color="purple">$\huge{らしさ}$</font>
しかない。

男らしさ、女らしさって一体なに！？
[NervesJP](https://nerves-jp.connpass.com/)らしさとは？　ーー 私の筆力で伝えることは難しいのですが、いつもよりTwitterを大目に引用してできる範囲で書いてみます。

<font color="purple">$\huge{NervesJP\ 探検隊}$</font>
が結成されました！

## 資料集

以下、本回でよく参照していた資料です。

### [ElixirでIoT！？ナウでヤングでcoolなNervesフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)

@takasehideki 先生の**ナウでヤングでcoolな**資料です。
特に以下のページをよくみていました。
[Nerves]()の内部構造が書かれています。

![スクリーンショット 2022-02-18 19.53.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5563c13f-5bf9-7626-d277-c54cf86de8ac.png)

### [fwup.conf](https://github.com/nerves-project/nerves_system_rpi4/blob/5d34cab0eae0f3e4578492d5c67ad40da4cf4309/fwup.conf)

https://github.com/nerves-project/nerves_system_rpi4/blob/5d34cab0eae0f3e4578492d5c67ad40da4cf4309/fwup.conf

ここに書いてあることを読み解いていました。


----

# 19:35

Zoomで開催しました。
**everyone, onlineでenjoyです。**

この時点では9名参加しています。
遅れた方もいらっしゃって、最終的には11人参加していました。
13人申し込みで11人ですから、84%の出席率です。


# 19:45 探検開始

19:35に来ていた人のみで自己紹介をまわしました。
その後、早速本題に入りました。

@pojiro 隊長が、[mix upload](https://github.com/nerves-project/ssh_subsystem_fwup/blob/main/lib/mix/tasks/upload.ex)タスクの奥深くへと入り込んでいく様を、お茶の間で楽しむ ーー そんな構図です。

途中、 @takasehideki 先生が合いの手をいれながら、Oheさんをお茶の間から呼び出します。
Oheさんは、その後、入隊していっしょに奥深くへと入り込んでいっていました。
@kikuyuta 先生はというと、そわそわしています。
オリンピック、特に**ロコ・ソラーレ**が気になって気になってそわそわしています。

と、言ってみたところで参加していない人にはなんのことだかさっぱりわからないでしょう。

## なつかしの川口浩探検隊シリーズ

そこでたとえ話をしてみます。
私の印象です。
私の感じ方です。
昭和の名番組「[水曜スペシャル 川口浩探検隊](https://www.youtube.com/watch?v=VogtUerCUro)」の撮影現場、生素材をみているようでした。

https://www.youtube.com/watch?v=VogtUerCUro

なんだか知らないし、にわかには信じられないけれども、最後までみるとその正体が明らかになるのではないかというワクワク、ドキドキ感で最後までみちゃうあの名番組です。

本回と[水曜スペシャル 川口浩探検隊](https://www.youtube.com/watch?v=VogtUerCUro)との違いは、完成されたコンテンツではなく、生のメーキングシーンだということです。
その生のメーキングシーンを楽しめるかどうか。
[Nerves](https://www.nerves-project.org/)を楽しむ気持ちが必要です。
もちろん編集をして印象的なシーンを自在に前にもってきたり、後ろに移動したり、おどろおどろしく重々しいナレーションを入れることでついつい最後までみてしまうコンテンツに昇華することができるとおもいます。



さらにもうひとつの違いは、本回にはいつでも入隊できるということです。
川口浩隊長に着いていくことはできませんが、本回にはいつでも参加することができます。
@pojiro 隊長はあなたの入隊を待っています。

あなたも
<font color="purple">$\huge{NervesJP\ 探検隊}$</font>
に入隊してみませんか！？


# Twitter

本回の様子をTwitterから拾ってみます。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ガリゴリ手をいごかしている <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <br>Nerves.Runtime.KV.get_all しらんかった〜</p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1494631810856210433?ref_src=twsrc%5Etfw">February 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">/dev/rootdisk0 is なに？？ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1494634005538295808?ref_src=twsrc%5Etfw">February 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">うわ〜っもうちょいで真相を突き詰められそうなのに，気になって夜しか寝れないっ！！ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1494646696629866501?ref_src=twsrc%5Etfw">February 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

![スクリーンショット 2022-02-19 10.12.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5acb8850-5f53-3c69-331b-cf6a756c6b9b.png)


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">まぁこんな感じも <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> らしさってコトでみなさん楽しんでもらえてたようで良かったです．昼に寝れたら良い夢が見れるかも？？</p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1494829941472776192?ref_src=twsrc%5Etfw">February 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ドタバタ調査になってしまいました💦<br><br>Nerves, Elixirで「こういうのを知りたい」ということがありましたら挙げていただければ、その内容でみんなで議論できて楽しいと思います！<br><br>昨日はご参加いただきありがとうございました！</p>&mdash; 衣川亮太💉💉, ソフトウェア開発を行う Tombo Works 代表 (@pojiro3) <a href="https://twitter.com/pojiro3/status/1494816530022158336?ref_src=twsrc%5Etfw">February 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 21:30 本会終了

時間切れにより、最後まで正体を明らかにできなかったのは、本家と同じフォーマットでした。

https://www.youtube.com/watch?v=VogtUerCUro&t=3760s

**我々は幻を見たのか、いや違う。**
**あと一歩でその姿を目の当たりにすることができたのだ！**
**だが非情にも我々に許された時間の終わるときがきたのである。**

[mix upload](https://github.com/nerves-project/ssh_subsystem_fwup/blob/main/lib/mix/tasks/upload.ex)、それはあまりにも深いMixタスクであった。

我々はこれまでNervesの各地を旅して、さまざまな謎を追い、また未知なるものに挑んできた。
だが、これからも知られざる謎と未知とがある限り
<font color="purple">$\huge{我々の挑戦は続くのである。}$</font>





---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>
<font color="purple">$\huge{Enjoy\ Nerves🚀}$</font>

2022/02/18(金)に開催された[**NervesJP #23 2月18日 mix upload ライブ調査回**](https://nerves-jp.connpass.com/event/236900/)のレポートです。
次回も楽しみです！！！
<font color="purple">$\huge{NervesJP\ 探検隊}$</font>
にぜひあなたも入隊してください！

体験入隊はコチラからどうぞ〜

## NervesJP Slack

隊員募集中!!!

https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA

熱烈歓迎！！！
未知の生物、機能、探検したいテーマも大募集しています。
うっかり入隊すると、あなたはすぐに隊長になれます！
現実世界で◯◯長と呼ばれるようになるにはそれなりの時間がかかります。
**NervesJP 探検隊**ならすぐに隊長に昇格できます！

必要なのは、旺盛な好奇心と、[Nerves](https://www.nerves-project.org/)を楽しむ気持ちのみです。

## Nervesどうやってはじめるの!?

超入門資料は[こちら](https://qiita.com/torifukukaiou/items/91441a14dcf66472af39)です。

https://qiita.com/torifukukaiou/items/91441a14dcf66472af39


## 次回

次回の[NervesJP](https://nerves-jp.connpass.com/)の開催予定日は、
<font color="purple">$\huge{3月吉日}$</font>
です。
Coming soon!!!
Don't miss it!!!




Twitterのハッシュタグ[**#NervesJP**](https://twitter.com/hashtag/NervesJP)にご注目ください！



---


# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-18])
95
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)をはじめられたばかりの方も、腕におぼえがある方も、どんなものなのかなあと様子見をきめこんでいる方も、
つまりは
<font color="purple">$\huge{全人類のみなみなさま！！！}$</font>
**お手にとって、お楽しみください!!!**

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [fukuoka.ex特別編:WEB+DB PRESS vol127 Phoenix特集こたつで座談会](https://fukuokaex.connpass.com/event/239094/)

https://fukuokaex.connpass.com/event/239094/

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






