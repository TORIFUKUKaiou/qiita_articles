---
title: >-
  Build Slack bot on Nerves-powered Raspberry Pi using pure-Elixir HTTP server
  Bandit 
tags:
  - Elixir
  - Slack
  - Nerves
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:14:52+09:00'
id: 2209429851665d620f2e
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**主人は無理をいうなるものと知れ**

Advent Calendar 2022 7日目[^1]の記事です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今日は

https://nerves-jp.connpass.com/event/234191/

が開催されます。
出し物を用意しておきます。

# Building a Slack bot with a pure-Elixir HTTP server Bandit, Nerves firmware, and Raspberry Pi

[Bandit](https://github.com/mtrudel/bandit)を使ってSlackアプリを作ります。
Slackアプリは[Nerves](https://www.nerves-project.org/)の上で動かします。
[Nerves](https://www.nerves-project.org/)はRaspberry Piの上で動かします。

> Bandit is an HTTP server for Plug apps.

---

> Nerves is the open-source platform and infrastructure you need to build, deploy, and securely manage your fleet of IoT devices at speed and scale.


## Source code

https://github.com/TORIFUKUKaiou/hello_nerves_poncho

これっす。

4つコマンドをつくりました。

| コマンド | 働き |
|:-----------|:------------|
| /hello       | Hey there を返す        |
| /aht20-awesome      | 私の家の温度、湿度を返す(湿度は値が変。物理的に壊れてしまっているっぽい)        |
| /light-awesome 1 | LED ON !!!|
| /light-awesome 0 | LED OFF |




# どうやって外から家の中にあるRaspberry Piにつなげているの？

[ngrok](https://ngrok.com/)です。

> Spend more time programming. One command for an instant, secure URL to your localhost server through any NAT or firewall.

図にするとこんな感じです。


![スクリーンショット 2022-01-08 18.09.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a3db43c1-9a73-aa09-1f0a-5432cf723d03.png)

※ 各言語・フレームワークのロゴの権利はそれぞれの作成者に帰属しています

[ngrok](https://ngrok.com/)に払い出してもらったURLをSlackの設定画面に設定して、そこに[スラッシュコマンド](https://slack.com/intl/ja-jp/help/articles/201259356-Slack-%E3%81%AE%E3%82%B9%E3%83%A9%E3%83%83%E3%82%B7%E3%83%A5%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89)を送ってもらっています。

# どこで試せるの？

:::note warn
2022/01/07だけかなあ。
いつまでもパソコンの電源いれたままだとかあちゃんに怒られるので。
:::

[NervesJP](https://nerves-jp.connpass.com/)のSlackにある`#notification-awesome`チャンネルです。
[招待リンク](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)

[NervesJP](https://nerves-jp.connpass.com/)では、[Elixir](https://elixir-lang.org/)や[Nerves](https://www.nerves-project.org/)、IoTが好きな愉快なfolksたちがあなたの訪れを待っています。

I hope someday you'll join us.
[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)

| コマンド | 働き |
|:-----------|:------------|
| /hello       | Hey there を返す        |
| /aht20-awesome      | 私の家の温度、湿度を返す(湿度は値が変。物理的に壊れてしまっているっぽい)        |
| /light-awesome 1 | LED ON !!!|
| /light-awesome 0 | LED OFF |

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:


<font color="purple">$\huge{All\ your\ codebase\ are\ belong\ to\ us.}$</font>

2022年に流行る技術予想 ーー それは、[Nerves](https://www.nerves-project.org/)と[Zig](https://ziglang.org/)です:rocket::rocket::rocket:
