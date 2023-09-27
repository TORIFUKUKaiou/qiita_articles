---
title: 「【増枠】LiveView JP#12：はじめてのElixir AI・ML…Livebook＋Nxで」レポート（2022-11-22）
tags:
  - Elixir
  - Phoenix
  - LiveView
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-12-19T19:29:58+09:00'
id: 5212b1aa1bab752a2229
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
Advent Calendar 2022 171日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/11/22(火)は、「[【増枠】LiveView JP#12：はじめてのElixir AI・ML…Livebook＋Nxで](https://liveviewjp.connpass.com/event/262754/)」が開催されました。
この記事は、イベントのレポートです。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```


# Let's get started! :qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan: 

定刻通り19:30には、はじまりませんでした。
少し集まりを待ちました。

19:35はじまりました。
最初は15人くらいでした。

# [LiveView JP](https://liveviewjp.connpass.com/)の紹介

![スクリーンショット 2022-11-22 19.37.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/253048ba-4fbb-fbae-4ff3-13563c994d9d.png)

![スクリーンショット 2022-11-22 19.39.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e223a871-e2bc-97d4-a79f-0aa8177de5d9.png)

# 乾杯

19:40くらいに乾杯スタート :beer::beers:
酒をロードする。

![スクリーンショット 2022-11-22 19.40.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/62c7c86b-d501-2cd9-3622-91ae937a872e.png)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">LiveView JP#12：LivebookによるAI・ML開発入門<br>始まります！乾杯！<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/flIZQjPw2V">pic.twitter.com/flIZQjPw2V</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595004827805052928?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 資料

この記事で一番大事なところです。
ポイントです。
繰り返し書いておきます。
この記事で一番大事なところです。

https://liveviewjp.connpass.com/event/262754/presentation/

# Nx、Axonを楽しむための前説  @nako_sleep_9h さん

https://speakerdeck.com/nako_sleep_9h/nx-axonwole-simutamenoqian-shuo

![スクリーンショット 2022-11-22 19.47.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b57e0e90-8454-6bf7-9ac9-e95c705b392b.png)

![スクリーンショット 2022-11-22 19.48.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/44507e29-b4dc-fcdb-de7d-59ad19a5e311.png)

![スクリーンショット 2022-11-22 19.50.02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/505358eb-4edb-8846-c4e0-d0725ddb591f.png)

![スクリーンショット 2022-11-22 19.51.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9dcbb326-0a81-ee32-f11a-7391e40243ae.png)

わかりやすいLTでした :tada:

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">1本目のLT、<a href="https://twitter.com/nako_sleep_9h?ref_src=twsrc%5Etfw">@nako_sleep_9h</a> さんで「Nx、Axonを楽しむための前説」💁‍♂️<br>機械学習とは？行列とは？から、NxとPythonとの比較から導入していただきました。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/QkSA3TmLmI">pic.twitter.com/QkSA3TmLmI</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595007833363615745?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# Livebookを楽しむための前説 @nako_sleep_9h さん

https://speakerdeck.com/nako_sleep_9h/livebookwole-simutamenoqian-shuo

![スクリーンショット 2022-11-22 19.54.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/61a8ec3a-5254-af68-0156-0c9046862a6f.png)

![スクリーンショット 2022-11-22 19.57.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f62da7ae-78b0-d137-451a-b15a93ac1f39.png)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">2本目のLT、<a href="https://twitter.com/nako_sleep_9h?ref_src=twsrc%5Etfw">@nako_sleep_9h</a> さんで「Livebookを楽しむための前説」💁‍♂️<br>Livebookはコードもかけて、グラフやマーメイド図も書けて、モブプロもできてなにかと便利です。しかもウェブブラウザ上からも使えます😆<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/uCFcdfeJ3h">pic.twitter.com/uCFcdfeJ3h</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595009082196623360?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

わかりやすいLTでした :tada::tada::tada:

# Livebook環境構築ライブコーディング @tuchiro さん

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">3本目のLT、<a href="https://twitter.com/tuchro?ref_src=twsrc%5Etfw">@tuchro</a> さんで「Livebook環境構築ライブコーディング」💁‍♂️<br>少し込み入ったことや重い処理がしたいときはlocalに落としてきた方が汎用性が高いとのこと。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/QOKsVWc63p">pic.twitter.com/QOKsVWc63p</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595010266714238982?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


# Livebook＋Nx＋AxonではじめるElixir AI・ML入門 @piacerex さん

https://qiita.com/piacerex/items/6a9a5cc5d0e9dd9398ff

![スクリーンショット 2022-11-22 20.07.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fe5c183e-e0b4-9da3-24ce-fca20f968747.png)

![スクリーンショット 2022-11-22 20.18.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ac96b1bf-8278-5668-afb4-157c2297a21b.png)

![スクリーンショット 2022-11-22 20.21.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c8b711d8-a49d-781d-0bbc-b86dab6ec6dc.png)

![スクリーンショット 2022-11-22 20.23.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cc95abe2-7abf-7c4c-1086-c58c15ae31d5.png)

![スクリーンショット 2022-11-22 20.24.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3ca2f73a-2cf2-e4c0-e9fb-f1757076cb6c.png)

![スクリーンショット 2022-11-22 20.26.23.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/43b7fd30-e476-5a97-04ce-6b4a5c7298e5.png)

![スクリーンショット 2022-11-22 20.45.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6e356c12-f14a-a5f1-45e6-d6c73e7bf623.png)

![スクリーンショット 2022-11-22 20.46.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ae35960b-8d99-08ef-199f-e260ab09a6e3.png)

![スクリーンショット 2022-11-22 20.46.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/65bcc416-fc9a-9a7f-af46-ed05fe5cec13.png)


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">猫がパンをかぶった画像の先行きが刺さったみたいで、たくさんコメントをいただいた模様😜 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/kIBBNHRdTj">https://t.co/kIBBNHRdTj</a> <a href="https://t.co/vkiNftSEgA">pic.twitter.com/vkiNftSEgA</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1595023316422889472?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">4本目のLT、<a href="https://twitter.com/piacere_ex?ref_src=twsrc%5Etfw">@piacere_ex</a> さんで「Livebook＋Nx＋AxonではじめるElixir AI・ML入門」💁‍♂️ <br>基本はNx.tensor()で行列を作る。<br>Nx.reshape()でどういう形の行列(何次元の行列)にするかを加工する。まずこれが大事とのこと。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/wSz97Lginx">pic.twitter.com/wSz97Lginx</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595013168090451968?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



# Livebookで試しなが作る、はじめてのAxonプログラム @GeekMasahiro さん

https://qiita.com/GeekMasahiro/items/d956a7a880a937370a56

![スクリーンショット 2022-11-22 20.50.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/631c889b-1ad2-d5fb-2498-72694ed7b68d.png)

![スクリーンショット 2022-11-22 20.50.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7d1753c3-e462-d05a-9838-90c515cf9d61.png)

![スクリーンショット 2022-11-22 20.58.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/25453812-7d59-8dc2-bcf0-a80da01d907d.png)


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">5本目のLT、<a href="https://twitter.com/GeekMasahiro?ref_src=twsrc%5Etfw">@GeekMasahiro</a> さんで「LiveBookで試しながら作る、はじめてのAxonプログラム」💁‍♂️<br>最初はランダムな直線だった線が学習によって正解の曲線に近づいていくデモが驚くほど分かりやすいです！<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/ge8jvEQ0nz">pic.twitter.com/ge8jvEQ0nz</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595022789085638657?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



# LivebookでEvison遊んでみた @the_haigo さん

![スクリーンショット 2022-11-22 21.00.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1649e9cc-58cd-7908-eceb-a9884457ac0d.png)

![スクリーンショット 2022-11-22 21.06.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/866b2acb-f3f2-3647-b325-d03d732777e1.png)

![スクリーンショット 2022-11-22 21.13.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/40982503-3ae2-dbf5-6a34-c5add7befd0f.png)


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">6本目のLT、<a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> さんで「LivebookでEvison遊んでみた」💁‍♂️ <br>EvisionはPortなどを使用しないでElixirから直接、画像の生成、保存、加工などができる。<br>そしてEvisionのリファレンスにある関数の量がものすごい多い！<a href="https://t.co/hEg7y1kGbv">https://t.co/hEg7y1kGbv</a><a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/NiBX9thvY5">pic.twitter.com/NiBX9thvY5</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1595026361118523392?ref_src=twsrc%5Etfw">November 22, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


# Elixir Advent Calendarのお知らせ @piacerex さん

https://qiita.com/advent-calendar/2022/elixir

奮ってご参加ください！
**コラムを書いてください!**

「購読」を押してね！
参加してコラムを書いてね！
熱烈歓迎です！

![スクリーンショット 2022-11-22 21.04.32.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9e93d4cd-8048-d788-9151-6f9a9e72ca00.png)




---

# 告知


## 2022/12/03(土) 13:00 〜 15:00 piyopiyo.ex #12：Phoenixのローカル環境構築をやってみる会

https://piyopiyoex.connpass.com/event/263636/

## 2022/12/08(木) 20:10 〜 21:40 Nxバックエンド勉強会#8

北九州産業学術推進機構(FAIS)の旭興産グループ研究支援プログラムの一環です

https://pelemay.connpass.com/event/264838/



## 2022/12/21(水) 19:30 〜 21:00 ElixirImp#27：「LTしてくれた方々への感謝祭」という名の忘年会

https://fukuokaex.connpass.com/event/263809/

## 2022/12/27(火) 19:30 〜 21:00  LiveView JP#13：「LTしてくれた方々への感謝祭」という名のXmas会

https://liveviewjp.connpass.com/event/263811/

---

# このあとは二次会です

<font color="pink">$\huge{ムフフ}$</font>

です。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/11/22(火)に開催された、「[【増枠】LiveView JP#12：はじめてのElixir AI・ML…Livebook＋Nxで](https://liveviewjp.connpass.com/event/262754/)」のレポートを書きました。

## [LiveView JP](https://liveviewjp.connpass.com/)
奇数回の開催では、LiveView／phx_gen_auth／tailwind components or daisyUIの活用と融合についてLT会とモブプログラミングをやる回となり、偶数回は、Livebook／Nx／Axonの活用と融合についてのLT会とモブプログラミングをやる回となります、

<font color="red">$\huge{ワクワク}$</font>
です。

以上です。



