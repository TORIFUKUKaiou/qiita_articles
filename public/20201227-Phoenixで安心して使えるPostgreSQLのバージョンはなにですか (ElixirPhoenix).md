---
title: Phoenixで安心して使えるPostgreSQLのバージョンはなにですか? (Elixir/Phoenix)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2020-12-27T09:15:56+09:00'
id: 276186d57c5716c7e494
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- 2020/12/26(土)に行われた[kokura.ex#16：Elixir忘年会&もくもく会～入門もあるよ（9:30~）](https://fukuokaex.connpass.com/event/198374/)でこんな質問がありました
    - **（Phoenixにつかうという観点で） Postgres 13系ってstableなんでしたっけ？**
    - @im_miolab さん、開催ありがとうございます！
- せっかくなので、調べたことを記事にしておきます
- これまで私は意識したことはありませんでした
    - それで困ったことはありません

# 回答(2020/12/27 07:49現在)
- Supports PostgreSQL 8.4, 9.0-9.6, and **later** (hstore is not supported on 8.4)
    - [Postgrex](https://github.com/elixir-ecto/postgrex)
        - [Phoenix](https://www.phoenixframework.org/)アプリプロジェクトの`mix.lock`に、[Postgrex](https://github.com/elixir-ecto/postgrex)は入っています

# 調べたこと
- [Phoenix](https://www.phoenixframework.org/)公式ガイドの[Installation -- PostgreSQL](https://hexdocs.pm/phoenix/installation.html#postgresql)には特にバージョンの言及はなし
    - @mokichi さん、ありがとうございます！
- [Postgrex](https://github.com/elixir-ecto/postgrex)
    - [José Valim](https://twitter.com/josevalim)氏が[Contributors](https://github.com/elixir-ecto/postgrex/graphs/contributors)に名を連ねていらっしゃる
    - **later**がどこまでのバージョンを指しているのかは不明ですが、おそらく13も余裕で対応しているのではないでしょうか

# そういえば、思い出したこと
## [Gigalixir](https://www.gigalixir.com/)で使っているバージョン
- PostgreSQL `12.5`
- `gigalixir pg`して出力される`url`に対して、ローカルマシンから`psql url`をして繋いでみました
- 説明前後しますが、[Gigalixir](https://www.gigalixir.com/)というのは、簡単にWebアプリケーションをデプロイできるサービスです
    - 手前味噌ですが、[Hello Gigalixir (Phoenix/Elixir)](https://qiita.com/torifukukaiou/items/d2d0e9f56ffe3bb8eda1)や
    - [Phoenix](https://www.phoenixframework.org/)公式ガイドの[Deploying on Gigalixir](https://hexdocs.pm/phoenix/gigalixir.html#content)
    - をご参照ください

```
psql=> SELECT version();
                                                               version                                                               
-------------------------------------------------------------------------------------------------------------------------------------
 PostgreSQL 12.5 (Ubuntu 12.5-0ubuntu0.20.04.1) on x86_64-pc-linux-gnu, compiled by gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, 64-bit
(1 row)
```

## [Release a Phoenix application with docker and Postgres](https://medium.com/@j.schlacher_32979/release-a-phoenix-application-with-docker-and-postgres-28c6ae8c7184)
- 2019/12/31の記事です
- この記事中では、PostgreSQLは`9.6`を使っています
- 私が[Phoenix](https://www.phoenixframework.org/)プロジェクトでDockerやろうとアレコレしたときに参考にしました

## [Phoenixプロジェクトをmix releaseでパッケージ化してdockerコンテナで動作させる](https://www.koga1020.com/posts/mix-release-example)
- @koga1020 さんの2019/12/14の記事です
- こちらではPostgreSQLのバージョンは明示されていないので、`docker-compose up`した時点でのlatestで構築されるものとおもわれます
- こちらの記事は`mix release`を調べていてとても参考にしました
    - Thanks a lot:bangbang::bangbang::bangbang:

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- 2020/12/27 07:49現在、[Phoenix](https://www.phoenixframework.org/)アプリとの組み合わせにおいて、
- PostgreSQLは9.6を使っておくのが無難は無難
    - [Postgrex](https://github.com/elixir-ecto/postgrex)のサポートバージョン情報
- [Gigalixir](https://www.gigalixir.com/)は`12.5`を使っているようなので、これもだいじょうぶでしょう
- あれこれ上で言いはしましたが:interrobang:、[Postgrex](https://github.com/elixir-ecto/postgrex)のサポートバージョン情報には**later**と書いてあるし、[José Valim](https://twitter.com/josevalim)氏が[Contributors](https://github.com/elixir-ecto/postgrex/graphs/contributors)に名を連ねていらっしゃるので、新しいものだったら何でも動きそう:bangbang:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
