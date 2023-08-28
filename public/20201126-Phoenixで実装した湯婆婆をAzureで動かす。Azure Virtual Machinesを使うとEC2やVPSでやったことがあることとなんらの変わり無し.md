---
title: >-
  Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual
  Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。
tags:
  - Azure
  - Elixir
  - Phoenix
  - fukuoka.ex
  - 湯婆婆
private: false
updated_at: '2021-01-03T23:12:38+09:00'
id: c468a228f9d0ba13ffb9
organization_url_name: fukuokaex
slide: false
---
この記事は、[湯婆婆 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/yubaba)の3日目です。
前日は、@h-takaumaさんの[Dialogflowで湯婆婆を実装してみる](https://qiita.com/h-takauma/items/b9bae322a9c29f9c7b27)でした。

# はじめに
- [ひょんなこと](https://qiita.com/advent-calendar/2020/azure-cloudnative)から[Azure](https://azure.microsoft.com/ja-jp/)をはじめました
- [Phoenix](https://www.phoenixframework.org/)アプリを[Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)で動かしてみます
- 動機は**タイトルにおもい**をこめました
- [Phoenix](https://www.phoenixframework.org/)アプリはなにでもいいのですが、[Phoenixで湯婆婆を実装してみる](https://qiita.com/torifukukaiou/items/43f50cb6abab40d4e7d1)なんてどうかなあー、と
- 以下、[TORIFUKUKaiou/yubaba](https://github.com/TORIFUKUKaiou/yubaba)プロジェクトで説明します
    - このプロジェクトはこの記事で説明している下記の変更は、すでに行っております

## 完成品
- ~~[https://yubaba.torifuku-kaiou.tokyo/yubaba](https://yubaba.torifuku-kaiou.tokyo/yubaba)~~
    - ~~この記事で紹介している方法で構築しています~~
    - ~~[Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)を使っています~~
    - ~~[Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)が700円/日ほどかかるようなので課金状況みて止めるかもしれません~~
    - ~~↓↓↓へ転送します~~
    - 転送も止めました
- ~~[https://yubaba-vm.torifuku-kaiou.tokyo/yubaba](https://yubaba-vm.torifuku-kaiou.tokyo/yubaba)~~
    - ~~[Azure VM](https://azure.microsoft.com/ja-jp/services/virtual-machines/)で動かしています~~ :sweat_smile:
    - 止めました

# [Docker](https://www.docker.com/)
- ほぼほぼ、[Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content)に書いてある通りのことをやります

1. `config/prod.secret.exs`を`config/releases.exs`にリネーム
1. `config/releases.exs`の先頭のほうにある`use Mix.Config`を`import Config`に書き換える
  - よくみて書き換えてね
1. `config/prod.exs`の中で`import_config "prod.secret.exs"`を呼び出しているところはもはやいらないので消す
1. `config/releases.exs`に、`config :yubaba, YubabaWeb.Endpoint, server: true`を足す
1. `config/prod.exs`の`url:`のところを変更する
1. `lib/yubaba/release.ex`をつくる
1. `Dockerfile`、`entrypoint.sh`ファイルを作る
    - `Dockerfile`はサンプルがあるのでほぼそのまま写します
    - [Release a Phoenix application with docker and Postgres](https://medium.com/@j.schlacher_32979/release-a-phoenix-application-with-docker-and-postgres-28c6ae8c7184)を参考にしていい感じに少し変えています



## config/prod.exs
```diff:config/prod.exs
@@ -10,7 +10,7 @@ use Mix.Config
 # which you should run after static files are built and
 # before starting your production server.
 config :yubaba, YubabaWeb.Endpoint,
-  url: [host: "example.com", port: 80],
+  url: [host: "yubaba.torifuku-kaiou.tokyo", port: 443],
   cache_static_manifest: "priv/static/cache_manifest.json"

 # Finally import the config/prod.secret.exs which loads secrets
 # and configuration from environment variables.
-import_config "prod.secret.exs"
+# import_config "prod.secret.exs"
```

## lib/yubaba/release.ex

```elixir:lib/yubaba/release.ex
defmodule Yubaba.Release do
  @app :yubaba

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
```

## Dockerfile
```docker:Dockerfile
FROM elixir:1.9.0-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python

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
RUN apk add --no-cache openssl ncurses-libs bash

WORKDIR /app
COPY entrypoint.sh .

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/yubaba ./

ENV HOME=/app

CMD ["bash", "/app/entrypoint.sh"]
```

## entrypoint.sh

```sh:entrypoint.sh
#!/bin/bash

bin="/app/bin/yubaba"

eval "$bin eval \"Yubaba.Release.migrate\""
exec "$bin" "start"
```

## [Docker イメージを構築](http://docs.docker.jp/v1.9/engine/userguide/dockerimages.html)

- と準備が整ったところで[Docker イメージを構築](http://docs.docker.jp/v1.9/engine/userguide/dockerimages.html)します
- **Docker イメージとはコンテナの土台です** と↑のリンク先に書いてあります
- 想像の翼を自由に広げて感じ取りましょう

```
$ chmod +x entrypoint.sh
$ mkdir -p priv/static
$ docker build -t yubaba .
```

- とりあえずローカルで動かしてみましょうか
- `mix phx.gen.secret`の結果はここに書いてあるものとは異なりますので読み替えてください

```
$ mix phx.gen.secret
hogehogepekepekefoofooinoki123da

$ docker run -it --rm -p 5432:5432 -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=yubaba_dev postgres:9.6

$ docker run -it --rm -p 4000:4000 \
  -e DATABASE_URL=ecto://postgres:postgres@host.docker.internal/yubaba_dev -e SECRET_KEY_BASE="hogehogepekepekefoofooinoki123da" \
  yubaba
```

- visit: http://localhost:4000/yubaba
- ちゃんと動きましたか？
- 動かなかったら私の記述が足りていないところや誤りがあるかもしれないのでお気軽にお問い合わせください
- あー、`host.docker.internal`は[macOS](https://docs.docker.jp/docker-for-mac/networking.html#mac-i-want-to-connect-from-a-container-to-a-service-on-the-host)と[Windows](https://docs.docker.jp/docker-for-windows/networking.html#i-want-to-connect-from-a-container-to-a-service-on-the-host)でしか使えないのですかね
- ここまででもだいぶ長くなりました

# [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)で動かす
- ようやく本題です
- [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)というのは、最初から[Docker](https://www.docker.com/)が使えるようになっているコンピュータがあって、ぽちぽちっとイメージや環境変数を指定したら勝手にいい感じに起動してくれるすぐれモノです
    - 私のイメージを書いています
    - 正しい定義は[公式ページ](https://docs.microsoft.com/ja-jp/azure/containers/)をご参照ください

## 完成品
- ~~[https://yubaba.torifuku-kaiou.tokyo/yubaba](https://yubaba.torifuku-kaiou.tokyo/yubaba)~~

## 概要
- 0. まずは[無料で始める](https://azure.microsoft.com/ja-jp/)でアカウントをつくりましょう
- 1. [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)をつくってそこに上で作ったDockerイメージを置く(pushする)
- 2. [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)でPostgreSQLを動かす
    - [データベース](https://azure.microsoft.com/ja-jp/product-categories/databases/)を使うのがいいのだとおもいます
    - とにかく私は[Docker](https://www.docker.com/)と仲良くなりはじめたので[Docker](https://www.docker.com/)でやってみます
- 3. [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)で湯婆婆アプリを動かす
- 4. SSL証明書を取得して、`.pfx`形式にする
- 5. [Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)と湯婆婆アプリを結びつける
- 6. [Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)のIPアドレスをAレコードとしてDNS設定する

## 1. [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)をつくってそこに上で作ったDockerイメージを置く(pushする)
- [クイック スタート:Azure portal を使用して Azure コンテナー レジストリを作成する](https://docs.microsoft.com/ja-jp/azure/container-registry/container-registry-get-started-portal)に従って、Docker イメージを置く場所を確保します
    - `サブスクリプション`と`リソースグループ`は料金に関するアレなやつです
    - 感じてください
- [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)ができあがったら、コンソールにあるクイックスタートに書いてあることを参考にしながらDockerイメージをプッシュします
- PostgreSQLはDocker Hubから頂戴します
![スクリーンショット 2020-11-26 2.33.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9c521a85-1f0d-d3eb-a2a1-3a769cbeefbe.png)

- `docker login awesometest.azurecr.io`に使う情報は、↑左側の`アクセスキー`を押すとわかります

```
$ docker login awesometest.azurecr.io
$ docker tag yubaba awesometest.azurecr.io/yubaba
$ docker push awesometest.azurecr.io/yubaba
```

- これでDockerイメージが[Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)に置けたのであります :tada::tada::tada:

## 2. [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)でPostgreSQLを動かす
- 雰囲気、これな[クイック スタート:Azure portal を使用してコンテナー インスタンスを Azure 内にデプロイする](https://docs.microsoft.com/ja-jp/azure/container-instances/container-instances-quickstart-portal)感じで進めます
- PostgreSQLはDocker Hubから頂戴します

![スクリーンショット 2020-11-26 2.45.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/388c257a-881b-bb86-ab5f-39a75f2c2c70.png)

- ネットワークの設定はプライベートにして、もしはじめてなら`仮想ネットワーク`は新規作成します(こだわりなければ名前だけつけておけばいいでしょう)
- ポートは5432にします
![スクリーンショット 2020-11-26 2.48.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/aa869a5f-f7fc-1f84-79fd-5a130bbe9a2e.png)

- 詳細のところで環境変数`POSTGRES_PASSWORD`と`POSTGRES_DB`を設定しておきます

![スクリーンショット 2020-11-26 2.52.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/db73cc93-db46-6b01-5778-7561abff1fc4.png)

- あとは作成へ一直線です
- できあがったらPostgreSQLのIPアドレスを控えておきます

![スクリーンショット 2020-11-26 2.54.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a372f9c8-03c1-f529-fa86-cf1c60a022db.png)

## 3. [Azure コンテナーサービス](https://docs.microsoft.com/ja-jp/azure/containers/)で湯婆婆アプリを動かす
- 手順2と同じような感じです
- 手順1で作って、イメージを置いている[Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)から取得します
![スクリーンショット 2020-11-26 2.56.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/bf1f4b42-6f18-3bd1-3d49-d5dbe476384b.png)
- ネットワークはプライベートにして、2番と同じ仮想ネットワークを選んでおきます
- ポートは`4000 TCP`です
- 環境変数には次の２つを設定してください
    - DATABASE_URL
        - ecto://postgres:postgres@10.1.0.4/yubaba
        - 手順2のIPアドレスを指定します
    - SECRET_KEY_BASE
        - hogehogepekepekefoofooinoki123da (例)
        - ローカルでの動作確認のときに`mix phx.gen.secret`にて生成したものを書きます
- 作成できましたらIPアドレスを控えておきます

## 4. SSL証明書を取得して、`.pfx`形式にする
- SSL証明書はたとえば[Let's Encrypt](https://letsencrypt.org/ja/)を利用させてもらって、[DNS-01 チャレンジ](https://letsencrypt.org/ja/docs/challenge-types/#dns-01-%E3%83%81%E3%83%A3%E3%83%AC%E3%83%B3%E3%82%B8)で取得するのでどうでしょうか
- この記事では詳細は省きます
- すでに取得済という前提で進めます
- `.pfx`という形式で必要となります
- [Azure Application Gateway で Let’s Encrypt も使えます。Let’s Try ！](https://level69.net/archives/24281)の記事で詳しく説明されています
    - ありがとうございます！

```
# cd /etc/letsencrypt/live/torifuku-kaiou.tokyo/
# ls
cert.pem  chain.pem  fullchain.pem  privkey.pem

# openssl pkcs12 -export -inkey privkey.pem -in cert.pem -out agw.pfx
```
- Passwordをつけます
- `agw.pfx`を5で適用します


## 5. [Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)と湯婆婆アプリを結びつける
- 雰囲気、[クイック スタート:Azure Application Gateway による Web トラフィックのルーティング - Azure portal](https://docs.microsoft.com/ja-jp/azure/application-gateway/quick-create-portal)こんな感じで設定していきます
    - レベルは`Standard V2`を選んでください
    - これにしておかないとWebSocketのエラーがでるようです
    - 700円/日くらいと私が個人で使いつづけるにはまあまあする
    - 湯婆婆で動かしつづけるのはもったいない。。。
- 仮想ネットワークは、PostgreSQLや湯婆婆をつくるときに使ったものと同じものを選びます
- 一番最初にやるときは`サブネット構成の管理`からサブネットの追加が必要になります
    - なんとなく雰囲気でやりましょう
![スクリーンショット 2020-11-26 3.10.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ca1a07b0-42f5-cbef-1353-1fa9898694fb.png)
- 次の`フロントエンドの数`というタブではIPの種類を`パブリック`にしましょう
    - IPアドレスは選ぶものがなければ新規作成で作ってください
- `バックエンド`タブは雰囲気↓な感じで設定します
    - IPアドレスは湯婆婆コンテナインスタンス(3)のものです
![スクリーンショット 2020-11-26 3.15.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0f1130a5-ff68-cb5c-f489-4eee7e6b9b11.png)
- `構成`というタブでは真ん中の`ルーティング規則の追加`を押して↓てな感じで設定します
- 証明書は4のものをアップロードします

![スクリーンショット 2020-11-26 3.18.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/680b0573-c1fe-3bf9-8a3d-fd1fd623cb9f.png)

- あとは作成まで一直線です :rocket::rocket::rocket:
- 作成できたら、`フロントエンド パブリック IP アドレス`を控えておきます

## 6. [Azure Application Gateway](https://docs.microsoft.com/ja-jp/azure/application-gateway/overview)のIPアドレスをAレコードとしてDNS設定
- あとは`フロントエンド パブリック IP アドレス`をAレコードとしてお使いのサービス([お名前.com](https://www.onamae.com/)や[Google Domains](https://domains.google.com/)など)にDNSの設定をすれば完了です :tada::tada::tada: 

![スクリーンショット 2020-11-26 3.35.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e91b7e5-c351-92af-4d3b-79d0f5b8aa86.png)





# Wrapping Up! :lgtm: :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5: :lgtm: 
- [Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content)には`Dockerfile`が書いてあるなー、だけどこれなにに使うのだろう？　という感じでいまいちピンときていませんでした
- [コンテナサービス](https://docs.microsoft.com/ja-jp/azure/containers/)と組み合わせることでそういうことに使うのね！　というのがわかってきました
- 今回私は全編手作業でやっていますが、[GitHub アクションを構成してコンテナー インスタンスを作成する](https://docs.microsoft.com/ja-jp/azure/container-instances/container-instances-github-action)を駆使して自動化するんだろうなあー　ということにおもいをはせつつ筆をおきます
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 
- 4日目は、@wakwakさんの[湯婆婆Androidアプリを作ってみました](https://qiita.com/wakwak/items/b00372ab0eddeeac3e4c) です。続けてお楽しみください。(おもしろいですよ〜)

