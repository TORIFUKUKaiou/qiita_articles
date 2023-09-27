---
title: 'NervesJP #7 Buildroot勉強回 の復習をする'
tags:
  - Nerves
private: false
updated_at: '2020-06-24T22:08:58+09:00'
id: ce141100348a4f558669
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- 2020/6/15に行われた[NervesJP #7 Buildroot勉強回](https://nerves-jp.connpass.com/event/178989/)に出席しました
- まずは[Nerves](https://www.nerves-project.org/)はおいといて、[Buildroot](https://buildroot.org/)を楽しみたいとおもいます
- macOS Catalina で作業をしました
- Targetは、Raspberry Pi 2です

# 準備
- [VirtualBox](https://www.virtualbox.org/)をインストールしておきましょう

# [The Buildroot user manual](https://buildroot.org/downloads/manual/manual.html) をみてmakeしてみる

- 適当な作業ディレクトで仮想マシンを作ります

```
$ curl -O https://buildroot.org/downloads/Vagrantfile
$ vagrant up
```

- けっこう時間がかかります
- 気長に待ちましょう
- 以降は、[Buildroot の使い方 - 基本編](https://qiita.com/pu_ri/items/75c80e388c79fe0d3f0b)をとても参考にしました！
    - ありがとうございます！

```
# host
$ vagrant ssh

# virtual machine
$ cd buildroot-2020.02
$ make list-defconfigs
$ make raspberrypi2_defconfig
$ make
```

- 私は令和二年なのにいまだにRaspberry Pi 2をつかっています
- `make`は1時間くらいかかった気がします
- `/home/vagrant/buildroot-2020.02/output/images/sdcard.img`ができあがります！

# microSDカードに焼きましょう:fire::fire::fire:

- まず`sdcard.img`をhost側にもっていきます

```
# virtual machine
$ exit

# host
$ vagrant ssh-config
Host default
  HostName 127.0.0.1
  User vagrant
  Port 2222
  ...

$ scp -P 2222 -i private_key vagrant@127.0.0.1:/home/vagrant/buildroot-2020.02/output/images/sdcard.img .
```

- `private_key`の場所は、`vagrant ssh-config`の結果を参照してください
- その他PortやHostName、Userも`vagrant ssh-config`の結果を参照してください

## Raspberry Pi Imagerのインストール
- コマンドで焼き込むこともできますがなんだかこわかったのでGUIツールを使いました
- [Downloads](https://www.raspberrypi.org/downloads/)からインストーラーをダウンロードできるのでダウンロードしてインストールします

<img width="682" alt="スクリーンショット 2020-06-23 23.25.27.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d467926d-f97c-e8a3-7eca-66826851a86c.png">

- こんな素敵なツールが立ち上がります
    - `CHOOSE OS`でUse Customから`sdcard.img`を選びます
    - `CHOOSE SD CARD`で挿入したmicroSDカードを選びます
- `WRITE` ! :fire::fire::fire:

# 結果
- こんがり焼きあがった :fire: microSDカードをRaspberry Pi 2に差し込んでディスプレイとHDMIでつないで起動してみました
- `buildroot login:` に対して `root` と打ち込むとコマンドが使えました
- `cd`と`ls`くらいしてみました

![IMG_20200624_215335.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dd5c982a-69fd-9faf-f794-b091602847b1.jpeg)




# Wrapping Up
- 今回は[Nerves](https://www.nerves-project.org/)はあんまり関係ありませんでしたがこの経験はいつか活きてくるはず :rocket::rocket::rocket: 
- **Enjoy!**



