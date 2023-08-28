---
title: >-
  『プログラミングElixir』を買って、読んで、Qiitaに記事を書いていたら、ラズパイ4をもらったり、自分が書いた原稿が雑誌に載ったり、机をもらったり、YouTubeに出してもらえたりしました
tags:
  - Elixir
  - Qiitaエンジニアフェスタ_技術書
private: false
updated_at: '2021-08-07T22:48:41+09:00'
id: 8495f93c4bf18c3b9d97
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/d409f91fc8b9b44cefb4

# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- この記事は、「[今まで買ってよかった技術書を紹介しよう！](https://qiita.com/official-events/d409f91fc8b9b44cefb4)」という[Qiitaエンジニアフェスタ2021](https://qiita.com/official-campaigns/engineer-festa/2021)の中の1つのテーマに応募した記事です
- 私がオススメする技術書は、「[プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)」です


# Elixirプログラム例
- まずは[Elixir](https://elixir-lang.org/)をまだ書いたことがない方のために、[Elixir](https://elixir-lang.org/)のプログラム例を示します

```elixir:hello.exs
Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.2"}
])

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> HTTPoison.get!()
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& &1["title"])
|> IO.inspect()

```

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)はパイプ演算子と呼ばれるもので、前の計算結果が次の関数の第一引数に入ります
- 私はこれを美しいとおもいまして、[Elixir](https://elixir-lang.org/)を好きな人たちはおおむね[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を好意的にとらえているようです
- これで通じる方もいれば、通じない方もいらっしゃるとおもいます
- 私の感じ方なので押し付けるつもりはありません
- きちんとした説明が欲しい方は、@zacky1972先生の「[大学でElixirを教えた話](https://qiita.com/zacky1972/items/0c2869f9f39f7bb917a5)」をご参照ください
    - コメントの議論はとても有益です

## Run
- イゴかすには、[Elixir](https://elixir-lang.org/) 1.12以上をお使いください

```
$ elixir hello.exs
```

- 初回はライブラリのインストールやらコンパイルやらで少し時間がかかります
- 実行すると[Elixir](https://elixir-lang.org/)タグのついたQiita記事のうち最新の20件のタイトル一覧が出力されます


# プログラミングElixir :book: 
- とにかく、[Elixir](https://elixir-lang.org/)でプログラミングするのが楽しいものだと感じた私は『プログラミングElixir』にて学習を進めました
    - 私が最初に手にしたのは第1版でした
    - その後、第2版がでたので第2版も所有しています
    - 第2版が対象にしている[Elixir](https://elixir-lang.org/)のバージョンは`1.6`です
    - 2021-08-07現在、最新の[Elixir](https://elixir-lang.org/)のバージョンは`1.12`です
    - バージョンにはずいぶん開きはありますが、本質的なところはかわってないとおもいますし、[Elixir](https://elixir-lang.org/)をいいなとおもった人をますます好きにしてくれる良書です
- この本によりますます[Elixir](https://elixir-lang.org/)を好きになりました 
- 学習したことは発信したくなりました
- 『プログラミングElixir』📖に出会うまで私にとって、[Qiita](https://qiita.com/)は見るもの、読むものでした
- 私のまわりの[Elixir](https://elixir-lang.org/)に詳しい方たちが[Qiita](https://qiita.com/)にアウトプットしていたので、私が書いたっていいんじゃないかとおもってアウトプットするようになりました
- そうこうしているうちにいろいろモノをいただいたりしました
- <font color="purple">$\huge{ありがとうございます！}$</font>

## いただいたモノ
- 2020.12 Raspberry Pi 4 + 温度・湿度センサーなどいろいろ部品
    - [IoT ALGYAN 豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)にて講師側で活動
    - [グラフうねうね (動かし方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/3926fe3740e229594c8f)
- 2021.01 FLEXISPOT スタンディングデスク 電動式 昇降デスク ＆ 天板
    - [日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)
- 2021.07 SORACOMノベルティ詰め合わせ
    - [ソラコム主催 ラズパイコンテスト 参加賞]((https://twitter.com/torifukukaiou/status/1416757292221960192))

## 受賞
- 『プログラミングElixir』📖を買って読む前には賞なんてもらったことはありませんでした
- 2021.01 [#Qiitaアドカレ 日本マイクロソフト賞 5 名 (Azure x Python, Cloud Native) -- マイクロソフト賞 ④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)
- 2021.07 [ソラコム主催 ラズパイコンテスト 参加賞](https://twitter.com/torifukukaiou/status/1416757292221960192)

## 名乗るほどのものでもない名前を載せてもらいました
- [Elixir](https://elixir-lang.org/)本体へのプルリクが採用されました :tada::tada::tada:
    - https://github.com/elixir-lang/elixir/commit/877ebd2e129fe2a469a363a8575edbb7400f3dda
- [Interface 2021年1月号 「IoT向きモダン言語 Elixirの研究」](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)
    - @takasehideki 先生との共著です

## 異名をいただきました
- [歌うアルケミスト 🎤](https://twitter.com/piacere_ex/status/1334656415357538304)
- [Advent Calendar芸人](https://qiita.com/takasehideki/items/198b5f6425890c181eaf#advent-calendar)

## マイクロソフトさんのYouTubeチャンネル「くらでべ」に出していただきました :tada::tada::tada: 
- [Elixir と Azure の愛を語る！](https://www.youtube.com/watch?v=R3o8vR1A9ao):video_camera:
    - 私が考える[Elixir](https://elixir-lang.org/)のよさを話しました
    - マイクロソフト様にはすべて採用していただけました
        - ありがとうございます！
    - お時間ありましたらご覧になってください


## Elixirの純粋なもくもく会[autoracex](https://autoracex.connpass.com/)を立ち上げました
- https://autoracex.connpass.com/
- これは自分でやりはじめたことですが、[プログラミングElixir](https://www.ohmsha.co.jp/book/9784274226373/):book: を買っていなかったら、コミュニティを立ち上げるということはなかったでしょう
- あなたのご参加をお待ちしています :tada: 



# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- 今まで買ってよかった技術書は「[プログラミングElixir](https://www.ohmsha.co.jp/book/9784274226373/):book:」です
- この本のおかげで[Elixir](https://elixir-lang.org/)をますます好きになりました
- 好きという気持ちを抑えられず、あふれるおもいは[Qiita](https://qiita.com/)にアウトプットを行うようになりました
    - 場を提供し続けていらっしゃる[Increments](https://increments.co.jp/)さんに感謝です！
- そうするといろいろな方との交流がうまれました
- 結果としてモノや思い出が増えました
- 繰り返しになりますが、私にとって今まで買ってよかった技術書は「[プログラミングElixir](https://www.ohmsha.co.jp/book/9784274226373/):book:」です
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:  

## さいごに
- もし[Elixir](https://elixir-lang.org/)に興味をもっていただいて、コミュニティを探していらっしゃいましたら、以下のSlackをご紹介しておきます
- あなたのご参加を楽しみにしています :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5: 
    - [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)
    - [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)


