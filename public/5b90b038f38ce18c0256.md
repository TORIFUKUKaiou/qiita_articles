---
title: Phoenixの開発環境をつくる(Elixir)
tags:
  - Azure
  - Elixir
  - Phoenix
  - Qiitaエンジニアフェスタ_MS開発ツール
private: false
updated_at: '2021-08-16T00:18:13+09:00'
id: 5b90b038f38ce18c0256
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/c6ee70084f9aeb38b0cc

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [Phoenix](https://www.phoenixframework.org/)とは、[Elixir](https://elixir-lang.org/)でWebアプリをつくっていけるフレームワークです
- devcontainerとは、[Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)のことを私は指しています
- **[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)**と[Docker](https://www.docker.com/)でお手軽に[Phoenix](https://www.phoenixframework.org/)の開発環境を整えてしまいましょう :rocket::rocket::rocket: という内容です
- 「[夏の大納涼 Visual Studio / Visual Studio Code / GitHub Codespaces ♥ Azure 祭り](https://qiita.com/official-events/c6ee70084f9aeb38b0cc)」というイベントの参加記事です
- 以下の環境で試しました

## macOS 10.15.7
|  | バージョン |
|:-|:-:|
|Docker Desktop   | 3.5.2  |
|Visual Studio Code   | 1.59.0  |

## Windows 11 Home (22000.132)
|  | バージョン |
|:-|:-:|
|Docker Desktop   | 3.5.1  |
|Visual Studio Code   | 1.57.1  |


# devcontainer
- 今回は、とあるフォルダ内に`.devcontainer`というフォルダを用意して以下3ファイルをつくります

```json:.devcontainer/devcontainer.json
{
    "name": "Elixir & Node.js & PostgresSQL",
    "dockerComposeFile": "docker-compose.yml",
    "service": "web",
    "workspaceFolder": "/workspace",
    "settings": {
        "terminal.integrated.profiles.linux": {
            "bash": {
                "path": "/bin/bash",
            }
        }
    },
    "extensions": [
        "jakebecker.elixir-ls",
        "ms-azuretools.vscode-docker"
    ]
}
```

```docker:.devcontainer/Dockerfile
FROM elixir:1.12

ENV DEBIAN_FRONTEND=noninteractive

# Install debian packages
RUN apt-get update
RUN apt-get install --yes build-essential inotify-tools postgresql-client

# Install Phoenix packages
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix archive.install hex phx_new 1.5.10 --force

# Install node
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt-get install -y nodejs

ENV DEBIAN_FRONTEND=dialog

WORKDIR /app
EXPOSE 4000
```

```yaml:.devcontainer/docker-compose.yml
version: "3"
services:
  web:
    # Uncomment the next line to use a non-root user for all processes. You can also
    # simply use the "remoteUser" property in devcontainer.json if you just want VS Code
    # and its sub-processes (terminals, tasks, debugging) to execute as the user. On Linux,
    # you may need to update USER_UID and USER_GID in .devcontainer/Dockerfile to match your
    # user if not 1000. See https://aka.ms/vscode-remote/containers/non-root for details.
    # user: node
    build:
      context: .
      dockerfile: Dockerfile
    volumes:
      - ..:/workspace:cached
    # Overrides default command so things don't shut down after the process ends.
    command: sleep infinity
    links:
      - db
  db:
    image: postgres
    restart: unless-stopped
    ports:
      - 5432:5432
    environment:
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
    volumes:
      - ./../data/db:/var/lib/postgresql/data
```

# 使い方
- @takasehideki 先生の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する #導入手順](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#%E5%B0%8E%E5%85%A5%E6%89%8B%E9%A0%86)」を参考に、インストールを進めます
    - [Visual Studio Code](https://code.visualstudio.com/download)
        - 拡張機能[Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
    - [Docker Desktop](https://www.docker.com/products/docker-desktop)
- あとは[Visual Studio Code](https://code.visualstudio.com/download)で、**Remote-Containers: Open Folder in Container...** から`.devcontainer`があるフォルダを選べばいいです
    - 具体的には、これも@takasehideki 先生の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する #2. VS Codeをdev-container機能で開く](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#2-vs-code%E3%82%92dev-container%E6%A9%9F%E8%83%BD%E3%81%A7%E9%96%8B%E3%81%8F)」をご参照ください
        - [コーヒーを淹れる:coffee:](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#3-%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%82%92%E6%B7%B9%E3%82%8C%E3%82%8Bcoffee)が一番重要だと個人的にはおもっています
        - 気長に待つ必要があります
        - [コーヒーを淹れる:coffee:](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#3-%E3%82%B3%E3%83%BC%E3%83%92%E3%83%BC%E3%82%92%E6%B7%B9%E3%82%8C%E3%82%8Bcoffee)は、@takasehideki 先生の記事中での表現です :joy::joy::joy::joy::joy:

![スクリーンショット 2021-01-09 15.34.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/63ddeaaa-a162-00cd-4d8c-445036c0d982.png)

左下が`>< Dev Container: Elixir & Node.js & PostgreSQL`な感じになっていたら成功です



# helloプロジェクト作成

- [Phoenix](https://www.phoenixframework.org/)のプロジェクトを作っていきましょう
- [Visual Studio Code](https://code.visualstudio.com/download)付属のターミナルで操作します
- もし表示されていない場合は、`Terminal > New Terminal`を選んでください
- プロジェクト名を`hello`にした理由は公式のガイドにならいました
    - https://hexdocs.pm/phoenix/up_and_running.html#content [^1]

[^1]: 日本語では、@koga1020 さんの https://zenn.dev/koga1020/books/phoenix-guide-ja-1-5 で読めます。Thanks!

```
/workspace# mix phx.new hello
```

- `Fetch and install dependencies? [Yn]`にはとりあえず、`n`を答えておきます
- [Visual Studio Code](https://code.visualstudio.com/download)で編集できますので、`hello/config/dev.exs`を以下のように変更します
    - `hostname`を`localhost`から`db`に変更しています
- `hello/config/test.exs`も同様に変更しておきます

```elixir:hello/config/dev.exs
config :hello, Hello.Repo,
  username: "postgres",
  password: "postgres",
  database: "hello_dev",
  hostname: "db", # localhost => dbへ変更
  show_sensitive_data_on_connection_error: true,
  pool_size: 10
```

- データベースの設定を変更したら、各種ライブラリのインストールを行います


```
/workspace# cd hello
/workspace/hello# mix setup
```

- `setup` taskの内容は、`hello/mix.exs`に書いてあります

```elixir:mix.exs
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
```

# Run :rocket::rocket::rocket:

```
/workspace/hello# mix phx.server
``` 

- Visit: http://localhost:4000

![スクリーンショット 2021-01-09 15.51.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/40bb2958-7cd8-2d6c-120a-3377b9812afe.png)


:tada::tada::tada:

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm: 
- うまくいったかな :interrobang::interrobang::interrobang:
    - もしうまくいかなかったら、[elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slackにお越しください
    - 私は[autoracex](https://autoracex.connpass.com/)というチャネルに入り浸っておりますのでお気軽にお声掛けください
    - サポートします
- ありがとナイス:flag_cn:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:

## [Elixir](https://elixir-lang.org/)はじめてだよ〜 という方へ
- もしまだ[Elixir](https://elixir-lang.org/)を楽しんだことがない方はぜひこの記事を参考に環境構築をしていただいたら、下記のような`hello.exs`(たとえば`/workspace`配下)を作ってみてください
- 実行は、`elixir hello.exs`です
- そうすると、`Azure`タグのついた最新記事を20件取得して、そのタイトルの一覧を表示してくれます[^2]

[^2]: 1回目は依存ライブラリのダウンロードとコンパイルが行われるため、結果がでるまでちょっと時間がかかります。

```elixir:hello.exs
Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.2"}
])

"https://qiita.com/api/v2/items?query=tag:Azure"
|> HTTPoison.get!()
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& &1["title"])
|> IO.inspect()
```

- こんな感じで、パイプ演算子と呼ばれる[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を使う書き方がよくでてきます
- [Elixir](https://elixir-lang.org/)にハマるとこれがとても気持ちよくなります
    - [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)が心地よいから、[Elixir](https://elixir-lang.org/)にハマっていくのかもしれません

