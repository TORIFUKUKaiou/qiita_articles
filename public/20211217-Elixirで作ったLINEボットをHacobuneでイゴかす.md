---
title: Elixirで作ったLINEボットをHacobuneでイゴかす
tags:
  - Elixir
  - さくらインターネット
  - autoracex
  - Hacobune
private: false
updated_at: '2021-12-23T07:01:40+09:00'
id: 7283f17c956a567e660e
organization_url_name: null
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/advent-calendar/2021/docker
2021/12/23(木)の回です。


# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- 「[Banditを利用してLINEボット開発を楽しむ(Elixir)](https://qiita.com/torifukukaiou/private/05255dc857ddd5a695ee)」と題して、作ったLINEボットをさくらインターネットさんの[Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)でイゴかしてみます[^1]

[^1]: 「動かしてみます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# What is Hacobune ?

> Hacobuneは、当社が「インフラを意識しない世界を実現する」をビジョンに開発したPaaS型クラウドサービスです。スタートアップ企業や少人数でのサービスの開発を行うお客さまなど、スモールスタートでの開発に適しています。Hacobuneを利用することで、インフラの構築が不要となり、お客さまはアプリケーションの開発およびアップデートのみに専念することができ、サービスリリースのサイクルを加速させることが可能となります。

(https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

# ハイライト

`Dockerfile`をつくればでデプロイできちゃいます :rocket::rocket::rocket:

# ソースコード

https://github.com/TORIFUKUKaiou/bandit_line_bot

## Dockerfile

https://hexdocs.pm/phoenix/releases.html#containers

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: のガイドを参考にしています。


```docker:Dockerfile
ARG BUILDER_IMAGE="hexpm/elixir:1.12.0-erlang-24.0.1-debian-bullseye-20210902-slim"
ARG RUNNER_IMAGE="debian:bullseye-20210902-slim"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

RUN mix deps.compile

COPY lib lib

RUN mix compile

RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/prod/rel/bandit_line_bot ./

USER nobody

ENTRYPOINT ["/app/bin/bandit_line_bot"]

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
$ docker build -t bandit_line_bot .
$ docker tag bandit_line_bot <your_username>/bandit_line_bot
$ docker login
$ docker push <your_username>/bandit_line_bot
```

## [Hacobune](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)

https://manual.c1.hacobuneapp.com/docs

に従ってすすめるとよいです。
こんな感じです。


![スクリーンショット 2021-12-17 0.57.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0405dcd4-06bf-dbd9-6ecd-744f00a25e7a.png)



- ポートは`4000`です。
- 外部公開は有効にします(LINEからHTTP Postしてもらうため)

あとは環境変数の設定を行ってください。
先述の[bandit_line_bot](https://github.com/TORIFUKUKaiou/bandit_line_bot)では次の2つの環境変数を設定する必要があります。

- CHANNEL_SECRET
- CHANNEL_ACCESS_TOKEN


たったこれだけで、しかもいまなら無料!!! で、LINEボットをイゴかすことができます:tada::tada::tada:

<font color="purple">$\huge{Thank\ you\ very\ much!!!}$</font>


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [docker](https://www.docker.com/)!!!
Enjoy LINE!!!
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
