---
title: Hacobuneにデータベースを使うPhoenix Chatアプリをデプロイする(Elixir)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2021-08-23T11:59:56+09:00'
id: e45406000046638fb9a8
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- さくらインターネット株式会社さんが提供している、PaaS型クラウドサービス「[Hacobune（はこぶね）](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)」に、[Phoenix](https://www.phoenixframework.org/)を利用してつくったChatアプリをデプロイしてみます
- デプロイ方法は次の3種類があります
    - **① パブリックのDockerイメージを使用**
    - ② プライベートのDockerイメージを使用
    - ③ GitHubレポジトリをHacobuneに接続して使用（Dockerfileが必須）
- この記事では自分でビルドしたDockerイメージを[Docker Hub](https://hub.docker.com/)にPushして、そのイメージを使うことで、**① パブリックのDockerイメージを使用** にてデプロイをします
- データベースは[Hacobune](https://manual.c1.hacobuneapp.com/docs)の中にある「[アドオン](https://manual.c1.hacobuneapp.com/docs/create-addon)」機能の中から[MySQL](https://www.mysql.com/jp/)を使ってみます[^1]
- この記事は、[Hacobune](https://manual.c1.hacobuneapp.com/docs)へのデプロイを主題としています

# できたもの
- https://phx-chat.c1.hacobuneapp.com/rooms
    - テスト用のユーザは、`awesome@awesome.com` と `test@awesome.com` を登録しています
        - パスワードは`123456789012`です
    - ご自由にお使いください
- [Register](https://phx-chat.c1.hacobuneapp.com/users/register)からユーザ登録することもできます

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5726f85c-5607-221c-1242-01d66a6d722b.gif)

- それぞれ別のユーザでログインしています
- ある人の投稿操作が他の人に即座に反映されている様子を示しています
- 見た目がそっけないのはご容赦ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

## ソースコード
- [GitHub TORIFUKUKaiou/hacobune_phx](https://github.com/TORIFUKUKaiou/hacobune_phx)
- [.devcontainer](https://code.visualstudio.com/docs/remote/containers)を用意していますので、[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)と[Docker](https://www.docker.com/)でお手軽に環境構築できます
    - 手前味噌の「[Phoenixの開発環境をつくる(Elixir)](https://qiita.com/torifukukaiou/items/5b90b038f38ce18c0256)」をご参照ください

### 参考にした資料 |> ありがとうございます！！！
- [Tracking Users in a Chat App with LiveView, PubSub Presence](https://elixirschool.com/blog/live-view-with-presence/)
    - [LiveView](https://github.com/phoenixframework/phoenix_live_view)のバージョンが古いですがざっとみておくとよいとおもいます
- [Phoenix LiveViewで作る web/mobile チャットアプリ 下準備編](https://qiita.com/the_haigo/items/c814c741faa447446ce5)
    - @the_haigo さん!
    - モデルをとても参考にさせていただきました
- [作って学ぶPhoenix LiveView、チャットアプリの作成](https://qiita.com/pojiro/items/dc8c9d97be82f91560bf)
    - @pojiro さん!
    - 記事中の`phx-hook`、`phx-update="append"`、`temporary_assigns: [messages: []]`にてチャットっぽくなりました
- [The Pragmatic Studio Phoenix LiveView](https://pragmaticstudio.com/courses/phoenix-liveview) :video_camera: 
    - ビデオ教材です
- [Programming Phoenix LiveView](https://pragprog.com/titles/liveview/programming-phoenix-liveview/) :book: 
    - 本です
    - [Phx.Gen.Auth](https://github.com/aaronrenner/phx_gen_auth) まわりで参考にしました
- [Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content)
    - Dockerfileのベースにしました
- [さくらインターネットの新PaaSの「Hacobune」で phpMyAdmin と WordPress を動かす](https://kazeburo.hatenablog.com/entry/2021/08/13/180414)
    - アドオンの使い方の感触をつかむことができました
- [MySQLでデータベース作成する「CREATE DATABASE」](https://uxmilk.jp/12421)
    - 当初、`CREATE DATABASE hacobune_phx;`と文字コードを指定せず作ったことでデフォルトのLatin1になって日本語が登録できなかったので、データベースを作り直すことになりました


# アプリケーションの仮登録
- ホスト名を決定します
- [Hacobune（β版）ドキュメント](https://manual.c1.hacobuneapp.com/docs)に従って、[アプリケーションの追加](https://manual.c1.hacobuneapp.com/docs/create-application)と[アプリケーションの公開](https://manual.c1.hacobuneapp.com/docs/publish-application)まで仮の値ですすめます
- ここで決定したドメイン名を`config/prod.exs`に設定します
    - 現状は`c1.hacobuneapp.com`のみ選択可能です
    - 以下は、`phx-chat.c1.hacobuneapp.com`の例です

```elixir:config/prod.exs
config :hacobune_phx, HacobunePhxWeb.Endpoint,
  url: [host: "phx-chat.c1.hacobuneapp.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"
```

# Dockerイメージの作成
- [ソースコード](https://github.com/TORIFUKUKaiou/hacobune_phx)はあのレベルまで持っていくにもいろいろとあるにはあるのですが、参考資料によりなんとかかんとかつくりました
    - `mix phx.new`するときに、`--database mysql`を指定しました
- プロジェクトのルートに以下のようなDockerfileをつくりました[^2]
    - [Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content) を参考にしました


```docker:Dockerfile
FROM elixir:1.12.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.9 AS app
RUN apk add --no-cache openssl ncurses-libs bash libstdc++

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/hacobune_phx ./
COPY entrypoint.sh .

ENV HOME=/app

CMD ["bash", "/app/entrypoint.sh"]
```

```sh:entrypoint.sh
bin="/app/bin/hacobune_phx"
# start the elixir application
eval "$bin eval \"HacobunePhx.Release.migrate\""
exec "$bin" "start"
```

- 以下のようにしてDockerイメージを[Docker Hub](https://hub.docker.com/)にPushしました
- [Docker Hub](https://hub.docker.com/)にアカウントを登録しておいてください

```
$ docker build -t hacobune_phx .
$ docker tag hacobune_phx torifukukaiou/hacobune_phx:0.2.0
$ docker login
$ docker push torifukukaiou/hacobune_phx:0.2.0
```

- とりあえず初回は手動でPushしましたが、GitHubのドキュメント「[Dockerイメージの公開](https://docs.github.com/ja/actions/guides/publishing-docker-images)」に従うことで[GitHub Actions](https://github.co.jp/features/actions)で自動で、[Docker Hub](https://hub.docker.com/)にPushできるようにしました
    - https://github.com/TORIFUKUKaiou/hacobune_phx/blob/ad51f8bf67349c992760a41cd91a5fb5f5f8b6d4/.github/workflows/push.yaml

# アドオン(MySQL)の作成

![スクリーンショット 2021-08-22 21.32.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6184c3b5-1923-04c0-c41e-3e59eba719d2.png)

- こんな感じでMySQLを選びます
- (ディスクサイズは1GBを選んでいたような気がしますがβ版だからなのか表示上は`0GB`になっています)

# データベースの作成
- [アドオンの外部接続](https://manual.c1.hacobuneapp.com/docs/endpoint-addon)を参考に、MySQLサーバに手元のPCからログインします

```
$ mysql -uroot -h <IPアドレス> -P <ポート番号> -p

mysql> CREATE DATABASE hacobune_phx DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;

mysql> quit
```


# アプリケーションの登録

![スクリーンショット 2021-08-22 21.40.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/35897133-b3d1-e3c6-3a8c-ab4df81cf29d.png)

- Dockerイメージ名には、[torifukukaiou/hacobune_phx:0.2.0](https://hub.docker.com/layers/torifukukaiou/hacobune_phx/0.2.0/images/sha256-bd98566f5727b701fe7d519377c88426702295977937af366d5fdd857c00a38d?context=repo)のような感じで指定します
- ポートは`4000`番にしておきます
- 環境変数は以下の2つを設定しておきます
    - DATABASE_URL
        - `ecto://root:<password>@mysql:3306/hacobune_phx`
            - `ecto://<user>:<password>@HOST:PORT/database_name`
            - アドオン名を`mysql`とつけたのでHOSTは、`mysql`となっています
            - `<password>`はMySQLのアドオンを作成するときに指定したパスワードです
    - SECRET_KEY_BASE
        - 開発マシンでプロジェクトのルートにて`mix phx.gen.secret`をして出力された長い文字列を指定します

# Run :rocket::rocket::rocket:
- 以上でChatアプリがイゴくようになりました[^3] :tada::tada::tada:
- もう一度、WebアプリのURLを書いておきます
- https://phx-chat.c1.hacobuneapp.com/rooms
    - テスト用のユーザは、`awesome@awesome.com` と `test@awesome.com` を登録しています
        - パスワードは`123456789012`です
    - ご自由にお使いください

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [Hacobune（はこぶね）](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)に、[Phoenix](https://www.phoenixframework.org/)アプリを簡単にデプロイすることができました
- [Phoenix](https://www.phoenixframework.org/)にてChatアプリを作るのはとてもいい勉強になりました
    - Chatアプリの作り方については、[Phoenix](https://www.phoenixframework.org/) 1.6.0の正式リリース後に改めて書きたいとおもっています[^4]
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:



[^1]: [Phoenix](https://www.phoenixframework.org/)といえば[PostgreSQL](https://www.postgresql.org/)ですが、2021/08/22現在の[Hacobune](https://manual.c1.hacobuneapp.com/docs) β版では、MySQLとRedisの2つが提供されています
[^2]: 前の節でホスト名を直打ちして固定しているのでこのDockerイメージは私以外に使いみちがありません
[^3]: 記事では一本道でできるように書きましたが、実際には一歩進んで二歩下がるみたいなことを繰り返しました :sweat_smile:
[^4]: おもっています[^5]
[^5]: あくまでもおもっています
