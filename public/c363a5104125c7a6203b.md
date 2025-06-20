---
title: 闘魂Phoenix道場：MySQLをDockerで立ち上げるッ！！！ Phoenixアプリから使わせていただく
tags:
  - MySQL
  - Elixir
  - Phoenix
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-20T07:15:04+09:00'
id: c363a5104125c7a6203b
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

本記事は、[【あなたの】はじめてのMySQL](https://qiita.com/official-events/10a25cbc18d0f3e2ddb0) への参加記事です。


https://qiita.com/official-events/10a25cbc18d0f3e2ddb0

次の２つの「はじめて」で書きます。

- MySQLをメインテーマにすえた記事を**はじめて**書く
- Phoenixアプリが使用するデータベースとしてMySQLを**はじめて**使う

もしかしたら、以前も書いたことあるかも :interrobang: ですし、やったことあるかも  :interrobang: です。あしからずご了承ください。覚えていないので、**新鮮な気持ちで「はじめて」やります！**

# PhoenixのデフォルトDBはPostgreSQL

PhoenixのデフォルトDBはPostgreSQLです。そのことについては次の記事にしたためました。

[闘魂Phoenix道場：PostgreSQLをDockerで立ち上げるッ！！！（devcontainer付き） Phoenixアプリから使わせていただく](https://qiita.com/torifukukaiou/items/bc1e3486330e1be2674f)

https://qiita.com/torifukukaiou/items/bc1e3486330e1be2674f

この記事では、MySQLを使ってみたいと思います :qiitan:
私は学生や社会人にAWSを教える機会があります。その際に、Webアプリケーションの例としてWordPressを取り上げます。ですから、いつもMySQLにはお世話になっています。余談でした。

# Phoenixアプリが使用するデータベースにMySQLを採用する

_見出しが何だか、上から目線です。MySQL愛好家のみなさまごめんなさい :pray::pray::pray:_ 


[Phoenix](https://www.phoenixframework.org/) のプロジェクトを作成する際に、使用するデータベースについて何も指定しないとPostgreSQLがデフォルトで選ばれます。

今回は、MySQLを選びます。自発的に、MySQLを選ぶわけです。

```bash
mix phx.new hello --database mysql
```

`--database mysql`で、MySQLを指定するという格好です。
ドキュメントは、「[mix phx.new - Options](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.New.html#module-options)」です。

話の順番が前後しますが、[Phoenix](https://www.phoenixframework.org/)とは、Elixir製の**すんごいWebアプリケーションフレームワーク**のことです。

# DockerでMySQLを立ち上げる

新しいPCを新調するたびに、自分のローカルにMySQLを入れるのは面倒ですし、慎重派の私はDockerコンテナで立ち上げています。

```bash
docker run -d --rm -p 3306:3306 \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  -e MYSQL_ROOT_PASSWORD= \
  mysql
```

## バージョン

2025/06/20現在、バージョンを指定しないと、「9.3.0 MySQL Community Server - GPL」が立ち上がっていました。   

## 環境変数

`MYSQL_ALLOW_EMPTY_PASSWORD`と`MYSQL_ROOT_PASSWORD`には、`config/dev.exs`にデータベースへの接続情報が以下のようにデフォルトで作られるのでそれにあわせています。「[mysql - Environment Variables](https://hub.docker.com/_/mysql)」の記述をChatGPTの協力のもと読み込んで環境変数をセットしました。  


```elixir:config/dev.exs
config :hello, Hello.Repo,
  username: "root",
  password: "",
  hostname: "localhost",
  database: "hello_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

## CRUDを試す

`mix phx.gen.live Accounts User users name:string age:integer`とやって、指示通りに、`lib/hello_web/router.ex`を編集し、`mix ecto.migrate`（マイグレーション）してから簡単なCRUD（Create/Read/Update/Delete）操作を試してみました。**もちろん、動きます！** 
  
[mix phx.gen.live](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Live.html)タスクについては、リンク先をご参照ください。簡単にざっくり言うと、データモデル、スキーマ、マイグレーションファイル、GUIをいい感じに作ってくれる足場をかためるコマンドです。

# おわりに

Phoenixアプリが使用するデータベースにMySQLを**はじめて**使ってみました。
もしかしたら、以前も書いたことあるかも :interrobang: ですし、やったことあるかも  :interrobang: です。あしからずご了承ください。覚えていないので、**新鮮な気持ちで「はじめて」やりました！**

[【あなたの】はじめてのMySQL](https://qiita.com/official-events/10a25cbc18d0f3e2ddb0)キャンペーンをきっかけに、Phoenixで組み合わせて使ってみようと思いました。  

闘魂とは、己に打ち克つこと。そしてPhoenixアプリケーションの裏にMySQLあり。

**元氣ですかーーーッ！！！**
