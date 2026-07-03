---
title: 「ElixirImp#28：Elixir Advent CalendarコラムをLT化しましょ！」レポート（2023-02-15）
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-02-25T10:08:13+09:00'
id: 57a40119c9eefd056cae
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

本日 2023-02-15(水)は、「[ElixirImp#28：Elixir Advent CalendarコラムをLT化しましょ！](https://fukuokaex.connpass.com/event/274844/)」が行われました。
そのイベントレポートです。


```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# 「ElixirImp」とは？

「ElixirImp」は、「Elixir実装の芽をみんなで愛でる」コミュニティです。

ElixirImpのLT（Lightning Talk）会は、様々な「Elixir実装の芽」…つまり、みなさんがElixirで作ったもの（個人、仕事、もくもく会、技術書典などを問わず）を持ち寄り、みんなで一緒に愛でる会です。

# 本日のテーマは？

[Elixir Advent Calendar](https://qiita.com/advent-calendar/2022/elixir)コラムをLT化しましょ！

# 会の趣旨説明、録画のご案内、カンパイ挨拶＋Zoom記念撮影

@FRICK さん

約6分遅れではじまりました。
乾杯スタートです。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaの中の人をお招きしてのElixirImp、はじまったー😆 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/uzlS6jYxge">pic.twitter.com/uzlS6jYxge</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625807662599528448?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ここからはLT会です。


# [Elixir入門者向けコミュニティ「piyopiyo.ex」を発足して1周年なので振り返り](https://qiita.com/nako_sleep_9h/items/2a2cbc0ca26fab8feb1f)

トップバッターは、@nako_sleep_9h さん :tada::tada::tada: 

https://qiita.com/nako_sleep_9h/items/2a2cbc0ca26fab8feb1f

- [piyopiyo.ex](https://piyopiyoex.connpass.com/) -- Elixir／Phoenixの初心者向けコミュニティです
- 毎月ちょっとずつ作り上げていくディアゴスティーニ方式w (仕様検討、実装、デプロイ)
- [課題は「どこまで入門者向けにハードルを下げるか？」と「面白さ」の両立](https://qiita.com/nako_sleep_9h/items/2a2cbc0ca26fab8feb1f)
- [グッズを作りました](https://qiita.com/nako_sleep_9h/items/2a2cbc0ca26fab8feb1f#%E3%82%B0%E3%83%83%E3%82%BA%E3%82%92%E4%BD%9C%E3%82%8A%E3%81%BE%E3%81%97%E3%81%9F)
- [Discordサーバー『elixirと見習い錬金術師』紹介](https://qiita.com/nako_sleep_9h/items/9b6b9b70084cf5998f2d)

初心者にやさしいコミュニティ: [piyopiyo.ex](https://piyopiyoex.connpass.com/)

## YouTube動画

<iframe width="894" height="475" src="https://www.youtube.com/embed/e9JKDvs48-k" title="完走賞いただいたよ報告＋piyopiyo.ex2022年振り返り（Discord「elixirと見習い錬金術師」の紹介も） @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [今日のiex]((https://qiita.com/t-yamanashi/items/6f45021a7333de3ff3df)) ＆ Elixirでスマホネイティブアプリ開発できる「ElixirDesktop」

@t-yamanashi さん

https://qiita.com/t-yamanashi/items/6f45021a7333de3ff3df

- iexとはElixirをインストールすると使えるREPL (Read-Eval-Print Loop) 
- `h Enum.map`等でヘルプが見えるよ

Liveコーディング:rocket::rocket::rocket:

![スクリーンショット 2023-02-15 19.53.37.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7c877f2e-1ba4-8dd2-7de2-d0f734d7396d.png)

---

続いてiPadでElixirを動かす！

https://qiita.com/t-yamanashi/items/1dde44eda425d32a7f6a

今日のiexは響きが良い。
Liveコーディングすごい！

## YouTube動画

<iframe width="894" height="503" src="https://www.youtube.com/embed/rRApId0WNEE" title="今日のiex ＆ Elixirでスマホネイティブアプリ開発できる「ElixirDesktop」 @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [Livebook で Bumblebee の画像分類を実行する](https://qiita.com/RyoWakabayashi/items/b9b4799683af5aaa29dd)

@RyoWakabayashi さん

https://qiita.com/RyoWakabayashi/items/b9b4799683af5aaa29dd


- わたしも結構書いた（６０記事!)
- Livebookで遊んでいます
- PythonでJupyterをよく使っていたのですんなり使うようになった
- [Bumblebee](https://github.com/elixir-nx/bumblebee)が2022/12にでた
- Stable Diffusionとかを簡単に動かせる
- [Google Colaboratory 上で Elixir Bumblebee を動かし、画像生成やテキスト補完を実行する](https://qiita.com/RyoWakabayashi/items/de43ca943444fd766716)

## Liveコーディングで書かれた「Advent Calendar celebration」

![スクリーンショット 2023-02-15 20.06.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9f38ded3-4f07-50d8-8813-44be7a44437b.png)

## Liveコーディングで書かれた「Qiita with Elixir」

![スクリーンショット 2023-02-15 20.07.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ac8b019c-1f64-78ff-8f8c-3a15aa195987.png)


## YouTube動画

<iframe width="894" height="493" src="https://www.youtube.com/embed/nxIZiyqooHg" title="お絵描きAIをElixirで動かす＋α（Elixir Bumblebee on Livebook） @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [Dockerを使ってElixirの分散システムを気軽に楽しむ](https://qiita.com/mnishiguchi/items/d75668aa5c458644d759)

@mnishiguchi さん

https://qiita.com/mnishiguchi/items/d75668aa5c458644d759

- アメリカ在住。
- 発表現在、6:10 G'Morning!!!
- [autoracex, 闘魂ex](https://autoracex.connpass.com/)で毎日もくもくしています


```elixir
defmodule Toukon do
  def aisatsu, do: "元氣ですかーーーーッ！"
end

Node.spawn(
  :"fuga@localhost",
  fn ->
    Toukon.aisatsu() |> IO.puts()
  end
)
```

分散ネットワークで遊んでみてください。
**Elixirらしい、ど真ん中。**

## YouTube動画

<iframe width="894" height="503" src="https://www.youtube.com/embed/1M-7TTMId5g" title="Dockerを使ってElixirの分散システムを気軽に楽しむ @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [Elixirで始めるGraphQLサーバ](https://qiita.com/Yoosuke/items/f50277343d6114f37d33)／クライアント／クエリとミューテーション＋α

@Yoosuke さん

https://qiita.com/Yoosuke/items/35b424c72cac9dc8df66

https://qiita.com/Yoosuke/items/f50277343d6114f37d33

- 今年は3記事でやめるつもりが、31記事書いた
- サクっとできます！
- [Absinthe](https://github.com/absinthe-graphql/absinthe)
- GraphQLの解説も丁寧にしています
- サクっとつくってから説明読むのがおすすめ
- GraphQLシリーズは、今年のアドベントカレンダーに続きを書きます！

技術的に面白いし、モチベーションのアップダウンの話の方が面白かった！

## YouTube動画

<iframe width="894" height="503" src="https://www.youtube.com/embed/ejVYjl4B1uY" title="Elixirで始めるGraphQLサーバ／クライアント／クエリとミューテーション＋α @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# Qiita Advent Calendar運営がみたElixirの熱狂

![スクリーンショット 2023-02-15 20.32.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d046c7d8-03eb-0595-840d-12cce5771de6.png)

@danwatanabe さん
中の人！

**やってくれたな! Elixir!**

![スクリーンショット 2023-02-15 20.34.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2bc35cbe-03b2-2141-1895-f6fc3590da2f.png)


![スクリーンショット 2023-02-15 20.35.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3d8e0382-8a70-faf4-df61-fb73d4188b58.png)

![スクリーンショット 2023-02-15 20.39.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7183858b-5eee-358f-4826-cc16be21449b.png)

![スクリーンショット 2023-02-15 20.39.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4b37dd25-71f4-2050-059c-4a6b322e3010.png)

![スクリーンショット 2023-02-15 20.40.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9a59eccb-ea66-cd09-0082-ec48a7fea429.png)


ダークモード使ってみてください。
ベータ版

![スクリーンショット 2023-02-15 20.41.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/927d6439-dfd0-e8bf-20bf-796b237a12ba.png)


完走賞で素振りになりましたー(@nako_sleep_9h さん)　|> めちゃくちゃうれしいです（@danwatanabe さん）

## YouTube動画

<iframe width="894" height="503" src="https://www.youtube.com/embed/WoIoYime10k" title="Qiita Advent Calendar運営がみたElixirの熱狂 @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [「なぜ私はElixirに賭けたか」のその先：プログラマとして体力／気力がゼロになってても全回復できる Elixirが奏でる、未来志向でSF的、サイバーパンクな世界へようこそ（今からElixirを始める説明付き）](https://qiita.com/piacerex/items/09876caa1e17169ec5e1)

@piacerex さん

https://qiita.com/piacerex/items/09876caa1e17169ec5e1

Qiitaのコラムは、 [ElixirImp#28：Elixir Advent CalendarコラムをLT化しましょ！](https://fukuokaex.connpass.com/event/274844/)に貼っています。

- Elixirのアドベントカレンダーは、シリーズ10くらいで止めるようにうながしていた。@piacerex さんの知らないところで増殖していた。
- Elixirは楽しく開発できるよ
- Web SPAやスマホのネイティブ開発もElixirで開発できるようになっている
- AI/MLもElixirは強力になってきている
- 分散コンピューティング
- [全ての準備が揃ったElixirを今から始めるメリット](https://qiita.com/piacerex/items/09876caa1e17169ec5e1#%E5%85%A8%E3%81%A6%E3%81%AE%E6%BA%96%E5%82%99%E3%81%8C%E6%8F%83%E3%81%A3%E3%81%9Felixir%E3%82%92%E4%BB%8A%E3%81%8B%E3%82%89%E5%A7%8B%E3%82%81%E3%82%8B%E3%83%A1%E3%83%AA%E3%83%83%E3%83%88)
- Elixirに入門するにはちょうどいい時期です
- ハッピーです

## YouTube動画

<iframe width="894" height="503" src="https://www.youtube.com/embed/QP-PcARZRqA" title="「なぜ私はElixirに賭けたか」のその先  @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# [闘魂Elixir ── Qiitaアドカレ完走賞を目指してみましょう！](https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e) ＋ [最終発表](https://qiita.com/torifukukaiou/items/4f9a293f27320b0c5614)

@torifukukaiou さん

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

https://qiita.com/torifukukaiou/items/4f9a293f27320b0c5614


- 論語と算盤 名書
- Elixir→torifukuさん→プロレス（闘魂）を知りました。連鎖
- Qiitaは希望ｗ
- ブラボー！
- 久々に心の底から大笑いした。幸せな気持ちですw
- 闘魂と狂気の狭間な感じが吹きそうでしたｗ
- 闘魂と投稿をかけるのはズルいｗ
- アドベントカレンダーハラショーｗｗ
- もうすでに始まっている

## YouTube動画

<iframe width="894" height="483" src="https://www.youtube.com/embed/c0LP23SM7BU" title="闘魂Elixir ── Qiitaアドカレ完走賞を目指してみましょう！＋最終発表 @ ElixirImp#28" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

---

# Twitter

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaの中の人をお招きしてのElixirImp、はじまったー😆 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/uzlS6jYxge">pic.twitter.com/uzlS6jYxge</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625807662599528448?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日のElixirImp、QiitaのElixir Advent Calendarをみんなで眺めながらLTが繰り広げられる会です😆 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> <a href="https://t.co/lW7bhUyOzR">https://t.co/lW7bhUyOzR</a> <a href="https://t.co/8t95XPJgKT">pic.twitter.com/8t95XPJgKT</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625813157913698304?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">GraphQLのサーバだけで無く、フロントもElixirで書いちゃうコラムのLTッ😝 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a><a href="https://t.co/oMVHooaTlw">https://t.co/oMVHooaTlw</a><br><br>ミューテーションとかも実装してます😌 <a href="https://t.co/8ZlL5q9YlT">pic.twitter.com/8ZlL5q9YlT</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625818945751257088?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaの中の方からLTキター😍 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> <a href="https://t.co/WWLfsriJ6w">pic.twitter.com/WWLfsriJ6w</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625820767643656192?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Elixir、史上最高記録 of 史上最高記録…だったそうです😜 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> <a href="https://t.co/RXhogLDmhR">pic.twitter.com/RXhogLDmhR</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1625821477777051648?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaの中の方、面白すぎるｗｗ<br> <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a></p>&mdash; Koyo(miyamu) (@KoyoMiyamura) <a href="https://twitter.com/KoyoMiyamura/status/1625822124379340802?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiita ダークモード！搭載 (ベータ版）<br>目に優しい！<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/gqWOaHZTvK">pic.twitter.com/gqWOaHZTvK</a></p>&mdash; YOSUKE@プログラミング ElixirとPhoenix (@YOSUKENAKAO) <a href="https://twitter.com/YOSUKENAKAO/status/1625822859947024384?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ダークモードかっこいいな<br><br> <a href="https://twitter.com/hashtag/ElixirImp?src=hash&amp;ref_src=twsrc%5Etfw">#ElixirImp</a> <a href="https://t.co/LqLdxGLwe1">pic.twitter.com/LqLdxGLwe1</a></p>&mdash; Yuichi Onodera (@mokemoke6502) <a href="https://twitter.com/mokemoke6502/status/1625822879702200320?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">もし、ElixirのアウトプットするならQiitaに振り切る理由が出来たぞこれは。ダークモードがベータで使えるのは知らなかった…<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/jaowOmNfWt">pic.twitter.com/jaowOmNfWt</a></p>&mdash; Tanabebe (@tanabebe_jp) <a href="https://twitter.com/tanabebe_jp/status/1625823304828485633?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaのベータ版でダークモードが使えるようになるそうです！ <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/L8yauddUDn">pic.twitter.com/L8yauddUDn</a></p>&mdash; nako@9時間睡眠 (@nako_sleep_9h) <a href="https://twitter.com/nako_sleep_9h/status/1625824590831443969?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">四書五経の話しが何につながるのかと思って聞き入ってたら闘魂だった件<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/BPTF4DlRuc">pic.twitter.com/BPTF4DlRuc</a></p>&mdash; YOSUKE@プログラミング ElixirとPhoenix (@YOSUKENAKAO) <a href="https://twitter.com/YOSUKENAKAO/status/1625826471670616067?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Qiitaを書くのは希望です。<br>パンドラの箱を開けよう！<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a></p>&mdash; YOSUKE@プログラミング ElixirとPhoenix (@YOSUKENAKAO) <a href="https://twitter.com/YOSUKENAKAO/status/1625826759563431942?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">アドベントカレンダー 12月に１人25記事を書くのは人類のアップデートなり<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a></p>&mdash; YOSUKE@プログラミング ElixirとPhoenix (@YOSUKENAKAO) <a href="https://twitter.com/YOSUKENAKAO/status/1625827462776250368?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Elixirアドベントカレンダー2022は16シリーズあって、さすがに多いな？と投稿側として思っていたので、お話を聞けて楽しかったです！ <a href="https://t.co/QeMfils38J">https://t.co/QeMfils38J</a></p>&mdash; nako@9時間睡眠 (@nako_sleep_9h) <a href="https://twitter.com/nako_sleep_9h/status/1625836098739134465?ref_src=twsrc%5Etfw">February 15, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


---

# さいごに

この記事は、「[ElixirImp#28：Elixir Advent CalendarコラムをLT化しましょ！](https://fukuokaex.connpass.com/event/274844/)」のレポートです。
ありがとうございます！

記事を闘魂（投稿）していきましょう！







---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
