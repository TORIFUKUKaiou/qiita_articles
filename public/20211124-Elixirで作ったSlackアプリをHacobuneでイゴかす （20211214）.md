---
title: Elixirで作ったSlackアプリをHacobuneでイゴかす （2021/12/14）
tags:
  - Elixir
  - Docker
  - さくらインターネット
  - autoracex
private: false
updated_at: '2021-12-17T00:50:32+09:00'
id: 4411c9cdbba926b8d575
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/docker

2021/12/14(火)の回です。


# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- 「[ElixirでSlack botを作って楽しむ](https://qiita.com/torifukukaiou/items/7c203891144e9ec02d13)」と題して、作った[Slack](https://slack.com/)ボットアプリをさくらインターネットさんの[Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)でイゴかしてみます[^1]

[^1]: 「動かしてみます」の意。おそらく西日本の方言、たぶん。NervesJPではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# What is Hacobune ?

> Hacobuneは、当社が「インフラを意識しない世界を実現する」をビジョンに開発したPaaS型クラウドサービスです。スタートアップ企業や少人数でのサービスの開発を行うお客さまなど、スモールスタートでの開発に適しています。Hacobuneを利用することで、インフラの構築が不要となり、お客さまはアプリケーションの開発およびアップデートのみに専念することができ、サービスリリースのサイクルを加速させることが可能となります。

(https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

# ハイライト

`Dockerfile`をつくればでデプロイできちゃいます :rocket::rocket::rocket:

# ソースコード

https://github.com/TORIFUKUKaiou/slack_doorman

## Dockerfile

https://hexdocs.pm/phoenix/releases.html#containers

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: のガイドを参考にしています。


```docker:Dockerfile
ARG MIX_ENV="prod"

FROM hexpm/elixir:1.12.3-erlang-24.1.4-alpine-3.13.6 as build

# install build dependencies
RUN apk add --no-cache build-base git python3 curl

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ARG MIX_ENV
ENV MIX_ENV="${MIX_ENV}"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/$MIX_ENV.exs config/
RUN mix deps.compile

COPY priv priv

# note: if your project uses a tool like https://purgecss.com/,
# which customizes asset compilation based on what it finds in
# your Elixir templates, you will need to move the asset compilation
# step down so that `lib` is available.
COPY assets assets
RUN mix assets.deploy

# compile and build the release
COPY lib lib
RUN mix compile
# changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM alpine:3.13.6 AS app
RUN apk add --no-cache libstdc++ openssl ncurses-libs

ARG MIX_ENV
ENV USER="elixir"

WORKDIR "/home/${USER}/app"
# Creates an unprivileged user to be used exclusively to run the Phoenix app
RUN \
  addgroup \
   -g 1000 \
   -S "${USER}" \
  && adduser \
   -s /bin/sh \
   -u 1000 \
   -G "${USER}" \
   -h "/home/${USER}" \
   -D "${USER}" \
  && su "${USER}"

# Everything from this line onwards will run in the context of the unprivileged user.
USER "${USER}"

COPY --from=build --chown="${USER}":"${USER}" /app/_build/"${MIX_ENV}"/rel/slack_doorman ./

ENTRYPOINT ["bin/slack_doorman"]

# Usage:
#  * build: sudo docker image build -t elixir/slack_doorman .
#  * shell: sudo docker container run --rm -it --entrypoint "" -p 127.0.0.1:4000:4000 elixir/slack_doorman sh
#  * run:   sudo docker container run --rm -it -p 127.0.0.1:4000:4000 --name my_app elixir/slack_doorman
#  * exec:  sudo docker container exec -it slack_doorman sh
#  * logs:  sudo docker container logs --follow --tail 100 slack_doorman
CMD ["start"]
```

たぶん

https://docs.docker.jp/engine/userguide/eng-image/multistage-build.html#use-multi-stage-builds

に該当することをしているのだとおもいます。

# [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)へのデプロイ

https://manual.c1.hacobuneapp.com/docs

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:公式ドキュメントです。

## 事前準備

デプロイ方法は次の３種類とのことです。

**①パブリックのDockerイメージを使用**
②プライベートのDockerイメージを使用
③GitHubレポジトリをHacobuneに接続して使用（Dockerfileが必須）

**①パブリックのDockerイメージを使用**を説明します。
[dockerhub](https://hub.docker.com/)を使う例で書きます。

```bash
$ docker build -t slack_doorman .
$ docker tag slack_doorman <your_username>/slack_doorman
$ docker login
$ docker push torifukukaiou/slack_doorman
```

## [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

https://manual.c1.hacobuneapp.com/docs

に従ってすすめるとよいです。
こんな感じです。


![スクリーンショット 2021-11-24 20.42.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/571e05f8-a994-f9f1-8b37-f5de9942064d.png)


- ポートは`4000`です。
- 外部公開は有効にします([Slack](https://slack.com/)からHTTP Postしてもらうため)

あとは環境変数の設定を行ってください。
先述の[slack_doorman](https://github.com/TORIFUKUKaiou/slack_doorman)では次の3つの環境変数を設定する必要があります。

- SLACK_SIGNING_SECRET
- SLACK_BOT_TOKEN
- SECRET_KEY_BASE
    - `mix phx.gen.secret` で作成

たったこれだけで、しかもいまなら無料!!! で、[Slack](https://slack.com/)アプリをイゴかすことができます:tada::tada::tada:

<font color="purple">$\huge{Thank\ you\ very\ much!!!}$</font>


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [docker](https://www.docker.com/)!!!
Enjoy [Slack](https://slack.com/)!!!
Enjoy [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)!!!

**人間五十年 下天の内をくらぶれば、夢幻のごとくなり。一度生を得て滅せぬ者のあるべきか**

**時は今あめが下知る五月かな**

**露と落ち露と消えにしわが身かななにはのことも夢のまた夢**

**親思ふ心にまさる親心 今日のおとづれ何と聞くらん**

---

# おまけ

[Elixir](https://elixir-lang.org/)を始めてみよう！　とおもった、あなたに参考情報(クリスマス🎄プレゼント)を贈ります。:gift::gift::gift:
**思い立ったが吉日です!!!**

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- 角川文庫

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
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
