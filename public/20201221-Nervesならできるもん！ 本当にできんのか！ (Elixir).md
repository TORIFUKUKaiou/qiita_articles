---
title: Nervesならできるもん！ |> 本当にできんのか！ (Elixir)
tags:
  - RaspberryPi
  - Elixir
  - Nerves
private: false
updated_at: '2020-12-23T08:26:58+09:00'
id: dc54108e4a1f1cb3a650
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
この記事は[Raspberry Pi Advent Calendar 2020](https://qiita.com/advent-calendar/2020/raspberry-pi) **11日目**です。
あいていたので書きます

# はじめに
- [Elixir](https://elixir-lang.org/)というプログラミング言語があってですね、
- その[Elixir](https://elixir-lang.org/)を使って、モダンにIoT開発ができる[Nerves](https://www.nerves-project.org/)というものがあるのですよ
    - [IoT向きモダン言語Elixirの研究 2021年1月号](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)
- [Seeed UG Advent Calendar 2020](https://qiita.com/advent-calendar/2020/seeed_ug)で、ですね、こんな記事を書きました
    - [GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified) 〜Nervesならできるもん！〜](https://qiita.com/torifukukaiou/items/0b1faacfdaa1cf217bec)
- <font color="purple">$\huge{Nervesならできるもん！}$</font>
    - っていうんなら、じゃあ、やってみせなさいよ
    - <font color="purple">$\huge{本当にできんのか！}$</font>
- ということでやっていきたいとおもいます
- で、最近[Nerves](https://www.nerves-project.org/)でやってみせたは以下の記事があります
    - [Raspberry Pi 4 + Grove Base HAT for Raspberry Pi + Grove Buzzer + Grove ButtonでつくるNervesアラーム](https://qiita.com/torifukukaiou/items/d24749203b1586b5685a)
    - [Grove Base HAT for RasPiは真っ直ぐグイっとさす](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad)
    - [Grove - Buzzer をNervesで鳴らす](https://qiita.com/torifukukaiou/items/19fecf95b9313b8a2b8a)
- GPIOをopenして`1`を書きこんだり、`0` or `1`を読み取るということはこれまでやったことがあります
- 同じことばかりやっていても私の進歩がないので、私が使ったことの無い部品を使ってみようとおもうわけです

# 完成イメージ

![IMG_20201221_101457.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f327bb87-6d7b-c107-87da-aa2e975153ac.jpeg)

![IMG_20201221_101557.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c100c2e7-cfd6-aad2-2928-c1300ad3a7ba.jpeg)

## 使用したもの
- Raspberry Pi 4
- Grove Pi+
- Grove - Temp&Humi Sensor
- Grove - LCD RGB Backlight



## [Elixir](https://elixir-lang.org/)

**Elixir (エリクサー) は並行処理の機能や関数型といった特徴を持つ、Erlangの仮想マシン (BEAM) 上で動作するコンピュータプログラミング言語である。ElixirはErlangで実装されているため、分散システム、耐障害性、ソフトリアルタイムシステム等の機能を使用することができるが、拡張機能として、マクロを使ったメタプログラミング、そしてポリモーフィズムなどのプログラミング・パラダイムもプロトコルを介して実装されている。[^1]**

[^1]: [https://ja.wikipedia.org/wiki/Elixir_(プログラミング言語)](https://ja.wikipedia.org/wiki/Elixir_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E))


## [Nerves](https://www.nerves-project.org/)
- [ElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
    - このツイートがオリジンだとおもっています
    - [Nerves](https://www.nerves-project.org/)の[Justin Schneck]氏が :thumbsup: しています
- 一躍有名にしたのはもちロン:mahjong:  @takasehideki 先生
    - [ElixirでIoT！？ナウでヤングでcoolなNervesフレームワーク](https://www2.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)

# I2C というものを私は使ったことがありません
- そういえば`I2C`って、最近記事をみたよなあ〜
    - @myasu さんの [Elixir Circuits I2Cでアナログ入力 （Grove Base Hat for Raspberry Pi）](https://qiita.com/myasu/items/81320c5e571c3124b338)
    - @mnishiguchi さんの [[Elixir/Nerves] LCDにHello!](https://qiita.com/mnishiguchi/items/f93aafcdcf284db28475)
- @mnishiguchi さんは、ソースコード[https://github.com/mnishiguchi/lcd_display](https://github.com/mnishiguchi/lcd_display) を公開されているし、これみれば楽勝でしょう！
    - というかる〜い気持ちでのぞきに行きました
- <font color="purple">$\huge{ムム、これ思っていたよりたいへんかも}$</font>
    - なめていました。。。
- [[Elixir/Nerves] LCDにHello!](https://qiita.com/mnishiguchi/items/f93aafcdcf284db28475)で@mnishiguchiさんが紹介されているリンクを見たり読んだりして出直してきます :bangbang::bangbang::bangbang:
- ということで、[Nerves](https://www.nerves-project.org/)はなんでもできるけど、<font color="purple">$\huge{私にはできることとできないことがあり、}$</font>
- <font color="purple">$\huge{そしていまの自分では見えていないだけで圧倒的にできないことのほうが多い}$</font>
- ということに気づきまして、謙虚な気持ちになれ、まだまだ精進を重ねていきたいとおもいます
- と、決意を述べたところで、
- ここでやめると、いくらアドベントカレンダーだからって言って、[Qiita](https://qiita.com/)にあげる必要あったの？　ってなるので基本に忠実にRaspberry Pi OSでの動かし方を以下書きます

# まずはRaspberry Pi OS を焼きます
- [Raspberry Pi Imager](https://www.raspberrypi.org/software/)を使いました

![スクリーンショット 2020-12-17 19.40.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/71d1c7cf-84fb-f3f1-11ee-9855f680aad0.png)

- こんがり焼き上がった :tada::tada::tada:
- 私はマイクロHDMIなるものをもっていないのでRaspberry Pi OSの画面を出せません!
- [ディスプレイなしでRaspberry Pi4にSSH接続する方法](https://akariu-gohan.hatenablog.com/entry/2020/08/26/080055)
   - ありがとうございます！
   - なるほど`ssh`という空のファイルをおいておくわけですね
   - この方法でssh接続できるようにします

# microSDカードをRaspberry Pi 4に挿して電源ON、LANケーブルでネットワークに接続

- 1分ほど瞑想をして

```
$ ssh pi@raspberrypi.local
```
- イケた :tada::tada::tada:
- <details><summary>パスワードはデフォルトのアレです</summary>raspberry</details>

```
pi@raspberrypi:~ $ sudo apt-get update
pi@raspberrypi:~ $ curl -kL dexterindustries.com/update_grovepi | bash
pi@raspberrypi:~ $ sudo reboot
```
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:ここの`sudo reboot`は不要かも?

```
pi@raspberrypi:~ $ git clone https://github.com/DexterInd/GrovePi.git
pi@raspberrypi:~ $ cd GrovePi/Software/Python
pi@raspberrypi:~/GrovePi/Software/Python $ sudo python3 setup.py install
pi@raspberrypi:~/GrovePi/Software/Python $ sudo reboot
```

```
pi@raspberrypi:~ $ cd GrovePi/Projects/Home_Weather_Display
pi@raspberrypi:~/GrovePi/Projects/Home_Weather_Display $ sudo python3 Home_Weather_Display.py 
```

![IMG_20201221_224458.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c32618e7-11f4-0664-8169-77b632e24c2b.jpeg)


Yay!!! :tada::tada::tada:

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: は色鉛筆で描きました

<font color="red">$\huge{ウソです}$</font>
[真っ赤なウソ](https://www.youtube.com/watch?v=kv-JZ7VSoHQ)です



# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Seeed株式会社](https://www.seeed.co.jp/)さんの部品をつかえば、[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)と電子工作に尻込みしている私でもはめ込み式なので簡単に工作ができます
- [Nerves](https://www.nerves-project.org/)はなんでもできるけど、<font color="purple">$\huge{私にはできることとできないことがあり、}$</font>
- <font color="purple">$\huge{そしていまの自分では見えていないだけで圧倒的にできないことのほうが多い}$</font>
    - 未来永劫できないと言っているわけではありません
    - 続ければできるようになるのです :rocket::rocket::rocket: 
- Enjoy [Elixir](https://elixir-lang.org/) !!!
- ということで、[Nerves](https://www.nerves-project.org/)が気になったかたはどうぞこちらへ
    - [Elixir](https://elixir-lang.org/)というプログラミング言語でIoTできる[ナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
    - [NervesJP Slackへの招待リンク](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
    - 愉快なfolksがあなたの訪れを大歓迎です :bangbang::bangbang::bangbang:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e310d56e-c416-ad39-d05d-23a375862eda.png)
