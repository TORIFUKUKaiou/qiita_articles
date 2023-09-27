---
title: 'Fortranをはじめる(Nervesにてはじめる前の準備運動を開始) '
tags:
  - Fortran
  - Elixir
  - Nerves
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:10:56+09:00'
id: 9494767af2816d1b607c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**いくら考えても、どうにもならぬときは、四つ辻へ立って、杖の倒れたほうへ歩む。**

Advent Calendar 2022 3日目[^1]の記事です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今朝、[NervesJP Slack ワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に、@kikuyuta先生から以下のツイートのご紹介がありました。

このビッグウェーブに乗るしかありません:surfer::surfer_tone1::surfer_tone2::surfer_tone3::surfer_tone4::surfer_tone5:[^3] 。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">TIL I could enable the Fortran compiler in the Nerves toolchains without affecting firmware sizes if you don&#39;t use Fortran. We&#39;ve gotten 2 requests in the history of Nerves for Fortran. Next toolchain release will support it - very curious if this will actually be used.</p>&mdash; Frank Hunleth (@fhunleth) <a href="https://twitter.com/fhunleth/status/1477768557513658370?ref_src=twsrc%5Etfw">January 2, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

次回のリリース[^2]で、[Nerves](https://www.nerves-project.org/)上でFortranも楽しめるようになるとのことなので、まずは**パソコン上にて**Fortranで`HELLO, WORLD!`しておきます。

[^2]: 正確には、`Next toolchain release`と原文のツイートには書いてあります。よくわからないので「次回のリリース」というあいまいで便利な日本語にしています。こうやって、翻訳時に間違いが埋め込まれていくというのを地でやっているわけでありまして、やっぱり英語は英語のまま理解するというのが一番よいわけです。

# 参考にしたサイト

https://www.tohoho-web.com/ex/fortran77.html

ありがとうございます！

これの[Elixir](https://elixir-lang.org/)版は、@nikuさんの「[Elixir 基礎文法最速マスター](https://qiita.com/niku/items/729ece76d78057b58271)」です。

# 実行環境

https://blog.office-iwakiri.com/archives/development-814

Dockerで実行しました。
上記を参考にしました。[^4]

ありがとうございます！

[^4]: 当初、 https://hub.docker.com/r/ibmcom/xlf-ce/ を参考にすすめてみましたが、`docker: no matching manifest for linux/amd64 in the manifest list entries.`というエラーがでて断念しました。断念したのは、元となるリポジトリが5年間ほど更新されていないことと私はいずれ[Nerves](https://www.nerves-project.org/)で動かすので、ここで立ち止まる必要はないからです。ググり力が足りず、なんだかわからないけど、今回はまあ、いいやと放っておくことにしました。いや、こういうのってすぐまた別なところで同じく詰まるんですよね。だから、私のマネなんか（だれもしないとはおもいますが）しないほうがいいです。

# ソースファイル

```fortran:hello.f
      PROGRAM HELLO
      PRINT *, 'HELLO, WORLD!'
      END PROGRAM HELLO
```

※ 6個のスペースには意味があります。詳しくは、「[とほほのFORTRAN入門](https://www.tohoho-web.com/ex/fortran77.html)」をご参照ください。私もノスタルジー感を出したく、「FORTRAN 77」 に従ってみました。

```Dockerfile:Dockerfile
FROM alpine

WORKDIR /home/fortran
RUN set -x && \
    apk update && \
    apk add --no-cache gfortran musl-dev

CMD ["/bin/sh"]
```

```yml:docker-compose.yml
version: '3'
services:

  fortran:
    build: .
    container_name: fortran
    volumes:
      - .:/home/fortran
    tty: true
```

# Run :rocket::rocket::rocket:

```
$ docker-compose run --rm fortran gfortran hello.f -o hello 
$ docker-compose run --rm fortran ./hello
```

<font color="purple">$\huge{\ HELLO, WORLD!}$</font>

:tada::tada::tada:



# ビッグウェーブ:surfer::surfer_tone1::surfer_tone2::surfer_tone3::surfer_tone4::surfer_tone5:なの?

**わかりません。**

ただ、少なくとも**私にとって**は間違いなく、すべからくビッグウェーブです。
私は誰かからたのまれたわけでもありませんが、@kaizen_nagoya さんに刺激を受けて、2022/12/25まで**アドベントカレンダー 2022**と題して書き続けることを決めました。
Fortran on [Nerves](https://www.nerves-project.org/)で何本か書けそうです。
**私には**ビッグウェーブ到来です。

冗談は顔だけにしておいて、以下の記事をご紹介しておきます。

[「Fortran」の人気が再燃？--専門家が考える現状と展望](https://japan.zdnet.com/article/35170463/)

<font color="purple">$\huge{「Fortran」の人気が再燃}$</font>

しているんです！[^5]

[^5]: 私事ですが実家を片付けていると、20年以上前に買ったFortranの本がでてきました。そのまま格納してしまいましたが、やっぱり引っ張り出してこようとおもいます。実家までは車で30分くらいです。

これは私の勝手なイメージですが、[Nerves](https://www.nerves-project.org/)には**必要最小限のものしかデフォルトでは入れない、必要な人は各自で必要なものを追加してね**というようなポリシーがあると思っています。
過去2度ほどのFortranの追加要望があったとツイートには書いてあります。
これが200回とか2,000回とか20,000回なら、必要ですね〜　と、[Nerves](https://www.nerves-project.org/)のコアチームが決断するのを私でも理解できるとおもいます。
たったの2回ですよ、たったの。
ということはですよ、ですよね〜。もうお分かりですよね、私が言いたいことは。

「[「Fortran」の人気が再燃？--専門家が考える現状と展望](https://japan.zdnet.com/article/35170463/)」この記事に書いてあるような事態が本場アメリカでは巻き起こっていて、何に使うのかまでは私にはわかりませんが、実行環境として[Nerves](https://www.nerves-project.org/)が一躍スターダムにのし上がってくるのかもしれません[^3] :rocket::rocket::rocket: 

[^3]: いろいろ前提を間違えているかもしれないので、どうでもいい想像です。


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

近々？、[Nerves](https://www.nerves-project.org/)でFortranを楽しめるようになるそうです。
Fortran未経験の方は、「[とほほのFORTRAN入門](https://www.tohoho-web.com/ex/fortran77.html)」を参考に、準備をはじめてみてはいかがでしょうか。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:


---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)



 
