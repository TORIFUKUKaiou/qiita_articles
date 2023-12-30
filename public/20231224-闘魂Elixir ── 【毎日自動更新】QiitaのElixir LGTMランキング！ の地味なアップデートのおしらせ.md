---
title: 闘魂Elixir ── 【毎日自動更新】QiitaのElixir LGTMランキング！ の地味なアップデートのおしらせ
tags:
  - Elixir
  - ポエム
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-24T10:49:15+09:00'
id: 1396dd672fd42042811c
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
今年2023年アドベントカレンダーにおいて26記事目の記事です :tada::tada::tada::tada::tada::tada: 
:::

**完走してからが本当の闘いです。**
**ようやく次の一歩を踏み出せました。**



# はじめに

[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)という記事を毎日更新しています。

https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd

Raspberry Pi 2上の[Nerves](https://nerves-project.org/)アプリケーションで定期的に更新をしているわけです。

12月のみ飾り付けとアドベントカレンダーの記事だと**おもわれる**記事たちのランキングを表示しておりました。
このたび当年のElixirアドベントカレンダーおよびNervesJPアドベントカレンダーに投稿された記事に絞り込むアップデータを施しました。

だれかに聞いてほしいので記事にいたしておきます。

# 変更内容

https://github.com/TORIFUKUKaiou/hello_nerves/commit/a4a7dfc9aa4dfa0d1d773bd2c9ef982b9c4a057a

```diff
       # アドベントカレンダー :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5:
       - ぜひご参加ください！
-      - [Elixir Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir)
-      - [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)
-      - [fukuoka.ex Elixir／Phoenix Advent Calendar 2020](https://qiita.com/advent-calendar/2020/fukuokaex)
-      - [#NervesJP Advent Calendar 2020](https://qiita.com/advent-calendar/2020/nervesjp)
+      - [Elixir Advent Calendar #{Timex.now().year}](https://qiita.com/advent-calendar/#{Timex.now().year}/elixir)
+      - [#NervesJP Advent Calendar #{Timex.now().year}](https://qiita.com/advent-calendar/#{Timex.now().year}/nervesjp)
       """
     end
   end
@@ -122,11 +120,38 @@ defmodule Qiita do
     if HelloNerves.is_xmas?() do
       year = Timex.now().year
 
-      filter(items, Timex.beginning_of_month(year, 12) |> Timex.to_datetime(), "updated_at", 1000)
+      advent_calendar_urls =
+        [
+          "https://qiita.com/advent-calendar/#{year}/elixir",
+          "https://qiita.com/advent-calendar/#{year}/nervesjp"
+        ]
+        |> Enum.reduce([], fn calendar_url, acc ->
+          acc ++ get_advent_calendar_urls(calendar_url)
+        end)
+
+      items
+      |> Enum.filter(fn item -> item["url"] in advent_calendar_urls end)
+      |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
       |> build_table("updated_at")
-      |> Kernel.<>(
-        "\nupdated_atが#{year}/12/01より大きい記事を並べています。アドベントカレンダーだけ取得するようないい方法があればお知らせください！"
-      )
+    end
+  end
+
+  defp get_advent_calendar_urls(calendar_url) do
+    with %{status: 200, body: html} <-
+           Req.get!(calendar_url, pool_timeout: 50000, receive_timeout: 50000),
+         {:ok, parsed_doc} <- Floki.parse_document(html),
+         [{_tag, _attrs, json} | _] <-
+           Floki.find(parsed_doc, "[data-js-react-on-rails-store=AppStoreWithReactOnRails]"),
+         {:ok, decoded} <- Jason.decode(json),
+         [table_advent_calendars | _] <-
+           get_in(decoded, ["adventCalendars", "tableAdventCalendars"]) do
+      table_advent_calendars
+      |> Map.fetch!("items")
+      |> Enum.map(&get_in(&1, ["article", "linkUrl"]))
+      |> Enum.filter(& &1)
+      |> Enum.reject(&String.contains?(&1, "private"))
+    else
+      _ -> []
     end
   end
 end
```

**たぶん、これで放っておいても来年以降は自動でいい感じに更新されるはず。**
**たぶん、これで放っておいても再来年以降も自動でいい感じに更新されるはず。**
**たぶん、これで放っておいても再々来年以降も自動でいい感じに更新されるはず。**

だって、`#{Timex.now().year}`とか書いたから。

URLの体系とかがかわったら駄目だけど、
いい感じに更新されなければ、それをQiitaアドベントカレンダー2024に書けばよい！

いやー、我ながらみれば見るほど、雑で、いけていない気がします。
`private`さんというユーザーや`private`をユーザー名に含む方がいたら、ゴメンナサイです :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

ほかには自分で気持ち悪いとおもったのは以下です。

```elixir
     if HelloNerves.is_xmas?() do
       year = Timex.now().year
```

いまならこう書かない気がしていて、過去に自分で書いたコードが気持ち悪かったです。
過去の遺産っちいうことで、早くランキング記事に反映させたかったのでご勘弁ください。
そんなんにこだわっていると**12月がおわっちゃうのでね。2024年のアドベントカレンダーのテーマにとっておきます。**

どうせ誰にも見えないところだしどうでもいいやという投げやりな気持ちと**神は細部に宿る**ですのでちゃんとしておきたい気持ちのはざまで乙女心のように、秋の空のように揺れ動いています。


# さいごに

[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)という記事の地味なアップデートのお知らせでした。

https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd

---

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
