---
title: Dockerを使ってLivebookとGrafanaをサーバ上でイゴかす(もちろんHTTPS)
tags:
  - Elixir
  - Docker
  - Livebook
private: false
updated_at: '2022-02-02T00:31:36+09:00'
id: 6f6e9297e5275b951094
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Docker](https://www.docker.com/)を使って、[Livebook](https://github.com/livebook-dev/livebook)と[Grafana](https://github.com/grafana/grafana)をサーバ上でイゴかします[^1]
    - [Livebook](https://github.com/livebook-dev/livebook)は[Elixir](https://elixir-lang.org/)で楽しめるノートブックです
    - [Grafana](https://github.com/grafana/grafana)は全然わかっていませんが、https://github.com/nginx-proxy/acme-companion/tree/7f1b75460d2a4ba9aa81e6da06c3119b41ef94db#readme のサンプルで使われていたのでそのまま使ってみました
- ホスト名とIPアドレスの紐付けはこの記事では書いていません
- [Google Domains](https://domains.google/intl/ja_jp/)、[お名前.com](https://www.onamae.com/)等お使いのサービスのDNS設定にてAレコードを登録しておいてください

![スクリーンショット 2021-09-15 22.34.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a4bf2d89-e259-5d09-316f-da5bf9d8d405.png)



# できあがったもの
- どうぞご自由にお使いください
- [Time4VPS](https://www.time4vps.com/)の[Linux VPS - Linux 2](https://www.time4vps.com/linux-vps/) でイゴかしています
    - RAM: 2GB
    - OS: Ubuntu 20.04 LTS
    - 月額 3.99EUR
- だれも使っていないであろう状態でメモリは以下のようになっていました

```
$ free -m
              total        used        free      shared  buff/cache   available
Mem:           1987         588         115          52        1283        1177
Swap:             0           0           0
```

## [Livebook](https://github.com/livebook-dev/livebook)
- https://livebook.torifuku-kaiou.tokyo
- https://livebook.torifuku-kaiou.app
    - Password: `enjoyelixirwearethealchemists`

## [Grafana](https://github.com/grafana/grafana)
- https://grafana.torifuku-kaiou.app

# 構成図
![](https://github.com/nginx-proxy/acme-companion/raw/main/schema.png)

- https://github.com/nginx-proxy/acme-companion より
- この記事の場合、`app1`が[Livebook](https://github.com/livebook-dev/livebook)、`app2`が[Grafana](https://github.com/grafana/grafana)、`app3`はまだないということになります
- **Automated creation/renewal of Let's Encrypt (or other ACME CAs) certificates using acme.sh.**

# docker-compose.yml
- ここで、いきなり、`docker-compose.yml`と`.env`を書いておきます
- ここがこの記事のハイライトです
- たったの2ファイルです
- **これだけでイゴきます**

```yaml:docker-compose.yml
version: "3.3"

services:
  nginx-proxy:
    image: nginxproxy/nginx-proxy
    container_name: nginx-proxy
    ports:
      - 80:80
      - 443:443
    volumes:
      - certs:/etc/nginx/certs
      - vhost:/etc/nginx/vhost.d
      - html:/usr/share/nginx/html
      - /var/run/docker.sock:/tmp/docker.sock:ro

  nginx-proxy-acme:
    image: nginxproxy/acme-companion
    container_name: nginx-proxy-acme
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - acme:/etc/acme.sh
      - certs:/etc/nginx/certs
      - vhost:/etc/nginx/vhost.d
      - html:/usr/share/nginx/html
    environment:
      - DEFAULT_EMAIL=${EMAIL}
      - NGINX_PROXY_CONTAINER=nginx-proxy
    depends_on:
      - nginx-proxy

  grafana:
    image: grafana/grafana
    container_name: grafana
    environment:
      - VIRTUAL_HOST=${GRAFANA_HOST}
      - VIRTUAL_PORT=3000
      - LETSENCRYPT_HOST=${GRAFANA_HOST}
      - LETSENCRYPT_EMAIL=${EMAIL}
    depends_on:
      - nginx-proxy-acme

  livebook:
    image: livebook/livebook:0.2.3
    container_name: livebook
    environment:
      - VIRTUAL_HOST=${LIVEBOOK_HOST}
      - VIRTUAL_PORT=8080
      - LETSENCRYPT_HOST=${LIVEBOOK_HOST}
      - LETSENCRYPT_EMAIL=${EMAIL}
      - LIVEBOOK_PASSWORD=enjoyelixirwearethealchemists
    depends_on:
      - nginx-proxy-acme

volumes:
  certs:
  vhost:
  html:
  acme:
```

```:.env
EMAIL=torifuku.kaiou@gmail.com
GRAFANA_HOST=grafana.torifuku-kaiou.app
LIVEBOOK_HOST=livebook.torifuku-kaiou.tokyo,livebook.torifuku-kaiou.app
```

## [Docker](https://www.docker.com/)のインストール
- 話は前後しますが、[Docker](https://www.docker.com/)のインストールが必要です
- 次の手順を参考にしてインストールしてください
    - https://docs.docker.com/engine/install/ubuntu/
    - 上記とプラス `sudo apt install docker-compose`


## 実行
- 適当なディレクトリに`docker-compose.yml`と`.env`を格納しておきます
- DNSの設定は済んでいるものとします
- `docker-compose config`で正しく環境変数が埋め込まれてていることを確認しておきましょう

```
$ sudo docker-compose config

$ sudo docker-compose up -d
```



## docker-compose.yml を書くまでにやったこと
- 思い出を書いておきます
- https://github.com/nginx-proxy/acme-companion/tree/7f1b75460d2a4ba9aa81e6da06c3119b41ef94db#readme に書いてある`docker`コマンドのサンプルをそのまままずサーバ上で実行してみました
- そうすると、あっけなく成功したので自信を得て、`docker-compose.yml`にしてみました
- 一発で動いたわけではなく、エラーが発生してログとの格闘はあるにはありましたが、ここでは最終成果のみ書いておきます
- 最初の実験は[Azure 仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)で実施しました
- その公式に書いてあるコマンドは以下のようなもので、メールアドレスとホスト名は自分が使うものに置き換えました

```
$ sudo docker run --detach \
    --name nginx-proxy \
    --publish 80:80 \
    --publish 443:443 \
    --volume certs:/etc/nginx/certs \
    --volume vhost:/etc/nginx/vhost.d \
    --volume html:/usr/share/nginx/html \
    --volume /var/run/docker.sock:/tmp/docker.sock:ro \
    nginxproxy/nginx-proxy

$ sudo docker run --detach \
    --name nginx-proxy-acme \
    --volumes-from nginx-proxy \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    --volume acme:/etc/acme.sh \
    --env "DEFAULT_EMAIL=torifuku.kaiou@gmail.com" \
    nginxproxy/acme-companion

$ sudo docker run --detach \
    --name grafana \
    --env "VIRTUAL_HOST=docker-study-ip.westus.cloudapp.azure.com" \
    --env "VIRTUAL_PORT=3000" \
    --env "LETSENCRYPT_HOST=docker-study-ip.westus.cloudapp.azure.com" \
    --env "LETSENCRYPT_EMAIL=torifuku.kaiou@gmail.com" \
    grafana/grafanaa
```

- ここでいろいろ詰まってしまうのではないかとヒヤヒヤしていたのですが、公式の記述がしっかりしているおかげで何も詰まることはなくすんなり成功体験ができました :tada::tada::tada::tada::tada:
- <font color="purple">$\huge{ありがとうございます！}$</font>


![スクリーンショット 2021-09-15 20.59.48.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6af498a2-c645-2e03-29bb-b7b3c4ca6ad5.png)



# 後記
- 以前から[Livebook](https://github.com/livebook-dev/livebook)をhttps://livebook.torifuku-kaiou.tokyo にて全世界に公開していました
- けっこう手動でやっていました
    - [asdf](https://github.com/asdf-vm/asdf)によるErlang, Elixirのインストール
        - Erlangのインストールがけっこうハマりがち
    - Nginxのインストール
    - certbotのインストール
    - SSL証明書の取得(期限が近くなったら更新)
    - [Livebook](https://github.com/livebook-dev/livebook)の`git clone`
    - [Livebook](https://github.com/livebook-dev/livebook)が新しくなったら`git pull`
    - とかとか
- `nginx letsencrypt docker compose`でググってみて見つかった先人の方々の記事を読みました
    - ありがとうございます！
- [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)というDocker Imageを使うといいよという記事をたくさん目にしました
- [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)へアクセスすると、[nginx-proxy/nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)にリダイレクトされました
- あとは、[nginx-proxy/nginx-proxy](https://github.com/nginx-proxy/nginx-proxy)のほうを読み込みました
- というか私にとってはむしろ[nginx-proxy/acme-companion](https://github.com/nginx-proxy/acme-companion)のREADMEがとてもわかりやすかったです
- `docker-compose.yml`を書くときのImage名は最新のREADMEにあわせて書いてみました

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- 次は自作の[Phoenix](https://www.phoenixframework.org/)アプリをぶら下げてみようとおもいます[^2]
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 



[^1]: イゴかす = 動かす。西日本の一部の方言(たぶん)。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ
[^2]: あくまでもおもっています
