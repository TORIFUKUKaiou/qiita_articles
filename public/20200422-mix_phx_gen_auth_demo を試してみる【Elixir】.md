---
title: 'mix_phx_gen_auth_demo を試してみる[Elixir]'
tags:
  - Elixir
  - Phoenix
  - fukuoka.ex
  - kokura.ex
private: false
updated_at: '2020-04-22T07:23:24+09:00'
id: 0be1bcd131ff3790a347
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [mix_phx_gen_auth_demo](https://github.com/dashbitco/mix_phx_gen_auth_demo)を動かしてみます
- そのうち`mix phx.gen.auth`コマンドが使えるようになることでしょう
- [Elixir](https://elixir-lang.org/)の[Slack](https://elixir-lang.slack.com)で知り合いになった方とDMをやりとりしていて、[An upcoming authentication solution for Phoenix](https://dashbit.co/blog/a-new-authentication-solution-for-phoenix)という記事を教えてもらいました

# [An upcoming authentication solution for Phoenix](https://dashbit.co/blog/a-new-authentication-solution-for-phoenix) に書いてあること(私がポイントだとおもったところ)
- [Elixir](https://elixir-lang.org/)の作者である[José Valim](https://github.com/josevalim)さんは、authenticationにも精通している
    - `I am no stranger to authentication.`
- [Ruby on Rails](https://rubyonrails.org/)のauthenticationソリューション[Devise](https://github.com/plataformatec/devise)は、最も多くダウンロードされたもので、キャリアパスを変えたもの([Elixir](https://elixir-lang.org/)界隈に専念するようになった)
    - [torifukukaiou](https://qiita.com/torifukukaiou)は[Elixir](https://elixir-lang.org/)や[Phoenix](https://www.phoenixframework.org/)よりも[Ruby on Rails](https://rubyonrails.org/)のほうを先に使ったことがあって、[Devise](https://github.com/plataformatec/devise)も使ったことがあります
    - ずいぶん前から[José Valim](https://github.com/josevalim)さんにはずいぶん[お世話になっていたこと](https://github.com/heartcombo/devise/graphs/contributors)に気づきました
- [Phoenix](https://www.phoenixframework.org/)向けの[Devise](https://github.com/plataformatec/devise)を作らないのかとよくきかれた
- いろいろ考えた、試行錯誤した

```
Therefore, with all things considered, there is very little space for an authentication
framework. So what does it mean? Everyone has to write their
authentication system from scratch?

Not really. My proposed solution is to provide generators to inject all 
relevant authentication code into your application.
```

- すべてのことを考慮すると、Webアプリケーションフレームワークの中においてauthenticationフレームワークに残された余地はほとんどない。ということはつまり、誰もが自分のauthenticationシステムをスクラッチで開発しないといけないのだろうか？
- いいえ、そんなことはない。**ここで提案する解決策は、関連するすべてのauthenticationコードをアプリケーションに注入するジェネレータを提供することだ！**
    - `mix phx.gen.auth`
- これを決心したから３ステップのとりくみがあって、その３番目は
- あとは[Phoenix](https://www.phoenixframework.org/)のつまらない(!?)アプリケーションコードを書くだけなのである :-)
    - `Then all that is left is to write plain and boring Phoenix application code :-)`
- そうして書いたのが[a pull request to a bare Phoenix application](https://github.com/dashbitco/mix_phx_gen_auth_demo/pull/1)である
    - 以下、この↑プロジェクトを動かしてみます


# 必要なもの
- [Elixir](https://elixir-lang.org/) 1.10.2 
    - 違うバージョンでもいいのかも、とりあえず私が使ったバージョン
- PostgreSQL
- Node.js
    - Would you refer to [Installation](https://hexdocs.pm/phoenix/1.5.0-rc.0/installation.html#content) ?

# 動かしてみる

```
% git clone https://github.com/dashbitco/mix_phx_gen_auth_demo.git
% git checkout -b auth origin/auth
```
- masterブランチにはないので、authブランチに切り替えます

## mix.exsのdepsを書き直す

```elixir:mix.exs
  defp deps do
    [
      {:bcrypt_elixir, "~> 2.0"},
      #{:phoenix, github: "phoenixframework/phoenix", override: true},
      {:phoenix, "1.5.0-rc.0", override: true},
```

- 私の環境の問題だけかもしれませんが、`mix deps.get`がうまく進まなかったので書き換えました

```
% mix local.hex # 要らないのかも?
% mix archive.install hex phx_new 1.5.0-rc.0 # 要らないのかも?
% mix deps.get
```


- PostgreSQLの`postgres`に`Superuser`のロールがあることを確認する

```
% psql postgres  
psql (12.2)
Type "help" for help.

postgres=# \du
                                   List of roles
 Role name |                         Attributes                         | Member of 
-----------+------------------------------------------------------------+-----------
 postgres  | Superuser, Create DB                                       | {}
 root      | Create DB                                                  | {}
 torifuku  | Superuser, Create role, Create DB, Replication, Bypass RLS | {}
```

- もし`Superuser`のロールがない場合にはつけてください
    - [PostgreSQLでユーザのロールを変更する](https://db.just4fun.biz/?PostgreSQL/PostgreSQL%E3%81%A7%E3%83%A6%E3%83%BC%E3%82%B6%E3%81%AE%E3%83%AD%E3%83%BC%E3%83%AB%E3%82%92%E5%A4%89%E6%9B%B4%E3%81%99%E3%82%8B)
    - ありがとうございます！

```
postgres=# ALTER ROLE postgres WITH SUPERUSER;
```
- なぜ`Superuser`のロールが必要なのかは正確にはわかっていませんが、無いとあとで怒られます
    - `priv/repo/migrations/20200316103722_create_users_auth_tables.exs`の中に、`execute "CREATE EXTENSION IF NOT EXISTS citext", ""`行があって、これを実行するのに`Superuser`のロールが必要なのだそうです
    - [citext](https://www.postgresql.jp/document/8.4/html/citext.html)は、**大文字小文字の区別がない文字列型** のことだそうです

```
% mix ecto.setup
% npm install --prefix assets
% mix phx.server
```

<img width="1260" alt="スクリーンショット 2020-04-21 23.52.55.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3072300b-aa2b-bb50-bcf7-c7ba65c082e1.png">

**Yay!**

## Wrapping Up
- [mix_phx_gen_auth_demo](https://github.com/dashbitco/mix_phx_gen_auth_demo)プロジェクトで、`mix phx.gen.auth` で注入されることになるであろうコードを確認できます
- まだチラ見しかしていませんがそんなに長くないです
- authenticationのコードを注入できるようにしたからあとは、お好みで各自カスタマイズしてねってことだとおもいます
- 楽しんでいきましょう！




