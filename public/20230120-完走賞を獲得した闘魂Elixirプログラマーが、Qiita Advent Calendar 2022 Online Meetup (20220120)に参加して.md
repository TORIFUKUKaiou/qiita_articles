---
title: >-
  完走賞を獲得した闘魂Elixirプログラマーが、Qiita Advent Calendar 2022 Online Meetup
  (2022/01/20)に参加して改めて「アウトプットはいいぞ！」とおもったことを投稿（闘魂）します
tags:
  - Elixir
  - ポエム
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-01-22T06:51:49+09:00'
id: 2ee18ec594e39fb9edc0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>

https://increments.connpass.com/event/267714/

<b><font color="purple">$\huge{アウトプットはいいぞ！}$</font></b>



# はじめに

2023/01/20(金)は、「[Qiita Advent Calendar 2022 Online Meetup](https://increments.connpass.com/event/267714/)」が開催されました。
参加しました。
おもったことを投稿（**闘魂**）します。

![スクリーンショット 2023-01-20 22.20.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/42fbf869-55b6-6264-dbf5-913b9f5a9dec.png)


## 概要

この記事の概要です。

- Twitterの[#Qiitaアドカレ](https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hashtag_click)ハッシュタグがついたメッセージにとにかくいいねをしました
- [完走賞](https://qiita.com/advent-calendar/2022/present-calendar)ありがとうございます！ :tada:
- アウトプットをした人に手厚いフィードバックをされている会社さんがある（投稿には**闘魂**が必要だということ！？)
- アンケートに答えると、[アドベントカレンダー2022](https://qiita.com/advent-calendar/2022)の参加を促されましたが、私は後ろは振り返りません！　[アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)を書きます! 書いています！
- 来年のアドベントカレンダーとは、[アドベントカレンダー2024](https://qiita.com/advent-calendar/2024)のこと!?

私は、[Elixir](https://elixir-lang.org/)が好きでございまして、 @piacerex さんの発表があるので参加しました。
[Elixir](https://elixir-lang.org/)とはプログラミング言語です。
「[Elixir Advent Calendar 2022](https://qiita.com/advent-calendar/2022/elixir)」にてカレンダーいいね賞を獲得しました。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/ohrdev?ref_src=twsrc%5Etfw">@ohrdev</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> <br>Congratulations! <a href="https://t.co/83zhMTePWy">pic.twitter.com/83zhMTePWy</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1616400029056634880?ref_src=twsrc%5Etfw">January 20, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

---

# Twitterの[#Qiitaアドカレ](https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hashtag_click)ハッシュタグがついたメッセージにとにかくいいねをしました

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">statuses =<br> last_created_at()<br> |&gt; <a href="https://t.co/kO4RPtuuvw">https://t.co/kO4RPtuuvw</a>()<br><br>statuses<br> |&gt; <a href="https://t.co/0AayRnz4Mq">https://t.co/0AayRnz4Mq</a>(fn %{id: id} -&gt;<br> Liker.Twitter.Api.create_favorite(id)<br> end)<br><br>片っ端から <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> のツイートをいいねしています。 <a href="https://twitter.com/hashtag/myelixirstatus?src=hash&amp;ref_src=twsrc%5Etfw">#myelixirstatus</a> <br>I use Elixir.<a href="https://t.co/msJIejgctn">https://t.co/msJIejgctn</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1616382185660989440?ref_src=twsrc%5Etfw">January 20, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

自分で押すとイベントを集中して聞けなくなってしまいます。
みなさんのメッセージには**いいね**したいです。
いいねを押すことに熱中してイベントを聞き逃すことがあっては本末転倒です。
そこで、[Elixir](https://elixir-lang.org/)で書いたプログラムで自動的に**いいね**をしました。

ソースコードは以下にあります。

https://github.com/TORIFUKUKaiou/hello_nerves_poncho/tree/main/liker


# [完走賞](https://qiita.com/advent-calendar/2022/present-calendar)ありがとうございます！ :tada:

受賞できました:tada::tada::tada:
ありがとうございます。
週明け!? にいただく住所などの確認は速攻で回答します。
ここに書いてもいいくらいです。

ここに書くのは控えます。
あれこれファンレターや**不安レター**が届いても返信に困りますので。
ガイドラインにも「[個人情報の取り扱いは慎重に](https://help.qiita.com/ja/articles/qiita-community-guideline#part-825516215107ca13)」と書いてありますので私の住所を書くのは控えます。

![スクリーンショット 2023-01-20 22.43.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6e872c0d-c5ea-a128-3b51-a855e35916e4.png)

「[Elixir Advent Calendar 2022](https://qiita.com/advent-calendar/2022/elixir)」カレンダーに**70**記事投稿しました。

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

## 70記事投稿

**70**記事は全然大したことありません。上には上がいます。 @kaizen_nagoya さんです。

[AUTOSAR Countdown Advent Calendar 2022](https://qiita.com/advent-calendar/2022/autosar)

https://qiita.com/advent-calendar/2022/autosar

おひとりでいったいどれだけの数の記事投稿されているのでしょう！？　すごいです。
Amazingです！　驚愕です! 憧れです!
もっと投稿されている方をご存知でしたらぜひお便りをくださいませ。

---

# アウトプットをした人に手厚いフィードバックをされている会社さんがある（投稿には**闘魂**が必要だということ！？)

「アウトプットはいいぞ-組織編-」に移ってからの話だとおもいます。
登壇された企業さまでは、記事を投稿した人に手厚いフィードバックをされているそうです。

私はフィードバックなんてなくても書いています。もしかするとHENTAIなのではないか！？　とおもいました。
ちょっと待てよ、と。最初にQiitaに書いたときはどきどきしなかったか、と。そういうみずみずしい気持ちを忘れているだけで、感覚が麻痺してただ厚かましくなっているだけではないか、と。厚かましいからこの記事を書けるのではないか、と。

ふりかえってみました。[デビュー作](https://qiita.com/torifukukaiou/items/49b0e472844fe466a89d)を書いた当時のことを。
正確にはもうおもいだせませんが、炎上するんじゃないか:fire:とか自意識過剰にそんなことをおもっていました。そんなことはありませんでした。心配する必要はありません。
その後、私は[Elixir](https://elixir-lang.org/)に出会ったのが良かったのだとおもいます。とにかく[Elixir](https://elixir-lang.org/)を題材にした記事を書き続けました。そういえば、いつも今日登壇された@piacerexをはじめ[Elixir](https://elixir-lang.org/)コミュニティの方が数名、いいねやLGTMを毎回してくれていました。
いまとなっては「フィードバックなんていらない」という心境に私はなっていますが、最初のうちはやっぱり母性のような、つまり「**やさしさに包まれたならきっと目に映る全てのことはメッセージ**」が必要なのかもしれません。
いまさら気づきました。私は[Elixir](https://elixir-lang.org/)コミュニティのやさしさに包まれていました。
**ありがとうーーーーッ！！！　ございます。**

## Qiitaは外部記憶装置

投稿（闘魂）することに感覚が麻痺してただ厚かましくなってくると、Qiitaを外部記憶装置として利用させていただくようになります。
この心境になればしめたものです。自分の知見は誰かの役に立つかもしれない、なんて気負う必要もなく、忘れっぽい**未来の自分へ向けて書く**のです。
また書くことで頭の中を整理できますし、書く間に考えていることは脳が大事なことだと認識してくれて記憶に定着するのです。**アウトプットはいいぞ！**　なのです。
ただしこの場合はガイドラインの「[エンジニアにとって再利用性・汎用性の高い記事を書こう](https://help.qiita.com/ja/articles/qiita-community-guideline#part-b4aad8bd99f11ff)」や「[みんなが読んでも理解できる記事を書こう](https://help.qiita.com/ja/articles/qiita-community-guideline#part-dcf67be6af2522fb)」を意識しておく必要があります。

この記事がガイドラインを守っていないぞ！　と親切な方からお言葉をいただける大きなブーメランを放り投げたのかもしれません。

## はじめるには母性のやさしさが必要。さらに上を目指すには厳しい父性が必要だ。(Awesome YAMAUCHI)

それでちょっと思い出したことがあるので書きます。昨今は男らしさ、女らしさなんてあんまり言ってはいけないのかもしれませんが、私は古い人間なのでご容赦いただきたいです。
私が最近気づいたことがあります。
それは
**はじめるには母性のやさしさが必要。さらに上を目指すには厳しい父性が必要だ。**
ということです。

なにを言っているのかわからないとおもいますので説明を続けます。

羽生善治永世七冠がまだ将棋をはじめたばかりのころ、めちゃくちゃ弱かったそうです。だけど将棋に打ち込む姿勢にはなにか光るものがあったようです。それに気づいた将棋道場の席主のグッジョブだとおもいます。本来は存在しない15級という級を特別に羽生少年に作ってあげたそうです。少しずつでも級があがっていけば自信がつくのじゃないかという配慮です。この特別配慮がなければ、羽生善治永世七冠は誕生しなかったとおもいます。なにか物事を始めるには母性的なやさしさが必要なのです。

昨年日本を熱狂させたサッカー:soccer:日本代表に話を転じます。強豪国ドイツとスペインを撃破しました。ドーハの悲劇に代表されるようにワールドカップ出場が目標だったころはあたたかく見守ってあげる必要がありました。ワールドカップに出場できるようになったら次は**世界一**です。マスコミは「悲願のベスト８」なんていいますけど、そういう言い方はもうやめたほうがいいとおもいます。「悲願の優勝」ならまだいいです。ベスト８ってことはもうどこかで負けて帰ってきなさいと言っていることと同じです。ワールドカップに出場できるようになったのです。もっと国民全体で負けた悔しさをバネにすべきです。そうすること**ワールドカップで優勝**:confetti_ball:できます！ 世界平和:sunny:を実現できます!

いい例はソフトバンクホークス:baseball:です。いまでこそ常勝鷹軍団ですが、南海ホークスからダイエーホークスになったときは弱かったです。世界のホームラン王、王貞治監督（当時）に向けて生卵をぶつけるなんてことを血の気の多い北九州のファンはしていました。

> 「『卵をぶつけられるような野球をやっているのは俺たちなんだ。だからこそ、ぶつけられないようにしよう。あの連中に喜んでもらおうよ』という話を選手たちにしました。我々にとってはいい刺激になったと思います」。屈辱の「生卵事件」から3年後の99年、王ダイエーはリーグ優勝を果たし、日本シリーズも制した。

生卵やペットボトルなどものを投げつけたり、罵声を浴びせる必要はありません。そうしろと言ってもいません。こうした厳しい父性が必要なのです。
そしてもっと突き詰めれば、誰かに怒ってもらえるうちはまだまだ甘いのです。自分に打ち克つ必要があるのです。

https://www.nikkansports.com/baseball/news/202005060000249.html

アントニオ猪木さんは、「闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことだとおもいます」と1998-04-04引退試合でドン・フライを4分9秒グラウンドコブラツイストで破ったあとの引退セレモニーで述べられています。
記事を投稿（闘魂)し続けるには、克己といいますか、いいねなんてもらえなくても自分で自分にご褒美を与えるとでもいいますか、魂を鼓舞する闘魂が必要なのです。

王陽明先生は言いました。
**山中の賊を破るは易く、心中の賊を破るは難し。**

山賊に勝つのは簡単です。武器を持ちや大軍で取り囲めば一網打尽です。
それに対して、己の弱い心に打ち克つことのほうがもっと難しいのです。

こんな記事でいいのだろうか、炎上しやしないだろうか、マサカリが飛んできやしないだろうか。
記事を投稿（**闘魂**)することを危ぶんでいらっしゃる方の心情はこんなところでしょうか。

アントニオ猪木さんがいいことを言っています。
「危ぶむなけれ　危ぶめば道はなし 迷わず行けよ 行けばわかるさ ありがとうーーーーッ！！！」

あなたが一歩を踏み出すのを私は応援します。
私は一歩を踏み出して、[日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)をもらいました。雑誌を書きました。新聞に載りました。今年は[完走賞](https://qiita.com/advent-calendar/2022/present-calendar)をもらいました。


https://www.youtube.com/watch?v=R3o8vR1A9ao

https://www.nishinippon.co.jp/item/n/887930/

厳しい父性とは畢竟自分自身に打ち克つことです。克己です。闘魂です。

## 私のQiitaデビュー作

炎上しませんでした。
話題になることもありませんでした。

https://qiita.com/torifukukaiou/items/49b0e472844fe466a89d

---

# アンケートに答えると、[アドベントカレンダー2022](https://qiita.com/advent-calendar/2022)の参加を促されましたが、私は後ろは振り返りません！　[アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)を書きます! 書いています！

アンケートに答えました。
すると以下のようなページが表示されました。

![スクリーンショット 2023-01-20 21.34.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/25c05270-4c50-2098-efbb-66aea8a7e72f.png)

[アドベントカレンダー2022](https://qiita.com/advent-calendar/2022)の参加を促されたわけです。
私だけかもしれません。
自在に時をかけるおっちゃんなのかもしれません。

言います。
私は後ろは振り返りません。
[アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)に参加します！
参加しています！


https://qiita.com/tags/adventcalendar2023

---


# 来年のアドベントカレンダーとは、[アドベントカレンダー2024](https://qiita.com/advent-calendar/2024)のこと!?

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日は Qiita Advent Calendar 2022 Online Meetup にご参加いただきありがとうございました🙌<br><br>来年のアドベントカレンダー、そして今後開催するイベントにもぜひご参加ください！<a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a></p>&mdash; Qiita (キータ) 公式 (@Qiita) <a href="https://twitter.com/Qiita/status/1616413560825065472?ref_src=twsrc%5Etfw">January 20, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

2023年01月20日に、[Qiita (キータ) 公式](https://twitter.com/Qiita)から以下の発信がありました。

> 来年のアドベントカレンダー、そして今後開催するイベントにもぜひご参加ください！

今年のアドベントカレンダー = [アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)
来年のアドベントカレンダー = [アドベントカレンダー2024](https://qiita.com/advent-calendar/2024)

だと私はおもうのです。

重箱の隅をつついているわけではなく、
私は、[アドベントカレンダー2024](https://qiita.com/advent-calendar/2024)
をはじめます :rocket::fire:

:yum: 冗談です。ポエムです。来年のアドベントカレンダーとは、この場合、[アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)を指しているとわかって書いています。冗談は顔だけにしておきます。

[アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)を始めているのは本当です。
私のアドベントカレンダー一覧は、[こちら](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。


---

# 投稿（**闘魂**)は連鎖する！

もともとは「闘魂は連鎖する」です。
1998-04-04にアントニオ猪木さんが、引退試合でドン・フライを4分9秒グラウンドコブラツイストで破ったあとの引退セレモニーで古舘伊知郎さんのナレーションがありました。
詳しくは以下をご覧ください。

https://qiita.com/torifukukaiou/items/44db8a4997812518730a#%E9%97%98%E9%AD%82%E3%81%AF%E9%80%A3%E9%8E%96%E3%81%99%E3%82%8B

とうこう: 投稿
とうこん: 闘魂

わかりますかね。
投稿と闘魂は音では一字違いなのです。よく似ています。
私も**闘魂**（闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことだとおもいます）を連鎖させたいです。
私はアントニオ猪木さんのように色紙を頼まれることもありません。ですから以下の取り組みをしています。

- **闘魂**をQiitaをお借りしてインターネットの大地に刻みこむ
- 「投稿」のことをLTなどでは話し言葉でこそっと「とうこん」と言う
- 年賀状の一言に「闘魂」を揮毫する（結構好評でした)

書き言葉にすると不自然きわまりないのですが、会話の中では相手が文脈で「投稿」と認識してくれます。
私は「とうこん」と言います。
記事を**闘魂**するのです。

少し上で書きました通り、最初のうちはだれかの支えが必要でしょう。
だんだんと数を増していくと感覚が麻痺する部分もあるでしょうが、自分の怠け心、弱い心を自分で叱咤激励できるようになる必要があります。
**闘魂**です。大山康晴永世名人流に言うなら「**克己**」です。

こうして投稿(**闘魂**）は連鎖していくのです。

そうした投稿(**闘魂**）の連鎖は、人類進歩の一歩になるのです。
**あなたの記事が人類を進化させるのです！**


追伸
投稿を**闘魂**に置き換えた @t-yamanashi さんのお知り合いの方に感謝です。
ありがとうーーーーッ！！！　ございます。


---

# @piacerex さんの発表で紹介されていた記事

「**Elixirに賭けた**」
読み応え抜群のコラム群です。
ぜひお読みになってください。

https://qiita.com/piacerex/items/bac30ec027c9eef0e717

https://qiita.com/piacerex/items/09876caa1e17169ec5e1

https://qiita.com/nako_sleep_9h/items/9b6b9b70084cf5998f2d

https://qiita.com/piacerex/items/96efdb1377417f942531

https://qiita.com/piacerex/items/fcb29251e37b1ac3e063

https://qiita.com/piacerex/items/7bf8f9f4f5f576e597f5

---

# おわりに

「[Qiita Advent Calendar 2022 Online Meetup](https://increments.connpass.com/event/267714/)」に参加しておもったことを書きました。

特に言いたいことを３つ拾っておきます。


- (技術記事投稿を)はじめるには母性のやさしさが必要。さらに上を目指すには厳しい父性が必要だ。
- [アドベントカレンダー2023](https://qiita.com/advent-calendar/2023)ははじまっています
- 投稿（**闘魂**)は連鎖する！（**あなたの記事が人類を進化させるのです！**)

[完走賞](https://qiita.com/advent-calendar/2022/present-calendar)ありがとうございます！ :tada:

<b><font color="purple">$\huge{アウトプットはいいぞ！}$</font></b>

---

<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
