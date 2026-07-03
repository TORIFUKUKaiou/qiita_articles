---
title: 'NervesJP #14 新年LT回 で話したこと (Elixir)'
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
private: false
updated_at: '2021-01-15T00:46:48+09:00'
id: e3c95c58effa4ece1a46
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- 2021/01/09(土) 18:00〜 「[NervesJP #14 新年LT回](https://nerves-jp.connpass.com/event/199455/)」が開催されました
- そこで話したことをまとめておきます
- こういう感じの会です[^1]

![スクリーンショット 2021-01-11 21.48.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/741c75b2-e899-a908-2ab8-53ef4d774920.png)

[^1]: @piacerex さん主催のElixir DI = [Elixir Digitalization Implementors](https://fukuokaex.connpass.com/event/192867/)

# 動機
- @kentaro さんが資料を[アップ](https://nerves-jp.connpass.com/event/199455/presentation/)されていたので、私もやっておこうとおもいました

# 発表内容 :tada::tada::tada:
- start time: 19:07

## 自己紹介
- 名乗るほどのものではありませんが[torifukukaiou](https://twitter.com/torifukukaiou)こと[Awesome](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)と言います。

## Motivation
- Elixir is beautiful.
- Yes, I was born to love Elixir.

## [Nerves](https://www.nerves-project.org/)上級者:interrobang:向け

- **上級者**と当日は言っちゃいましたが、`export MIX_TARGET=rpi4 && mix firmware && mix upload`をやったことさえあれば上級者です
- ご本人([あんちぽ](https://qiita.com/kentaro)さん)のまえで`mix upload.hotswap` 🚀🚀🚀 を実演
    - @zacky1972 先生の「[mix_tasks_upload_hotswap の Hexライブラリ版を試す -- 結果](https://qiita.com/zacky1972/items/f0b47eded7c902008871#%E7%B5%90%E6%9E%9C)」にあるように、
    - ソースコードの変更内容をNervesアプリへ反映する時間を
    - `export MIX_TARGET=rpi4 && mix firmware && mix upload`とくらべて、`mix upload.hotswap`は**20秒以上短縮**してくれます:bangbang::bangbang::bangbang:
- 「[Phoenixのdevcontainer (Elixir)](https://qiita.com/torifukukaiou/items/636bb0a08d6a0b597a69)」というQiita記事を[Nerves](https://www.nerves-project.org/)アプリから書き換えるという出し物をしました
    - https://github.com/TORIFUKUKaiou/hello_nerves/blob/87c902b9dd553a9a63cc196acc70d359f65f0f42/lib/qiita/nerves_jp_lt_20210109.ex
    - 実は @takasehideki 先生は動いている様子をみるのは[はじめて](https://twitter.com/takasehideki/status/1347851305776078849)だったようで、実演してよかったです
- ご本人([あんちぽ](https://qiita.com/kentaro)さん)の解説記事「[`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側](https://qiita.com/kentaro/items/3fbf6a0e603adf64b235)」もご参照ください

## [Nerves](https://www.nerves-project.org/)初心者向け

- https://aht20.torifuku-kaiou.tokyo/aht20-dashboard
- [AHT20で温度湿度を取得して全世界に惜しげもなくあたい（値）を公開する(Elixir/Nerves/Phoenix)](https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347)
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: を画面共有しながら、[Nerves](https://www.nerves-project.org/)でIoTをはじめてみようかなあという方に向けて説明しました

### ハードウエア
- [Raspberry Pi 4GBモデル](https://www.seeedstudio.com/Raspberry-Pi-4-Computer-Model-B-4GB-p-4077.html)
- [Grove Base HAT for Raspberry Pi](https://wiki.seeedstudio.com/jp/Grove_Base_Hat_for_Raspberry_Pi/)
- [Grove AHT20 I2C (温湿度センサ)](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
- AC-DCアダプタ（Type-C, 5V3A）
- microSDカード（16 GB Class10)
- [Seeed株式会社](https://www.seeed.co.jp/)さんの製品を使うことで、
- [不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)な私でも、はめ込み式で簡単に工作を楽しめます 🚀🚀🚀 

![IMG_20210102_173324.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/96e4da17-99e2-8732-1048-cc21f04ee61a.jpeg)

### 開発環境構築
- ここは当日はしゃべっていませんが、どこからみればいいのかを書いておきます

#### 日本語
- なにはともあれ環境構築からなので
- @takasehideki 先生の「[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)」
- 最近はこちらの[devcontainer](https://code.visualstudio.com/docs/remote/containers)方式の「[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)」のほうがオススメかも :interrobang:
    - DockerとVisual Studio Codeでできちゃいます
- 環境構築ができたら、
    - @kentaro さんの[ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)
    - [Elixir School](https://elixirschool.com/en/)のhttps://elixirschool.com/ja/lessons/specifics/nerves/
        - `この和訳は最新です。`と表示されていることを確認して参照してください
        - 私と@takasehideki先生で最新版にしました
        - https://github.com/elixirschool/elixirschool/pull/2512
    - あたりがオススメです :rocket::rocket::rocket: 

#### 公式
- [Installation](https://hexdocs.pm/nerves/installation.html#content)
- [Getting Started](https://hexdocs.pm/nerves/getting-started.html#content)

# Wrapping Up 🎍🎍🎍🎍🎍
- We are the alchemists, my friends!
  - alchemists = Elixirの熟練者
- end time: 19:14
    - 7分しゃべってしまった。LTじゃないから:ok:とのことでした。
- Enjoy [Elixir](https://elixir-lang.org/)!!!
- 環境構築や[Elixir](https://elixir-lang.org/)のことでつまったら、ぜひ[NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)へおいでください！
    - 愉快なfolksたちがあなたの参加を歓迎します :bangbang::bangbang::bangbang:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)



