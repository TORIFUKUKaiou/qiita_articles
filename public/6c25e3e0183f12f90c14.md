---
title: androidアプリにて、AdMobで以前はテスト広告を表示できていたはずなのだけれども、なにもしていないのにできなくなったよ〜　=> 解決したよ〜という話
tags:
  - Android
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-19T22:41:35+09:00'
id: 6c25e3e0183f12f90c14
organization_url_name: fukuokaex
slide: false
---
**少にして学べば、即ち壮にして為すことあり。壮にして学べば、即ち老いて衰えず。老いて学べば、即ち死して朽ちず**

Advent Calendar 2022 48日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

今日は、[android](https://developer.android.com/?hl=ja)アプリの話を書きます。

[AdMob](https://firebase.google.com/docs/admob?hl=ja)で、以前は[テスト広告](https://developers.google.com/admob/android/test-ads?hl=ja)を表示することができていたけれども、できなくなったよ〜　=> 解決したよ〜という話です。
たぶん、`app-ads.txt`の書き換えでうまくいくとおもいます。
もちろん同じ現象、原因であれば :rocket::rocket::rocket:

# 事象、前提条件

事象、前提条件を書きます。

## エラー内容

こんな感じのエラーを吐いていました。

```json
    {
      "Code": 3,
      "Message": "No ad config.",
      "Domain": "com.google.android.gms.ads",
      "Cause": "null",
      "Response Info": {
        "Response ID": "null",
        "Mediation Adapter Class Name": "",
        "Adapter Responses": []
      }
    }
```

以下のようなコードがあったとして、`adError`と`adError.toString()`した感じです。

```java
mAdView.setAdListener(new AdListener() {
    @Override
    public void onAdFailedToLoad(LoadAdError adError) {
        // Code to be executed when an ad request fails.
    }
```

## app-ads.txt

事前に、`app-ads.txt`を設置していました。
[AdMob](https://firebase.google.com/docs/admob?hl=ja)の管理コンソールのほうで設定するようにいわれたから指示にしたがって設置をしていました。
管理コンソールにて、[アプリ] > [すべてのアプリを表示] > `app-ads.txt` タブでたどり着けます。
**設定方法**をクリックすると、以下のような案内が表示されます。

![スクリーンショット 2022-02-19 18.17.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4d0e13c8-497e-bffd-1053-55b6c5ae5886.png)



なんだかよくわかりませんが、言われた通りに一行だけ書いた`app-ads.txt`ファイルをつくりました。
なにかしらサーバにおけばいいので、私は[Firebase Hosting](https://firebase.google.com/docs/hosting?hl=ja)を使っておいていました。

**言われた通りに一行だけ書いた`app-ads.txt`ファイルをおいていた**
どうもこれが原因のようです。

# 解決策

どうやってたどり着いたのかは忘れましたが、`app-ads.txt`ファイルにもう一行書いたほうがいいよ〜　という書き込みを見つけました。

https://github.com/googleads/googleads-mobile-flutter/issues/59#issuecomment-919726101

![スクリーンショット 2022-02-19 18.22.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ad1edb70-feee-f57a-9ca7-3595c82bc834.png)

私はこれで解決しました:tada::tada::tada:
**Thanks a lot!!! です。**
<font color="purple">$\huge{アリガトウゴザイマス}$</font>

---
以下、設定方法が書いてあるページの紹介です。

https://developers.google.com/admob/android/test-ads?hl=ja

上記のページに書いてある`google.com, pub-3940256099942544, DIRECT, f08c47fec0942fa0`を、`app-ads.txt`ファイルに書き足して設置し直したたところ解決しました。

設置して、すぐに解決したわけではなく、６時間くらいかかったようにおもいます。
このへんは、`app-ads.txt`の設定方法に書いてあるとおり、24時間はかかるようです。
6時間で解決してラッキーでした。
私は幸運の持ち主です。
運がいいんです。
[とっても!ラッキーマン](https://ja.wikipedia.org/wiki/%E3%81%A8%E3%81%A3%E3%81%A6%E3%82%82!%E3%83%A9%E3%83%83%E3%82%AD%E3%83%BC%E3%83%9E%E3%83%B3)です。

> AdMob によるお客様の app-ads.txt ファイルのクロールおよび確認が完了するまで、少なくとも 24 時間お待ちください。



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:


[android](https://developer.android.com/?hl=ja)アプリにて使っている[AdMob](https://firebase.google.com/docs/admob?hl=ja)で、以前は[テスト広告](https://developers.google.com/admob/android/test-ads?hl=ja)を表示できていたはずなのだけれども、なにもしていないのにできなくなったよ〜　=> 解決したよ〜という話を書きました。

久しぶりにJavaを触りました。

---
