---
title: 'よげんの書 ── SORACOM UG x NervesJP #1 ~Hello, world!~ レポート'
tags:
  - Elixir
  - ポエム
  - SORACOM
  - Nerves
  - autoracex
private: false
updated_at: '2021-12-15T07:01:22+09:00'
id: bfb827fd97c70e89c427
organization_url_name: null
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/15(水)の回です。



# プロローグ

　この記事は、「よげんの書」である。2021年12月14日(火) 19:30〜開催の「[SORACOM UG x NervesJP #1 ~Hello, world!~](https://soracomug-tokyo.connpass.com/event/231532/)」イベントの予定である。投稿日を見てほしい。イベントの開催日よりも前に書いている。更新もイベントの前に済ませてある。


# はじめに

[Elixir](https://elixir-lang.org/)楽しんでいますか :bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)楽しんでいますか :bangbang::bangbang::bangbang:

https://soracomug-tokyo.connpass.com/event/231532/

[SORACOM UG](https://soracomug-tokyo.connpass.com/)と[NervesJP](https://nerves-jp.connpass.com/)のスペシャルコラボイベント第一弾イベントが、2021年12月14日(火) 19:30〜開催されました。
この記事はそのイベントの様子をレポートしたものです。
[NervesJP](https://nerves-jp.connpass.com/)側の視点が多い点はご容赦ください。
 
# イベント

## 19:30〜19:35 オープニング (SORACOM UG / NerversJP運営)

定刻通りにはじまりました。
グランドルールの案内に続いて、会の趣旨が説明されました。

> IoTやSORACOM、ElixirやNervesに興味がある方なら誰でも大歓迎です。業種、職種、ハードウェア、ソフトウェア、クラウドなど担当分野は問いません。SORACOMやNervesをまだ使っていなくても問題ありませんので、初参加大歓迎です。 お気軽にご参加ください。


## 19:35〜20:05 NervesJP枠

[NervesJP](https://nerves-jp.connpass.com/)からは、3名登壇しました。

### [高瀬先生](https://www.keisu.t.u-tokyo.ac.jp/2021/04/02/%E9%AB%98%E7%80%AC-%E8%8B%B1%E5%B8%8C/)

[高い並列性能と耐障害性を持つElixirとNervesでIoTの新しいカタチを切り拓く](https://www.keisu.t.u-tokyo.ac.jp/2021/04/02/%E9%AB%98%E7%80%AC-%E8%8B%B1%E5%B8%8C/)

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:の資料で、以下の説明をしてくださいました。

- [Elixir](https://elixir-lang.org/)とはなにか？
- [Elixir](https://elixir-lang.org/)がIoTのための言語である
- Webアプリケーションフレームワーク: [Phoenix](https://www.phoenixframework.org/)
- powered by ElixirなJupyter: [Livebook](https://github.com/livebook-dev/livebook)
- AIやるなら: [Nx](https://github.com/elixir-nx/nx)
- IoTを楽しむなら: [Nerves](https://www.nerves-project.org/)
- [Nerves](https://www.nerves-project.org/)は、**ナウでヤングでcoolなすごいヤツ**です

---

### (名乗るほどのものではございませんが) Awesome YAMAUCHI(@torifukukaiou)

https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d

https://qiita.com/torifukukaiou/items/3a77efc82c48dc0ff61e

上記の記事を使って次のことを説明しました。

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) パイプ演算子を使った気持ちいい、[AwesomeなElixirのプログラム例](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#qiita-api)
- [SORACOM Arc x Nerves](https://qiita.com/torifukukaiou/items/3a77efc82c48dc0ff61e)
    - できませんでした:sob::sob::sob: という内容でした
    - 後述しますが、参加者Xさんの助言により、なんとなんとイベント中に解決してしまいました :rocket:
- [Nerves Livebookからはじめてみませんか！？](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nerves%E3%81%AF%E3%81%98%E3%82%81%E3%81%A6%E3%81%BF%E3%82%8B)
- [Raspberry PiなどのデバイスなしでNervesをはじめられますとぅ〜〜〜:interrobang::interrobang::interrobang:](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#%E8%BF%BD%E8%A8%98)
- [れっつじょいなす NervesJP & アドベントカレンダー熱烈歓迎](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nervesjp)
- [We are the Alchemists, my friends!](https://www.youtube.com/watch?v=KXw8CRapg7k)
    - [Elixir](https://elixir-lang.org/)は、日本語に訳すと不老不死の霊薬です。
    - その[Elixir](https://elixir-lang.org/)と名付けられたプログラミング言語の使い手は、**Alchemist(錬金術師)**と尊称されます。


<details><summary>[AwesomeなElixirのプログラム例](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#qiita-api)</summary><div>

```elixir
Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

"https://qiita.com/api/v2/items?query=elixir"
|> HTTPoison.get!([], [timeout: 50_000, recv_timeout: 50_000])
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& Map.take(&1, ["title", "url"]))
|> IO.inspect()
```
</div></details>



---

### nishiuchikazumaさん

**オレオレハードで小水力発電所いごかしたよ！**

すごいパワーワードです。
「水力発電所のオープンソース化」!!!
パネルディスカッションにて自己紹介をされました。



## 20:05〜20:35 SORACOM UG枠

[SORACOM UG](https://soracomug-tokyo.connpass.com/)さんからは、[SORACOM](https://soracom.jp/)さんのサービスをいろいろと丁寧にわかりやすく解説していただきました:tada:
ありがとうございます！
[SORACOM Arc](https://soracom.jp/services/arc/)は、[Nerves](https://www.nerves-project.org/)との相性が良さそうです:rocket:

## 20:35～20:55 パネルディスカッション

Maxさんによるモデレートでパネルディスカッションが行われました。

[NervesJP](https://nerves-jp.connpass.com/)からはpojiro3さんがパネルディスカッションから参戦しました。
pojiro3は日本初? の[Nerves](https://www.nerves-project.org/)搭載プロダクト[Pocket LANcher](https://www.pocket-lancher.com/)を開発、販売されています。

@torifukukaiouが解決できなかった「[SORACOM Arc](https://soracom.jp/services/arc/) x [Nerves](https://www.nerves-project.org/)」は、参加者のXさんの助言によりイベント中になんとなんと解決できてしまいました:rocket::rocket::rocket:
みなさん、大興奮でした:tada:

[SORACOM](https://soracom.jp/) x [Nerves](https://www.nerves-project.org/)で、あんなことやこんなことをやると楽しそうだよね〜　というホビーユースから新しい製品、新しい産業の創出につながり得るたくさんのアイデアがでてきました。




## 20:55〜21:00 クロージング

大団円のフィナーレとなりました。
みんなでラインダンスを踊りました:two_women_holding_hands:

<iframe width="963" height="542" src="https://www.youtube.com/embed/2axs0_g1sIo" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>






# おわりに
- ぜひ第二弾、第三弾も継続して開催して欲しい、開催したいよねとの声が、参加者、登壇者双方から多数あがりました:+1::+1_tone1::+1_tone2::+1_tone3::+1_tone4::+1_tone5:
- [NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)にたくさんの方が参加してくださいました
- 若干の空きがあった[#NervesJP Advent Calendar 2021](https://qiita.com/advent-calendar/2021/nervesjp)が全日、埋まりました
- [Nerves](https://www.nerves-project.org/)は、[Elixir](https://elixir-lang.org/)でIoTを楽しめる**ナウでヤングでcoolなすごいヤツ**です。







# エピローグ

　2021年12月13日(月)以降は更新しないことにする。イベント本番後に記事を書き直してしまうと、**よげん**にならない。変更履歴で区別をつけられるというのはその通りだが、この記事を表示した時に表示されている**投稿日**と**更新日**の表記がイベント開催日時よりも前になっていることにこの記事の意味がある。

　イベント開催前にレポート（妄想）を書いてしまうという新たな試みであり、発明なのである。


<font color="purple">$\huge{思考は現実化する}$</font>
