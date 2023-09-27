---
title: CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)
tags:
  - Elixir
  - CircleCI
  - Phoenix
private: false
updated_at: '2021-08-01T21:07:33+09:00'
id: 1e266c7b213cdd3fd58e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 8日目です。
前日は、[WindowsでIExで日本語を使う(iex --werl) (Elixir)](https://qiita.com/torifukukaiou/items/34406dd5b6b386f1ef9e) でした。

# はじめに
- [Phoenix](https://www.phoenixframework.org/)プロジェクトで、[CircleCI](https://circleci.com/)を使ってみました
- アカウント登録とか[GitHub](https://github.com/)や[Bitbucket](https://bitbucket.org/)リポジトリとの連携はなんとな〜くやればできます
- `mix test`が自動で行われるようにします
- ついでに[Gigalixir](https://www.gigalixir.com/)へのデプロイも行います
- プロジェクトのルートに`.circleci/config.yml`を置きます

![スクリーンショット 2020-12-07 20.02.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8548dd48-3945-d39f-2b0f-8925a6ad0558.png)



# .circleci/config.yml
- 2021/08/01追記
    - 久しぶりに以下を使ってみるとかわっていたところがあるので追記しておきます
    - [Gigalixir](https://www.gigalixir.com/)のコマンドインストールの際にPythonが3系にかわっていたり、Rustが必要だったりしました
    - 2021/08/01に私がデプロイまでできた`.yml`をご紹介しておきます
    - https://github.com/TORIFUKUKaiou/autorace_phoenix/blob/dd92d470ed6aa5834ce1eb2f48a5723494124c4c/.circleci/config.yml

```yml:.circleci/config.yml
version: 2
jobs:
  build:
    parallelism: 1
    docker:
      - image: circleci/elixir:1.10.4
        environment:
          MIX_ENV: test
      - image: circleci/postgres:10.1-alpine
        environment:
          POSTGRES_USER: postgres
          POSTGRES_DB: my_app_test
          POSTGRES_PASSWORD: postgres

    working_directory: ~/app

    steps:
      - checkout

      - run: mix local.hex --force
      - run: mix local.rebar --force

      - restore_cache:
          keys:
            - v1-mix-cache-{{ .Branch }}-{{ checksum "mix.lock" }}
            - v1-mix-cache-{{ .Branch }}
            - v1-mix-cache
      - restore_cache:
          keys:
            - v1-build-cache-{{ .Branch }}
            - v1-build-cache
      - run: mix do deps.get, compile
      - save_cache:
          key: v1-mix-cache-{{ .Branch }}-{{ checksum "mix.lock" }}
          paths: "deps"
      - save_cache:
          key: v1-mix-cache-{{ .Branch }}
          paths: "deps"
      - save_cache:
          key: v1-mix-cache
          paths: "deps"
      - save_cache:
          key: v1-build-cache-{{ .Branch }}
          paths: "_build"
      - save_cache:
          key: v1-build-cache
          paths: "_build"

      - run:
          name: Wait for DB
          command: dockerize -wait tcp://localhost:5432 -timeout 1m

      - run: mix test

      - store_test_results:
          path: _build/test/lib/my_app

  deploy:
    docker:
      - image: circleci/elixir:1.10.4
    steps:
      - add_ssh_keys
      - checkout
      - run: sudo apt-get update
      - run: sudo apt-get install -y python-pip
      - run: sudo pip install gigalixir --ignore-installed six
      - run:
          name: my_app
          command: |
            echo 'export SUFFIX=$(echo $CIRCLE_BRANCH | tr "[:upper:]" "[:lower:]" | tr -cd "[a-z0-9-]")' >> $BASH_ENV
            echo 'export APP_NAME="$GIGALIXIR_APP_NAME-$SUFFIX"' >> $BASH_ENV
            source $BASH_ENV
      - run: gigalixir login -e "$GIGALIXIR_EMAIL" -p "$GIGALIXIR_PASSWORD" -y
      - run: gigalixir git:remote $GIGALIXIR_APP_NAME
      - run: git push -f gigalixir HEAD:refs/heads/main

      - run: printf "Host *\n StrictHostKeyChecking no" > ~/.ssh/config
      - run: gigalixir ps:migrate

workflows:
  version: 2
  deploy:
    jobs:
      - build
      - deploy:
          requires:
            - build
          filters:
            branches:
              only: main
```

- `my_app`は適宜読み替えてください
- `build` jobはなんとなく、[https://github.com/CircleCI-Public/circleci-demo-elixir-phoenix/blob/master/.circleci/config.yml](https://github.com/CircleCI-Public/circleci-demo-elixir-phoenix/blob/master/.circleci/config.yml)を見ながら書いてみました
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: [Supported Languages Guide](https://circleci.com/docs/2.0/demo-apps/#section=welcome)からのリンク先
    - 要は、`mix test`したいがために準備をしてから、`mix test`を行っているのみです
- `deploy` jobはなんとなく、[https://github.com/gigalixir/gigalixir-getting-started/blob/42a73c9e0f7de50cbfabd092a504aa454f9f9fc8/.circleci/config.yml](https://github.com/gigalixir/gigalixir-getting-started/blob/42a73c9e0f7de50cbfabd092a504aa454f9f9fc8/.circleci/config.yml)を見ながら書いてみました
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: [https://gigalixir.readthedocs.io/en/latest/deploy.html](https://gigalixir.readthedocs.io/en/latest/deploy.html)からのリンク先
    - 要は、`git push -f gigalixir HEAD:refs/heads/main`と`gigalixir ps:migrate`をしたいがために、`gigalixir `コマンドのインストールやらの準備をしてから、目的のコマンドを実行しています
    - Gigalixirにはあらかじめ枠(アプリケーションとデータベース)が用意されている状態を想定しています
        - 参考という名の手前味噌
        - [Hello Gigalixir (Phoenix/Elixir)](https://qiita.com/torifukukaiou/items/d2d0e9f56ffe3bb8eda1) 
    - `main`ブランチ[^1]にマージされた場合にのみデプロイすることとしています

[^1]: `master`ブランチではなく、`main`ブランチにしています

# プロジェクト固有の設定

## mix release
- ほぼほぼ、[Deploying with Releases](https://hexdocs.pm/phoenix/releases.html#content)に書いてある通りのことをやります

1. `config/prod.secret.exs`を`config/releases.exs`にリネーム
1. `config/releases.exs`の先頭のほうにある`use Mix.Config`を`import Config`に書き換える
1. `config/prod.exs`の中で`import_config "prod.secret.exs"`を呼び出しているところはもはやいらないので消す
1. `config/releases.exs`に、`config :my_app, MyAppWeb.Endpoint, server: true`を足す
1. `config/prod.exs`の`url:`のところを変更する
1. `lib/my_app/release.ex`をつくる

```diff:config/prod.exs
@@ -10,7 +10,7 @@ use Mix.Config
 # which you should run after static files are built and
 # before starting your production server.
 config :yubaba, YubabaWeb.Endpoint,
-  url: [host: "example.com", port: 80],
+  url: [host: "gigalixir-app-name.gigalixirapp.com", port: 443],
   cache_static_manifest: "priv/static/cache_manifest.json"

 # Finally import the config/prod.secret.exs which loads secrets
 # and configuration from environment variables.
-import_config "prod.secret.exs"
+# import_config "prod.secret.exs"
```

- `gigalixir-app-name.gigalixirapp.com`は適宜読み替えてください

```elixir:lib/my_app/release.ex
defmodule MyApp.Release do
  @app :my_app

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

- `MyApp`や`:my_app`は適宜読み替えてください


## [CircleCI](https://circleci.com/)
- プロジェクトの設定で設定します

### Environment Variables
- GIGALIXIR_APP_NAME
    - `gigalixir apps`して、`unique_name`を指定します
- GIGALIXIR_EMAIL
    - [Gigalixir](https://www.gigalixir.com/)のログインIDです
- GIGALIXIR_PASSWORD
    - [Gigalixir](https://www.gigalixir.com/)のログインパスワードです
    - Circle CIのコンテナから[Gigalixir](https://www.gigalixir.com/)にログインするために教えてあげます

### SSH Key
- 秘密鍵
    - passphraseは空[^2]
- Hostnameは空

たとえば

```
cd ~/.ssh
ssh-keygen -b 4096 -f gigalixir
```

で作った場合、`~/.ssh/gigalixir` の中身を登録します。
[CircleCI](https://circleci.com/)のコンテナから[Gigalixir](https://www.gigalixir.com/)のアプリコンテナへデプロイをしますので、[CircleCI](https://circleci.com/)が秘密鍵を知っておく必要があるというわけです。



[^2]: [メモ: SSH 鍵を作成する際は必ず空のパスワードを設定してください。 CircleCI ではパスワードを使った SSH 鍵の復号はできません。](https://circleci.com/docs/ja/2.0/add-ssh-key/#%E6%89%8B%E9%A0%86)




## [Gigalixir](https://www.gigalixir.com/)
- [https://console.gigalixir.com/#/account/ssh-keys](https://console.gigalixir.com/#/account/ssh-keys)で、公開鍵`gigalixir.pub`の中身を登録します
- この公開鍵がデプロイ環境の`authorized_keys`に設定されるという仕掛けなわけです

# Wrapping Up :lgtm: :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5: :lgtm: 
- GitリポジトリにPushすると、自動で`mix test`してくれるし、`main`ブランチ[^1]にマージしたら自動で[Gigalixir](https://www.gigalixir.com/)へデプロイしてくれます
    - お前、`test`書いていないやん！　は、 :sweat_smile:
    - いままでいちいち、`git push gigalixir main`していた自分にさようなら :sunglasses:
- ありがとうございます！　[CircleCI](https://circleci.com/) !!!
- @im_miolab さんの「[【Elixir 1.11】Phoenix Framework + DB開発をDockerでやる #2（CIパイプライン導入）](https://qiita.com/im_miolab/items/f5f426985f968e686e85)」もご参照ください
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 
