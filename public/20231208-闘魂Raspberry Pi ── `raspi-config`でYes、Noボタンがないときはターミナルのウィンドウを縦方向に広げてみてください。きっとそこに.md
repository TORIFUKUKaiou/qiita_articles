---
title: >-
  闘魂Raspberry Pi ──
  `raspi-config`で<Yes>、<No>ボタンがないときはターミナルのウィンドウを縦方向に広げてみてください。きっとそこにいます。サマルトリアの王子さんです。
tags:
  - RaspberryPi
  - Elixir
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-09T11:44:33+09:00'
id: a700e62e2ed14a357b53
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

Raspberry Pi OSを使う機会がありました。
I2Cを有効にしたいのです。

`raspi-config`で上下、左右キーを使って操作するアレです。
で、困ったことがありました。いつもと感じが違うぞ、と。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a580f85f-0802-4d36-1571-7ec1477ab769.png)

そうそう、うんうん「enable」にしたいのさ、でもどうやってこの画面でenableに変更するの！？

新し目のRaspberry Pi OS（Linux raspberrypi 6.1.0-rpi7-rpi-v8 #1 SMP PREEMPT Debian 1:6.1.63-1+rpt1 (2023-11-24) aarch64 GNU/Linux）をインストールしたせいで、なにか変わったのだけど、まだ情報が出回っていないのかなあ、とかあらぬ方向に想像を膨らませたり、どうやってググったらいいんだと右往左往していました。そのへんをほっつき歩いて文字通り右往左往していました。

Raspberry Pi OSにはSSH接続でUbuntu(WSL 2)からアクセスしています。

# 結論

ターミナルのウィンドウを縦方向に大きく、目一杯広げてください。
いるじゃない！　そこに！　

ドラクエ２のサマルトリアの王子をおもいだしました。
`<Yes>`、`<No>`ボタンにこう言われた気がしました。 **「いやー さがしましたよ」**

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d3239804-de00-0d7b-e87d-424c77e9dc1c.png)


# さいごに

`raspi-config`で `<Yes>` 、 `<No>` ボタンがないときはターミナルのウィンドウを縦方向に広げてみてください。きっとそこにいます。サマルトリアの王子さんです。
このあと[Elixir](https://elixir-lang.org/)をインストールしてAHT20で温度・湿度を測る（予定、あくまで予定です）ので[Elixir](https://elixir-lang.org/)の記事にさせてください。

Raspberry PiってことでもうそれIoTと言って過言ではないですよね！、ということで「(ElixirかIoTくらいは絡んでいればおけ」の精神に照らすと、両方絡んでいるので堂々と[#NervesJP Advent Calendar 2023](https://qiita.com/advent-calendar/2023/nervesjp)の末席を汚します。

---

私は自分自身と闘いました。
「闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います」とアントニオ猪木さんは引退試合後のセレモニーで述べられました。
猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>

