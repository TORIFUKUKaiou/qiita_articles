---
title: Dockerコンテナ上でSpringを使ってHello Worldを楽しむ（in チャレキャラ）
tags:
  - Java
  - spring
  - ハッカソン
  - Docker
  - HelloWorld
private: false
updated_at: '2023-09-06T13:25:35+09:00'
id: 5bf02da6dee22efecf3c
organization_url_name: haw
slide: false
ignorePublish: false
---
# はじめに

私は2023-09-02(土)に行われた[チャレキャラ](https://challecara.org/) コアイベント（オンライン）に参加して、メンター（師匠役、先生役）をしました。  
なにをしたかというと学生の開発チームから話を聞いて、困っていることの相談に乗るということをしました。
今年の[チャレキャラ](https://challecara.org/)は、5/27からはじまっています。私自身は今年初参加でした。  

3チームの面談をしたところ、そのうち2チームがJavaでWebアプリケーションを作るとのことでした。  
前回の面談(8/12)では別のメンターの方が[Spring](https://spring.io/)をススメられていましたので、私も同じく[Spring](https://spring.io/)をススメておきました。  
公式ページを案内しておきました。  

私自身は最近、Javaにあまり触れていないのですが、学生からいつ質問が飛んできても良いように、`Hello World`くらいはやっておきたいと思いました。せっかくなので記事をしたためておきます。  
`Hello World`つまり環境構築と言い換えてもよいとおもうのですが、ここさえ突破できればあとは個別の話として学生各々でがんばってくださいでもよいと思っています。  
０から１０すべてを教えるのではなく、０から１までは教えてあとは自走してもらうのがよいと思いますし、環境構築を飽きずに投げ出さずにやりきった人たちなら、あとはかけ算で１０まですぐに到達できるものと思います。

この記事では、[Spring](https://spring.io/)で`Hello World`を[Docker](https://www.docker.com/)を使って動かしましたということを書いています。  

# What is [チャレキャラ](https://challecara.org/) ?

そもそも[チャレキャラ](https://challecara.org/)とは一体何でしょうか。  
「**チャレキャラは九州の学生のための育成型アプリコンテストです。**」とのことです。  

動画があります。  

<iframe width="1081" height="608" src="https://www.youtube.com/embed/mIbuFA2_uv0" title="チャレキャラ プロモーションムービー" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

この動画は過去に[チャレキャラ](https://challecara.org/)に参加してくれた学生が作ってくれた動画です。  
[チャレキャラ](https://challecara.org/)の卒業生が、[チャレキャラ](https://challecara.org/)に貢献するというのも[チャレキャラ](https://challecara.org/)の特徴です。  

https://challecara.org/ から引用します。

| Question | Answer |
|:-|:-|
| 誰が参加できるの？  |  九州の大学、高専、高校、専門学校に通っていて、アプリ開発やウェブサービス開発に興味のある人を対象としています。 チームでも、お一人でも参加できます。何からはじめたら良いかわからない人をサポートする体制を整えております！ |
| 何をするの？  |  １２月のコンテストで作品発表することを目標に、７月から順次開催される開発イベントに参加します。 イベントでは、どのようにアプリやウェブサービスを開発したらよいのかを、 メンター*がやさしく指導します。開発イベント以外の時間にも個別に作業を進めてもらい、 その間はチャレキャラの Slack コミュニティなどを通してサポートします。*主に九州に拠点を置くソフトウェア開発企業からプロのエンジニアが参加しています。 |
| どんな人がいるの？  |  毎年、九州の各学校からアプリを作りたいという強い思いを持つ学生が集まってきます！ 最初からチームで参加する人もいますし、１人で参加して、チャレキャラの中で仲間を見つける人もいます。 本格的なプログラミングははじめての人もいますし、企画力のみで参加する人もいます。そんな皆さんをサポートするため、メンターは九州に拠点を置くソフトウェア開発企業からプロのエンジニアが参加しています。 |


**チャレキャラは九州の学生のための育成型アプリコンテストです。**

# イゴかす[^1]

[^1]: 「動かす」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。2017年ころのオートレースの実況では、実況アナウンサーが「針[^2]イゴきます」とはっきり言っていた。

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切る。発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。


[Spring Quickstart Guide](https://spring.io/quickstart)に従って、`Hello World`をイゴかしてみます。

https://spring.io/quickstart

手順は、[Spring Quickstart Guide](https://spring.io/quickstart)にすべて書いてあります。


## 手順1. start.spring.io でプロジェクトを作る

[start.spring.io](https://start.spring.io/)では、プロジェクトを作ってくれます。

![スクリーンショット 2023-09-05 16.00.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0322bad1-7af2-4541-8d46-7e6c7e073afc.png)

デフォルトから変更したところは、「Add Dependencies」を押して、「Spring Web」を選んだだけです。  
あとは「Generate」を押すと、`demo.zip`をダウンロードできます。
適当な場所に解凍します（unzip）。

## 手順2. DemoApplication.javaを変更する

[Spring Quickstart Guide](https://spring.io/quickstart)を参考に、`src/main/java/com/example/demo/DemoApplication.java`を変更（コピペ）します。

![スクリーンショット 2023-09-05 16.05.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f3cb4e5d-2dc9-2945-68bb-f50e2ce4cef8.png)

（これは画像ですので、 https://spring.io/quickstart からコピペしてください）

## 手順3. Run

あとは動かすだけです。
今回は[Docker](https://www.docker.com/)を使って動かしてみます。

プロジェクトのルートで以下のコマンドを実行します。

```bash
docker run \
       --rm \
       --mount type=bind,src=$(pwd),dst=/app \
       -w /app \
       -p 8080:8080 \
       amazoncorretto:20.0.2 \
       /app/gradlew bootRun
```

イメージが[amazoncorretto](https://hub.docker.com/_/amazoncorretto)なのは、[java](https://hub.docker.com/_/java)イメージがDEPRECATEDでして、[openjdk](https://hub.docker.com/_/openjdk/)イメージもDEPRECATEDでして、それでDEPRECATEDではないイメージとしてたどりついたのが[amazoncorretto](https://hub.docker.com/_/amazoncorretto)でしたというわけです。


少し待って、 http://localhost:8080/hello にアクセスしてみます。

![スクリーンショット 2023-09-05 16.08.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f737d26a-0055-e4f9-79e1-4fc475634695.png)

やったね:tada::tada::tada:
`Hello World`ができました。

クエリパラメータで値を指定すると表示される内容が変わります。
http://localhost:8080/hello?name=Awesome

![スクリーンショット 2023-09-05 16.10.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4463c4e9-cf68-b869-f049-7ca704eceb1a.png)

**Awesome!!!**


# さいごに

この記事では、[Spring](https://spring.io/)で`Hello World`を[Docker](https://www.docker.com/)を使って動かすことを楽しみました。

[Spring](https://spring.io/)についてもっと詳しいことを学びたい方は、 https://spring.io/guides へと進んでください。

[Docker](https://www.docker.com/)について学びたい方は、公式ページを有志の方が日本語訳されている下記のページがよいでしょう。特に「[始め方 - Get started](https://docs.docker.jp/get-started/toc.html)」を一通りやってみるのがオススメです。2h〜4hくらいで終わるとおもいます。「コマンド(cdやls、mkdir、cp、mv等)は知っています。だけど[Docker](https://www.docker.com/)は初めてです」という大学生といっしょに読みながらハンズオンをしたときにだいたいそのくらいの時間で終わりました（私の教え方がいいのかも :interrobang: しれません :sweat_smile:）。

https://docs.docker.jp/

[Docker ドキュメント日本語化プロジェクト](https://docs.docker.jp/)

イメージ、コンテナ、ボリュームを自分の言葉で語れるようになると「**完全に理解した**（もちろん例の意味です。製品を利用をするためのチュートリアルを完了できたという意味。）」になれるとおもいます。


それではごいっしょに！
「いやぁ、[Qiita](https://qiita.com/)って本当にいいもんですね～。それではまたご一緒に投稿を楽しみましょう」

<iframe width="960" height="540" src="https://www.youtube.com/embed/TsYL6oN8SXs" title="水野晴郎さん　映画って本当にいいもんですね" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>


## 追伸

[チャレキャラ](https://challecara.org/)に参加のみなさん、がんばってください！
