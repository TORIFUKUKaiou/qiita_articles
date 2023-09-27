---
title: 闘魂Elixir ーー Enum.reduceがあればなんでもできる！
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-03-23T19:21:19+09:00'
id: 01452b8dac5e82fbdd1b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

この記事は、2023/03/11(土)に行われる「[【オフライン開催！】fukuoka.ex#53 Elixir Lightning Talks!!](https://fukuokaex.connpass.com/event/272529/)」の発表(LT)資料です。

猪木さんの有名な言葉に「**元氣があればなんでもできる！**」があります。
これになぞらえて、
「[Enum.reduce](https://hexdocs.pm/elixir/Enum.html#reduce/3)があれば、[Enum](https://hexdocs.pm/elixir/Enum.html#reduce/3)はなんでもできます」を発表します。
[Elixir](https://elixir-lang.org/)をはじめたばかりの方は、まず[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールに慣れるとよいです。
[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールはよく使います。


```elixir
Mix.install [{:req, "~> 0.3.6"}]

"https://qiita.com/api/v2/items?query=tag:Elixir&per_page=100"
|> Req.get!()
|> Map.get(:body)
|> Enum.filter(fn %{"likes_count" => likes_count} -> likes_count > 1 end)
|> Enum.map(fn %{"title" => title, "user" => %{"id" => id}, "likes_count" => likes_count} -> {title, likes_count, id} end)
```

# 対象読者

- [Elixir](https://elixir-lang.org/)をはじめてみようかとはおもっているもののなかなか最初の一歩が踏み出せずに危ぶんでいる人
- [Elixir](https://elixir-lang.org/)をはじめたばかりの人

---

# 自己紹介

名乗るほどのものではございません。

## Twitter

https://twitter.com/torifukukaiou

## Qiita

https://qiita.com/torifukukaiou

[Elixir](https://qiita.com/tags/elixir)タグのユーザーランキング第2位。

![スクリーンショット 2023-03-07 21.48.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1b31cb91-446e-111a-fa7d-7815b89b8fad.png)

## 受賞歴

### [#Qiitaアドカレ 日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93) (2021/01/15)

https://www.youtube.com/watch?v=R3o8vR1A9ao

### [Qiita Advent Calendar 2022 Qiita賞個人部門完走賞](https://blog.qiita.com/adventcalendar-2022-qiitapresents-winners/) (2023/01/23)

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">アドベントカレンダーはハラショーだ！<br>これが本当のアドハラ<a href="https://twitter.com/hashtag/Qiita?src=hash&amp;ref_src=twsrc%5Etfw">#Qiita</a> <a href="https://twitter.com/hashtag/Qiita%E3%82%A2%E3%83%89%E3%82%AB%E3%83%AC?src=hash&amp;ref_src=twsrc%5Etfw">#Qiitaアドカレ</a> <a href="https://twitter.com/hashtag/autoracex?src=hash&amp;ref_src=twsrc%5Etfw">#autoracex</a> <a href="https://twitter.com/hashtag/%E9%97%98%E9%AD%82?src=hash&amp;ref_src=twsrc%5Etfw">#闘魂</a> <a href="https://t.co/71gyjOCPfT">pic.twitter.com/71gyjOCPfT</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1623469162378178561?ref_src=twsrc%5Etfw">February 8, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## GitHub

https://github.com/TORIFUKUKaiou

### [Elixir](https://elixir-lang.org/)への貢献



覚えていられれるくらい数が少ないという証左です。
[私の貢献](https://qiita.com/torifukukaiou/private/e7fd639b6da0292c1325)

https://qiita.com/torifukukaiou/private/e7fd639b6da0292c1325


Elixir本体、Phoenix、Nerves Livebook、Ecto

## 執筆

https://gihyo.jp/magazine/wdpress/archive/2022/vol127

## [闘魂Elixir](https://autoracex.connpass.com/)コミュニティ主催

https://autoracex.connpass.com/

every dayもくもく会。

[Elixirイベントカレンダー](https://elixir-jp-calendar.fly.dev/)

![スクリーンショット 2023-03-09 9.11.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f0c6d92f-73a3-cc47-04d5-bc2a04b903c6.png)

**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだとおもいます。**
ーー 他人と比べる必要はありません。自分のペースで、己の技術力を高めていきましょう！

北米、南米からの参加者もいらっしゃいます。

モットー: **We are the Alchemists, my friends!!!**
我々ハ錬金術師我ガ友ヨ

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">I have a hike for Elixir.<br>Elixir, ok?<br><br># In Japanese:<br><br>ワレワレハ<br>レンキンジュツシ<br>ワガトモヨ<br><br>我々は<br>錬金術師<br>我が友よ<br><br>Above are 5-7-5 style.<br><br>Whatcha got?<br><br>---<br># In English<br><br>We are<br>the Alchemists,<br>my friends!<br><br>Sorry in English version is not 5-7-5 style.</p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1487227180253810689?ref_src=twsrc%5Etfw">January 29, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

---

# [Elixir](https://elixir-lang.org/)っぽいプログラム例

[Qiita API v2](https://qiita.com/api/v2/docs)を利用させていただいて、[Elixir](https://elixir-lang.org/)に関する記事を取得してみます。

ここでは、[Docker](https://www.docker.com/)で動かす例を示します。

```
$ docker run --rm -it hexpm/elixir:1.14.3-erlang-25.2.3-ubuntu-jammy-20221130 iex
```

[hexpm/elixir](https://hub.docker.com/r/hexpm/elixir)は、[Elixir](https://elixir-lang.org/)のWebアプリケーションフレームワーク[Phoenix](https://www.phoenixframework.org/)の[ドキュメント](https://www.phoenixframework.org/)にもでてくる由緒正しきDockerイメージです。

上のコマンドを迷わず実行すると、IExと呼ばれるREPL（その場でプログラムを打ち込んで結果が返ってくるのを楽しめる便利な道具）が立ち上がります。
迷わず、[Elixir](https://elixir-lang.org/)のプログラムを打ち込んでいきます。

まず、[Req](https://hexdocs.pm/req/readme.html)というHTTPクライアントライブラリをインストールします。

```elixir
iex> Mix.install [{:req, "~> 0.3.6"}]
```

`Shall I install Hex? (if running non-interactively, use "mix local.hex --force") [Yn]`や`Shall I install rebar3? (if running non-interactively, use "mix local.rebar --force") [Yn]`を訊かれたら、迷わず元氣よく`Y`を答えてください。


```elixir
"https://qiita.com/api/v2/items?query=tag:Elixir&per_page=100"
|> Req.get!()
|> Map.get(:body)
|> Enum.filter(fn %{"likes_count" => likes_count} -> likes_count > 1 end)
|> Enum.map(fn %{"title" => title, "user" => %{"id" => id}, "likes_count" => likes_count} -> {title, likes_count, id} end)
```

ここでみたように、[Elixir](https://elixir-lang.org/)では、パイプ演算子[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)と[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールを使ってプログラミングすることが多いです。
上の例には、実はマップやパターンマッチなど重要な概念がぎゅっとつまっています。

上記のプログラムは、[GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)で、[Elixir](https://qiita.com/tags/elixir)タグがついた記事の一覧を100件取得し、いいねが1以上ついた記事でフィルタして、各要素を`{タイトル, いいね数, id}`に丸めています。

ここからは[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールに話をしぼります。

2023-03-08 09:21現在の実行結果です。

```elixir
[
  {"闘魂Elixir ーー Enum.reduceがあればなんでもできる！", 3,
   "torifukukaiou"},
  {"Elixir Desktop で JavaScript 側をデバッグする（console.log の表示など）",
   2, "RyoWakabayashi"},
  {"Elixir Desktop iOS でカメラ撮影【2023年3月版】", 3,
   "RyoWakabayashi"},
  {"Rustler precompiledの環境構築", 4, "Shintaro_Hosoai"},
  {"Chatwork上で会話できるChatGPTボットをAWS Lambdaだけで実現するとき、Elixirだと少し良いものができたお話",
   2, "erin"},
  {"LivebookでChatGPT APIを使ってみた。試した会話から、ChatGPTお母さんは３時のおやつは無しだと判明した。",
   3, "GeekMasahiro"},
  {"Elixir 高性能な數の數え方（counters）", 5, "mnishiguchi"},
  {"Elixir ETSインメモリデータベースのバックアップと復元",
   7, "mnishiguchi"},
  {"Elixir 挑戦記 - 地理空間データを扱う", 3, "SF-28"},
  {"LivebookでKino.DataTableが表示されない", 3, "SF-28"},
  {"Elixir 学習記（4. パターンマッチング）", 3, "SF-28"},
  {"草莽Erlang ── 43. lists:concat", 2, "mnishiguchi"},
  {"草莽Erlang ── 42. lists:join", 2, "mnishiguchi"},
  {"Elixir Livebook で地図にポイントと一緒にデータを描画出来ないものだろうか",
   5, "hozyo"},
  {"Elixir Explorer データフレーム（DataFrame）の列名がクエリで使えない場合の回避方法",
   4, "RyoWakabayashi"},
  {"草莽Erlang ── 41. lists:append", 2, "mnishiguchi"},
  {"e-Stat の家計調査データから業界の成長・衰退や新型コロナの影響を可視化する",
   8, "RyoWakabayashi"},
  {"Nervesやっている人でディスク容量が少ない人は~/.nervesを消すとよいかもしれません",
   4, "torifukukaiou"},
  {"Elixir v1.17ではIO.read(:all)はDeprecateだってよ（2023-02-25現在v1.14）",
   4, "torifukukaiou"},
  {"Phoenix Storybook で楽しいコンポーネントベース開発", 7,
   "RyoWakabayashi"},
  {"Elixir Livebook で佐賀県のGTFSで全バス路線を地図に描きたいのだ",
   7, "hozyo"},
  {"Elixir Livebook を改造して3Dの立方体を回転させる 〜Kinoの旅　なんでもできる国〜",
   5, "RyoWakabayashi"},
  {"LivebookのSmartCellのDBとMapを使ってGPSログデータを可視化してみた",
   4, "the_haigo"},
  {"LivebookのSecretsを使う", 5, "SF-28"},
  {"Elixir 挑戦記 - 開発環境構築", 4, "SF-28"},
  {"Petal Pro を Fly.io にデプロイして超簡単 Web アプリケーション公開",
   8, "RyoWakabayashi"},
  {"UbuntuコンテナでEXLAが動かない", 4, "SF-28"},
  {"Petal Pro で爆速高機能 Web 開発を体験してみた", 10,
   "RyoWakabayashi"},
  {"総務省統計局の家計調査データからチョコレートを分析する",
   6, "RyoWakabayashi"},
  {"総務省統計局の家計調査データを Livebook で取得、加工、分析する",
   4, "RyoWakabayashi"},
  {"Elixir Livebook で佐賀県のGTFSからバス停を地図に落とせたらいいなー",
   9, "hozyo"},
  {"競プロ未経験者が、Elixir、LivebookでAtCoderに初参加してみたらアウトプットの機会として良かった話",
   6, "GeekMasahiro"},
  {"paiza.ioでelixir その185", 2, "ohisama@github"},
  {"paiza.ioでelixir その184", 2, "ohisama@github"},
  {"mix testでNGが発生したテストをseed値を指定して再現する方法",
   5, "GeekMasahiro"},
  {"逆にStreamを使う例題を作ってみよう！", 5, "GeekMasahiro"},
  {"Elixir 挑戦記 - 衛星データからNDVI算出", 8, "SF-28"},
  {"Elixir Livebook で Algolia からデータ検索してみる", 5,
   "RyoWakabayashi"},
  {"*Interp移植録 - 単眼視深度推定 / HR-Depth (OnnxInterp)", 4,
   "ShozF"},
  {"Google Colaboratory 上で Elixir Bumblebee を動かし、画像生成やテキスト補完を実行する",
   7, "RyoWakabayashi"},
  {"Google Colaboratory 上で Elixir Nx の各種バックエンドを動かす",
   4, "RyoWakabayashi"},
  {"「ElixirImp#28：Elixir Advent CalendarコラムをLT化しましょ！」レポート（2023-02-15）",
   13, "torifukukaiou"},
  {"ElixirのStreamを使ってみる", 4, "GeekMasahiro"},
  {"Elixir 学習記", 4, "SF-28"},
  {"Elixir 学習記（3. 演算子）", 7, "SF-28"},
  {"evision で検出した顔に Elixir Image でモザイクをかける", 5,
   "RyoWakabayashi"},
  {"Elixir Image と Nx と evision で相互変換", 3, "RyoWakabayashi"},
  {"Elixir Image で SVG を PNG に変換する", 3, ...},
  {"長年break文を使い続けたプログラマーが、break文の無いElixirを学んで、遅延評価にたどり着いた話",
   ...},
  {...},
  ...
]
```

# [Enum](https://hexdocs.pm/elixir/Enum.html)モジュール

[Enum](https://hexdocs.pm/elixir/Enum.html)モジュールは、リストやマップ、キーワードリストなどenumerablesと呼ばれるデータを取り扱う関数がそろっています。

最重要関数を４つ紹介します。
独断と偏見です。私の主観です。

- [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)
- [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)
- [Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)
- [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)


## [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)

enumerables（リストなど）の要素一つひとつに関数を適用して、もとのenumerablesと同じ長さのenumerablesを作ります。
例を示します。`[1, 2, 3]`のリストの各要素に`+1`します。

```elixir
iex> Enum.map([1, 2, 3], fn x -> x + 1 end)
[2, 3, 4]
```

## [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)

enumerables（リストなど）の要素一つひとつに関数を適用して、Truthyとなる要素のみからなるenumerablesを作ります。
例を示します。`[1, 2, 3]`のリストの中から偶数のみの要素でフィルターします。

```elixir
iex> Enum.filter([1, 2, 3], fn x -> rem(x, 2) == 0 end)
[2]
```

## [Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)

enumerables（リストなど）の中から一番大きな値を返してくれます。
一番簡単な要素が整数のリストから最大値を取得する例を示します。

```elixir
iex> Enum.max([1, 2, 3])
3
```

## [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)

専門家の間では畳込みと呼ばれています。
これがわかれば、あなたも専門家です。

よく示される例は足し算です。

```elixir
Enum.reduce([1, 2, 3], 0, fn x, acc -> x + acc end)
6
```

けれどこれって初見ではなかなか理解するのは難しいかもしれません。
私の主観にすぎません。
もちろん、初見でもわかるぜーっていう方はいるとおもいます。すごいことです！　あなたは、関数型言語のセンス抜群です。センスの塊です。

どういうふうに計算が進んでいるのかというと以下の感じ（猪木寛至）です。

```
x = 1, acc = 0 -> 1 + 0 = 1
x = 2, acc = 1 -> 2 + 1 = 3
x = 3, acc = 3 -> 3 + 3 = 6
```

これを理解するにはどうしたらいいかというと、さきほど紹介した３つの関数、つまり[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)、[Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)、[Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)を[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)でわざわざ書いてみるとよく理解できます。

以下、さきほど紹介したプログラム例を[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)で書いてみます。

## map相当


`[1, 2, 3]`のリストの各要素に`+1`します。



```elixir
iex> Enum.reduce([1, 2, 3], [], fn x, acc -> acc ++ [x + 1] end)
[2, 3, 4]
```

どういうふうに計算が進んでいるのかというと以下の感じ（猪木寛至）です。

```
x = 1, acc = [] -> [] ++ [2] = [2]
x = 2, acc = [2] -> [2] ++ [3] = [2, 3]
x = 3, acc = [2, 3] -> [2, 3] ++ [4] = [2, 3, 4]
```

[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)の使用例を再掲。

```elixir
iex> Enum.map([1, 2, 3], fn x -> x + 1 end)
[2, 3, 4]
```

## filter相当

`[1, 2, 3]`のリストの中から偶数のみの要素でフィルターします。

```elixir
iex> Enum.reduce([1, 2, 3], [], fn 
  x, acc when rem(x, 2) == 0 -> acc ++ [x]
  _, acc -> acc
end)
[2]
```

どういうふうに計算が進んでいるのかというと以下の感じ（猪木寛至）です。

```
x = 1, acc = [] -> []
x = 2, acc = [] -> [] ++ [2] = [2]
x = 3, acc = [2] -> [2]
```

[Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)の使用例を再掲。

```elixir
iex> Enum.filter([1, 2, 3], fn x -> rem(x, 2) == 0 end)
[2]
```

## max相当

要素が整数のリストから最大値を取得する例を示します。

```elixir
iex> Enum.reduce([1, 2, 3], 0, fn 
  x, acc when x > acc -> x
  _, acc -> acc
end)
3
```

どういうふうに計算が進んでいるのかというと以下の感じ（猪木寛至）です。

```
x = 1, acc = 0 -> 1
x = 2, acc = 1 -> 2
x = 3, acc = 2 -> 3
```

[Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)の使用例を再掲。

```elixir
iex> Enum.max([1, 2, 3])
3
```



まとめます。
この記事で言いたいことをもう一度おさらいします。
猪木さんの有名な言葉に「**元氣があればなんでもできる！**」があります。
これになぞらえて、
「[Enum.reduce](https://hexdocs.pm/elixir/Enum.html#reduce/3)があれば、[Enum](https://hexdocs.pm/elixir/Enum.html#reduce/3)はなんでもできます」を発表しました。


根拠は、[Enumerable](https://hexdocs.pm/elixir/Enumerable.html#content)プロトコルの中核関数は、[Enumerable.reduce/3](https://hexdocs.pm/elixir/Enumerable.html#reduce/3)です。

---

# おまけ

時間が余るようだったらちょっとみせます。
たぶん、話が脱線して、おまけは紹介できないとおもいます。

## [エリクサーチ](https://elixir-lang.info/)

もっと[Elixir](https://elixir-lang.org/)を楽しんでみようというかたへの道しるべ。

https://elixir-lang.info/

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/968f48b5-283f-8643-e623-fb2eeff663ca.png)

## ANSIエスケープコード

https://qiita.com/torifukukaiou/items/e3af576e8a1b20ab7110#%E3%82%B3%E3%83%B3%E3%82%BD%E3%83%BC%E3%83%AB%E3%81%AE%E5%87%BA%E5%8A%9B%E3%82%92%E4%B8%8A%E6%9B%B8%E3%81%8D%E3%81%99%E3%82%8B

## 闘魂プログラミング

https://qiita.com/torifukukaiou/items/c414310cde9b7099df55#%E9%97%98%E9%AD%82%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E3%81%A7%E8%A7%A3%E3%81%8F

## 猪木さんの試合など

**燃える闘魂** といえば、アントニオ猪木さんです。

猪木さんのことを懐かしく思い出す方もいらっしゃるでしょうし、猪木さんが試合をしている姿を知らない方もいらっしゃるでしょう。
猪木さんの試合動画などをご紹介します。
2023-03-11現在、[新日本プロレスワールド](https://njpwworld.com/)で無料公開されています。

- [2022年10月10日 東京・両国国技館 燃える闘魂 アントニオ猪木 追悼VTR](https://njpwworld.com/p/s_00623_1_1_sp)

(ちょっと前までは、ドン・フライとの引退試合やハルク・ホーガン戦などいくつか無料でしたが、今朝みたら有料コンテンツに変わっていました。私はもちろん有料会員です）

---

# さいごに

まとめます。
この記事で言いたいことをもう一度おさらいします。
猪木さんの有名な言葉に「**元氣があればなんでもできる！**」があります。
これになぞらえて、
「[Enum.reduce](https://hexdocs.pm/elixir/Enum.html#reduce/3)があれば、[Enum](https://hexdocs.pm/elixir/Enum.html#reduce/3)はなんでもできます」を発表しました。


根拠は、[Enumerable](https://hexdocs.pm/elixir/Enumerable.html#content)プロトコルの中核関数は、[Enumerable.reduce/3](https://hexdocs.pm/elixir/Enumerable.html#reduce/3)だからです。

**[Elixir](https://elixir-lang.org/)をはじめてみようかとはおもっているもののなかなか最初の一歩が踏み出せずに危ぶんでいる人へ**


[闘魂Elixir](https://autoracex.connpass.com/)コミュニティ、[elixir.jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-1pmz8bye8-4E7OUiLPxhCAHhN3RJqs~w)、[Discordサーバー『elixirと見習い錬金術師』](https://discord.com/invite/k7PHppmy53)はあなたの訪れを熱烈歓迎します。

https://qiita.com/nako_sleep_9h/items/9b6b9b70084cf5998f2d

この道を行けば
どうなるものか
危ぶむなけれ
危ぶめば道はなし
踏み出せば
その一足が道となり
その一足が道となる
迷わず行けよ
行けばわ（分）かるさ
**ありがとうーーーーッ！！！**

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
