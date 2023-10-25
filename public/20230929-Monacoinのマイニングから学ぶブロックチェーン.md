---
title: Monacoinのマイニングから学ぶブロックチェーン
tags:
  - Monacoin
  - ブロックチェーン
  - Web3
  - AdventCalendar2023
private: false
updated_at: '2023-10-26T00:05:12+09:00'
id: 5bd93c1b2df055dcacc4
organization_url_name: haw
slide: true
ignorePublish: false
---
この記事は、2023年10月17日(火)に開催される「[e-ZUKA Tech Night vol.59 -グローバルでの暗号通貨関連開発のリアル-](https://ezukatechnight.doorkeeper.jp/events/162603)」にて私が行うLT(Lightning Talks)の資料です。

---

# はじめに

さっそく[Monacoin](https://monacoin.org/)をマイニングします。
※ testnetです。

プログラムはここにあります。

https://github.com/TORIFUKUKaiou/ntgbtminer/tree/topic-monacoin

**Python 2**です。マイニングを開始（デモ）。
(自分用メモ: sshしてマイニング開始プログラムがおいてあるディレクトに `cd` しておくこと)

---

![computer_mining_kasoutsuuka.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/be0ae112-d584-7743-c3c5-2676827e3910.png)


---

# ブロックチェーンの基本

ブロックチェーンは、ブロックがチェーンでつながっているからその名前がついたものです。
ブロックには正当な取引が含まれており、これらの取引はトランザクションとも呼ばれます。
取引（トランザクション）は価値の移転です。暗号資産（仮想通貨)の場合はコインの移動です。

---

オリジナルのブロックチェーンはBitcoinです。[Monacoin](https://monacoin.org/)は、Bitcoinから派生して作らています。
ブロックチェーンに使われている技術は、成熟した（枯れた）技術の組み合わせです。ひとつひとつは真新しいものではありませんがそれらを巧みに組み合わせて、人間の欲をも刺激する形に仕立てあげられた発明です。

![network_blockchain.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7b9d6d69-678d-b107-5646-271caa4cae83.png)

---

# 中学生、高校生向け **ブロックチェーン授業**

私は飯塚市の中学生、高校生に **ブロックチェーン** を教えることをしています。
そのときに使っている資料を一部抜粋します。


![次世代のICT基盤 「ブロックチェーン」 がもたらす社会変革.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cf054203-d22c-9d19-808f-4f559947830f.png)


各々のキャラクターが持っている宝箱は、各自が持っている鍵（秘密鍵)だけで開けることができます。
各キャラクターは開いている宝箱をたくさん持っていて、これがアドレス（≒公開鍵）を表現しています。
みなで台帳を**公開**しているから不正ができない。
海賊の航海にちなんでまさに **大公開（航海)時代** なのです。

