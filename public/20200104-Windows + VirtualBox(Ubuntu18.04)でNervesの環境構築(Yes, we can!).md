---
title: 'Windows + VirtualBox(Ubuntu18.04)でNervesの環境構築(Yes, we can!)'
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-05-06T16:38:08+09:00'
id: 11d5f09999e370704192
organization_url_name: fukuokaex
slide: false
---
# 2020/05/06 追記
- Windowsで[Nerves](https://www.nerves-project.org/)をはじめられる方は、@takasehideki 先生の[ElixirでIoT#4.1.1：WSL 2でNerves開発環境を整備する](https://qiita.com/takasehideki/items/b8ea8b3455c70398178a) を参考にすすめることをオススメします
- 私もWSL2で`$ mix firmware`、`$ mix firmware.burn`ができました 🚀🚀🚀


# はじめに
- [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
- [Windows + Virtual Box(Ubuntu18.04)でNervesの環境構築に挑戦した](https://qiita.com/kanchan-1996/items/c12832c45129d27f42e2)
    - こちらを読んでWindowsで[Nerves](https://nerves-project.org/)をやってみたくなりました
    - なぜなら私はMacで楽して環境構築したからです
    - この記事からリンクされている記事、特に[@TAKASEhidek](https://twitter.com/TAKASEhideki)先生の[ElixirでIoT#4.1：Nerves開発環境の準備（2019年12月版）](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)にいろいろヒントをいただきました
    - ありがとうございます！
- [VirtualBox](https://www.virtualbox.org/)と[Vagrant](https://www.vagrantup.com/)を使います
    - VirtualBox is a powerful x86 and AMD64/Intel64 virtualization product for enterprise as well as home use. 
    - Vagrant is a tool for building and managing virtual machine environments in a single workflow.
    - 私はちゃんと説明できませんので、それぞれのドキュメントの一行目の説明を書いておきます:man_tone3:
    - すごく乱暴にいいますと、Windows 10を動かしたままUbuntuを動かせます
    - というか、私にはこうとしか説明できません:man_tone2:

# Windows 10スペック
- Microsoft Windows 10 Home
- 10.0.18362 ビルド 18362
- Dell Inc.
- Inspiron 5767
- x64-ベース PC
- プロセッサ: Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz、2901 Mhz、2 個のコア、4 個のロジカル プロセッサ
- インストール済の物理メモリ: 16.0 GB

# 他につかう**モノ**
- Raspberry Pi 2
    - [このページ](https://hexdocs.pm/nerves/targets.html)にあるものでしたら他のものでも大丈夫です
    - 私はRaspberry Pi 2しかもっていません:santa_tone2:
- microSD
- microSDカードアダプタ(USBでWindowsに挿せるもの)

# [VirtualBox](https://www.virtualbox.org/)のインストール
- [VirtualBox 6.0](https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe)
- をインストールします
- 2020/1/4現在、このあとインストールする「Vagrant 2.2.6」が[VirtualBox 6.0](https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-Win.exe)まで対応しています
- インストーラをダウンロードして、.exeをダブルクリックしてNext、Nextです

# [Vagrant](https://www.vagrantup.com/)のインストール
- [vagrant_2.2.6_x86_64.msi](https://releases.hashicorp.com/vagrant/2.2.6/vagrant_2.2.6_x86_64.msi)
- をダウンロードして、.msiをダブルクリックしてNext、Nextです

# Ubuntuのセットアップ

## Vagrantfile
```Ruby:Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 2
    vb.memory = "4096"
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt install -y build-essential automake autoconf git squashfs-tools ssh-askpass libssl-dev libncurses5-dev fop xsltproc libxml2-utils openjdk-8-jdk unixodbc-dev libwxgtk3.0-dev unzip
    wget https://github.com/fhunleth/fwup/releases/download/v1.5.1/fwup_1.5.1_amd64.deb
    dpkg -i fwup_1.5.1_amd64.deb
  SHELL
end
```

- 適当なフォルダーに`Vagrantfile`を置いてください
- `vb.cpus`や`vb.memory`の値はお使いのマシンにあわせて調整してください
- [公式ドキュメント](https://hexdocs.pm/nerves/installation.html#linux)に書いてあることをしています
- 違いは、`libssl-dev libncurses5-dev fop xsltproc libxml2-utils openjdk-8-jdk unixodbc-dev libwxgtk3.0-dev unzip`を追加しています
    - `libssl-dev libncurses5-dev fop xsltproc libxml2-utils openjdk-8-jdk unixodbc-dev libwxgtk3.0-dev`は[Erlang](https://www.erlang.org/)のインストールで必要になります
    - `unzip`は[Elixir](https://elixir-lang.org/)のインストールで必要になります
    - 以下[Elixir](https://elixir-lang.org/)のインストール等も`"shell"`で書こうとしたのですが、`asdf`が事前に`sudo su - vagrant`とかしても/root/.asdfにcloneされるのであきらめました
- `Vagrantfile`がおいてあるフォルダーにコマンドプロンプトで`cd`してたどりついたら

## Windows
```
> vagrant up
```
- してください
- 私の場合、20分くらいでしたでしょうか
- 無事`vagrant up`が終わったら

## Windows
```
> vagrant ssh
```
- してください
- 以降Ubuntuでの操作になります

## Ubuntu
```
$ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.6
$ echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
$ echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
$ source ~/.bashrc
$ asdf plugin-add erlang
$ asdf plugin-add elixir
$ asdf install erlang 22.1.4
$ asdf install elixir 1.9.4-otp-22
$ asdf global erlang 22.1.4
$ asdf global elixir 1.9.4-otp-22
$ mix local.hex --force
$ mix local.rebar
$ mix archive.install hex nerves_bootstrap --force
$ ssh-keygen -t rsa -f ~/.ssh/id_rsa 
```
- `asdf install erlang 22.1.4`が一番時間がかかります
    - ~~ドキュメントまわりで警告でましたが私は無視しました~~
    - 公開当初は上記のような適当なこと書いていましたが、先人の方々の記事を参考にして警告がなくなるようにしました
- 私の場合、16分くらいでしたでしょうか
- もし進んでいるのかどうか不安になりましたら、もう一個コマンドプロンプトを立ち上げて、`vagrant ssh`して

## Ubuntu
```
$ tail -f /home/vagrant/.asdf/plugins/erlang/kerl-home/builds/asdf_22.1.4/otp_build_22.1.4.log
```
- とでもすればちゃんとがんばっている様子がみれます
- 話が前後しますが、[Erlang](https://www.erlang.org/)と[Elixir](https://elixir-lang.org/)、[Nerves](https://nerves-project.org/)をインストールしている感じです
- [公式ページ](https://hexdocs.pm/nerves/installation.html#all-platforms)の通り、だいたいそのままです
- `ssh-keygen`している理由は、お手持ちのハードウェア(Raspberry Pi等)のうえで動いている[Nerves](https://nerves-project.org/)にsshで接続できるようになるのですがその際に必要になります(この記事では扱いません)
- 私はメモリを4GB確保できるマシンで環境構築しましたが、そうではない場合は[Erlang](https://www.erlang.org/)のインストールらへんが失敗するとおもわれます
    - その際は[@etcinitd](https://twitter.com/etcinitd)さんの[Erlangのコンパイルが出来ず、やむを得ずパッケージで入れ直したり、VirtualBoxからNervesデバイスが見え無かったり・・・等、当日ハマったところの処置についてまとめてみました。](https://twitter.com/etcinitd/status/1148587762435575808)が参考になるとおもいます
- ここまでうまくいきましたらゴールは目の前です

# サンプルプロジェクト
- 引き続きUbuntuでの作業です

## Ubuntu
```
$ git clone https://github.com/nerves-project/nerves_examples.git
$ cd nerves_examples/hello_leds/
$ export MIX_TARGET=rpi2
$ mix deps.get
$ mix firmware
$ exit
```
- MIX_TARGETは[Targets](https://hexdocs.pm/nerves/targets.html#content)をみながらお手元のハードウェアを指定してください
- `mix deps.get`と`mix firmware`は少し時間かかります
- 一旦、UbuntuからぬけてmicroSDを認識させます

## Windows
```
> vagrant halt
```
- Ubuntuを止めます
- firmwareを焼くmicroSDカードをUSBアダプタ経由でWindowsに挿します
- 私はこういうやつを使いました

![IMG_20200104_224605.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/50b50206-6ced-ebd6-c1a3-7b074d1c554d.jpeg)




![vm-vb.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/185ebb26-466f-c038-ccec-66a61ec06c16.png)

- ↑こういうやつをダブルクリックして
- [設定] |> [USB]とすすんで

![usb-setting.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/455a2f6b-9ad5-6cc3-5e7e-d74c264ff498.png)

- こんな感じに設定します
- ふたたびUbuntuを起動しましょう

## Windows
```
> vagrant up
> vagrant ssh
```

## Ubuntu
```
$ lsusb
Bus 001 Device 002: ID 1307:0310 Transcend Information, Inc. SD/MicroSD CardReader [hama]
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
```
- こんな感じでmicroSDっぽいやつを認識していれば大丈夫です

```
$ cd nerves_examples/hello_leds/
$ export MIX_TARGET=rpi2
$ mix firmware.burn
```

![firmware_burn.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d7e23ce9-1fcd-599b-d97d-794fd27178d5.png)

- 私は、microSDカードのサイズで`1`を選びました
- **一番緊張する瞬間であります**
- こんがり焼きあがりましたら、ハードウェアにmicroSDカードをさしこんで電源ONです！

![IMG_20200104_234408.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/46f66f42-327c-26a0-6e59-8abbcac928c5.jpeg)


![VID_20200104_214146.gif](https://firebase.torifuku-kaiou.tokyo/VID_20200104_214146.gif)

# Tips
## パソコンの電源を切るとき
```
# Ubuntu
$ exit
logout
Connection to 127.0.0.1 closed.

# Windows
> vagrant halt
```

## また開発するぞ！
```
# Windows
> vagrant up
> vagrant ssh

# Ubuntu
$ mix nerves.new hello_nerves
```

- [Nerves](https://nerves-project.org/)の環境構築を題材にした[VirtualBox](https://www.virtualbox.org/)と[Vagrant](https://www.vagrantup.com/)の使い方な記事になりました:keyboard:

# このあとは！
- 私の記事ですが紹介しておきます
- [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)
- [Nervesでcron的なことをする](https://qiita.com/torifukukaiou/items/19a6aef76e28f9a1f319)
- [Nervesを使ってRaspberry Pi 2でLEDをチカチカさせる 〜クリスマスの飾り付けをしよう〜](https://qiita.com/torifukukaiou/items/bf0354db8cd0628f161e)
- [Nervesを使って毎朝天気予報をRaspberry Pi 2にしゃべらせる(できた！)](https://qiita.com/torifukukaiou/items/795ee5a112845dbf7730)
- **[Nerves](https://nerves-project.org/)を楽しみましょう！:rocket:**

