---
title: '[Elixir]Qiitaの自分の記事をエクスポートする'
tags:
  - Elixir
  - Qiita夏祭り2020_Qiita
private: false
updated_at: '2020-12-20T01:47:33+09:00'
id: 5ed277b219da1731dc78
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [「Qiita夏祭り2020 オンライン」ライブ配信](https://connpass.com/event/180539/) に参加しました
- パネルディスカッションの中で「あると便利だよね〜」と話にでていたエクスポートの件を[Elixir](https://elixir-lang.org/)を使って書いてみました
- 最大10,000件までエクスポートできます(たぶんね)
    - ~~自分の記事がそんなに多くないので本当に動くのかどうかは未確認 :sweat_smile:~~
    - **2020/12/20現在、私の記事は140件ほどあるので試してみたところ、ページネーションのところがちゃんと動くことを確認しました**
- [Elixir](https://elixir-lang.org/)は**1.11.2-otp-23**を使っています

# 0. インストールとプロジェクトの作成
- まずは[Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB) などを参考にしてください
- インストールができましたら以下のコマンドでプロジェクトを作ります

```
$ mix new qiita_export
$ cd qiita_export
```

# 1. 依存関係の解決

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"}, # add
      {:jason, "~> 1.2"} # add
    ]
  end
```

```
$ mix deps.get
```

# 2. ソースコードを書く

```elixir:lib/qiita/api.ex
defmodule Qiita.Api do
  @token "secret"
  @per_page 100
  @headers [Authorization: "Bearer #{@token}", Accept: "Application/json; Charset=utf-8"]

  def items_count(id \\ "torifukukaiou") do
    HTTPoison.get("https://qiita.com/api/v2/users/#{id}")
    |> decode_response()
    |> Jason.decode!()
    |> Map.get("items_count")
  end

  def items_by_page(page) do
    "https://qiita.com/api/v2/authenticated_user/items?page=#{page}&per_page=#{@per_page}"
    |> HTTPoison.get(@headers)
    |> decode_response()
    |> Jason.decode!()
  end

  def max_page(items_count) when rem(items_count, @per_page) == 0 do
    div(items_count, @per_page) |> min(100)
  end

  def max_page(items_count) do
    (div(items_count, @per_page) + 1) |> min(100)
  end

  defp decode_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
  end

  defp decode_response(_), do: raise("")
end
```

- tokenはご自身でログイン後、 https://qiita.com/settings/applications から取得してください

```elixir:qiita_export.ex
defmodule QiitaExport do
  @user_id "torifukukaiou"
  def run do
    max_page = Qiita.Api.items_count(@user_id) |> Qiita.Api.max_page()

    1..max_page
    |> Enum.each(fn page ->
      Qiita.Api.items_by_page(page)
      |> Enum.each(fn %{"body" => body, "title" => title} ->
        File.write!(filename(title), body)
      end)
    end)
  end

  defp filename(title) do
    title
    |> String.replace("/", "_") # ファイル名に使えない文字があったらここで調整
    |> Kernel.<>(".md")
  end
end
```

- (`.md`でいいんだよね? :thinking: )


# 3. 実行 :rocket::rocket::rocket:

```elixir
$ iex -S mix

iex> QiitaExport.run
:ok
``` 

# Wrapping Up
- [「Qiita夏祭り2020 オンライン」ライブ配信](https://connpass.com/event/180539/)は、いろいろな話を聞けておもしろかったです
- 正直に申しますと、私が書いた[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)で、[QiitaオリジナルTシャツ](https://qiita.com/official-events/0e872f8893283d4fd212#qiita%E8%B3%9E)をGet!できるのではないかとワクワク期待をして参加しました :sweat_smile:
- 受賞はできませんでしたが、また次もあるようですのでそれまで精進を続けていきたいとおもっております
    - 記事を投稿できたので良しとします！　ヨシ
- **Enjoy!!! :rocket::rocket::rocket:** 
