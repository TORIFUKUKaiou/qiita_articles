---
title: 「ElixirImp#25：はじめてのWebAssembly＋Elixir」レポート
tags:
  - Rust
  - Elixir
  - WebAssembly
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-22T13:35:04+09:00'
id: 150790f5944947580013
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
Advent Calendar 2022 160日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/10/19(水)は、「[ElixirImp#25：はじめてのWebAssembly＋Elixir](https://fukuokaex.connpass.com/event/262073/)」が開催されました。


# 19:35 Let's get started!

はじまりました〜

![スクリーンショット 2022-09-27 19.39.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f38c246a-8fea-654a-0c17-0a16788eff02.png)

# [ElixirImp](https://fukuokaex.connpass.com/event/262073/)の紹介

「ElixirImp」は、「Elixir実装の芽をみんなで愛でる」コミュニティです。

ElixirImpのLT（Lightning Talk）会は、様々な「Elixir実装の芽」…つまり、みなさんがElixirで作ったもの（個人、仕事、もくもく会、技術書典などを問わず）を持ち寄り、みんなで一緒に愛でる会です。

# そもそもwasmって何？…WebAssemblyはじめての方へ

@nako_sleep_9h さん

https://speakerdeck.com/nako_sleep_9h/wasmtutehe-webassemblyhazimetenofang-he

![スクリーンショット 2022-10-19 19.40.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/27d50be3-a7f9-4a86-fad5-63bb43b2c0cf.png)

![スクリーンショット 2022-10-19 19.43.22.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/47e7254b-7f38-0de5-1ae1-cc7e1061888d.png)

https://github.com/appcypher/awesome-wasm-langs

![スクリーンショット 2022-10-19 19.46.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ec998173-09dd-fc5c-00c0-30ecb42d368b.png)

![スクリーンショット 2022-10-19 19.46.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4996abc1-3cf1-e44b-7e11-dee35e9545ca.png)

![スクリーンショット 2022-10-19 19.48.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f20c6ca1-3427-c1d3-e7ea-4e81cfa0d88f.png)

WebAssemblyで動いている:rocket::rocket::rocket:

https://vketcloud.com/


# Ubuntu（Linux）でWasmExを動かそう

@t-yamanashi さん

https://qiita.com/t-yamanashi/items/c151eb3bb155da75f1cf

記事の内容を実演していただきました。

![スクリーンショット 2022-10-19 20.00.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2f859f83-0547-16c6-0330-528bca4cd294.png)

![スクリーンショット 2022-10-19 20.02.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/db8c12f9-63e4-95a1-3df1-0f7645b088a2.png)

![スクリーンショット 2022-10-19 20.04.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e778f21-4fad-e75f-ea33-ec19732075c2.png)

![スクリーンショット 2022-10-19 20.12.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/37fd0e2c-02fb-786e-2353-d2647a5852de.png)

**2147483647 + 1**を実施すると、パニックした様子。
2147483647の意味は、[こちら](https://dic.nicovideo.jp/a/2147483647)。


![スクリーンショット 2022-10-19 20.17.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a0ed9acb-e275-07a9-ed2e-36815fd95a8d.png)




Ubuntuだけではなく、macOS、Windows(WSL2)で動くそうです :tada:

# RustとElixirに入門するなら

本日は、RustとElixirの話が多めです。

https://gihyo.jp/magazine/wdpress/archive/2022/vol131

2022年10月22日紙版発売！！！

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WEB+DB PRESS Vol.131、どこよりも早い表紙画像です！<br>Rust入門、はじめてのElixir、実装して学ぶHTTP/3を大特集！10月22日発売です！<a href="https://twitter.com/hashtag/wdpress?src=hash&amp;ref_src=twsrc%5Etfw">#wdpress</a> <a href="https://t.co/uEIjuPYXu6">pic.twitter.com/uEIjuPYXu6</a></p>&mdash; WEB+DB PRESS編集部 (@wdpress) <a href="https://twitter.com/wdpress/status/1577119064807251968?ref_src=twsrc%5Etfw">October 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

そして、2022/11/08(火) 19:30からは、「[WEB+DB PRESS Vol.131「はじめてのElixir」特集記念イベント](https://fukuokaex.connpass.com/event/262903/)」が予定されています。


https://fukuokaex.connpass.com/event/262903/


# ElixirConf繋がりでLiveViewNative触ってみた

@the_haigo さん

https://speakerdeck.com/thehaigo/elixirconfxi-garideliveviewnativeyatutemita

![スクリーンショット 2022-10-19 20.27.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/23cd2afb-79a7-3be8-3a69-d0b682eff109.png)

![スクリーンショット 2022-10-19 20.28.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2c16844e-b865-0b31-a9f6-057ea881eea1.png)

![スクリーンショット 2022-10-19 20.29.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/99546c67-0ea2-0317-dfb4-a0eca5dc61fa.png)

![スクリーンショット 2022-10-19 20.33.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c5df8e75-d216-8d71-8dac-af11ebf206ad.png)



この[チュートリアル](https://liveviewnative.github.io/liveview-client-swiftui/tutorials/yourfirstapp/)がよくできています:+1:

https://liveviewnative.github.io/liveview-client-swiftui/tutorials/yourfirstapp/

---

<iframe width="1012" height="569" src="https://www.youtube.com/embed/dnDGh_Jmw-s" title="ElixirConf 2022 - Brian Cardarella - What is LiveView Native?" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# 告知タイム

告知タイムです。

## @zacky1972 さんから

https://pelemay.connpass.com/event/263304/

[Nxバックエンド勉強会#7](https://pelemay.connpass.com/event/263304/)

2022/11/10(木) 20:10〜

LT募集中！！！
Nxの行列処理や機械学習関連のLT募集中だそうです。

## @nako_sleep_9h さん

https://piyopiyoex.connpass.com/event/262598/

[piyopiyo.ex#10+LiveViewJP：はじめてのLiveView〜SPAを作ってみよう](https://piyopiyoex.connpass.com/event/262598/)

2022/10/25(火) 19:30〜


## @torifukukaiou さん、 @Mnishiguchi さんから

[autoracex](https://autoracex.connpass.com/) コミュニティをやっています。

直近の開催案内です。

2022/10/21（金） 00:00〜

https://autoracex.connpass.com/event/260194/

2022/10/22（土） 00:00〜

https://autoracex.connpass.com/event/260190/

**We are the Alchemists, my friends!!!** なので、対象は全人類です:rocket:


## @piacerex さんから

https://qiita.com/piacerex/items/e5590fa287d3c89eeebf

この記事への追加希望は、ぜひ@piacerexさんにお便りをお寄せくださいとのことです。

## 2022/11/08(火) 19:30 〜 21:00 WEB+DB PRESS Vol.131「はじめてのElixir」特集記念イベント

https://fukuokaex.connpass.com/event/262903/

## 2022/11/16(水) 19:30 〜 21:00

https://fukuokaex.connpass.com/event/263738/

## 2022/11/22(火) 19:30 〜 LiveView JP#12：はじめてのElixir AI・ML…Livebook＋Nx＋Axonで

https://liveviewjp.connpass.com/event/262754/

## 2022/12/21(水) 19:30 〜 ElixirImp#27：「LTしてくれた方々への感謝祭」という名の忘年会

https://fukuokaex.connpass.com/event/263809/

## 2022/12/27(火) 19:30 〜 LiveView JP#13：「LTしてくれた方々への感謝祭」という名のXmas会

https://liveviewjp.connpass.com/event/263811/






# Twitter

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ElixirImp、はーじまーるよー😜 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a><a href="https://t.co/yGgfCtQy3W">https://t.co/yGgfCtQy3W</a><br><br>WebAssemblyとElixirでハロウィンっ😝 <a href="https://t.co/vucJS0YF9w">pic.twitter.com/vucJS0YF9w</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582680839183556610?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">わ、かぼちゃ被ってる！かわいい！<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/PuBBXKxG83">https://t.co/PuBBXKxG83</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1582681242872709121?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ハッピーハロウィンなElixirImp、はじまったー😉 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/ZITNxec4Zp">pic.twitter.com/ZITNxec4Zp</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582683101813440512?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">1本目のLT、 <a href="https://twitter.com/nako_sleep_9h?ref_src=twsrc%5Etfw">@nako_sleep_9h</a> さんで「そもそもwasmって何？…WebAssemblyはじめての方へ」💁‍♂️ <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a><br><br>WASMの入門の入門から開始です😉 <a href="https://t.co/SCUS0tm8EX">pic.twitter.com/SCUS0tm8EX</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582683806229987329?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Wasm対応言語一覧．「不安定だが使える」まで含めるといっぱいある．<a href="https://t.co/t9sSptfaiy">https://t.co/t9sSptfaiy</a><br> <a href="https://twitter.com/hashtag/ElixirImp?src=hash&amp;ref_src=twsrc%5Etfw">#ElixirImp</a></p>&mdash; だーすー:||（Hiroshi Suda） (@suda_hiroshi) <a href="https://twitter.com/suda_hiroshi/status/1582684625344032775?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Wasmによって作られているプロダクト．こちらもいっぱいある．<a href="https://t.co/VnRt2xqraq">https://t.co/VnRt2xqraq</a><br> <a href="https://twitter.com/hashtag/ElixirImp?src=hash&amp;ref_src=twsrc%5Etfw">#ElixirImp</a></p>&mdash; だーすー:||（Hiroshi Suda） (@suda_hiroshi) <a href="https://twitter.com/suda_hiroshi/status/1582685051699224578?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">「Brainf*ckのWASMは安定している」という謎の強さを醸すパワーワード😝 <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/PmF6HcGHdU">pic.twitter.com/PmF6HcGHdU</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582685275289190400?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WebAssemblyってElixir以上に何なのかわからん。そもそもプログラミング言語ではない。とな。<br>重めの処理のサービスに多い感じっぽい？<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/6XZTuLp1JW">pic.twitter.com/6XZTuLp1JW</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1582685363658948609?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">発表内容の切り抜き： WasmExの資料<a href="https://t.co/SL1D3cHgwQ">https://t.co/SL1D3cHgwQ</a><br> <a href="https://twitter.com/hashtag/ElixirImp?src=hash&amp;ref_src=twsrc%5Etfw">#ElixirImp</a></p>&mdash; だーすー:||（Hiroshi Suda） (@suda_hiroshi) <a href="https://twitter.com/suda_hiroshi/status/1582687696228864002?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">2本目のLT、 ymnさんで「Ubuntu（Linux）でWasmExを動かそう」💁‍♂️ <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a><br><br>WasmExのインストールと、Rust等、関連ツールもインストールして動かしていってます😌<br><br>なお、WasmEx、Ubuntuだけで無く、Mac／Windows（WSL2）でも動いた模様😉 <a href="https://t.co/uwHNzbEKVy">pic.twitter.com/uwHNzbEKVy</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582687926013825024?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">WSL2, Mac, Linux全部でWebAssemblyの環境構築。<br>全環境検証してくださったのすごく有難い！<br>確かにElixirもcurlコマンドでインストールできるようになってほしいなぁ...<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/HMbzGH2ajR">pic.twitter.com/HMbzGH2ajR</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1582688666685960192?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">3本目のLT、 <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> さんで「ElixirConf繋がりでLveViewNative触ってみた」💁‍♂️ <a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a><br><br>FireFlyが未だ固まっていないので、Native繋がりでLveViewNativeの掘り下げ（ぜんぜんコッチでも楽しい）😋 <a href="https://t.co/JtYGKXwuDV">pic.twitter.com/JtYGKXwuDV</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1582694260415291392?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Phoenix LiveViewでUnityのバックエンドを触る日が来るかも？！すごく楽しみな機能。分かるようになりたいなぁ。<a href="https://twitter.com/hashtag/elixirimp?src=hash&amp;ref_src=twsrc%5Etfw">#elixirimp</a> <a href="https://t.co/Z0qkRdtMlU">pic.twitter.com/Z0qkRdtMlU</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1582697772608008192?ref_src=twsrc%5Etfw">October 19, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



# 2次会

<font color="purple">$\huge{ムフフでです}$</font>

ぜひ次回は参加して、ご自身で体験してください！

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/10/19(水)に開催された、「[ElixirImp#25：はじめてのWebAssembly＋Elixir](https://fukuokaex.connpass.com/event/262073/)」のレポートを書きました。



以上です。



