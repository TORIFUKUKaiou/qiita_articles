---
title: 闘魂LocalStack ── LocalStackを楽しむ
tags:
  - AWS
  - Docker
  - LocalStack
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-08-22T13:30:35+09:00'
id: 89a24e2b60c454b953a2
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

:::note warn
本記事の内容は、macOS Ventura 13.5(M2)でのみ試しています。
:::


# はじめに

[LocalStack](https://localstack.cloud/)を**完全に理解しました**(※)。  

(※)例の意味です。「製品を利用をするためのチュートリアルを完了できたという意味」私はチュートリアルを全部やったわけではないのでまだ早いのかもしれません。  

開発マシンにあれこれインストールしたくなかったので、全部[Docker](https://www.docker.com/)コンテナ内で実行することにします。なぜインストールしたくないの？　と言われると明確な答えはなく、「なんとなく」の気分です。憧れとまでは行きませんが、なんとなく前からDockerコンテナの中でdockerコマンドを使うことをやってみたかったというのもあります。  

# What is [LocalStack](https://localstack.cloud/) ?

[LocalStack](https://localstack.cloud/)とは

> LocalStack is a cloud service emulator that runs in a single container on your laptop or in your CI environment. With LocalStack, you can run your AWS applications or Lambdas entirely on your local machine without connecting to a remote cloud provider!

です。

https://docs.localstack.cloud/getting-started/ に書いてあります。  
AWSをエミュレートできます。会社の後輩に教えてもらいました。  
[LocalStack](https://localstack.cloud/)は[Docker](https://www.docker.com/)コンテナとして動作します。  
[AWS CLI](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-welcome.html)でリソースの作成などの操作をエミュレートできます。  

# Ubuntuのコンテナの中でLocalStackのコンテナを動かす

「[How can i run docker command inside a docker container?](https://forums.docker.com/t/how-can-i-run-docker-command-inside-a-docker-container/337)」が参考になります。  

どうやら2つの手法があるそうです。

- DinD(Docker in Docker)
- DooD(Docker outside of Docker)

https://blog.nijohando.jp/post/docker-in-docker-docker-outside-of-docker/

を参考にさせていただきました。ありがとうーーーーッ！！！　でございます。  

以下、DooD(Docker outside of Docker)でやってみます。  

# 環境構築

DooD(Docker outside of Docker)でやってみます。  

`Dockerfile`と`docker-compose-for-copy.yml`の2つのファイルを用意します。  

```docker:Dockerfile
FROM ubuntu:22.04

WORKDIR /root

# Docker
# https://docs.docker.com/engine/install/ubuntu/
RUN apt-get update && apt-get install -y \
  ca-certificates \
  curl \
  gnupg \
  sudo \
  vim \
  unzip \
  jq \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN sudo install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN sudo chmod a+r /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io \
  docker-buildx-plugin \
  docker-compose-plugin \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# LocalStack
COPY docker-compose-for-copy.yml docker-compose.yml 

# aws cli
# https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
```

ベースイメージはUbuntuを使っています。  
ここでやっていることは次の通りです。  

- Ubuntuコンテナにてdockerコマンドが使えるようにDockerをインストール
- LocalStackを動かす`docker-compose.yml`を`/root`に配置
- `aws`コマンドが使えるようにAWS CLIをインストール
  - M2ではなくIntelをお使いの場合はダウンロードするバイナリが違いますので、コメントのリンク先をご参照ください

```yml:docker-compose-for-copy.yml
version: "3.8"

services:
  localstack:
    container_name: "${LOCALSTACK_DOCKER_NAME-localstack_main}"
    image: localstack/localstack
    ports:
      - "4566:4566"            # LocalStack Gateway
      - "4510-4559:4510-4559"  # external services port range
    environment:
      - DEBUG=${DEBUG-}
      - DOCKER_HOST=unix:///var/run/docker.sock
    volumes:
      - volume:/var/lib/localstack
      - "/var/run/docker.sock:/var/run/docker.sock"

volumes:
  volume:
```

`docker-compose-for-copy.yml`は、

https://docs.localstack.cloud/getting-started/installation/#docker-compose

を参考に作りました。`/root/docker-compose.yml`として配置します。  

ホスト（開発マシン）でビルドします。  

```bash
docker build -t my-image:latest .
```

環境構築は以上です。  

# Run

Ubuntuコンテナを動かします。  

```bash
docker run -it --rm \
-v /var/run/docker.sock:/var/run/docker.sock \
my-image:latest
```

ここでのポイントは、`"-v /var/run/docker.sock:/var/run/docker.sock"`です。  
Ubuntuコンテナ側からホスト（開発マシン）の`docker.sock` (/var/run/docker.sock)をマウントすることでUbuntuコンテナ上のdockerコマンドはホスト（開発マシン）上のDocker環境で実行されます。  

Ubuntuコンテナのbashが立ち上がりますので次のコマンドを実行してみましょう。

```bash
curl gateway.docker.internal:4566/_localstack/health | jq
```

`gateway.docker.internal`に対して接続しているのは、コンテナの中から実行するんだったら`localhost`とか`127.0.0.1`でいけそうな気がしましたが駄目でした。頭がこんがらがりそうですが、Dockerコンテナ自体は結局ホスト（開発マシン）で動いている関係でこうなるのだと思います。

`gateway.docker.internal`については、「[コンテナからホスト上のサービスに対して接続したい](https://docs.docker.jp/v19.03/docker-for-mac/networking.html#mac-i-want-to-connect-from-a-container-to-a-service-on-the-host)」を参考にしました。

次のような実行結果が得られます。  


```json:
{
  "services": {
    "acm": "available",
    "apigateway": "available",
    "cloudformation": "available",
    "cloudwatch": "available",
    "config": "available",
    "dynamodb": "available",
    "dynamodbstreams": "available",
    "ec2": "available",
    "es": "available",
    "events": "available",
    "firehose": "available",
    "iam": "available",
    "kinesis": "available",
    "kms": "available",
    "lambda": "available",
    "logs": "available",
    "opensearch": "available",
    "redshift": "available",
    "resource-groups": "available",
    "resourcegroupstaggingapi": "available",
    "route53": "available",
    "route53resolver": "available",
    "s3": "running",
    "s3control": "available",
    "scheduler": "available",
    "secretsmanager": "available",
    "ses": "available",
    "sns": "available",
    "sqs": "available",
    "ssm": "available",
    "stepfunctions": "available",
    "sts": "available",
    "support": "available",
    "swf": "available",
    "transcribe": "available"
  },
  "version": "2.2.1.dev"
}
```

:tada::tada::tada:
各種AWSのサービスが動いていそうです。


# [LocalStack](https://localstack.cloud/)でS3を操作してみる

以下、Ubuntuコンテナの中での操作です。

```bash
docker compose up -d
export AWS_ACCESS_KEY_ID=1
export AWS_SECRET_ACCESS_KEY=2
export AWS_DEFAULT_REGION=us-west-2
```

`docker compose up -d`は、Dockerfileの中に書いた「`COPY docker-compose-for-copy.yml docker-compose.yml`」により、`/app/docker-compose.yml`が配置されておりますのでそれを開始しています。`AWS_ACCESS_KEY_ID`等は、`aws config`をする代わりに環境変数で初期設定をしています。今回はAWSに接続するのではなく、[LocalStack](https://localstack.cloud/)でエミュレートするので値は適当でよいです。  


「[AWS CLI で高レベル (S3) コマンドを使用する](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-services-s3-commands.html)」を参考に[LocalStack](https://localstack.cloud/)上で[S3](https://aws.amazon.com/jp/pm/serv-s3/)の操作をしてみます。  

[S3](https://aws.amazon.com/jp/pm/serv-s3/)とはSimple Storage Serviceの略で、「場所を問わず、任意の量のデータを保存および取得できるように構築されたオブジェクトストレージ」です。

`awesome-bucket`を作成し、そこに`awesome.txt`をアップロードし、`awesome.txt`がアップロードされたことを確かめてみます。  
`--endpoint-url`オプションで、[LocalStack](https://localstack.cloud/)を指すようにします。  
`gateway.docker.internal`をホスト名にしているのは前項で説明した通りです。  

```
aws --endpoint-url=http://gateway.docker.internal:4566 s3 mb s3://awesome-bucket

echo "We are the Alchemists, my friends!!!" >> awesome.txt

aws --endpoint-url=http://gateway.docker.internal:4566 s3 cp awesome.txt s3://awesome-bucket/

aws --endpoint-url=http://gateway.docker.internal:4566 s3 ls s3://awesome-bucket
```

:tada::tada::tada:
[S3](https://aws.amazon.com/jp/pm/serv-s3/)をエミュレートすることができました！！！

# さいごに

本記事では、はじめての[LocalStack](https://localstack.cloud/)ということで、[S3](https://aws.amazon.com/jp/pm/serv-s3/)の操作のみを行ってみました。  
[LocalStack](https://localstack.cloud/)の公式には「[Quickstart](https://docs.localstack.cloud/getting-started/quickstart/)」がありますのでもっと複雑で実践的なことをやりたい人は、そちらをやってみるとよいでしょう。私はまだやっていませんが「[Tutorials](https://docs.localstack.cloud/tutorials/)」もあります。  

[AWS CLI](https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-chap-welcome.html)や[AWS CloudFormation](https://aws.amazon.com/jp/cloudformation/)、[Terraform](https://www.terraform.io/)、[Serverless](https://www.serverless.com/)などを試してみるときに、AWSアカウント上にリソースを作ることなくローカルの開発環境でエミュレートできるので便利そうです。公式にも書いてあるように時短と経費の節約（Save time and resources）ができます。  

![スクリーンショット 2023-08-20 12.02.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cdc60b2b-13be-e986-3118-bc8bf3cb66b6.png)

他には単なる趣味に近いところで、Dockerコンテナの中でdockerコマンドを実行することをやってみました。この記事では、「**DooD(Docker outside of Docker)**」をやってみました。  

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
