---
title: Azure Container InstancesでNervesアプリを開発する
tags:
  - Azure
  - Elixir
  - Docker
  - Nerves
private: false
updated_at: '2020-12-16T08:46:25+09:00'
id: 998d6539e4adcd1816b3
organization_url_name: fukuokaex
slide: false
---
この記事は、「[Docker Advent Calendar 2020](https://qiita.com/advent-calendar/2020/docker)」 7日目です。
あいていたので埋めました。
前日は、@c3driveさんの[AWSにコンテナ環境を構築する](https://qiita.com/c3drive/items/597b060fdde07131d893)

# はじめに
- [Nerves](https://www.nerves-project.org/)は、
    - [ElixirのIoTでナウでヤングなcoolなすごいヤツです:rocket:](https://twitter.com/torifukukaiou/status/1201266889990623233)です
- [Elixir](https://elixir-lang.org/)というプログラミング言語でIoT開発を楽しむことができます
- [Nerves](https://www.nerves-project.org/)は環境設定がいろいろ必要です
- 慣れてしまえばそうでもないのですがはじめてやるにはいろいろ罠があるというか
- それで、@takasehideki 先生が[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)を公開してくれました
    - 知り合いにすぐ試してもらいたい！
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)というグループの会合で、このコンテナを[Azure Container Instances](https://docs.microsoft.com/ja-jp/azure/container-instances/)で動かせないの？　みたいな話がでたので、いいネタだとおもってかきました
- macOS 10.15.7
- Docker 20.10.0

# Dockerfile

```Dockerfile
# docker-elixir 1.11.2
# https://hub.docker.com/_/elixir
FROM elixir:1.11.2

ENV DEBCONF_NOWARNINGS yes

# Install libraries for Nerves development
RUN apt-get update && \
    apt-get install -y build-essential automake autoconf git squashfs-tools ssh-askpass pkg-config curl openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
COPY ./config_files/id_rsa.pub /root/.ssh/authorized_keys
EXPOSE 22

# [Optional] Uncomment this section to install libraries for customizing Nerves System
#RUN apt-get update && \
#    apt-get install -y libssl-dev libncurses5-dev bc m4 unzip cmake python && \
#    rm -rf /var/lib/apt/lists/*

# Install fwup (https://github.com/fhunleth/fwup)
ENV FWUP_VERSION="1.8.2"
RUN wget https://github.com/fhunleth/fwup/releases/download/v${FWUP_VERSION}/fwup_${FWUP_VERSION}_amd64.deb && \
    apt-get install -y ./fwup_${FWUP_VERSION}_amd64.deb && \
    rm ./fwup_${FWUP_VERSION}_amd64.deb && \
    rm -rf /var/lib/apt/lists/*

# Install hex and rebar
RUN mix local.hex --force
RUN mix local.rebar --force
# Install Mix environment for Nerves
RUN mix archive.install hex nerves_bootstrap 1.10.0 --force

CMD ["/usr/sbin/sshd", "-D"]
```

- [https://github.com/NervesJP/docker-nerves/blob/v0.2/Dockerfile](https://github.com/NervesJP/docker-nerves/blob/v0.2/Dockerfile)をベースに`ssh`接続できるようにしました
- `ssh`接続は、@kuboshu83 さんの[[Docker入門]コンテナにsshでアクセスするための設定メモ](https://qiita.com/kuboshu83/items/f827ad7068550cded72d) を参考にしました
    - ありがとうございます！
- [https://github.com/NervesJP/docker-nerves/blob/v0.2/Dockerfile](https://github.com/NervesJP/docker-nerves/blob/v0.2/Dockerfile)を書き換えることなく、もっとスマートにやるやり方があるかもしれません
- 私にはこの`ssh`接続できるようにするという方法しかおもいつきませんでした
- `config_files/id_rsa.pub` をおいています
  - `id_rsa.pub`はすでに`~/.ssh/`につくっていたものを使いました
  - そんなファイルがない場合は`ssh-keygen`でググっていただければ、きっと答えはみつかるでしょう

```
$ mkdir config_files
$ cp ~/.ssh/id_rsa.pub config_files/
$ docker build -t docker-nerves .
```

- イメージを作ったら、あとの手順は以下のような感じです
    - 1. [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)にイメージを登録
    - 2. [Azure Container Instances](https://docs.microsoft.com/ja-jp/azure/container-instances/)でそのカスタムイメージを使うように設定する
    - 3. `ssh`で接続して[Nerves](https://www.nerves-project.org/)アプリの開発をする
- 以下、もう少し詳しくみていきます

# 1. [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)にイメージを登録
- [クイック スタート:Azure portal を使用して Azure コンテナー レジストリを作成する](https://docs.microsoft.com/ja-jp/azure/container-registry/container-registry-get-started-portal)
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:だいたいここに書いてある通りにやっていけばよいです
- 私はイメージのプッシュにAzure CLIなるものは一切つかいませんでした
- [Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)のコンソールに「クイック スタート」というページがあるのでそこを参考にするとよいです
- まず「アクセスキー」というページに行って、管理者ユーザーを有効にしておきます
- そこに書いてあるユーザー名とpasswordは`docker login`でつかいます

```
$ docker login xxx.azurecr.io
$ docker tag docker-nerves xxx.azurecr.io/docker-nerves
$ docker push xxx.azurecr.io/docker-nerves
```

- xxxは、[Azure Container Registry](https://docs.microsoft.com/ja-jp/azure/container-registry/)を作るときに決めた名前(値)がはいります

# 2. [Azure Container Instances](https://docs.microsoft.com/ja-jp/azure/container-instances/)でそのカスタムイメージを使うように設定する

![スクリーンショット 2020-12-16 0.02.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7a170ef9-1ed6-ddb8-6cb0-deabea808e88.png)

- [クイック スタート:Azure portal を使用してコンテナー インスタンスを Azure 内にデプロイする](https://docs.microsoft.com/ja-jp/azure/container-instances/container-instances-quickstart-portal)な感じですすめます
- ネットワークは`パプリック`にして、ポート`22`を開けておきます
- 設定するのはそれくらいで、あとは`次へ` `次へ`です
- しばらくするとコンテナが立ち上がるので割り振られたIPアドレスを覚えておきます
  - 以下、`20.43.93.225`だとします
  - このコンテナは記事を書いたあとに消しました

# 3. `ssh`で接続して[Nerves](https://www.nerves-project.org/)アプリの開発をする

```
$ ssh root@20.43.93.225
```
:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:で、コンテナの中に入ります

## コンテナの中での操作
```
$ cd ~/.ssh
$ ssh-keygen -t rsa -b 4096
$ cd
$ mix nerves.new hello_nerves
$ cd hello_nerves
$ export MIX_TARGET=rpi4
$ mix deps.get
$ mix firmware
```

で、無事にコンテナの中にファームウェア
`/root/hello_nerves/_build/rpi4_dev/nerves/images/hello_nerves.fw`ができます :fire::fire::fire: 

Raspberry Pi 4以外の場合は、[Targets](https://hexdocs.pm/nerves/targets.html#content)から値を選んでください。

## 開発マシンにもどって

```
$ scp root@20.43.93.225:/root/hello_nerves/_build/rpi4_dev/nerves/images/hello_nerves.fw .
```

- クラウドにあるコンテナからファームウェアをもってきて
- microSDカードを開発マシンに挿して

```
$ fwup hello_nerves.fw
```

- あっ、[fwup](https://github.com/fhunleth/fwup)のインストール方法を説明していない。。。
  - そこは 
  - [fwupのインストール
](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9#fwup%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)  :gift::gift::gift:
- クラウドのコンテナからRaspberry Piに`mix upload`(つまりssh)したいという話がでていた部分はこの記事ではなにもできていません


## メモ

- `mix`コマンドを実行したときに、

```
warning: the VM is running with native name encoding of latin1 which may cause Elixir to malfunction as it expects utf8. Please ensure your locale is set to UTF-8 (which can be verified by running "locale" in your shell)
```
という警告がちょいちょいでていました。


# [Nerves](https://www.nerves-project.org/)で一体何がつくれるの？
- いろいろ作れます :rocket::rocket::rocket: 
- 簡単な作例をご紹介します
- 手前味噌です
- [Raspberry Pi 4 + Grove Base HAT for Raspberry Pi + Grove Buzzer + Grove ButtonでつくるNervesアラーム](https://qiita.com/torifukukaiou/items/d24749203b1586b5685a)

![https___qiita-image-store.s3.ap-northeast-1.amazonaws.com_0_131808_decc299d-a6e7-1e9d-2d0e-6bb58c57b476.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b8daa10b-badb-d044-fe8a-4f377f9bbed4.jpeg)

# おまけ2 どうやってコンテナの中の`.ex`を編集するの？
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)でいけちゃいます
- [Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh)を参考にしてください
- こんな感じで、ローカルファイルを編集している感覚で開発を進めることができます

![スクリーンショット 2020-12-16 8.42.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/46306a1a-b085-c238-3992-07087cc987b6.png)


# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- @takasehideki 先生の`Dockerfile`は書き換えずにそのままで対応できるもっとスマートな方法があるかもしれません
- クラウドのコンテナからRaspberry Piに`mix upload`(つまりssh)したい！？　というような話には踏み込めていません
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:  
- この記事をきっかけに[Nerves](https://www.nerves-project.org/)に興味をもっていただけましたら、ぜひ[NervesJPのSlack](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)でお待ちしています！
    - 愉快なfolksたちが歓迎します！！！

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/303fdfc9-707d-4791-b27c-a7bc2172c51b.png)

明日は、@kosuketakeiさんの[文系出身業務経験なしのプログラマーがDocker使ってみた](https://qiita.com/kosuketakei/items/6fad4fe6c2dc43b467c9) です。引き続きお楽しみください。

