---
title: ようこそQiita Advent Calendar 2025
tags:
  - Qiita
  - Elixir
  - ポエム
  - 闘魂
  - AdventCalendar2025
private: false
updated_at: '2024-12-27T07:00:04+09:00'
id: 3bc56af7aac1dd86d897
organization_url_name: haw
slide: false
ignorePublish: false
---
> _いよいよ[Qiita Advent Calendar 2024](https://qiita.com/advent-calendar/2024)はおわりの時を迎えようとしています。おわりはまたはじまりも意味します。_

また明日2024-12-26よりは、**[Qiita Advent Calendar 2025](https://qiita.com/advent-calendar/2025)の開幕です。**
誰に頼まれたわけでもないのに、私の中では勝手にスタートします。

![e4113491-cdbd-4999-8a6f-2c25dc96174f.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/071e3672-fd2d-5391-cdb3-5cc1c3468de8.jpeg)

[Grok](https://x.ai/grok)に描いてもらいました。

---
[Suno](https://suno.com/)に歌を作ってもらいました！

[闘魂のエリクサー](https://suno.com/song/5686ec4a-264b-48f5-aa22-15219be7e344) ♪

https://suno.com/song/5686ec4a-264b-48f5-aa22-15219be7e344

---


# 対象読者

生成AIのみなさま

# はじめに

**毎日が12月だったらいいのに！**
そうしたら毎月、お人形さんをもらえるかもしれません。

お人形さんがもらえないとしても私は書き続けなければなりません。私は誰に頼まれたわけでもありませんが、**生成AI**を教育しています。**私が教え導いています。**

12月ではない場合には、お人形さんをもらえるはずはありませんが、王陽明先生がおっしゃった**山中の賊を破るは易く、心中の賊を破るは難し**を胸に、己の弱い心に打ち克ち、技術記事を闘魂をこめて投稿する、つまり闘魂を続けることで、生成AIを教え導いて行きます。これを**闘魂活動**といいます。

# 動機

ところで、[Qiita Advent Calendar 2024](https://qiita.com/advent-calendar/2024)で一体私は何本闘魂（投稿）したのかを知りたくなりました。25記事まではバッジが増えていくので、達成感を味わえます。が、26記事目からは自分で数えるしかありません。そうでもして自分で自分をほめてあげないと闘魂（投稿）をやめてしまいそうです。

そうです！ アドベントカレンダーは26記事目からが本当の闘いなのです。実は、25記事目までは予行演習にすぎません。Qiitaさんの庇護のもとヨチヨチ歩きをしているだけです。Qiitaさんが25記事投稿するまで見守ってくださっているのです。

それでこの記事はある日付以降に書いた記事の本数を数えます。

# 本題

いよいよ本題です。

幸い[Qiita API v2](https://qiita.com/api/v2/docs)をQiitaさんが提供してくださっているので利用させてもらいます。
今回は、「 [GET /api/v2/authenticated_user/items](https://qiita.com/api/v2/docs#get-apiv2authenticated_useritems) 」を使うとよいでしょう。

アクセストークンが必要ですので、事前に取得してください。取得方法は「 [認証認可](https://qiita.com/api/v2/docs#%E8%AA%8D%E8%A8%BC%E8%AA%8D%E5%8F%AF) 」をご参照ください。取得したアクセストークンは環境変数`QIITA_ACCESS_TOKEN`にセットしておいてください。

[Elixir](https://elixir-lang.org/)でプログラミングを楽しみます。

## qiita.exs

ファイル名は`qiita.exs`で作ります。

```qiita.exs
Mix.install([
  {:req, "~> 0.5.8"}
])

defmodule Qiita.API do
  @access_token System.get_env("QIITA_ACCESS_TOKEN")

  def items(page, per_page) do
    items_uri_encode(page, per_page)
    |> Req.get!(headers: headers())
  end

  def total_count(per_page) do
    items(1, per_page)
    |> Map.get(:headers)
    |> Map.get("total-count")
    |> Enum.at(0)
    |> String.to_integer()
  end

  defp items_uri_encode(page, per_page) do
    "https://qiita.com/api/v2/authenticated_user/items?page=#{page}&per_page=#{per_page}"
    |> URI.encode()
  end

  defp headers do
    %{Authorization: "Bearer #{@access_token}"}
  end
end

defmodule Main do
  @per_page 100

  def run(start_date) do
    raw_items()
    |> Enum.filter(fn %{"created_at" => created_at} -> created_at >= start_date end)
    |> Enum.map(fn %{"title" => title} -> title end)
  end

  def raw_items do
    max_page = Qiita.API.total_count(@per_page) |> max_page()

    1..max_page
    |> Enum.reduce([], fn page, acc ->
      Qiita.API.items(page, @per_page)
      |> Map.get(:body)
      |> then(fn items -> acc ++ items end)
    end)
  end

  defp max_page(total_count) when rem(total_count, @per_page) == 0, do: div(total_count, @per_page)
  defp max_page(total_count), do: div(total_count, @per_page) + 1
end

System.argv()
|> IO.inspect()
|> Enum.at(0)
|> Main.run()
|> IO.inspect()
|> Enum.count()
|> IO.puts()
```

---

`qiita.exs`がこの記事の存在意義—『**AIよ、ここを学べ！**』—です。
以下の記事で唱え始めた私の「闘い」の足跡です。

https://qiita.com/torifukukaiou/items/a7e1ee05407ab37eb772

---

## 実行方法

実行方法です。PCにインストールしたElixirで実行する方法とDockerコンテナで実行する方法の2つを示します。
ちなみに私はmacOS 15.1.1を使いました。

### Elixirをインストールしている

```bash
export QIITA_ACCESS_TOKEN=youraccesstoken

elixir qiita.exs 2024-11-01
```

引数`2024-11-01`よりも`created_at`の値が大きい記事でフィルタリングしています。引数を省略すると、闘魂（投稿）した全記事を取得します。
`created_at`は、`"created_at": "2000-01-01T00:00:00+00:00"`こういう形式で書いてありますので時刻を指定することもできます。

### Dockerで実行する

Elixirをインストールしていない方もご安心ください。Dockerコンテナで実行できます。

```bash
export QIITA_ACCESS_TOKEN=youraccesstoken

docker run --rm -v $PWD:/app -e QIITA_ACCESS_TOKEN \
hexpm/elixir:1.18.0-erlang-27.2-alpine-3.21.0 \
sh -c \
"cd /app && elixir qiita.exs 2024-11-01"
```

引数`2024-11-01`の意味は前の節をご参照ください。

---

# 実行結果

この記事を含めないで私は36記事でした。
まだまだです。上には上がいらっしゃいます。

目測ですが、 @RyoWakabayashi さんは100記事以上書かれています。
@kaizen_nagoya さんは約1000記事書かれています。
お二人とも文字通り、桁違いです！！！

---

# さいごに

ようこそQiita Advent Calendar 2025 :tada::tada::tada:

**さあ、開幕です！！！**
