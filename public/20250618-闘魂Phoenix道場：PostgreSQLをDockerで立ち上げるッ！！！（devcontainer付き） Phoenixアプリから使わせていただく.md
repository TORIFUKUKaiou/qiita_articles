---
title: 闘魂Phoenix道場：PostgreSQLをDockerで立ち上げるッ！！！（devcontainer付き） Phoenixアプリから使わせていただく
tags:
  - PostgreSQL
  - Elixir
  - Phoenix
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-20T07:11:42+09:00'
id: bc1e3486330e1be2674f
organization_url_name: haw
slide: false
ignorePublish: false
---
いよいよはじまりました！
[Qiita Tech Festa](https://qiita.com/tech-festa/2025) :tada::tada::tada: 

https://qiita.com/tech-festa/2025


# はじめに

こんにちは、ElixirとPhoenixをこよなく愛する闘魂プログラマーです。  
つまりAIプログラマーです。あっ、AIとは、**A**ntonio **I**nokiさん、つまり猪木さんのことです。  

本記事は、[みんなでPostgreSQLの知見を共有しよう](https://qiita.com/official-events/96a5d14a8908bfca8b8f) への参加記事です。


https://qiita.com/official-events/96a5d14a8908bfca8b8f

# PhoenixのデフォルトDBはPostgreSQL

[Phoenix](https://www.phoenixframework.org/) では、プロジェクトを作成する際にPostgreSQLがデフォルトで使われます。

```bash
mix phx.new hello
# => デフォルトでPostgreSQLが選ばれます
```

[Phoenix](https://www.phoenixframework.org/)とは、Elixir製の**すんごいWebアプリケーションフレームワーク**のことです。

# DockerでPostgreSQLを立ち上げる

新しいPCを新調するたびに、自分のローカルにPostgreSQLを入れるのは面倒ですし、慎重派の私はDockerコンテナで立ち上げています。

```bash
docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres  \
-e POSTGRES_PASSWORD=postgres postgres
```

`POSTGRES_USER`と`POSTGRES_PASSWORD`には、`config/dev.exs`にデータベースへの接続情報が以下のように作られるのでそれにあわせて、`postgres`をセットしています。


```elixir:config/dev.exs
config :hello, Hello.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "hello_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

# devcontainerでも起動してます

私がメンテしている [phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer) というdevcontainer定義でもPostgreSQLが入っています。

こちらを使うと、Elixir + Phoenix + PostgreSQL の開発環境が短時間で整います。
devcontainerですので、つまりは所謂ひとつのCodespaceでも開発ができます。
別記事で紹介していますので、よければご覧ください。

https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92

# おわりに

PhoenixとPostgreSQLは、最初から相性がいいです。意識しなくてもPostgreSQLと共に開発が始まります。  

PostgreSQLキャンペーンをきっかけに、象さんのアイコンを思い出しました。  

闘魂とは、己に打ち克つこと。そしてPhoenixアプリケーションの裏にPostgreSQLあり。

**元氣ですかーーーッ！！！**
