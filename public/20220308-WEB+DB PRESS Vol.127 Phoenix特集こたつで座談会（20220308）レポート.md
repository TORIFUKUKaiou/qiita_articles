---
title: WEB+DB PRESS Vol.127 Phoenix特集こたつで座談会（2022/03/08）レポート
tags:
  - Elixir
  - Phoenix
  - AdventCalendar2022
private: false
updated_at: '2022-03-09T11:21:07+09:00'
id: 26e81d72b4525528a366
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**すみの江の岸による波よるさへや夢のかよひ路人目よくらむ**


---

Advent Calendar 2022 67日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/03/08(火)は、[**【YouTube配信決定！】WEB+DB PRESS vol127 Phoenix特集こたつで座談会**](https://fukuokaex.connpass.com/event/239094/)が開催されました。

[WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127)に、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しめるフレームワーク[Phoenix](https://www.phoenixframework.org/)が特集されました。
[Phoenix](https://www.phoenixframework.org/)が雑誌に載る！　これはめでたい:tiger:！ 　ということで、@kn339264 nakoさんが発起人で会が開催されました。

[YouTube](https://www.youtube.com/watch?v=RyylUNU-_Q4)で配信 :video_camera: されていました:rocket::rocket::rocket:

[elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slackに入っているとより楽しめます。

## Zoomの背景画像

![wdpress127_zoom_bg.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/48ad8266-dd69-9880-e5a7-776459659cf4.jpeg)

@mokichi さん作です。
Zoomの背景画像にぴったりです。



# 19:30 :congratulations: **赤飯** :congratulations:

:congratulations::congratulations::congratulations::congratulations::congratulations::congratulations::congratulations::congratulations::congratulations::congratulations:

@piacerex ピアちゃんと @kn339264 nakoさんの掛け合いからはじまりました。

祝いと言えば、
<font color="red">$\huge{赤飯}$</font>
です。
赤飯の開封の儀からはじまりました。

**Let's get started!!!**

![スクリーンショット 2022-03-08 19.34.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d817d9e2-2312-5dea-fb8b-304ed4ebd986.png)



いいですか、あけますよ！！！
---

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">オープニングアクトお赤飯wwww<br><br> <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/ikRmCNWfPq">pic.twitter.com/ikRmCNWfPq</a></p>&mdash; 古賀 祥造 (@koga1020_) <a href="https://twitter.com/koga1020_/status/1501144592141352960?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WEBDB PRESS！！こういうの嬉しいねぇ！<br> <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/5sENLqHBgM">pic.twitter.com/5sENLqHBgM</a></p>&mdash; Tashiro (@tashiro_web) <a href="https://twitter.com/tashiro_web/status/1501144839231983623?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WEBDBPRESS座談会開幕おめでとうございます！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/bFFjklnnJ0">pic.twitter.com/bFFjklnnJ0</a></p>&mdash; フウト (@fuutotto) <a href="https://twitter.com/fuutotto/status/1501144893724696577?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><a href="https://t.co/a0iiIXmjXT">https://t.co/a0iiIXmjXT</a><br><br>に参加しています。 <a href="https://t.co/NawwHXMKkY">pic.twitter.com/NawwHXMKkY</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1501144901882310666?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">赤飯！笑<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/L3U5zukqim">pic.twitter.com/L3U5zukqim</a></p>&mdash; Koyo(miyamu) (@KoyoMiyamura) <a href="https://twitter.com/KoyoMiyamura/status/1501144939560071172?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/WDPress?src=hash&amp;ref_src=twsrc%5Etfw">#WDPress</a><br>めでたい！ <a href="https://t.co/yM5l4Pwjb6">pic.twitter.com/yM5l4Pwjb6</a></p>&mdash; けんぞう (@kenzonag) <a href="https://twitter.com/kenzonag/status/1501144991543881729?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="und" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/hADyfwwD0r">pic.twitter.com/hADyfwwD0r</a></p>&mdash; ymn (@ymnbuild) <a href="https://twitter.com/ymnbuild/status/1501145073865527298?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><br><br>ながら参加。<br>オープニングで公開された画像w<br>「WEB DB PRESS」と書いてありますね（笑 <a href="https://t.co/BJFG6c8XiC">https://t.co/BJFG6c8XiC</a> <a href="https://t.co/8753DJjoz3">pic.twitter.com/8753DJjoz3</a></p>&mdash; みずりゅ＠技術書典12で「Elixirへのいざない ネイティブアプリを錬金しよう」を頒布 (@MzRyuKa) <a href="https://twitter.com/MzRyuKa/status/1501145160536629260?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「WEB+DB PRESS vol127 Phoenix特集こたつで座談会」は赤飯スタートだよ！ <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/XGB6WpyIGa">pic.twitter.com/XGB6WpyIGa</a></p>&mdash; nako@1日9時間睡眠 (@kn339264) <a href="https://twitter.com/kn339264/status/1501145301813719041?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


# 19:38 @koga1020 さんによる司会進行

会がはじまりました。
@koga1020 さんによる雑誌の紹介が行われました。

![スクリーンショット 2022-03-08 19.46.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9701c7f0-c04a-94a0-3719-613a65c2120c.png)

<font color="purple">$\huge{爽快感}$</font>
をご堪能ください。

# 19:50 自己紹介

執筆陣の自己紹介です。
あいにく @tamanugi さんは欠席でした。
本当に残念です。

- @kentaro あんちぽさん
- @takasehideki 先生
- @torifukukaiou 
- @the_haigo さん 
- @mokichi さん

の順にまわしました。

![スクリーンショット 2022-03-08 22.23.37.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a2be83a2-9507-7708-08cf-2670e32bf949.png)

![スクリーンショット 2022-03-08 22.23.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ae197a21-d700-2c7c-9ea5-758e3497c45c.png)



# 19:53 お祝いのメッセージ

お祝いのメッセージを頂戴しました。

- @kikuyuta 先生（レビューアー)
- @FRICKさん
- @koyo-miyamura さん（レビューアー)
- @piacerex ピアちゃん（レビューアー)

@FRICKさんは本人もいるけどビデオメッセージでした〜

![スクリーンショット 2022-03-08 19.56.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e8296c87-966d-7d99-6010-6f283f998bc3.png)





# 19:59 @kentaro あんちぽさんによる「[WEB+DB PRESSで特集記事を書く方法 / How to Become an Author of WEB+DB PRESS](https://speakerdeck.com/kentaro/how-to-become-an-author-of-web-plus-db-press)」

https://speakerdeck.com/kentaro/how-to-become-an-author-of-web-plus-db-press

@kentaro あんちぽさんによる「[WEB+DB PRESSで特集記事を書く方法 / How to Become an Author of WEB+DB PRESS](https://speakerdeck.com/kentaro/how-to-become-an-author-of-web-plus-db-press)」の話がありました。
雑誌に書いてみたいですか！
名前が載りたいですか！
ぜひこちらを読んで、名乗りをあげてください！
「や〜、や〜、われこそは○○なり！」

@kentaro あんちぽさんは、今回で6回目とのことです。
企画を技術評論社さんに通してくださいました。
今回の叙勲をすると間違いなく
<font color="purple">$\huge{勲一等}$</font>
の功績に値します。

あとは今回惜しくも参加できなかったのですが、 @tamanugi さんのリファレンス実装はとてもありがたかったです！


![スクリーンショット 2022-03-08 22.32.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ae9e5cb0-8793-9520-b88e-75166541ec7a.png)

グレートな幸運
こういうのを**天佑**というのだとおもいます。


---
話を戻します。
雑誌に書いてみたいですか！
名前が載りたいですか！
ぜひこちらを読んで、名乗りをあげてください！
「や〜、や〜、われこそは○○なり！」

![スクリーンショット 2022-03-08 20.11.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fbead213-114e-515a-8165-c95741afd13f.png)

> お金を払ってでも体験したいぐらいの、テクニカルライティングのスキルを磨くまたとない機会

まさに
**その通りです。** ([阿部老人](https://www.iat.co.jp/gogoiwate/backnumber/%E3%82%88%E3%81%86%E3%81%93%E3%81%9D%E5%B2%A9%E6%89%8B%E3%81%B8-%E6%B0%91%E8%A9%B1%E3%81%AE%E9%87%8C%E3%81%B8go%EF%BC%81go%EF%BC%81/)）

ざひチャレンジを！！！ :rocket::rocket::rocket:

<font color="purple">$\huge{次はあなたの番です！}$</font>

雑誌の最後のページをみてみてください。


![154621979-b76e53fc-2b05-49da-a6d2-c94d5e263147.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/584edb7f-9ceb-51e4-658d-ccfd7b1c4784.png)

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: **これ、真に受けちゃっていいんです！**


## 記事のネタ募集中!

雑誌社の方は、記事のネタを常に探しているそうです。
手を挙げるか、手を挙げないか ーー あなた次第です。



## 原典を読みましょう！

「原典を読みましょう！」
これは「書く人」になるために最低限必要な通過儀礼です。
逆に言うと、これさえやっていればすぐにでも「書く人」になれます。
私は齢40歳をすぎるまで気づきませんでした。

本編で言い忘れましたが、書ける人、書けない人をわけるものはたったひとつのことです。
それは英語の原文を読んでいるかどうかです。
これは[Elixir](https://elixir-lang.org/)に限った話だけではなく、あらゆる技術書と呼ばれるものはたいていほとんどのものがそうです。
書いている人がやっていることは英語の原文を理解して日本語で自分の言葉で書いていることが大半です。
英語を読むことを苦手だとおもっている人が多いから、本や雑誌として成立しているのです。
原典をあたりましょう。

これはもっと言うと、論語や西郷南洲遺訓が読み続けられている仕組みとある意味同じなのです。
まず論語や西郷南洲遺訓は、孔子や大西郷先生が書き残したわけではないのです。
弟子たちや話を聞いて感銘を受けた人たちが書き残しています。
オリジナルの人たちは自分では書かないものなのです。
いまだに読み続けられているのは、もともとご本人が書いたものではないものをアレコレと時代に即して解釈を加えながら出版され続けているからなのです。
なかには途中の解説本の解説もあるでしょうが、そういうものはたいてい詰まらないものです。
やはりおもしろいものは原典と作者が体当たりをしています。

**「各経典の原文を熟読して記憶し、黙考することにつとめよう」**
1817年に日田で咸宜園という私塾をはじめた広瀬淡窓先生の言葉です。
咸宜園の出身者には、高野長英、大村益次郎、長三州、上野彦馬、清浦奎吾などがいます。
（私も跡地で入塾の手続きをしました。咸宜園の末席を汚しておるわけです。）

幸い[Elixir](https://elixir-lang.org/)や[Phoenix](https://www.phoenixframework.org/)は作者がdocumentを残しています。
こんな幸運で書きやすいことはないのです。
それを読んでいるか、いなか ーー ここが書く人と読む人をわけるポイントです。

[Elixir](https://elixir-lang.org/)に限った話だけではないのです。
英語を読むか、読まないか -- ただそれだけです。
本や雑誌には誌面の都合があるので全部は書けません。
英語から日本語にするときにだいぶ情報は省略されています。

ずーっと、誰かが書いたものを日本語で読み続けることで満足しますか、あなたが書きますか。
Why not?

<font color="purple">$\huge{次はあなたの番です！}$</font>


# 20:10 座談会

@koga1020 さんの進行で座談会は進みました。

Twitterの声を拾います。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">書店にElixir・Phoenixの文字並んでるの熱いですねぇ<br><br> <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; 古賀 祥造 (@koga1020_) <a href="https://twitter.com/koga1020_/status/1501149784396075009?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">終始お祝いムードからのあんちぽさんによるLT🚀 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; 古賀 祥造 (@koga1020_) <a href="https://twitter.com/koga1020_/status/1501151170106036228?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">お祝いメッセージめでたい <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; nako@1日9時間睡眠 (@kn339264) <a href="https://twitter.com/kn339264/status/1501151393776046082?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「コミュニティへのお返し」っていうマインド素敵 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; 古賀 祥造 (@koga1020_) <a href="https://twitter.com/koga1020_/status/1501151528714792961?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">あんちぽさんのスライド、シンプルなのに臨場感ある👀<br>提案から8分後に目次が決まり、30分ちょいで話がだいたい固まる…<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501152293982400513?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">GitHub上で執筆進むの良き <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; 古賀 祥造 (@koga1020_) <a href="https://twitter.com/koga1020_/status/1501152587948576768?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> あんちぽさんのTL、執筆企画から特集の出版の仕方まで凄くためになる…！！</p>&mdash; FRICK/フリック@仮想世界創造機構 (@TewiEwi_no96) <a href="https://twitter.com/TewiEwi_no96/status/1501153642493407239?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「アウトラインがしっかりしていれば、執筆自体はなんとかなる。」<br><br>全体の見通しをしっかり立てるっていうのはプログラミングも執筆も同じかぁ。<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501153689863524353?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「WEB+DB PRESS vol127 Phoenix特集こたつで座談会」にて、執筆陣／出版関係者、そしてイベント参加者の皆さん50名オーバーが、一緒の「バーチャルこたつ」に入ってぬくぬくしながら、おめでたいカンパイの様子はこんな感じでしたー😆 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://twitter.com/hashtag/fukuokaex?src=hash&amp;ref_src=twsrc%5Etfw">#fukuokaex</a> <a href="https://twitter.com/hashtag/autoracex?src=hash&amp;ref_src=twsrc%5Etfw">#autoracex</a> <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://twitter.com/hashtag/ElixirDI?src=hash&amp;ref_src=twsrc%5Etfw">#ElixirDI</a> <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/KNm2OX1c4g">pic.twitter.com/KNm2OX1c4g</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1501154077258153987?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ウチラ、Elixir楽しんでるだけ😜 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1501154725768888320?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「WEB+DB PRESS vol127 Phoenix特集こたつで座談会」で「WEB+DB PRESSで特集記事を書く方法」というお話をしました。<br><br>技術雑誌記事の企画・執筆について、具体的な流れやtipsなどを盛り込みました。執筆者が増えるきっかけになるとうれしいです！<a href="https://t.co/TyQHWqsJfM">https://t.co/TyQHWqsJfM</a><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; antipop.eth (@kentaro) <a href="https://twitter.com/kentaro/status/1501155056523300869?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">【Elixirに触れたきっかけ】<br>あんちぽさん→Nervesから<br>torifukuさん→kokura.exから<br>haigoさん→e-ZUKA Tech Nightから<br><br>皆様、「気がついたらすごいことになっていた」とのこと👀✨<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501155877348253699?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">3章のまとめは実質私が書いた（！？）<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; Koyo(miyamu) (@KoyoMiyamura) <a href="https://twitter.com/KoyoMiyamura/status/1501156516082360320?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Yes! <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><br>Yes, you did.</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1501165616597590019?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Phoenixの認証コードは、ライブラリの提供ではなく、コード生成である点がすごいなぁと思う<br><br>学習にもなるし、カスタマイズしやすいですよねb<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; Koyo(miyamu) (@KoyoMiyamura) <a href="https://twitter.com/KoyoMiyamura/status/1501156956622716928?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">確かにElixirってどれもこれも実践的だと思うんだよね。<br>そしてmokichiさん…分量紙面の4倍書いたのかぁ…😲<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501157421040877571?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ページ数の枷がなかったらどんな記事になるんだろうと気になる by takase先生。たしかに気になる <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; nako@1日9時間睡眠 (@kn339264) <a href="https://twitter.com/kn339264/status/1501159373883998208?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">執筆者から他の執筆者の章を褒めるタイム。第5章が人気の模様！<br>あとはtamanugiさんのrealworldの話が聞ければよかった！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501159504590770176?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><br>老婆心旺盛なtorihukuさんω</p>&mdash; FRICK/フリック@仮想世界創造機構 (@TewiEwi_no96) <a href="https://twitter.com/TewiEwi_no96/status/1501160275030192129?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><br><br>半年弱の短期間執筆を支えたのはオーサムBot（締め切り等への通知）だった</p>&mdash; みずりゅ＠技術書典12で「Elixirへのいざない ネイティブアプリを錬金しよう」を頒布 (@MzRyuKa) <a href="https://twitter.com/MzRyuKa/status/1501160560531886080?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">執筆者は互いにリアルで会ったことがない？！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501161687558213636?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a><br><br>今回の執筆者6名、実は執筆中に（と言うよりもそれ以前にも）直接会ったことがないと言う。。。<br>なのに、まとまった記事をかけたと言うのが、素晴らしい</p>&mdash; みずりゅ＠技術書典12で「Elixirへのいざない ネイティブアプリを錬金しよう」を頒布 (@MzRyuKa) <a href="https://twitter.com/MzRyuKa/status/1501161961991512069?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> WebDB PRESSの出版全てGitHubでやって編集者からの修正などもそこでやってたって、出版社もGitHub使う時代なんだなぁ</p>&mdash; FRICK/フリック@仮想世界創造機構 (@TewiEwi_no96) <a href="https://twitter.com/TewiEwi_no96/status/1501162081756020736?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「私にとってphoenixはphoenix(フィーニックス)ですね！」<br>？？！！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501162447251460097?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">We are the alchemist, my friends.<br>Programmer&#39;s best friend.<br>Elixirコミュニティって本当に温かいよね。日本も海外も。<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501162932884836352?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Phoniexの「presence」… <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> さんが説明中…は、WebSocketやLiveViewのバックグラウンドになってます😉 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1501163165354463236?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">We are the alchemist <br>Elixirコミュニティは温かいらしい！これから参加していきたい😆<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; フウト (@fuutotto) <a href="https://twitter.com/fuutotto/status/1501163444829327360?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Elixirの良さは、リアルタイム性、安定性、軽量性。<br>開発の生産性を高める本質がぎゅっと詰まってる！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501163944295092225?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">LiveView使うといい感じUIができますよね～<br>SPA並みのリッチなUIできるのに、サーバで状態持てるのがでかい<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; Koyo(miyamu) (@KoyoMiyamura) <a href="https://twitter.com/KoyoMiyamura/status/1501164923904466945?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">オーガナイザ、nakoさん！<br>誰もやらないのなら自分がやろうって手を挙げる勇気、かっこいい！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1501166258141601800?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <br>ElixirとJSのみでDeepLearningを使用したアプリケーションとか作ってます <a href="https://t.co/WYaO7UwOSl">pic.twitter.com/WYaO7UwOSl</a></p>&mdash; ShouTakafuji (@the_haigo) <a href="https://twitter.com/the_haigo/status/1501166502443352064?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">各章の見所、裏話、執筆についてや実務でのElixirの実例といった盛り沢山の内容であっという間に座談会の本編が終わってしまった😇<br>初心者にも触れやすく、理解しやすい素晴らしい記事の執筆ありがとうございます！<br>YoutubeLive配信ですが座談会参加したことでモチベーションが上がりました<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; フウト (@fuutotto) <a href="https://twitter.com/fuutotto/status/1501167098814689281?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WEB+DB PRESS Vol.127 Phoenix特集トークイベント、執筆陣の皆さま、出版関係者の皆さま、Zoom／YouTubeでご参加いただいた皆さま、そしてイベント運営の皆さま…おめでたい「こたつ」を53名もの皆さまと囲んでご一緒😌 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <br><br>「赤飯開幕」からアッと言う間の90分…楽しんでいただけましたか？🤔 <a href="https://t.co/mjwtsJUFqK">pic.twitter.com/mjwtsJUFqK</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1501191971896844288?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 21:00

@Yoosuke さんによるお祝いの言葉


---
編集者のinaoさんからコメントをいただきました。

- 共著を読者の方に読みやすいように仕上げるのは難しかったりするのですが、みなさまのチームワークはとてもすばらしかった
- すばらしいイベントを行ってくださいまして、本当にありがとうございました！
- ご挨拶もできましてうれしかったです。

実は、 @kentaro あんちぽさん 以外の他の執筆者は inao さんとお話するのははじめてでした。
こちらこそ「本当に」ありがとうございました。
（なに目線かはヒ・ミ・ツですが）この場をお借りして、inaoさんに感謝を申し上げます。

---
そして最後に発起人の@kn339264 nakoさんの締めです。


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日は良い座談会でしたね！スピーカーの皆さん、参加者の皆さん、ありがとうございました！by 座談会発起人 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a></p>&mdash; nako@1日9時間睡眠 (@kn339264) <a href="https://twitter.com/kn339264/status/1501171350224121869?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

こちらこそありがとうございました。
Thanks a lot!!!です。

# 21:00-22:00

本会は終了してあとはフリーディスカッションです。
内容は
<font color="purple">$\huge{ムフフ💜}$</font>
です。

[Elixir](https://elixir-lang.org/)のコミュニティにまだ入っていない方は、ぜひ参加して、あなたの目で確かめてください！

## [elixir-jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)

[elixir-jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)に飛び込んできてください。

## Elixirイベントカレンダー

https://elixir-jp-calendar.fly.dev/

![スクリーンショット 2022-03-08 23.19.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/be152bd6-82ea-e978-24ee-f13c1b50b436.png)

活発にイベントが開催されています。
イベントに参加してみましょう。
どのコミュニティもあなたの訪れを**熱烈歓迎**してくれます。

それぞれのコミュニティの特徴は以下の資料にまとまっています。

[Elixirコミュニティ の歩き方 －国内オンライン編－](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)

https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian


# お疲れさまでした！

@kn339264 nakoさん、お疲れさまでした！

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">座談会が終わったのでこれから食べます〜 <a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/Yfsb1o9CaM">pic.twitter.com/Yfsb1o9CaM</a></p>&mdash; nako@1日9時間睡眠 (@kn339264) <a href="https://twitter.com/kn339264/status/1501178104722591749?ref_src=twsrc%5Etfw">March 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


ゆっくり赤飯を食べてください。
お疲れさまでした。


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/03/08(火)に開催された、[**WEB+DB PRESS vol127 Phoenix特集こたつで座談会**](https://fukuokaex.connpass.com/event/239094/)のレポートを書きました。

[elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slackに**Let's join us! (れっつじょいなす)**

本屋 :books: さんへ、急げ〜:rocket::rocket::rocket:
[WEB+DB PRESS Vol.127](https://gihyo.jp/magazine/wdpress/archive/2022/vol127)

以上です。





