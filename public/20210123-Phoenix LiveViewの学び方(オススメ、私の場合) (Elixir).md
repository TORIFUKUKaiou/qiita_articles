---
title: Phoenix LiveViewの学び方(オススメ、私の場合) (Elixir)
tags:
  - Elixir
  - Phoenix
  - Petal
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-01-24T13:56:58+09:00'
id: 3a5ae33ba0de663f2c21
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- 本日**2021/01/23(土)**の[Elixir](https://elixir-lang.org/)イベントに参加しました
    - [kokura.ex#17：Elixir新年会&もくもく会～入門もあるよ（9:30~）](https://fukuokaex.connpass.com/)
        - @im_miolab さんお世話になりました！　ありがとうございました！
    - [autoracex #4](https://autoracex.connpass.com/event/201712/)
        - [kokura.ex](https://fukuokaex.connpass.com/)と共催という名の寄生開催
- その成果みたいなものです
- [Elixir](https://elixir-lang.org/)には、ご存知[Phoenix](https://www.phoenixframework.org/)というWebアプリケーションフレームワークがあります
- [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)というライブラリと組み合わせて使うことが主流だとおもいます
- この記事では、[LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)を私がどのように学んだのかをご紹介いたします

# [PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack)
- [kokura.ex](https://fukuokaex.connpass.com/)で聞いてきました
- リンク先の原文の先頭のほうにはこんな出だしがあります
- **There’s a new stack in town.**
    - 街でうわさのあいつみたいな感じでしょうか
    - :soccer: 
    - [すぐれものゾと街中騒ぐ :microphone: ](https://www.youtube.com/watch?v=e0VwO2-grZk&t=45)
        - そんときオレがスーパーヒーローさ
        - 燃えて青春かけぬけろ〜

## **P**
- [Phoenix](https://www.phoenixframework.org/)

## **E**
- [Elixir](https://elixir-lang.org/)

## **T**
- [Tailwind CSS](https://tailwindcss.com/)

## **A**
- [Alpine.js](https://github.com/alpinejs/alpine)

## **L**
- [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)

[LAMP](https://ja.wikipedia.org/wiki/LAMP_(%E3%82%BD%E3%83%95%E3%83%88%E3%82%A6%E3%82%A7%E3%82%A2%E3%83%90%E3%83%B3%E3%83%89%E3%83%AB))みたなノリでしょうか

# [The Pragmatic Studio -- Phoenix LiveView](https://pragmaticstudio.com/phoenix-liveview)
- https://pragmaticstudio.com/phoenix-liveview で学ぶことを私はオススメします
- 私は
- <font color="purple">$\huge{日本マイクロソフト賞④}$</font>
- を受賞しました
- もう一度いいます
- 私は[日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93) を受賞いたしました :tada::tada::tada: 
    - たぶん、1年ぐらい言い続けるとおもいます
    - 先日、[Qiita](https://qiita.com/)サポートチームの方に住所を連絡したところ、発送したとのご連絡をいただきました
    - たのしみ〜〜〜
- 受賞理由のひとつにあげていただいた「[Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9)」という記事を書くにあたって、[Phoenix LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)ぢからをこの動画コースで身につけました
- 全部見るには(**$99**)必要です
- 最初のほうだけ無料でみれるようですのでまずはそちらからお試しするとよいとおもいます
    - 前提知識はアレが必要、コレが必要とかは言いません
    - あえていえば、**ヤル気**だけは必要だとおもいます
        - **楽しむ気持ち**と言ったほうがいいのかもしれませんという気持ちです
    - 自分が本当に楽しんでいることであれば足りないものは後から補えるとおもいます
    - なのでせっかくヤル気になっているあなたはすぐにはじめてみましょう
        - [元気があればなんでもできる！](https://www.youtube.com/watch?v=t54194RGDac&t=16) といったほうがいいかもしれないという気持ちです
- レッスン動画で使うソースコードは[GitHub](https://github.com/pragmaticstudio/live_view_studio)に公開されています
- 各レッスンのはじめの雛形とレッスン終了後の完成形(お手本)がそれぞれブランチで用意されています
    - これによりタイプミス等のへんなところで詰まってしまう時間を節約できます
        - この形式は動画教材のとてもすぐれたフォーマットだとおもっています
    - ということで、`git clone`と`git diff`、branch、checkoutくらいのGitの知識はあったほうが学習をスムーズに進められます
        - もしGitに自信がない方は、[ドットインストール](https://dotinstall.com/)さんの[git入門](https://dotinstall.com/lessons/basic_git)を学んでおけば十分でしょう
        - もし黒い画面に自信が無い方は、知り合いの詳しい人に教えを請いましょう
        - もし開発マシンがない方は買いましょう
            - どれを買うのがいいかわからない人は、まわりの詳しい人に聞きましょう
            - それさえ難しい方は後述の**思い切って僕の胸に飛び込んで来てほしい**

```
$ git clone https://github.com/pragmaticstudio/live_view_studio.git
$ cd live_view_studio
$ git diff 1-button-clicks-begin..1-button-clicks-end
(差分はご自身でお確かめください)
```


# 環境構築
- [Phoenix](https://www.phoenixframework.org/)アプリを作れる環境をつくる必要があります

## 公式(が一番)
- ワシャあ、そうおもう(清吉（大滝秀治）)
- [Installation](https://hexdocs.pm/phoenix/installation.html#content)

## 手前味噌な記事で恐縮です
- [Phoenixのdevcontainer (Elixir)](https://qiita.com/torifukukaiou/items/636bb0a08d6a0b597a69)
    - [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)と[Docker](https://www.docker.com/)でお手軽に開発環境を整えられます

# 環境構築でもしもつまってしまったら
- 思い切って僕の胸に飛び込んで来てほしい
    - [清原巨人入り決断、長嶋監督のラブコールにグラリ](http://www5.nikkansports.com/baseball/kiyohara/reprint/lions/entry-67779.html)
- ここが一番つまらないし、謎につまったりすることがあるとおもいます
- 楽しむためには最初のひと頑張りは必要です
- [elixirjp.slack.com](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)にて`#kokura-ex`チャネルや`#autoracex`チャネルに飛び込んできてください
    - `@torifukukaiou` へどうぞ〜
    - どうも〜
    - 招待リンクが期限切れしていたら、お手数ですがコメント欄にお知らせください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- [Elixir](https://elixir-lang.org/)やっている人みな、**マジでいい人ばかり**なので、たとえ私が答えられんでも他の人が解決へと導いてくれるでしょう :rocket::rocket::rocket::rocket::rocket:

# Wrapping Up 🎍🎍🎍🎍🎍
- [PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack) !!!
    - [PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack) !!!
    - [PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack) !!!
    - [PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack) !!!
    - 今年は[PETAL](https://changelog.com/posts/petal-the-end-to-end-web-stack)をたくさん聞くことを期待しています
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket::rocket::rocket: 