[いらすとや](https://www.irasutoya.com/)をはじめとするフリー素材で作っています。この場をお借りして御礼申し上げます。 **ありがとうーーーーッ！！！** でございます。

西日本新聞
[飯塚高生徒がブロックチェーン学ぶ　IT企業幹部が用途や仕組み伝授](https://www.nishinippon.co.jp/item/n/887930/)


---

# ナンスとは？

ブロックを作る計算はナンスと呼ばれる値を見つける作業を含みます。

ナンスは、「**何っすか！？**」とひたすら計算を繰り返すわけです。
ナンスを見つけるのは大変ですが、正しいナンスの値を見つけた場合、それが正解であることを簡単に確認できます。
逆に言うと、確かめるのが簡単ではないと、Monacoinに参加しているみんな（ノード）で確かめることはできません。

---

# マイナーとは？

ブロックをがんばってつくる人をマイナーと呼びます。
マイナーはブロックを作成することでご褒美（報酬）としてMona（コイン）を獲得できます。

---

# ブロックチェーンの分散性

[Monacoin](https://monacoin.org/)には中央管理者がいません。誰か一人だけでも続けていればチェーンは続きます。
各自が得たコインは秘密鍵を持っている人だけが操作できます。これは従来のインターネットサービスとは異なる画期的な特徴です。

サービス主体（管理者）がいる従来型のインターネットサービスでは、そのサービスの主体が「や〜めた」すると全ては失われます。
真のWeb3型の構成では最後の一人がノードを立ち上げ続けている限りサービスは失われません。一時的に離れた人が再び戻ってきた場合には秘密鍵を持ってさえいれば、データの操作が可能です。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/306242ba-d2ea-ef8d-b3c2-4d7032a8b902.png)



---

# Faucet（水道の蛇口）

あなたがMonacoinのtestnetノードを立ち上げたとして、どこからコインを得ればよいでしょうか。
なんと私が配っています。

https://faucet.torifuku-kaiou.app/monacoin/testnet

あなたもtestnetで得たコインを配るWebサービスを立ち上げてみてください。

---

# そろそろ掘れたのではないでしょうか

コンソールをみてみましょう。もしも掘れなかったときのために予め掘っておきました。

## ブロック

エクスプローラを覗いてみましょう。

https://testnet-blockbook.electrum-mona.org/blocks

うまくいかなかったときのためにあらかじめ掘っておいたブロック [5e5e173928e5391f76115b025d6524895f4df6c105cfeb617b0bbef5c51cf0ad](https://testnet-blockbook.electrum-mona.org/block/5e5e173928e5391f76115b025d6524895f4df6c105cfeb617b0bbef5c51cf0ad)

https://testnet-blockbook.electrum-mona.org/block/5e5e173928e5391f76115b025d6524895f4df6c105cfeb617b0bbef5c51cf0ad

## コインベーストランザクション

https://testnet-blockbook.electrum-mona.org/tx/90753684e7ec7149df27c3e663658ab938452557a88701aee5ea1433fae6dbb4

---

![スクリーンショット 2023-09-29 13.48.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/01a16837-39b7-bef7-3876-c0f225e9c62b.png)

---

**実はLT（Lightning Talks）後、掘れていました！！！**

2023/10/17 20:53:40

```json
"coinbase": "0333cd1d323032333039323620652d5a554b412054656368204e6967687420766f6c2e353900000000",
```

[f858f88d51e68c09835e12f93b317b34ea34de9e9ac5b8a5e035e2872cf75bfa](https://testnet-blockbook.electrum-mona.org/block/f858f88d51e68c09835e12f93b317b34ea34de9e9ac5b8a5e035e2872cf75bfa)のブロックに取り込まれているコインベーストランザクション[6749cce14614473e4569addcf02e61968ce0a5b6dc6e4b6fad76590e64055e6e](https://testnet-blockbook.electrum-mona.org/tx/6749cce14614473e4569addcf02e61968ce0a5b6dc6e4b6fad76590e64055e6e)があります。そのコインベーストランザクションの `coinbase` フィールドをデコードしてみます。



```ruby
irb(main):001:0> msg = '323032333039323620652d5a554b412054656368204e6967687420766f6c2e3539'
=> "323032333039323620652d5a554b412054656368204e6967687420766f6c2e3539"
irb(main):002:0> [msg].pack('H*')
=> "20230926 e-ZUKA Tech Night vol.59"

```

やったね :tada::tada::tada:

---

# まとめ

ブロックチェーンとは取引の安全性と分散性を提供する画期的な技術です。
Monacoinのマイニングは面白く、ブロックチェーンの仕組みを学ぶ良い方法です。

- 取引(トランザクション)
- コインベーストランザクション
- ナンスを見つけるためのハッシュ計算の繰り返し
- ブロック

得たコインを配るFaucetもつくると更に理解が深まります。

---

# 刺激的なメッセージ

最後に、皆さんに刺激的なメッセージをお伝えします。ブロックチェーンの世界は常に進化し、新たな可能性が広がっています。あなたもこの革命に参加し、未来を創り出す一翼を担うことができます。ブロックチェーンの探求を通じて、新しい世界への扉を開けましょう。未来はここにあります！

ご質問や疑問点があれば、このあとの懇親会でお気軽にどうぞ。

