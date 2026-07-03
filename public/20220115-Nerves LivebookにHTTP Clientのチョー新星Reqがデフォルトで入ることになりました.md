---
title: Nerves LivebookにHTTP Clientのチョー新星Reqがデフォルトで入ることになりました
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-08-14T12:10:45+09:00'
id: 66e21a5a497ef5dbf4b2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**少年よ大志を抱け Boys be ambitious!**

Advent Calendar 2022 15日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)を楽しんでいますか:bangbang::bangbang::bangbang:

<font color="purple">$\huge{Enjoy\ Nerves\ Livebook🚀🚀🚀}$</font>

今回は、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)にHTTP Clientのチョー新星[Req](https://hexdocs.pm/req/Req.html)がデフォルトで入ることになりました。
私の[プルリク](https://github.com/livebook-dev/nerves_livebook/pull/148)が通ったのです。

<font color="purple">$\huge{私のプルリクが通ったのです🎉🎉🎉}$</font>

この記事では、プルリクを出した動機を語ります。

## What's [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) ?

[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)とは、[Elixir](https://elixir-lang.org/)でIoTを楽しめる**ナウでヤングでcoolなすごいヤツ**である[Nerves](https://www.nerves-project.org/)でJupyter感覚でNotebookを楽しめるものです。
要は、Raspberry Piで簡単に[Elixir](https://elixir-lang.org/)プログラミングを楽しめる環境を作れます。
IoTのHello, WorldであるブレッドボードつないでLEDチカチカとかもできます:rocket::rocket::rocket:

詳細は以下の記事をご参照くださいませ:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nerves-livebook


## HTTP Clientのチョー新星[Req](https://hexdocs.pm/req/Req.html)について

最近、記事を書きました。
YoungなHTTP Clientです。

https://qiita.com/torifukukaiou/items/4d842c6acae2b8967467

@zacky1972 先生と @im_miolab さんが毎週水曜日08:30に開催されている[【kokura.exラジオ】](https://fukuokaex.connpass.com/event/236141/)にて、私のことを指して、**[Elixir](https://elixir-lang.org/)界のEarly Adopters**との称号をいただきました :tada:

# プルリクを出した動機

- 素の[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)でいろいろ楽しめることをもっと知ってもらいたい！！！　
- たくさんのfolksたちにぜひRaspberry Piでイゴかしてほしい[^4]!!!

[^4]: 「動かして欲しい」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^5]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^5]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。



これらが根底にあります。
そのうえで、あんまりIoT、IoTしていない人はデータをどこかに送信してみたいという欲求がでてくるとおもっています。偏見でしたらすみません:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

ところがですよ、そのHTTP通信を素の[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)でやろうとするとつらいのですよ。

- 素の[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)で、HTTP通信のプログラムを実行したいときはおっかないErlangのプログラムを書くしかなく、けっこうつらい
- [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)に[HTTPoison](https://github.com/edgurgel/httpoison)や[Req](https://hexdocs.pm/req/Req.html)を追加してファームウェアをビルドすることはできるけど、それはやってみると実は簡単なことなんだけど、ぱっと見手順が難しそうにみえるし、たしかにプログラミング初心者ですみたいなレベルの人には超えないといけないハードル(特に環境構築とか環境構築)がちょっと高い

それで、特にプログラミング初心者向けにHTTP clientをデフォルトで追加してみてはどうでしょうか！　というプルリクを出してみたら、通ったという次第です。

プルリクに書いた英文は以下の通りです。

```
Hi! I have a proposal. How about including Req in the default dependency list in mix.exs?

I think entry-level users will likely want to do some HTTP requests at some stage.
They could install Req by themselves, but it would be handy if the popular HTTP client is available by default.
What do you all think?

BTW I really enjoy nerves livebook. I published a demo YouTube video: https://www.youtube.com/watch?v=-c4VJpRaIl4 .
```

英語完璧でしょ！
完璧すぎるんです!
種明かしすると、私が書いていません。
**英語に強い人に**添削という名で**全部書いてもらったので!**
英語についての話はまた記事をわけて書きます。
別の方向に言いたいことがあるので。

本記事でお伝えしたいことは以上です。
以下、今度はこの記事を書いた動機を書きます。
~~Advent Calendar 2022を埋める~~ (偽らざる気持ちではあります)
**Elixirはあなたの貢献を待っていますよ:rocket:** (きっと)
を伝えたいのです。


# :tada:名乗るほどのものでもない名[^2] を[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)の歴史(コミット)に刻みこみました:tada:

[^2]: そうやって枕詞のように「名乗るほどのものではありませんが」と言って、いつもしっかり名乗っています。いきなり「山内です」と言うより一瞬「あれ？」って注意を引くので、マヂで心理学的にはこちらの支配下に置くだなんだの効果があるとかないとか。私はそんなことは一切考えていません。素でやっています。あえて原点を求めるとすると、「あしたのジョー」でジョーが少年院の先輩方に「聞かれて名乗るのはおこがましいが」なんとかかんとかと発言するシーンと、古くからの友人がふざけて30年近く前に言っていたのを私ひとりが記憶していてずっと言っているわけです。私のしつこさを物語るエピソードです。


https://github.com/livebook-dev/nerves_livebook/pull/148

![スクリーンショット 2022-01-14 14.51.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/875315fd-9fb7-cb8e-9872-b15dec8cfd1e.png)

記念撮影です。
左上に[Frank Hunleth](https://twitter.com/fhunleth)さんと並んで私のマスコットが写っています。
右下のContributorsには、すでに貢献されていた @takasehideki先生と @mnishiguchi さんが写っています。
私が主催している[autoracex](https://autoracex.connpass.com/)コミュニティが[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)をジャックした瞬間です。
小が大を喰う合併です。(万俵 大介)

<font color="purple">$\huge{嘘です。}$</font>
ジャックも合併もしていません。
ましてや豆の木には登っていません。

妄想が過ぎましたが、はからずも達成感を飾らずに表現するとそんな心境であることは嘘ではありません。
世界的なソフトウェアに一行でも参加できたことは**とても誇らしいもの**です。
世界の中心で愛を叫びたくなります[^3]。

[^3]: 「elixir azure 愛」で検索🔍。 https://www.youtube.com/watch?v=R3o8vR1A9ao

すでに世界的に活躍されている方はいちいち細かいことを覚えていられないとおもいますが、そんな方でも最初に世界の扉を押し開けたときにはきっと誇らしい気持ちをお持ちになられたのではないでしょうか。
このレベルには私が達していないので想像するしかありません。

単なる通過点にすぎないことは断言できます。

## まだOSSにコントリビューションしたことがない方へ

[Elixir](https://elixir-lang.org/)界は、あなたの貢献を待っているように私はおもいます。
チャンスはそのへんにゴロゴロ転がっています。
この記事が、貢献への目の付け方のヒントとなり、さらには背中を押してあなたが一歩を踏み出してくれることを願っています。

私の記事を読んでくださっている方は、[Elixir](https://elixir-lang.org/)に興味がある方が大半だとおもいます。
マヂ、チャンスですよ!!!

こんなの欲しい! と思ったら、プルリクを作って提案してみてください:rocket::rocket::rocket:

## 私の貢献

覚えていられれるくらい数が少ないという証左です。

- https://github.com/elixir-lang/elixir/pull/11039
- https://github.com/elixir-lang/elixir/pull/11046
- https://github.com/nerves-project/nerves_bootstrap/pull/163
- https://github.com/phoenixframework/phoenix_live_view/commit/46d870c9f0101dcdf721807053c9ca2bd0c9f766
- https://github.com/livebook-dev/nerves_livebook/pull/148

単なる通過点です。



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

<font color="purple">$\huge{I\ like\ Nerves\ Livebook👍}$</font>
 


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

最後に、[Elixir](https://elixir-lang.org/)のご紹介をします。

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
-  [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @nako_sleep_9h さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

## <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方〜国内オンライン編〜**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian

[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)

---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
