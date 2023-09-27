---
title: Hello Gigalixir (Phoenix/Elixir)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2021-08-01T17:42:09+09:00'
id: d2d0e9f56ffe3bb8eda1
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)のWebフレームワークである[Phoenix](https://www.phoenixframework.org/)を使ってつくったプロジェクトを[Gigalixir](https://www.gigalixir.com/)にデプロイしてみます
- カスタムドメインをつけてみます
- 以下をとても参考にしています(ありがとうございます)
    - @piacerex さんの[【本番構築Gigalixir編②】Elixir／Phoenixで構築したCRUD Webアプリをリリース](https://qiita.com/piacerex/items/511f24888c7350639d0b) :lgtm::lgtm::lgtm: 
    - @pojiro さんの[使って学ぶgigalixir、DBを使うアプリをデプロイする](https://qiita.com/pojiro/items/efc72557fb00b56a977a) :lgtm::lgtm::lgtm:
- 2020/09/19(土)に行われた[kokura.ex#13：Elixirもくもく会～入門もあるよ](https://fukuokaex.connpass.com/event/188982/)での成果です
    - @im_miolab さん、ありがとうございます！
- `Elixir 1.10.4-otp-23`
- `Phoenix v1.5.4`

# 0. 準備
- [Phoenix](https://www.phoenixframework.org/)を利用してプロジェクトをつくります
- ここでは手前味噌の[LiveViewでinfinite scroll (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/c3e37813c6c32fb6d5d2)を使います

# 1. Gitリポジトリの初期化
- ここからは以下のドキュメントの内容に従って進めていきます
    - [Getting Started Guide](https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html): [Gigalixir](https://www.gigalixir.com/)のドキュメント
    - [Deploying on Gigalixir](https://hexdocs.pm/phoenix/gigalixir.html#content): [Phoenix](https://www.phoenixframework.org/)のガイド
- 私は、[Deploying on Gigalixir](https://hexdocs.pm/phoenix/gigalixir.html#content)に従って進めてみました
- まだプロジェクトを管理していない場合には以下のような感じで初期化をします

```
$ git init
$ git add .
$ git commit -m "Initial commit"
```

# 2. [Gigalixir](https://www.gigalixir.com/) CLIコマンドのインストール
- [Install the Command-Line Interface](https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html#install-the-command-line-interface) をご参照ください

# 3. [Gigalixir](https://www.gigalixir.com/)のサインアップ
- 私は[ここ](https://console.gigalixir.com/#/register)から作りました

# 4. [Gigalixir](https://www.gigalixir.com/)にlogin
- `1. Gitリポジトリの初期化`からそうですけど、カレントディレクトリは[Phoenix](https://www.phoenixframework.org/)プロジェクトのルートで作業します

```
$ gigalixir login
Email: torifuku.kaiou@gmail.com
Password: 
Would you like us to save your api key to your ~/.netrc file? [Y/n]: Y
Logged in as torifuku.kaiou@gmail.com.
```

- verify

```
$ gigalixir account
```


# 5. [Gigalixir](https://www.gigalixir.com/)アプリケーションの作成

```
$ gigalixir create
$ gigalixir apps
```

- verify

```
$ git remote -v
gigalixir	https://git.gigalixir.com/hoge.git/ (fetch)
gigalixir	https://git.gigalixir.com/hoge.git/ (push)
```

# 6. バージョン指定

- お使いの[Elixir](https://elixir-lang.org/), [Erlang](https://www.erlang.org/)、[Node.js](https://nodejs.org/ja/)のバージョンを指定します
- 自分が何を使っているんだっけ？　はたとえば以下のように調べます

```
$ asdf current                                                                     
elixir          1.10.4-otp-23
erlang          23.0.1

$ node -v
v12.18.3
```

```
$ echo "elixir_version=1.10.4" > elixir_buildpack.config
$ echo "erlang_version=23.0.1" >> elixir_buildpack.config
$ echo "node_version=12.18.3" > phoenix_static_buildpack.config
```

- `elixir_buildpack.config`と`phoenix_static_buildpack.config`ができておりますので、忘れずにgitの管理対象に含めます

```
$ git add elixir_buildpack.config phoenix_static_buildpack.config
$ git commit -m "set elixir, erlang, and node version"
```

# 7. SSLの設定
- あとでカスタムドメインに変えますが、一旦デフォルトでついているドメインで設定しておきます

```
$ gigalixir apps
[
  {
    "cloud": "gcp",
    "region": "v2018-us-central1",
    "replicas": 0,
    "size": 0.3,
    "stack": "gigalixir-18",
    "unique_name": "your_unique_name",
    "version": 2
  }
]
```

```diff:config/prod.exs
 config :hello_gigalixir, HelloGigalixirWeb.Endpoint,
-  url: [host: "example.com", port: 80],
+  url: [host: "your_unique_name.gigalixirapp.com", port: 443],
   cache_static_manifest: "priv/static/cache_manifest.json"
```

- `your_unique_name`は、`gigalixir apps`の結果に従ってください
- @mnishiguchi さんがコメントしてくださった https://qiita.com/torifukukaiou/items/d2d0e9f56ffe3bb8eda1#comment-268260110134882e938e に従ったほうがよさそうです

- データベース接続もSSLを使うことにしましょう

```diff:config/prod.secret.exs
 config :hello_gigalixir, HelloGigalixir.Repo,
-  # ssl: true,
+  ssl: true,
   url: database_url,
   pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
```

- 忘れずにコミットしておきましょう

```
$ git add .
$ git commit -m 'ssl'
```

# 8. データベースの準備

```
$ gigalixir pg:create --free
```


- Verify

```
$ gigalixir pg
$ gigalixir config
```

# 9. お待ちかね、デプロイの時間ですよ！

```
$ git push gigalixir master
```

- 少し待ちます(ソースコードがPushされて各種インストールなどなどが行われます)
- 続いてデータベースのマイグレーションを行います

```
$ gigalixir run mix ecto.migrate
```

- 続いてseedデータの投入を行います
- [How to run seeds?](https://gigalixir.readthedocs.io/en/latest/database.html#how-to-run-seeds)

```
$ gigalixir run -- mix run priv/repo/seeds.exs
```

- ここまで順調にきていれば

```
$ gigalixir open
```

![スクリーンショット 2020-09-19 10.09.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b10e8f5e-c7c9-12a1-727b-45f569944c83.png)

:tada::tada::tada:
**いつものアレが表示されるでしょう！**

もしうまくいかないところがありましたら`gigalixir logs`や`gigalixir ps`の内容をみてください（とのことです。私はつまるところがなかったのでこれらのコマンドのお世話になることはありませんでした:relaxed:)。

# 10. カスタムドメインの設定

- [How to Set Up a Custom Domain](https://gigalixir.readthedocs.io/en/latest/domain.html#how-to-set-up-a-custom-domain)を参考にします

```
$ gigalixir domains:add hello-gigalixir.torifuku-kaiou.app
Added hello-gigalixir.torifuku-kaiou.app.
Create a CNAME record with your DNS provider pointing to hello-gigalixir.torifuku-kaiou.app.gigalixirdns.com.
Please give us a few minutes to set up a new TLS certificate.
```

- 実行結果に従ってDNSの設定をします
- 以下、[Google Domains](https://domains.google/intl/ja_jp/)での設定例です

![スクリーンショット 2020-09-19 10.30.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1a3fd7fd-45d7-1658-9de6-60d80207ba42.png)

- たとえば`nslookup hello-gigalixir.torifuku-kaiou.app`等で設定が反映されていることを確認できるまで待ちます


```diff:config/prod.exs
 config :hello_gigalixir, HelloGigalixirWeb.Endpoint,
-  url: [host: "your_unique_name.gigalixirapp.com", port: 443],
+  force_ssl: [rewrite_on: [:x_forwarded_proto]],
+  url: [host: "hello-gigalixir.torifuku-kaiou.app", port: 443],
   cache_static_manifest: "priv/static/cache_manifest.json"
```

- 忘れずにコミットしておきます

```
$ git add .
$ git commit -m 'Custom Domain'   
```

- デプロイします

```
$ git push gigalixir master
```

`https://hello-gigalixir.torifuku-kaiou.app`
へアクセス :rocket::rocket::rocket: 

最初のうちはリダイレクトループに似たような現象が起きるかもしれません。
実際には[Phoenix](https://www.phoenixframework.org/)アプリケーションのほうでエラーが発生していてプロセス再起動を繰り返しています。

`gigalixir logs`をみると以下のようなログがでているとおもいます。

```
Origin of the request: https://hello-gigalixir.torifuku-kaiou.app

This happens when you are attempting a socket connection to
a different host than the one configured in your config/
files. For example, in development the host is configured
to "localhost" but you may be trying to access it from
"127.0.0.1". To fix this issue, you may either:

  1. update [url: [host: ...]] to your actual host in the
     config file for your current environment (recommended)
```

10分か20分くらい待ちます。
(それか、関係あったのかどうかわかりませんが私は待ちきれずに`gigalixir ps:restart`コマンドと[Gigalixir](https://www.gigalixir.com/)の管理コンソールで`Restart`ボタンを押したことをつけくわえておきます)

![スクリーンショット 2020-09-19 11.00.03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a55daaef-f822-c25a-9319-94ba6a6d4853.png)

# Wrapping Up
- Enjoy [Elixir](https://elixir-lang.org/)! :lgtm::lgtm::lgtm: 
- Enjoy [Phoenix](https://www.phoenixframework.org/)! :lgtm::lgtm::lgtm:
- https://hello-gigalixir.torifuku-kaiou.app/users
    - [LiveViewでinfinite scroll (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/c3e37813c6c32fb6d5d2)の様子がみれます






