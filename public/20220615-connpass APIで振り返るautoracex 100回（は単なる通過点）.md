---
title: connpass APIで振り返るautoracex 100回（は単なる通過点）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
  - QiitaEngineerFesta2022
private: false
updated_at: '2022-06-27T08:21:17+09:00'
id: 0c2f42e10f14f5dfff5f
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---

**志士は溝壑（こうがく）に在るを忘れず、勇士は其の元（かうべ）を喪うことを忘れず**

Advent Calendar 2022 130日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/) を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、2022-06-15(水)開催の「[ElixirImp#21:kokura.ex／autoracexキリ番＋fukuoka.ex5周年](https://fukuokaex.connpass.com/event/250362/)」にて、[autoracex](https://autoracex.connpass.com/)の話をする予定でして、その発表資料です。

# What's [autoracex](https://autoracex.connpass.com/) ?


![091bab86ad6e1d1581d0d0c8c066d32b.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/223f3661-95b6-64b5-be88-6f033e96a5b7.png)

- [Elixir](https://elixir-lang.org/)のもくもく会です
- 週2回開催しています
    - 2021-01-15に第一回を開催
    - 第50回は、2021-10-16
    - 第100回は、2022-05-20
- オートレースのよくある一般開催とあわせています（後付けです。~~数増し!?~~）
- オートレースの場合は以下の通りです
    - 金曜日: 前検日
    - 土曜日〜月曜日: 選手宿舎に缶詰で外部との接触は禁止(八百長などの防止)
- テーマ曲はElixirの紫色にちなんで、もちろん[セクシャルバイオレットNo.1](https://www.youtube.com/watch?v=mCdbIwyVcuE)です
    - 桑名正博さんの名曲です
    - You make me feel good.
    - 発売されたのは1979年です
    - その1979年の1月1日は私の誕生日です
    - KinKi Kidsの堂本光一さんとは全く同じ日です
    - ちょっとしたはずみがあれば私が歌って踊っていたはずです
- 読み方は、「オートレースエックス」と私は読んでいます
    - 「オートレースイーエックス」でも他の読み方でもなんでもいいです
- [fukuoka.ex](https://fukuokaex.connpass.com/)、[kokura.ex](https://fukuokaex.connpass.com/)は大先輩、主筋にあたります
    - 一門の末席を汚しております
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-1b4fgfwuo-DgV3k~3F7sQfZdPWmy9KMw) Slackの`#autoracex`チャンネルで活動しています
    - 英語、日本語の併記が望ましいですがどちらか一方だけでもよいです
- 24時間開催にしているので、時差を気にせず参加できます
- 海外（北米、南米）から参加してくださる方もいる、国際色豊かなコミュニティです
  - autorace (of course)
  - enjoy Elixir
  - freedom (anything, anytime, anywhere) ※「いつ何時、誰の挑戦でも受ける」のストロングスタイル



# What's [autorace](https://autorace.jp/) ?

- オートバイの競争（公営競技）です
    - 日本のみのルール
    - 一周500メートルのオーバルコースを6周回
    - ハンデ戦(速い選手ほど後ろから走る)
    - 公営競技とは、「国が認め、国の定めた法律のもとで運営されている『ギャンブル』のこと！」
- 1レースあたり、8台の競争車で1着を競います
- オートバイにブレーキはありません
    - no breakです
    - https://autorace.jp/guide/en/
- オートレース場は2022年06月現在、全国に五場あります
    - 伊勢崎（群馬県）
    - 川口（埼玉県）
    - 浜松（静岡県）
    - 山陽（山口県）
    - 飯塚（福岡県）
- 元SMAPの森且行さんが選手として活躍されています
    - [第52回SG日本選手権オートレース 優勝](https://autorace.jp/netstadium/Ondemand/asx/kawaguchi/2020-11-03_12)
    - 現在、[復帰へ向けて調整中](https://news.yahoo.co.jp/articles/4549c2f95b46e7687b1cf259b48706f4ad31721b)
- いくつかレース映像をご紹介します（ぜひご覧になってください！）
    - This is オートレース!
    - [10 19 ロッテvs近鉄 実況アナ絶叫 『This is プロ野球！』](https://www.youtube.com/watch?v=AaMZQ8ivhm0)

[第52回SG日本選手権オートレース 優勝](https://autorace.jp/netstadium/Ondemand/asx/kawaguchi/2020-11-03_12)

https://www.youtube.com/watch?v=8O8d5lskEmM

https://www.youtube.com/watch?v=k4qkhnYDq9c

https://www.youtube.com/watch?v=i63KfcnSSsM

https://www.youtube.com/watch?v=b0lf-PDsCq8


# [connpass API](https://connpass.com/about/api/)

https://connpass.com/about/api/

各種情報の取得ができます。

- グループごとにseries_id（グループID)が割り当てられていますのでこれを指定すると検索しやすいです
- このseries_id（グループID)の値は一度、[connpass API](https://connpass.com/about/api/)をコールしてみないとわからないです
- [autoracex](https://autoracex.connpass.com/)のseries_id（グループID)は、11144です
- ちなみに主筋の[fukuoka.ex／kokura.ex／ElixirImp -Elixir Communities](https://fukuokaex.connpass.com/)は、一門みな統一番号でして、5294です

プログラムで書くとこんな感じです。

```elixir
Mix.install [:req]

keyword = "autoracex"
%{body: body} = Req.get!("https://connpass.com/api/v1/event/?keyword=#{keyword}")

Map.get(body, "events")
|> Enum.find(fn %{"event_url" => event_url} -> String.contains?(event_url, keyword) end)
|> Map.get("series")
|> Map.get("id")
```

`series` -> `id`とネストしているところはこんな書き方で取得することもできます。

```elixir
Map.get(body, "events")
|> Enum.find(fn %{"event_url" => event_url} -> String.contains?(event_url, keyword) end)
|> get_in(["series", "id"])
```


# [connpass API](https://connpass.com/about/api/)で振り返るautoracex 100回

[Livebook](https://github.com/livebook-dev/livebook)で実行してみます。
Dockerを使います。

```bash
docker run -p 8080:8080 -p 8081:8081 --pull always livebook/livebook
```

上記は、公式に書いてあります。
実行すると、`http://localhost:8080/?token=bajcxod355oaerqxn65j5dkwv5mkgrir`のようなものが表示されるので、迷わずブラウザでアクセスしてみましょう。
あ、tokenの値は都度かわりますので適宜読み替えてください。
そうすると、[Livebook](https://github.com/livebook-dev/livebook)が立ち上がるので、画面右上の`New notebook`ボタンを押して[Elixir](https://elixir-lang.org/)のプログラミングを楽しんでいきます。

## [Req](https://hexdocs.pm/req/Req.html)のインストール

HTTPクライアント[Req](https://hexdocs.pm/req/Req.html)をインストールしておきます。

```elixir
Mix.install [:req]
```


## イベントの取得

まずはこれまで登録したイベントを取得します。

```elixir
count = 100
series_id = 11144

events = Stream.iterate(1, &(&1 + count))
|> Enum.reduce_while([], fn start, acc ->
  Process.sleep(5000)
  IO.inspect(start)
  %{body: body, status: 200} = Req.get!("https://connpass.com/api/v1/event/?series_id=#{series_id}&count=#{count}&start=#{start}&order=2")
  %{"events" => events, "results_available" => results_available} = body
  new_acc = acc ++ events
  cont_or_halt = if Enum.count(new_acc) < results_available, do: :cont, else: :halt
  
  {cont_or_halt, new_acc}
end)
```

以降、`events`に対してあれこれしてみます。

## イベント登録数は？

```elixir
Enum.count(events)
```

## 第一回目の開催は？

`events`は、開催日時順に取得しています。
説明が前後しますが、`order=2(開催日時順)`の指定です。
直近の開催が先頭にきています。
ですから第一回目を取得するには

```elixir
events |> Enum.reverse |> Enum.at(0)
```

と逆順にして先頭を取得するか

```elixir
events |> Enum.at(-1)
```

というふうに一番うしろを取得するとすればよいわけです。
2021-01-15が取得できました。

ちなみに、この2021-01-15という日は、私が[日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)を受賞した日です :tada::tada::tada:

https://www.youtube.com/watch?v=R3o8vR1A9ao

「elixir azure 愛」で検索してください。
YouTube動画がみつかるはずです。

ちなみに一年間は、365日 ÷ 7日/週で、だいたい52週くらいあります。
週1で開催していると年間で50回を達成できます。
週2で開催すると年間100回を達成できます。

# キリ番はいつ？

```elixir
events
|> Enum.find(fn %{"title" => title} -> String.contains?(title, "#50") end)
|> Map.take(["title", "started_at"])
```

第50回は、2021-10-16でした。
第100回は、2022-05-20でした。





## 延べ参加者数は？

```elixir
events
|> Enum.map(fn %{"accepted" => accepted} -> accepted end)
|> Enum.sum()
```

## 一番参加者が多かった会は？

```elixir
events
|> Enum.max_by(fn %{"accepted" => accepted} -> accepted end)
```

## 参加者が0人の会は？

```elixir
events
|> Enum.filter(fn %{"accepted" => accepted} -> accepted == 0 end)
|> Enum.map(& Map.take(&1, ["title", "started_at"]))
```

## そうだ参加者が0人の会はなかったことにしよう！

```elixir
events
|> Enum.reject(fn %{"accepted" => accepted} -> accepted == 0 end)
|> Enum.all?(fn %{"accepted" => accepted} -> accepted > 0 end)
```



# [connpass API](https://connpass.com/about/api/)で振り返るautoracex 100回 は、単なる通過点


**We are the Alchemists, my friends!!!**

[autoracex](https://autoracex.connpass.com/)への参加との**明確な因果関係はありません**が、一門からは世界に認められたメンバーを輩出:interrobang:しております:bangbang::bangbang::bangbang:

## @mnishiguchi さん

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Please welcome <a href="https://twitter.com/MNishiguchiDC?ref_src=twsrc%5Etfw">@MNishiguchiDC</a> to the Nerves core team! He has been contributing to Nerves Project for a long time, and we&#39;re thrilled to have him onboard.🎉</p>&mdash; Nerves (@NervesProject) <a href="https://twitter.com/NervesProject/status/1535003676577759234?ref_src=twsrc%5Etfw">June 9, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

初期のころから頻繁に参加してくださっている常連です。
実は共同代表者になっています。
ペンパルです。

## @the_haigoさん

![スクリーンショット 2022-06-06 3.29.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7db120d5-8c5f-52a6-9f2b-f727e06b083f.png)

お坊さんなので「辻説法」ならぬ「辻参加」をよくされています。
おそらくconnpassには一度も参加登録をされていないのかもしれません。
むしろでそうあってほしい。




これからも[autoracex](https://autoracex.connpass.com/)はただ前へ歩みを続けます。
進撃を続けます。
[「最後に、これから自分たちは何があっても前を見て、ただ前を見て進みたいと思いますのでみなさん、よろしくお願いいたします。」](https://www.sponichi.co.jp/entertainment/news/2016/01/18/kiji/K20160118011882530.html)
**志士は溝壑（こうがく）に在るを忘れず、勇士は其の元（かうべ）を喪うことを忘れず**
[「死ぬときはたとえドブの中でも前のめりに死にたい」](https://yoshiokuno.com/kyojinnohoshi-ryoma/)

It goes on and on and onです。



# まとめ


[connpass API](https://connpass.com/about/api/)で[autoracex](https://autoracex.connpass.com/)を振り返ることを楽しみました。
そして、この記事自体が[Enum](https://hexdocs.pm/elixir/1.13/Enum.html)モジュール、[|>](https://hexdocs.pm/elixir/1.13/Kernel.html#%7C%3E/2)（パイプ演算子）、[Livebook](https://github.com/livebook-dev/livebook)といった[Elixir](https://elixir-lang.org/)でよく利用されるものを解説した記事となっております。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



**We are the Alchemists, my friends!!!**

## [Qiita Engineer Festa 2022](https://qiita.com/official-campaigns/engineer-festa/2022) 2022年6月1日〜7月18日

https://qiita.com/official-campaigns/engineer-festa/2022

[QiitaEngineerFesta2022](https://qiita.com/tags/qiitaengineerfesta2022) タグと 
[fukuoka.ex：福岡Elixirコミュ](https://qiita.com/organizations/fukuokaex)のオーガナイゼーション指定
をお忘れなく！

## 明日2022/06/16(木)は、[NervesJP #26 Nerves tips, /bin/sh & nerves_heart](https://nerves-jp.connpass.com/event/251185/)でお会いしましょう！

https://nerves-jp.connpass.com/event/251185/

---

# We are the Alchemists, my friends!!! について

- 私は、Queenのにわかファンです
- 映画『ボヘミアンラプソディ』をみてからの**筋金入りの、正真正銘のにわか**ファンです
- [We Are The Champions](https://www.youtube.com/watch?v=04854XqcfCY)の替え歌です
- 最初は単なる冗談でしたが、いまではそれなりに深い意味が秘められているようにおもう今日このごろです
- 特に「my friends!!!」と呼びかけるところがポイントです

[Elixir](https://elixir-lang.org/)を私は楽しんでいる。
そしてそのよさをまわりに伝えたいとおもいはじめた。
私がElixirをはじめたばかりのころに憧れた錬金術師たちはQiitaに記事を書いていた。
それまでのQiitaは見るものであったが、自分でも書いてみることにした。


時は経ち、同時期に[Elixir](https://elixir-lang.org/)をはじめた友であり、ライバルである友人たちは世界へと羽ばたいていく。
それを応援したり、自分のことのようにうれしく思う一方で、指をくわえて座しているだけでいいの？　という煩悶、忸怩たる思い。
まだまだやれるはずだという根拠の無い自信。


**志士は溝壑（こうがく）に在るを忘れず、勇士は其の元（かうべ）を喪うことを忘れず**
It goes on and on and onです。

![091bab86ad6e1d1581d0d0c8c066d32b.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/223f3661-95b6-64b5-be88-6f033e96a5b7.png)

---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)




