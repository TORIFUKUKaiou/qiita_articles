---
title: git commit --allow-empty -m "empty commit"
tags:
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-28T23:04:02+09:00'
id: 552a5ac98ff42de8c019
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
何も変更をしていないけれども、コミットをしたいことありますよね！
私はあります。
PaaS（Platform as a Service）のアレをナニするときですよ。
これ以上は言いますまい。

```
git commit --allow-empty -m "empty commit"
```

これです。



# ヘルプ

`--allow-empty`とはどういう意味なのかを調べてみます。

```
git help commit
```

上記のコマンドを実行して出てきたヘルプの中から、`--allow-empty`を抜粋しておきます。

```
--allow-empty
  Usually recording a commit that has the exact same tree as its sole parent commit is a mistake, and the
  command prevents you from making such a commit. This option bypasses the safety, and is primarily for use
  by foreign SCM interface scripts.
```

# 記事にした背景

```
git commit --allow-empty -m "empty commit"
```

上記を私は覚えられません。
アウトプットをすることで脳が大事なことだと記憶してくれるんです。

[elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)というSlackワークスペースの`#autoracex`というチャンネルで、以前の私の書き込みが役に立ったよ〜　という方がいらっしゃっいました。

![スクリーンショット 2022-02-28 22.55.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e9a81ac0-e32c-7564-81ca-8f02ccbb5215.png)

それで他の方の役に立つことがあるかもしれないとおもいまして、記事にしておきました。

自分自身の記憶のためと、まだ知らないあなたのために書いています。
つまりは
<font color="purple">$\huge{愛💜}$</font>
です。

# この記事は


Advent Calendar 2022 58日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

次回もお楽しみに〜。


**花の色はうつりにけりないたづらにわが身世にふるながめせしまに**
