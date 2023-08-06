---
title: >-
  闘魂Time4VPS ーー Time4VPSのContainer
  VPSでDockerコンテナから外に通信できなかったり、Dockerビルド時に外と通信できなかったらDebian OSにするとよいかもしれません
tags:
  - Docker
  - Time4VPS
  - 闘魂
private: false
updated_at: '2023-08-06T09:04:06+09:00'
id: 0dd8bbc067166febc8d2
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

# はじめに

[Time4VPS](https://www.time4vps.com/)という格安のVPSサービスがあります。  
たとえば、メモリ8GB、ストレージ80GBで月額約10ユーロです。
2023-08-06現在、10ユーロは1564円です。
興味がわいた方は[料金ページ](https://www.time4vps.com/container-vps/#annually)をご覧ください。  

[Time4VPS](https://www.time4vps.com/)には4つのサービスタイプがあります。  

- [Linux VPS](https://www.time4vps.com/linux-vps/)
- [Windows VPS](https://www.time4vps.com/windows-vps/)
- [Container VPS](https://www.time4vps.com/container-vps/)
- [Storage VPS](https://www.time4vps.com/storage-vps/)

このうち[Container VPS](https://www.time4vps.com/container-vps/)を以前は[Docker](https://www.docker.com/)を動かすことはできませんでした。  
以前は、[Linux VPS](https://www.time4vps.com/linux-vps/)の方を契約するしかありませんでした。
幸いなことに、「[Can I run Docker on my server?](https://www.time4vps.com/knowledgebase/can-i-run-docker-on-my-server/)」にあるように、2020-01-10の注文分からは使えるようになりました。

ですが、当初はサポートしていなかったことにいわくがありそうです。  
AWSの[EC2](https://aws.amazon.com/jp/ec2/)では体験できない（発生しない）問題が起こりました。  

この記事では、問題とその回避策を述べます。 

# 問題 ーー Ubuntu 22.04で[Docker](https://www.docker.com/)の動きが変

 Ubuntu 22.04に[Docker](https://www.docker.com/)をインストールして動かそうとします。
 なんだか動きが変です。
 具体的には以下に遭遇しました。

 - `docker build`で外部のパッケージ（ライブラリ）取得ができない
 - `docker run`で外部のAPIコールに失敗する

```bash
# ホスト
docker run -it --rm ubuntu:22.04 /bin/bash

# コンテナ
root# apt-get update # 外と通信ができない！！！
```

[Docker](https://www.docker.com/)コンテナやイメージのビルド時に外と通信ができないのです。  
`--network=host`オプションを付けて実行すると成功します。
しかしなんだか嫌です。

AWSの[EC2](https://aws.amazon.com/jp/ec2/)では同種の問題は体験できませんでした（発生しませんでした）。
普通に外と通信できました。

 # 回避策

Debian 11をインストールしました。  
これで問題を回避できました。
私の場合、[Docker](https://www.docker.com/)さえ動けばいいのでOSにこだわりはありません。
他に試したこととしては[AlmaLinux 8](https://almalinux.org/ja/)を試してみましたが同じ問題が発生しました。

私のネットワーク関係のいまの知識、ググり力では解決はできず、 **究極の力技** で回避しました。  
この記事であげたような[Docker](https://www.docker.com/) Containerから外にでられないといったことはそれなりにあるようです。
よく目にしたキーワードには`iptables`がありました。

**追いかけ方のアドバイスを大募集です。このコマンドの結果はどうなりますか？　とかアドバイスをいただけると幸いです。**

# さいごに

[Time4VPS](https://www.time4vps.com/)の[Container VPS](https://www.time4vps.com/container-vps/)で[Docker](https://www.docker.com/)コンテナから外に通信できなかったり、[Docker](https://www.docker.com/)ビルド時に外と通信できなかったらDebian OSにするとよいかもしれません。

「おい！、OSなんて変えられないよ」という方にはご期待に添えず、自身の力不足を痛感しております。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>

