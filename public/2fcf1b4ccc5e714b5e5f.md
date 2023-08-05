---
title: docker-compose upでWordPressを動かす(もちろんHTTPS)
tags:
  - WordPress
  - Docker
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-09-12T15:32:36+09:00'
id: 2fcf1b4ccc5e714b5e5f
organization_url_name: fukuokaex
slide: false
---
# はじめに

ふとおもいつきでWordPressのサイトを立ち上げました。
`docker-compose.yml`を書いておきます。

# docker-compose.yml

```yml:docker-compose.yml
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
      - DEFAULT_EMAIL=example@example.com
      - NGINX_PROXY_CONTAINER=nginx-proxy
    depends_on:
      - nginx-proxy

  wordpress:
    image: wordpress
    restart: always
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
      VIRTUAL_HOST: wordpress.autoracex.dev
      VIRTUAL_PORT: 80
      LETSENCRYPT_HOST: wordpress.autoracex.dev
      LETSENCRYPT_EMAIL: example@example.com
    volumes:
      - wordpress:/var/www/html
    depends_on:
      - nginx-proxy-acme

  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_DATABASE: exampledb
      MYSQL_USER: exampleuser
      MYSQL_PASSWORD: examplepass
      MYSQL_RANDOM_ROOT_PASSWORD: '1'
    volumes:
      - db:/var/lib/mysql
    depends_on:
      - nginx-proxy-acme

volumes:
  certs:
  vhost:
  html:
  acme:
  wordpress:
  db:
```

## 環境変数

以下の環境変数の値は適宜書き換えてください。

- DEFAULT_EMAIL
- VIRTUAL_HOST
- LETSENCRYPT_HOST
- LETSENCRYPT_EMAIL

以下の環境変数にはそれぞれ同じ値を設定してください。

- WORDPRESS_DB_NAMEとMYSQL_DATABASE
- WORDPRESS_DB_USERとMYSQL_USER
- WORDPRESS_DB_PASSWORDとMYSQL_PASSWORD

## [Let's Encrypt](https://letsencrypt.org/ja/)

[Let's Encrypt](https://letsencrypt.org/ja/)でSSL証明書を取得しています。
[nginxproxy/acme-companion](https://hub.docker.com/r/nginxproxy/acme-companion)が取得してくれます。
また有効期限が近くなったら自動的に更新してくれます。

前提として、VIRTUAL_HOSTとLETSENCRYPT_HOSTに設定したドメインのAレコードには、動作させているサーバのIPアドレスが設定されているものとします。


# 動かし方

```
$ docker-compose up -d
```


# 参考記事

[Dockerを使ってLivebookとGrafanaをサーバ上でイゴかす(もちろんHTTPS)](https://qiita.com/torifukukaiou/items/6f6e9297e5275b951094)

自分で書いた記事です。

# おわりに

ふとおもいつきでWordPressのサイトを立ち上げて、ふとおもいつきでそのままQiitaにdocker-compose.ymlファイルを書いておきました。
