---
title: 闘魂Elixir ── Vonage APIのSMS送信をElixirで使ってみることを楽しむ
tags:
  - Elixir
  - Vonage
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-29T23:57:24+09:00'
id: 3acf47962820d840aedc
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir

:::note info
今年2023年アドベントカレンダーにおいて27記事目の記事です :tada::tada::tada::tada::tada::tada: 
:::

**完走してからが本当の闘いです。**
**さらに、もう一歩踏み出せました。**



# はじめに

「[【Vonage】コミュニケーションAPIを使ってみよう、Vonageのことなら何でも共有しよう！ by Vonage Advent Calendar 2023](https://qiita.com/advent-calendar/2023/vonage)」というイベントがあります。

https://qiita.com/advent-calendar/2023/vonage

SMS送信ならできそうなので、駆け込みで記事を書いてみました。

もちろん、私は[Elixir](https://elixir-lang.org/)を使います。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# アカウントを作ったらすぐにSMS送信ができました！

アカウントを作ったらすぐにSMS送信ができました！

## まずはcurlでSMSを送る

まずはcurlで試してみます。サンプルが書いてありました。


```bash
curl -X "POST" "https://rest.nexmo.com/sms/json" \
  -d "from=Vonage APIs" \
  -d "text=A text message sent using the Vonage SMS API" \
  -d "to=819012345678" \
  -d "api_key=api_key" \
  -d "api_secret=api_secret"
```

`to`は宛先の電話番号(日本の81からはじまっています)、`api_key`と`api_secret`は秘密です。これらは仮の値を上記に掲載しております。

管理画面ですでに払い出されているものを使います。**そのまま実行するとSMSが届きました！** 1回送ると約€0.08を消費するようです。`€`て何だ？　と私はなりました。どうやらユーロのことのようです。

## 次に[Elixir](https://elixir-lang.org/)でSMSを送る

[Req](https://hexdocs.pm/req/Req.html#content)を使って送ってみます。このcurlの形式はなんでも`application/x-www-form-urlencoded`というものらしいです。[Req](https://hexdocs.pm/req/Req.html#content)でどうやって書くのだ？　とドキュメントを眺めておりましたところ、きっとこれだとあたりをつけました。

```elixir
iex> {:ok, resp} = Req.post("https://httpbin.org/anything", form: [x: 1])
iex> resp.body["form"]
%{"x" => "1"}
```

果たして、ビンゴでした！！！
curlの実行例を[Req](https://hexdocs.pm/req/Req.html#content)に置き換えてみます。一応、`text`だけ区別がつくように`Req`という文字列を追加しておきました。

```elixir
Mix.install([
  {:req, "~> 0.4.0"}
])

form = [from: "Vonage APIs",
        text: "text=A text message sent using the Vonage SMS API, Req",
        to: "819012345678",
        api_key: "api_key",
        api_secret: "api_secret"]

Req.post("https://rest.nexmo.com/sms/json", form: form)
```

SMSが届きました:tada::tada::tada:

また約€0.08を消費しました。

# その他に気付いたこと

その他に気づいたことというか思い出を書いておきます。

## アカウント作成のときのパズルの意味がわからなかった！

![スクリーンショット 2023-12-25 21.25.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/457f17f0-bb2c-29b3-d49b-6b5781b3b7d3.png)

これ正解の図です。緑◯を車の絵と一番離れたところにある緑の線の終端にもっていくと正解です。
言葉で書くとさっぱりわかりませんね。

# はじめから€2.00をもらえました！

はじめから€2.00をもらえました！　ありがとうーーーーッ！！！ございます。素敵なクリスマスプレゼントをありがとうーーーーッ！！！でございます。 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 

![スクリーンショット 2023-12-25 22.03.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/39e668bf-06d9-ce15-976f-08ebd1b5af85.png)



# さらにクーポン適用で、€10.0もらえました！

https://qiita.com/advent-calendar/2023/vonage

このページに書いてある`23QTAVDR`で€10.0を追加でいただきました！
ありがとうーーーーッ！！！　ございます。マヂ、クリスマスプレゼントありがとうございます！　:santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 

# SMSを1回送ると約€0.08を消費しました

クーポンで€10.0を加算したので、最初に€12.0持っていました。

curlコマンドで一回送ったあとの残高です。管理画面のわかりやすいところというかトップ画面ですぐに見みることができます。

![スクリーンショット 2023-12-25 21.33.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/49516cbd-50f7-5428-f931-0513c8100c75.png)

[Elixir](https://elixir-lang.org/)で2通目を送ったときの様子です。

![スクリーンショット 2023-12-25 21.43.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8d64266f-c536-8003-0bbb-a1d25781a520.png)

一発で送信成功できてよかったです:tada::tada::tada:



# さいごに

[Vonage API](https://developer.vonage.com/ja/home)のSMS送信を[Elixir](https://elixir-lang.org/)で楽しみました。
クーポンという名の素敵なクリスマスプレゼント :christmas_tree::gift::christmas_tree:  、マヂありがとうございます！！！ :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 


他にもいろいろとAPIはあるようですし、本丸はVideo APIのようです。
また後日触ってみて記事なりあげたいとおもいます（あくまでも**おもっています**）。

![スクリーンショット 2023-12-25 22.17.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/069abfa4-3176-7864-01a4-2e3ea54539f2.png)



---

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

アドベントカレンダー2023はそろそろ幕を閉じ、**アドベントカレンダー2024**がもうすぐ開幕です！ :rocket::rocket::rocket:

![スクリーンショット 2023-12-25 23.37.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ff7d8496-820a-e635-462c-c1a0563ce774.png)







---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
