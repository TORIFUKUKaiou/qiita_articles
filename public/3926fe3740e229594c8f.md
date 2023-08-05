---
title: グラフうねうね (動かし方 編) (Elixir/Phoenix)
tags:
  - Elixir
  - Phoenix
  - Nerves
private: false
updated_at: '2021-01-03T23:10:49+09:00'
id: 3926fe3740e229594c8f
organization_url_name: fukuokaex
slide: false
---
この記事は[#NervesJP Advent Calendar 2020](https://qiita.com/advent-calendar/2020/nervesjp) 15日目です。
前日は、@kentaro さんの「[『プログラミングElixir 第2版』を読んでいまこそElixirに入門しよう](https://kentarokuribayashi.com/journal/2020/12/14/programming-elixir-1-6-ja)」でした。
**ぜひ『プログラミングElixir 第2版』を読みましょう！！！**

---

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか！
- **[I was born to love Elixir](https://qiita.com/torifukukaiou/items/33e3471aaab6d863aecf) :microphone::microphone::microphone:**
    - [Nerves](https://www.nerves-project.org/)はロックだ! (by @kikuyuta 先生)
- [2020/12/27 【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/) 楽しみですね！
    - I can't wait until 12/27/2020.
    - [Seeed株式会社](https://www.seeed.co.jp/)様ありがとうございます！
- [nerves_jp_chart](https://github.com/NervesJP/nerves_jp_chart)の動かし方を説明します

---

# このハンズオンの中で、みんなでこんなグラフを描くことになっています

![b1743949-1e37-e027-aee6-796f95b52644.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c71136fa-8f7d-dedb-86c8-02a0c61d3fbd.png)

- アニメーションGifはイベント後にあげようとおもいます
- ハンズオンイベントが終わったあとにもみなさまの手元で動かしてもらいたいとおもっています
- 簡単(!?)に動かせるように、[Docker](https://www.docker.com/)を使った動かし方をご説明します

---

# [プログラミングElixir 第2版](https://www.ohmsha.co.jp/book/9784274226373/)

![EoohLj8VgAAvhTJ.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7639b01f-b093-d8d1-610b-37adda97026a.jpeg)

## 書評
- [1 = a (プログラミングElixir 第2版)](https://qiita.com/torifukukaiou/items/14ad8b9673bd47ce8b8f)

---

# 準備
- [Docker](https://www.docker.com/)をインストールしてください
    - `docker`コマンド、`docker-compose`コマンドが使えることを確認してください
    - @takasehideki 先生の「[ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8)」の通りに進めていただくとうま〜くインストールできます

# Run

## ローカルマシンで動かす

- Windows10な方はPowerShellにて、macOSな方はターミナルにてお願いします

```
> git clone https://github.com/NervesJP/nerves_jp_chart.git
> cd nerves_jp_chart
> cp .env.sample .env
> mkdir -p priv/static
> docker-compose build --build-arg NERVES_JP_CHART_HOST=localhost --build-arg NERVES_JP_CHART_PORT=4000
> docker-compose up
```

- http://localhost:4000/chart-sample をブラウザで開いてみてください
- グラフのうねうね(サンプル)がみえるはずです！

### [Elixir](https://elixir-lang.org/)でデータPost(データ打ち上げ)
- 詳しくはイベント当日に説明されます
    - 楽しみにお待ちください
    - 乞うご期待！
- 今度は http://localhost:4000/chart-temperature を開いておいてください
- [nerves_jp_chart](https://github.com/NervesJP/nerves_jp_chart)を動かしているマシンに割りあたっているIPアドレスを調べてください
    - ここでは`192.168.1.11`とします
- 別のマシン(まあ、同じマシンでもよいです)から[Elixir](https://elixir-lang.org/)のプログラムでデータPostしてみます

```elixir
time = Timex.now() |> Timex.to_unix()
json = Jason.encode!(%{value: %{name: "your-name", value: 25.123, time: time}})
HTTPoison.post "http://192.168.1.11:4000/temperatures", json, [{"Content-Type", "application/json"}]
```

- もし別のマシンからのPostがうまくいかない場合は以下をご確認ください
    - [nerves_jp_chart](https://github.com/NervesJP/nerves_jp_chart)を動かしているマシンと[Elixir](https://elixir-lang.org/)のプログラムを動かしているマシン(ハンズオンイベントではRaspberry Pi 4)が同じネットワークにいるか
    - アンチウイルスソフトが通信を拒絶していないか
        - Windows セキュリティはデフォルト設定で通信できました


## [Azure Container Instances](https://docs.microsoft.com/ja-jp/azure/container-instances/)で動かす
- [IoT ALGYAN](https://algyan.connpass.com/)は、[日本マイクロソフト株式会社](https://www.microsoft.com/ja-jp)様にもたいへんお世話になっているようですね
    - ありがとうございます！
- 手前味噌ですが、「[Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9)」を**いろいろ:sweat_smile:**読み替えていただくとできます！
    - [Docker イメージを構築](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9#docker-%E3%82%A4%E3%83%A1%E3%83%BC%E3%82%B8%E3%82%92%E6%A7%8B%E7%AF%89) からやっていただくとよいです


# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- [2020/12/27 【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)でまずはうまく動きますように :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- みなさん、手元で動きましたか〜？　|> イゴキましたよね！  
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:
- `We are the Alchemists, my friends!`
    - **不老不死の霊薬**という名前のプログラミング言語の[Elixir](https://elixir-lang.org/)熟練のものたちは**アルケミスト(錬金術師)**と呼ばれます
    - [Elixir](https://elixir-lang.org/)と[Nerves](https://www.nerves-project.org/)を同時に触った**あなた**は、あなたがそうおもった瞬間から**アルケミスト**なのです
    - :book: [アルケミスト　夢を旅した少年](https://www.amazon.co.jp/dp/B00DE5YZZO/)
    - 世界を驚かせましょう！ with [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
        - 愉快なfolksたちが大歓迎です :bangbang::bangbang::bangbang:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/46d4f5a0-864e-80ed-7a82-08306cc7e13f.png)

<font color="purple">$\huge{The　Show　Must　Go　On!!!}$</font>[^1]

Inside my heart is breaking
My makeup may be flaking
But my smile, still, stays on

My soul is painted like the wings of butterfly
Fairy tales of yesterday, grow but never die
I can fly, my friends


[^1]: [「ショウ・マスト・ゴー・オン」（The Show Must Go On）](https://ja.wikipedia.org/wiki/%E3%82%B7%E3%83%A7%E3%82%A6%E3%83%BB%E3%83%9E%E3%82%B9%E3%83%88%E3%83%BB%E3%82%B4%E3%83%BC%E3%83%BB%E3%82%AA%E3%83%B3)は、イギリスのロック・バンド、クイーンが1991年に発表した楽曲。エルトン・ジョン版の[YouTube動画](https://www.youtube.com/watch?v=MqesIQa_4xw&t=132)。

# [Phoenix](https://www.phoenixframework.org/)
- Webアプリケーション作ってみたいよ〜
- [グラフうねうね (作り方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/private/e3056efc3d2c62600fa2)
