---
title: delikaのSign upをして、ダミーデータQiitadelikaDummyでクエリ実行する
tags:
  - delika
  - 40代駆け出しエンジニア
  - AdventCalendar2022
  - Qiitadelika
private: false
updated_at: '2022-03-22T19:46:48+09:00'
id: 8d59f139eb60ce881e8b
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/30be12dd14c0aad2c1c2

**心あてに折らばや折らむ初霜の置きまどはせる白菊の花**

Advent Calendar 2022 79日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」と銘打たれたイベントが開催中です。

この記事は、 **テーマ１　『delikaを使った記事を書こう！』** の参加記事です。
なにはともあれ、まずは[delika](https://delika.io/)を使ってみます。

@kaizen_nagoya さんの「[『delikaを使った記事を書こう！』としたら（１日目）](https://qiita.com/kaizen_nagoya/items/4e7f3873dd13e7ce3b26)」に続きます。

# What's [delika](https://delika.io/)?

> 「delika」は、オープンデータやビジネスデータを組み合わせることで、価値創出を実現するデータ共有プラットフォームです。あらゆる業種業界の企業において DX（デジタルトランスフォーメーション）が喫緊の課題となる中、 DX 実現に向けた重要な要素である、データ活用を支援しています。

とのことです。

https://delika.connecto-data.com/

トップページに動画があります。

<iframe width="853" height="480" src="https://www.youtube.com/embed/7KjA3Qmoq-Q" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


ぜひみてみましょう！

# さっそくつかってみよう ーー Sign up

https://delika.io/
にアクセスして右上の`Sign up`から、Sign upしましょう。

私は、GitHubアカウントと連携しました。
メールアドレスによる認証と電話番号(SMS）によるコードの確認がありました。

# ダミーデータ

「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」のイベントページにダミーデータが紹介されています。

[QiitadelikaDummy](https://delika.io/qiita_delika_article_campaign)

https://delika.io/qiita_delika_article_campaign

このデータを使ってみましょう。

# [QiitadelikaDummy](https://delika.io/qiita_delika_article_campaign)

以下の3種類のデータが登録されています。

1. [articles.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/articles.csv)
1. [tags.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/tags.csv)
1. [article_tags.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/article_tags.csv)

上記にアクセスして、`Preview`タブをみると10件プレビューできます。
データをダウンロードできます。
ダウンロードしたデータを確認するともっとたくさんのデータが格納されていることがわかります。

ダウンロードすると、`.gz`で得られます。
私はmacOSを使っています。

```bash
gzip -d 6db07f12-bdff-42a3-986d-aed4a6cdcfbd.csv.gz
```

てな具合に解凍をして、`.csv`ファイルを得られます。
以下、[tags.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/tags.csv)の一部です。

![スクリーンショット 2022-03-21 15.10.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/bcb137bc-1377-ef47-8c98-7a0b49a7e71c.png)




## [QiitadelikaDummy](https://delika.io/qiita_delika_article_campaign)データについて

ArticleとTagが多対多の関係です。

![スクリーンショット 2022-03-21 15.01.23.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b90bfeef-3d69-17a2-069e-fa91d14b167f.png)

# クエリの実行

https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy

に、`Try it!`というボタンがあります。
迷わず押してみましょう！

ページが遷移して、今度は`Run Query`ボタンがあります。
これも迷わず押してみましょう！

```sql
SELECT
    *
FROM
    [qiita_delika_article_campaign/QiitadelikaDummy/articles.csv] AS a
JOIN    [qiita_delika_article_campaign/QiitadelikaDummy/article_tags.csv] AS at
ON  at.article_id = a.id
```

上記のSQLが実行できます。

少し待つと、`Query finished.`というメッセージが表示されます。
結果は、`Result`タブで確認できます。
`Result`タブでは10件のみ表示されています。

![スクリーンショット 2022-03-21 15.16.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/879281b8-3f04-7774-985c-cfedffec2739.png)

`.csv`のデータをSQLで操作できるのですね！
<font color="purple">$\huge{すごい！　すごい！}$</font>

もっと多くのデータが結果には含まれています。
`Get Download URL`ボタンを迷わず押してダウンロードしてみてください。

## [delikaSQL](https://docs.delika.io/sql/)

[delikaSQL](https://docs.delika.io/sql/)のドキュメントは以下にあります。

https://docs.delika.io/sql/

## よくわからなかったこと

上記のスクリーンショットの一番左端の`id`は`articles.id`のことです。
`id`が1からはじまっていません。
`.csv`をダウンロードしてみても、`id`が1の結果はありません。

クエリを変更せずにもう一度`Run Query`ボタンを押して実行してみます。

![スクリーンショット 2022-03-21 15.22.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b7154249-025e-dd8d-b273-b457ab7ca45c.png)

おっ！　今度は、`id`が1の結果があります！

だけれどもよくみると、今度は`id`が3の結果がありません。
`.csv`をダウンロードしてみても`id`が3の結果はありませんでした。

`Run Query`ボタンを何回か押してみたところ、最初の10件をなんとなくでしかみていませんが、2枚のスクリーンショットの結果のどちらかが表示されているように見えました。

SQLで使っている[articles.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/articles.csv)と[article_tags.csv](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy/article_tags.csv)のデータの内容が更新されていたりするのかなあ？　と想像しました。

という想像をして筆を止めます。

## ドキュメント

[delika Docs](https://docs.delika.io/) にドキュメントがあります。
この記事では紹介しきれませんでしたが、 [API](https://docs.delika.io/api/v1/) が用意されています。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

この記事では、 [delika](https://delika.io/) にサインナップをして、ダミーデータ[QiitadelikaDummy](https://delika.io/qiita_delika_article_campaign/QiitadelikaDummy)にて紹介されているクエリをそのまま実行してみました。

[delika](https://delika.io/)を楽しんでいきたいとおもいます！


以上です。


# 尚々書

「データの民主化」実現のため、私にできることを模索して行こうとおもいます。
「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」イベントに参加登録された記事を読ませていただいてステップアップしたいとおもいます。
良い記事に出会えることを楽しみにしています。

手前味噌な記事ではありますが、[delika](https://qiita.com/tags/delika)、[Qiitadelika](https://qiita.com/tags/qiitadelika)いずれかのタグがついた記事を集めて一覧表示しています。
どうぞご参考になさってください。

https://qiita.com/torifukukaiou/items/b10fa94764aaaa2c6db1

それでは！　またどこかでお会いしましょう！
お元気で！


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





