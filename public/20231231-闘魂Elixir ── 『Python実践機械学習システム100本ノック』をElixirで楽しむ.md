---
title: 闘魂Elixir ── 『Python実践機械学習システム100本ノック』をElixirで楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-01-02T15:36:42+09:00'
id: 88a7683b7dea40df5028
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


[大晦日ハッカソン2023](https://omisoka-hackathon.connpass.com/event/304711/)の成果です。


# はじめに

『[Python実践機械学習システム100本ノック](https://www.shuwasystem.co.jp/book/9784798063416.html)』を[Elixir](https://elixir-lang.org/)で楽しんでみます。

会社の同僚がこの本で学んでいると聞いたので冬休みの宿題で私もやってみます。
100本中10本だけ進めました。

[Elixir](https://elixir-lang.org/)でもやってみたい衝動を抑えられませんでした。
[Elixir](https://elixir-lang.org/)でもやってみることでより理解が深まるだろうということでその記録を残しておきます。

![スクリーンショット 2023-12-31 17.08.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8169a91e-fd9d-ab1f-4318-33183e434922.png)



# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

---

# 準備

[Livebook](https://livebook.dev/)を使います。
[Docker](https://www.docker.com/ja-jp/)上で動かします。

[サポートページ](https://www.shuwasystem.co.jp/support/7980html/6341.html)の「MLSys_100Knocks.zip」をダウンロードし、展開します。
[Docker](https://www.docker.com/ja-jp/)コンテナからホスト（開発マシン)のファイルがみえるように次のコマンドで[Livebook](https://livebook.dev/)を起動します。

```bash
cd MLSys_100Knocks
docker run -p 8080:8080 -p 8081:8081 --pull always -u $(id -u):$(id -g) -v $(pwd):/data ghcr.io/livebook-dev/livebook
```

このコマンドは、[公式ページのDocker](https://github.com/livebook-dev/livebook?tab=readme-ov-file#docker)の項に書いてあるコマンドそのままです。

[Livebook](https://livebook.dev/)を使うと、こんな感じでプログラミングができます。

![スクリーンショット 2023-12-31 17.08.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8169a91e-fd9d-ab1f-4318-33183e434922.png)


# [Elixir](https://elixir-lang.org/)でプログラミング

「[Elixir](https://elixir-lang.org/) pandas」でググると、 @RyoWakabayashi さんの記事が見つかりました。
ありがとうーーーーッ！！！　ございます。私も~~パク~~リスペクトする感じです。

https://qiita.com/RyoWakabayashi/items/dfb5495b9c25eff710a2

[explorer](https://hex.pm/packages/explorer)を利用してみます。

以下、ノック10までの[Elixir](https://elixir-lang.org/)の例です。
何をやっているのかは、『[Python実践機械学習システム100本ノック](https://www.shuwasystem.co.jp/book/9784798063416.html)』をお買い求めのうえご確認ください。

```elixir
Mix.install([
  {:explorer, "~> 0.7.0"}
])
```

```elixir
require Explorer.DataFrame

current_dir = "/data/本章/1章"
file_path = fn file_name -> "#{current_dir}/#{file_name}" end

file_path.("output_data") |> File.mkdir_p!()
filename_order_data_csv = file_path.("output_data/order_data.csv") 
```

```elixir
m_store = file_path.("m_store.csv") |> Explorer.DataFrame.from_csv!()
m_area = file_path.("m_area.csv") |> Explorer.DataFrame.from_csv!()

files = File.ls!(current_dir)
|> Enum.filter(& String.contains?(&1, "tbl_order_"))
|> Enum.sort(:desc)

[haad_csv | _] = files
empty_df = file_path.(haad_csv) |> Explorer.DataFrame.from_csv!() 
|> Explorer.DataFrame.slice(0, 0)

files
|> Enum.reduce(empty_df, fn csv, acc ->
  df = file_path.(csv) |> Explorer.DataFrame.from_csv!()
  Explorer.DataFrame.concat_rows(acc, df)
end)
|> Explorer.DataFrame.filter(store_id != 999)
|> Explorer.DataFrame.join(m_store, on: [:store_id], how: :left)
|> Explorer.DataFrame.join(m_area, on: [:area_cd], how: :left)
|> Explorer.DataFrame.mutate(takeout_name: if(takeout_flag == 0, do: "デリバリー"))
|> Explorer.DataFrame.mutate(takeout_name: if(takeout_flag == 1, do: "お持ち帰り", else: takeout_name))
|> Explorer.DataFrame.mutate(status_name: if(status == 0, do: "受付"))
|> Explorer.DataFrame.mutate(status_name: if(status == 1, do: "お支払い済", else: status_name))
|> Explorer.DataFrame.mutate(status_name: if(status == 2, do: "お渡し済", else: status_name))
|> Explorer.DataFrame.mutate(status_name: if(status == 9, do: "キャンセル", else: status_name))
|> Explorer.DataFrame.to_csv(filename_order_data_csv)
```

[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)（パイプ演算子）が大活躍です。
こういうプログラムは、 [Elixir](https://elixir-lang.org/) が一番向いているようにおもいます。

[Explorer.DataFrame.mutate/2](https://hexdocs.pm/explorer/Explorer.DataFrame.html#mutate/2)の連発のところはもっと良い書き方があるかもしれません。
実はマクロのようで、無名関数を作って入れ込んでみたのですがうまく動きませんでした。もっとすっきり書くやり方がわかったら更新します。

`empty_df`のマッチで、`Explorer.DataFrame.slice(0, 0)`と書いているところももっと良い書き方があるかもしれません。

まあ、とにかくここで言いたいことは、 **データ変換はElixirが向いています** ということです。

---

# [大晦日ハッカソン2023](https://omisoka-hackathon.connpass.com/event/304711/)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hash&amp;ref_src=twsrc%5Etfw">#大晦日ハッカソン</a> まずは筋トレから。脳鍛。脳を鍛えるには運動しかない！　<a href="https://t.co/MW5Al4uVTS">https://t.co/MW5Al4uVTS</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1741290063143866737?ref_src=twsrc%5Etfw">December 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hash&amp;ref_src=twsrc%5Etfw">#大晦日ハッカソン</a> 『Python実践機械学習システム100本ノック』 1/100<br>千里の道も一歩から。「踏み出せばその一足が道となり　その一足が道となる　迷わず行けよ　行けばわかるさ　ありがとうーーーーッ！！！」<br><br>Google Colaboratoryでやっております。</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1741306099821912275?ref_src=twsrc%5Etfw">December 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hash&amp;ref_src=twsrc%5Etfw">#大晦日ハッカソン</a> 『Python実践機械学習システム100本ノック』 8/100。まずは10本までが一つの区切りのようです。9, 10を一旦眺めて、休憩に入ります。</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1741317503652175961?ref_src=twsrc%5Etfw">December 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hash&amp;ref_src=twsrc%5Etfw">#大晦日ハッカソン</a> 『Python実践機械学習システム100本ノック』 10/100。キリがいいので同じことをElixirでやってみます。</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1741327219849564250?ref_src=twsrc%5Etfw">December 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hash&amp;ref_src=twsrc%5Etfw">#大晦日ハッカソン</a> Qiita記事を書きました。 <a href="https://t.co/EVDnYfNcyY">https://t.co/EVDnYfNcyY</a> <br><br>あとは紅白をみます。よいお年を〜</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1741376335447286093?ref_src=twsrc%5Etfw">December 31, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



# さいごに

『[Python実践機械学習システム100本ノック](https://www.shuwasystem.co.jp/book/9784798063416.html)』を学んでいます。
まだ10%の進捗です。冬休みの宿題で学びを深めたいと思っています（あくまでも「思っています」）。

[Elixir](https://elixir-lang.org/)でも書いてみたい衝動を抑えられずに、書いてみました。
[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)（パイプ演算子）は最高でした。


---

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

アドベントカレンダー2023は幕を閉じ、**アドベントカレンダー2024**が開幕です:rocket::rocket::rocket:

![スクリーンショット 2023-12-25 23.37.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ff7d8496-820a-e635-462c-c1a0563ce774.png)







---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
