---
title: LivebookのSmart cellsでPostgreSQLの接続とグラフ描画を楽しむ（Elixir）
tags:
  - Elixir
  - Docker
  - 40代駆け出しエンジニア
  - Livebook
  - AdventCalendar2022
private: false
updated_at: '2022-09-27T21:43:15+09:00'
id: 8332fc2bac0778f40d8c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

[Elixir](https://elixir-lang.org/)には[Livebook](https://livebook.dev/)というすごいNotebookがあります。
2022/09/23現在、v0.6.3です。
現在進行形で、素敵な機能がもりもり盛り込まれています。
v1.0.0の世界線が楽しみです。ワクワクします。

[Elixir](https://elixir-lang.org/)の作者[José Valim](https://twitter.com/josevalim)さんの動画をみました。
同じようなことをやってみたいとおもいます。
[José Valim](https://twitter.com/josevalim)さんの動画では省略されているデータベースへのデータセットなども説明します。この通りにやれば、[José Valim](https://twitter.com/josevalim)さんが説明されていたことをおおよそ追体験できる記事です。

# [José Valim](https://twitter.com/josevalim)さんの動画

<iframe width="1115" height="627" src="https://www.youtube.com/embed/4hVIxyHxwK8" title="Livebook v0.6 - Automate and learn with smart cells by José Valim" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# Prerequests

[Docker](https://www.docker.com/)を使います。

# 説明

説明動画を撮りました。
細かいところは動画をみてください。
動画の中で使っているスニペットを貼っておきます。

## 動画

<iframe width="1093" height="615" src="https://www.youtube.com/embed/BY_R7Hgmv-A" title="Livebook smart cells postgres" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## docker-compose.yml

まず `docker-compose.yml` を用意します。

```yml:docker-compose.yml
version: '3'

services:
  livebook:
    image: livebook/livebook
    ports:
      - 8080:8080
      - 8081:8081
    depends_on:
      - db

  db:
    image: postgres:13
    ports:
      - 5432:5432
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres
```

実行します。
もちろん、`docker-compose.yml`をおいてあるディレクトリで実行してください。

```
docker-compose up
```

待ちます。
初回は、イメージのダウンロードが行われます。

https://qiita.com/torifukukaiou/items/24ab8b4b313b6f5171d9

:::note info
追記
上記記事に従うと、データベースの初期化を自動的に行えます。
:::


## Livebookの起動

しばらく待つとこんなログがでているはずです。
迷わず、ブラウザでアクセスしてください。
`token`は起動の都度かわります。
ご自身のお手元で表示された通りに入力してください。

```
[Livebook] Application running at http://0.0.0.0:8080/?token=dj6jahpaonhg7rq2nbzudtzg3mgj32go
```

## New notebook -> Smart cells

このへんはうまく説明できないので動画をみてください。

## PostgreSQLへデータのセット




https://qiita.com/torifukukaiou/items/24ab8b4b313b6f5171d9

:::note info
追記
上記記事に従うと、データベースの初期化を自動的に行えます。
:::


```
docker ps
```

で、PostgreSQLのCONTAINER IDを調べてください。
そうして

```
docker container exec -it 0be320382c2a bash
```

でPostgreSQLコンテナの中に入ります。
`0be320382c2a`はCONTAINER ID(例)です。
適宜読みかえてください。

以下、PostgreSQLコンテナでの操作です。

```
psql -U postgres
```

以下、psqlでの操作です。

```
CREATE DATABASE sample;
\c sample;
```

テーブル作成、データの挿入は以下のGistを使用させていただきました。
ありがとうございます！

https://gist.github.com/faustofjunqueira/ba97008616148653a9c633c066edaba9

そのまま転載しておきます。

```
DROP TABLE IF EXISTS iris;
CREATE TABLE iris(
  sepal_l FLOAT,
  sepal_w FLOAT,
  petal_l FLOAT,
  petal_w FLOAT,
  class   VARCHAR(20)
);

insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.5,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,3.0,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.7,3.2,1.3,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.6,3.1,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.6,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.9,1.7,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.6,3.4,1.4,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.4,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.4,2.9,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,3.1,1.5,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.7,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.8,3.4,1.6,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.8,3.0,1.4,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.3,3.0,1.1,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,4.0,1.2,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,4.4,1.5,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.9,1.3,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.5,1.4,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,3.8,1.7,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.8,1.5,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.4,1.7,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.7,1.5,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.6,3.6,1.0,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.3,1.7,0.5,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.8,3.4,1.9,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.0,1.6,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.4,1.6,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.2,3.5,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.2,3.4,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.7,3.2,1.6,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.8,3.1,1.6,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.4,1.5,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.2,4.1,1.5,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,4.2,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,3.1,1.5,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.2,1.2,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,3.5,1.3,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,3.1,1.5,0.1,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.4,3.0,1.3,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.4,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.5,1.3,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.5,2.3,1.3,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.4,3.2,1.3,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.5,1.6,0.6,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.8,1.9,0.4,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.8,3.0,1.4,0.3,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,3.8,1.6,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.6,3.2,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.3,3.7,1.5,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,3.3,1.4,0.2,'Iris-setosa');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.0,3.2,4.7,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,3.2,4.5,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.9,3.1,4.9,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,2.3,4.0,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.5,2.8,4.6,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,2.8,4.5,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,3.3,4.7,1.6,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,2.4,3.3,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.6,2.9,4.6,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.2,2.7,3.9,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,2.0,3.5,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.9,3.0,4.2,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,2.2,4.0,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,2.9,4.7,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,2.9,3.6,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.1,4.4,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,3.0,4.5,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.7,4.1,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.2,2.2,4.5,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,2.5,3.9,1.1,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.9,3.2,4.8,1.8,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,2.8,4.0,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.5,4.9,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,2.8,4.7,1.2,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,2.9,4.3,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.6,3.0,4.4,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.8,2.8,4.8,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.0,5.0,1.7,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,2.9,4.5,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,2.6,3.5,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,2.4,3.8,1.1,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,2.4,3.7,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.7,3.9,1.2,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,2.7,5.1,1.6,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.4,3.0,4.5,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,3.4,4.5,1.6,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.1,4.7,1.5,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.3,4.4,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,3.0,4.1,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,2.5,4.0,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.5,2.6,4.4,1.2,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,3.0,4.6,1.4,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.6,4.0,1.2,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.0,2.3,3.3,1.0,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,2.7,4.2,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,3.0,4.2,1.2,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,2.9,4.2,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.2,2.9,4.3,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.1,2.5,3.0,1.1,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,2.8,4.1,1.3,'Iris-versicolor');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,3.3,6.0,2.5,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.7,5.1,1.9,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.1,3.0,5.9,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.9,5.6,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.5,3.0,5.8,2.2,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.6,3.0,6.6,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (4.9,2.5,4.5,1.7,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.3,2.9,6.3,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,2.5,5.8,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.2,3.6,6.1,2.5,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.5,3.2,5.1,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,2.7,5.3,1.9,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.8,3.0,5.5,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.7,2.5,5.0,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.8,5.1,2.4,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,3.2,5.3,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.5,3.0,5.5,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.7,3.8,6.7,2.2,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.7,2.6,6.9,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,2.2,5.0,1.5,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.9,3.2,5.7,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.6,2.8,4.9,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.7,2.8,6.7,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.7,4.9,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.3,5.7,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.2,3.2,6.0,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.2,2.8,4.8,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,3.0,4.9,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,2.8,5.6,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.2,3.0,5.8,1.6,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.4,2.8,6.1,1.9,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.9,3.8,6.4,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,2.8,5.6,2.2,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.8,5.1,1.5,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.1,2.6,5.6,1.4,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (7.7,3.0,6.1,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,3.4,5.6,2.4,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.4,3.1,5.5,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.0,3.0,4.8,1.8,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.9,3.1,5.4,2.1,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.1,5.6,2.4,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.9,3.1,5.1,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.8,2.7,5.1,1.9,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.8,3.2,5.9,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.3,5.7,2.5,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.7,3.0,5.2,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.3,2.5,5.0,1.9,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.5,3.0,5.2,2.0,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (6.2,3.4,5.4,2.3,'Iris-virginica');
insert into iris(sepal_l, sepal_w, petal_l, petal_w, class) values (5.9,3.0,5.1,1.8,'Iris-virginica');
```

データベースにデータが入りました。
めでたしめでたし :tada:

私はAIに詳しくないです。
おそらく機械学習の最初によくでてくる題材、つまり「アヤメの分類」だとおもいます。

# LivebookでPostgeSQLに接続する、グラフを書く

動画をご覧になってください。
PostgeSQLへの接続では、`hostname`は、`docker-compose.yml`に書いた通りに`db`にします。

私の手元では、かっこいいGUIのでの接続ではうまく接続ができませんでした。
鉛筆アイコンから、`Convert Cell`をすると[Elixir](https://elixir-lang.org/)のコードがでてきます。
`opts`から`socket_options: [:inet6]`を削除してみたところ、接続に成功しました。






# おわりに

[Livebook](https://livebook.dev/)のSmart cellsでPostgreSQLの接続とグラフ描画を楽しむことができました。

私の場合はかっこいいGUIのままPostgreSQLに接続ができずそこを悩みました。
カンで、`socket_options: [:inet6]` を消してみたら動きました。
なんとなくですが、[José Valim](https://twitter.com/josevalim)さんが紹介されていた通りのことができました。

:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
めでたしめでたし  
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
