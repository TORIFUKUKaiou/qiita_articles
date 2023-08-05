---
title: >-
  GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified)
  〜Nervesならできるもん！〜
tags:
  - Python
  - RaspberryPi
  - Elixir
  - Nerves
  - Seeed
private: false
updated_at: '2020-12-24T23:25:32+09:00'
id: 0b1faacfdaa1cf217bec
organization_url_name: fukuokaex
slide: false
---
[Seeed UG Advent Calendar 2020](https://qiita.com/advent-calendar/2020/seeed_ug) **18日目** です。
前日は @tseigo さんの[Grove Speech Recognizer を obniz とつなげたメモ](https://www.1ft-seabass.jp/memo/2020/12/16/obniz-with-grove-speech-recognizer/)でした。

---

# はじめに
- [GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified)](https://www.seeedstudio.com/GrovePi-Starter-Kit-for-Raspberry-Pi-A-B-B-2-3-CE-certified.html)
![IMG_20201217_195832.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d8e1a4ee-a36a-006f-3e1f-ac56dbf0f40c.jpeg)


- いろいろ入っていて、いろいろと楽しめそうです !!!
![IMG_20201217_195840.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/13d2f74f-e677-e0bd-682a-65f018ddcfbb.jpeg)


- 私は[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)、開けたら最後、蓋を閉じれなくなってしまいました :sweat_smile: 

![IMG_20201217_195926.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/af1ba678-87a7-27e8-66b4-cf0c6dca3ade.jpeg)

- 今回は付属の`User Manual`に従ってプログラミングを楽しみたいとおもいます(Python)
- また、私は[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)も持っておりまして、すでに装着済ですし、外したりつけたりはピンを曲げたりしてしまいそうでこわいので[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)を使います

# まずはRaspberry Pi OS を焼きます
- [Raspberry Pi Imager](https://www.raspberrypi.org/software/)を使いました

![スクリーンショット 2020-12-17 19.40.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/71d1c7cf-84fb-f3f1-11ee-9855f680aad0.png)

- こんがり焼き上がった :tada::tada::tada:

# microSDカードをRaspberry Pi 4に挿して電源ON、LANケーブルでネットワークに接続

- 1分ほど瞑想をして

```
$ ping raspberrypi.local
```

- が通ったら

```
$ ssh pi@raspberrypi.local
```

- できない。。。
- [raspberry pi 3のsshが繋がらない対策（Connection refused）](http://web09.hatenablog.com/entry/how-to-raspberry-ssh)
- `ssh`が無効になっていると推測
- 面倒くさいけど、とりあえずディスプレイとキーボードをRaspberry Pi 4に接続して`ssh`を有効化しようとおもった
- あれ、これどこにHDMIあるの？
    - 私の知識は令和2年なのにいまだにRaspberry Pi 2の知識のままなのです
    - マイクロHDMI へ〜　へ〜　へ〜
    - **そんなものもっていませんですよ**
- じゃあ、Raspberry Pi 2でやればいいじゃん！
    - 一瞬そうおもった
    - けれどRaspberry Pi 2のところに行って茫然自失
    - はずしたくない
    - 恥ずかしいが、**はずしてしまったらふたたびつなげる自信がない**

![IMG_20201217_204351.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0d659574-d634-5a83-49bd-59811694c329.jpeg)

# <font color="purple">あ、そうだ:bangbang: それなら、[Nerves](https://www.nerves-project.org/)でやればいいじゃん！</font>
- ということであとはおなじみ[Nerves](https://www.nerves-project.org/)で楽しみましょう
- 手前味噌たち
    - [Raspberry Pi 4 + Grove Base HAT for Raspberry Pi + Grove Buzzer + Grove ButtonでつくるNervesアラーム](https://qiita.com/torifukukaiou/items/d24749203b1586b5685a)
    - [Grove - Buzzer をNervesで鳴らす](https://qiita.com/torifukukaiou/items/19fecf95b9313b8a2b8a)
    - [Grove Base HAT for RasPiは真っ直ぐグイっとさす](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad)
- 本当にそれでいいのか:interrobang:
    - あるイミこれで`Elixir`、`Nerves`のタグがつけられるのでいい
    - なにか方法があるのではないかと心がざらつく

# ディスプレイなしでsshを有効にする方法はないの？
- あった :tada::tada::tada::tada: 
- [ディスプレイなしでRaspberry Pi4にSSH接続する方法](https://akariu-gohan.hatenablog.com/entry/2020/08/26/080055)
    - ありがとうございます！
    - なるほど`ssh`という空のファイルをおいておくわけですね

```
$ ssh pi@raspberrypi.local
```
- イケた :tada::tada::tada:
- パスワードはアレです

# Example Project: Button And Buzzer

- `User Manual` p.20には`the Rotary to Port A0`と書いてあるけど、これは間違いじゃないかな
- `ButtonをD4に指す`が正しいとおもう

```
pi@raspberrypi:~ $ git clone https://github.com/DexterInd/GrovePi.git
pi@raspberrypi:~ $ cd GrovePi/Script/
pi@raspberrypi:~/GrovePi/Script $ sudo chmod +x install.sh 
pi@raspberrypi:~/GrovePi/Script $ sudo ./install.sh
pi@raspberrypi:~/GrovePi/Script $ sudo reboot
``` 


- (追記) この時点で、`sudo ./install.sh`がうまくイッていなかったのかも(ここからグダグダ)
- 再起動するのでもう一回`ssh`接続して

```
pi@raspberrypi:~ $ cd GrovePi/Projects/Button_And_Buzzer/
pi@raspberrypi:~ $ nano Button_And_Buzzer.py 
```

- 冒頭申した通り、私は[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)を使っているのでピンの番号が違うのでそこだけ変更しています

```
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ sudo python Button_And_Buzzer.py 
Traceback (most recent call last):
  File "Button_And_Buzzer.py", line 33, in <module>
    from grovepi import *
ImportError: No module named grovepi
```

- [No module named grovepi [solved]](https://forum.dexterindustries.com/t/no-module-named-grovepi-solved/382)
- [[Solved] “No module named di_i2c”](https://forum.dexterindustries.com/t/solved-no-module-named-di-i2c/7170)
    - これらのページの通りでもう少しすすめられそう

```
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ sudo apt-get update
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ sudo apt-get install libffi-dev
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ apt-get install python-pybind11
pi@raspberrypi:~/GrovePi/Software/Python $ pip3 install pybind11
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ apt-get install python3-pybind11
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ cd ~/GrovePi/Software/Python
pi@raspberrypi:~/GrovePi/Software/Python $ sudo python3 setup.py install
```

- いらんもんもインストールしていそう
- エラーがでる都度、ググって適当にカンでインストールしました
- 結局のところ、↓これが効いていそうな気がします

```
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ curl -kL dexterindustries.com/update_grovepi | bash
pi@raspberrypi:~/GrovePi/Projects/Button_And_Buzzer $ sudo python Button_And_Buzzer.py 
```

- ボタン押しても鳴らない
- 意を決して[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)を外して、`User Manual`に書いてある通り、`GrovePi+`を取り付けてためしてみよう
- **それでもダメなら**
- <font color="purple">$\huge{Nervesならできるもん！}$</font>
- と負け惜しみを用意しつつ
- 眠いし時間切れで、アドベントカレンダーだからという甘えのグダグダ感で
    - マイクロHDMI、そんなもの持っていませんよという方に`ssh`の方法を示せたし
    - おそらく`User Manual` P.20の誤植を指摘できたし
    - まあそんなところがこの記事の**醍醐味** (この記事が大ゴミ :recycle: :interrobang:)です

## `User Manual`の通りに組み立て直し
- GrovePi+をとりつけて、`Button_And_Buzzer.py` を元に戻して `sudo python Button_And_Buzzer.py`
- ボタン押したら鳴った :speaker::speaker::speaker: 
- なんか感動 !!!
    - 眠い目をこすりながら最後まで粘った自分をほめてあげたい

![IMG_20201217_234548.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/758988b1-6645-9011-546b-d33f5e9356c0.jpeg)

- けれど`Ctl+C`してもう一度、`sudo python Button_And_Buzzer.py`するとボタン押しても鳴らない :thinking:
- 再起動とかしたら鳴るような気がしないでもありませんが 
- まあ、もういいや静かな田舎町であの「フ、ピ〜〜〜〜〜〜〜〜〜〜」の大音量を鳴らすのは悪かろうし、そうそう<font color="purple">$\huge{Nervesならできるもん！}$</font>ともう一回言ってみたところで筆をおきます
- ちなみに↑の図は色鉛筆でかきました
    - <font color="red">$\huge{ウソです}$</font>
    - [真っ赤なウソ](https://www.youtube.com/watch?v=kv-JZ7VSoHQ)です


# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)と工作を諦めている、そこのあなた
- [Seeed株式会社](https://www.seeed.co.jp/)さんの[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)や[GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified)](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)で簡単に電子工作はじめてみましょう :bangbang: :rocket::rocket::rocket:  
- ところで[Nerves](https://www.nerves-project.org/)って何？　って気になったかたはどうぞこちらへ
    - [Elixir](https://elixir-lang.org/)というプログラミング言語でIoTできる[ナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
    - [NervesJP Slackへの招待リンク](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
    - 愉快なfolksがあなたの訪れを大歓迎です :bangbang::bangbang::bangbang:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e310d56e-c416-ad39-d05d-23a375862eda.png)


次回は、@airpocketさんで「[Maix Bit と 6 + 1 マイクロフォンアレイで音源可視化](https://qiita.com/airpocket/items/a03c1309df36a6795ba5)」です。
引き続きお楽しみください。



