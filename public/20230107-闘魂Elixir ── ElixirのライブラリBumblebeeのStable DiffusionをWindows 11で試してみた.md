---
title: 闘魂Elixir ── ElixirのライブラリBumblebeeのStable DiffusionをWindows 11で試してみた
tags:
  - Elixir
  - bumblebee
  - AdventCalendar2023
  - StableDiffusion
  - 闘魂
private: false
updated_at: '2023-01-07T13:48:38+09:00'
id: 3604c3d2ee2092087ba2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>


# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、 @the_haigo さんの「[ElixirのライブラリBumblebeeのStable DiffusionをM1 Macで試してみた](https://qiita.com/the_haigo/items/cbec41b5d1fd0db76ba4)」のリスペクト記事です。

https://qiita.com/the_haigo/items/cbec41b5d1fd0db76ba4

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# @mnishiguchi さんがうらやましかった

@mnishiguchi さんが楽しそうに取り組まれていました。
私も自分でやってみたくなりました。

以下、 @mnishiguchi の呪文と作品の数々をご紹介します。

## ディズニーの新作アニメ風の猪木さん

![スクリーンショット 2023-01-07 12.33.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/14566339-953e-9949-7a35-2ea6ed45e134.png)

## 古いディズニーアニメ風の猪木さん

![スクリーンショット 2023-01-07 12.33.03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8aab1e3a-5dc9-19a0-b8cf-1b0056d66305.png)

## 力道山先生、いやもしかしたらマス大山先生風の猪木さん

コンクリートに3000回打ち込んでようやく完成した空手チョップに込められた、猪木さんの師匠力道山先生の怒りがよく表現されています。
そしてこころなしかマス大山先生の雰囲気も感じます。

![スクリーンショット 2023-01-07 12.33.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2373087b-b7a4-7d0c-20a1-4a3e5f687693.png)


## 若い頃のスペース・ローン・ウルフ武藤敬司選手風!? の猪木さん

呪文に `fukuoka` があってもしかしたら、[猪木ファイナルカウントダウン 1stのアントニオ猪木 vs グレート・ムタ in 福岡ドーム](https://njpwworld.com/p/s_series_00127_1_1)が反映されているように私には見えました。
グレート・ムタ選手と武藤敬司選手は別人なのでこの説明はおかしいのかもしれません。

![スクリーンショット 2023-01-07 12.33.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ac6cf90f-65d3-67ff-1fc7-1393d88345e5.png)



# 手持ちのマシンではなかなか動かなかった

私も動かしてみたかったのですがなかなか動きませんでした。
メモリがけっこう必要です。マシンの中で他に何を動かしているか次第で変わってきますが、最低32GBは欲しいです。8GBのマシンは話になりません。

うごかなかったマシン一覧です。

- iMac 21.5-inc, Late 2012 メモリ 8GB: macOS CatalinaにElixirをインストールして動かしました。学習は終わるのですが、画像作成時にかならずメモリ不足で失敗します。
- [Time4VPS](https://www.time4vps.com/)のメモリ 8GBの[Linux 8](https://www.time4vps.com/linux-vps/)プラン: Ubuntu 22.04にElixirをインストールして動かしました。学習は終わるのですが、画像作成時にかならずメモリ不足で失敗します。
- Windows 11 メモリ 16GB: Ubuntu 20.04(wsl2)にElixirをインストールして動かしました。学習は終わるのですが、画像作成時にかならずメモリ不足で失敗します。余計なアプリを動かないようにしたりすればなんとかなるかもしれません。16GBは怪しいラインです。

## エラーログ


失敗したときのログです。
**Out of memory allocationg 4829686912 bytes.**

数字は変わることがあるでしょうから、数字を抜いたキーワードも記事に含めておきます。
**Out of memory allocationg bytes.**

![スクリーンショット 2022-12-28 21.57.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0dfab28e-02de-5564-1fc7-28f09589aa41.png)





# 私の手元で動いたコンピュータ ーー メモリ32GBのWindows 11

wsl2でUbuntu 22.04を動かしました。

以下のようにして環境構築しました。

1. [WSL を使用して Windows に Linux をインストールする](https://learn.microsoft.com/ja-jp/windows/wsl/install): PowerShellを管理者モードで`wsl --install`
1. Ubuntu 22.04が立ち上がったら、 @t-yamanashi さんの記事「[OS（Ubuntu 22.04）のインストールから初める仕事用Elixir開発環境の作成方法](https://qiita.com/t-yamanashi/items/9cb46beed0506edf26c6#elixir%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)」を参考にして[asdf](https://asdf-vm.com/)でErlangと[Elixir](https://elixir-lang.org/)をインストールしました。バージョンはErlangが`25.2`、[Elixir](https://elixir-lang.org/)が`1.14.2-otp-25`をインストールしました
1. あとは、「[ElixirのライブラリBumblebeeのStable DiffusionをM1 Macで試してみた](https://qiita.com/the_haigo/items/cbec41b5d1fd0db76ba4)」の通り動かしてみました
1. 呪文は、@mnishiguchiの成果を参考にしました

タスクマネージャーでメモリの使用量をなんとなく見ていたところ、Livebookを動かす前が8GBで、画像作成時は最大で24GBくらい使用していました。


# 作品

AIに作ってもらったジブリ風猪木さんです。

![スクリーンショット 2023-01-07 12.56.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a0863a6d-6bdd-4b60-b9aa-945d199bd536.png)




---

# さいごに

この記事では、「[ElixirのライブラリBumblebeeのStable DiffusionをM1 Macで試してみた](https://qiita.com/the_haigo/items/cbec41b5d1fd0db76ba4)」をWindows 11で動かしてみました。
メモリは32GBはあると安心です。あればあるほどいいです。大きさこそ正義です。

私はひとつの試みをしてみました。お気づきでしたでしょうか。AIが描いた絵がどうしてそうなったのかを一言コメントしてみたわけです。
人間が描いた絵画の評論家がいるようにAIが描いた絵の評論をする専門家が必要とされる時代が来るかもしれません。どうしてAIはこういう絵を描いたのかという説明ができる人です。
私はその走りかもしれません。私がものを知らないだけですでに権威者がいらっしゃるのかもしれません。
ただし、私の場合は**闘魂**と**猪木さん**というごく狭い領域の専門家です。 **闘魂評論家** です。

本記事を作成するにあたり、 @the_haigo さんを筆頭に、 @mnishiguchi さん、@t-yamanashi さんに助けていただきました。
また @RyoWakabayashi さんにはメモリについてのアドバイスをいただきました。
この場をお借りして御礼申し上げます。


**闘魂**とは、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダァー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

https://qiita.com/torifukukaiou/items/b6361f98194f3687a13c

https://qiita.com/torifukukaiou/items/4c35ace6db3f02ac3897

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

https://qiita.com/torifukukaiou/items/44db8a4997812518730a




---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
