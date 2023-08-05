---
title: Nervesでtarget(Raspberry Pi等)で動かすときはこっち、host(macOS等)で動かすときはそっち
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2019-12-24T12:50:23+09:00'
id: d26c9ffb051dd3df82ba
organization_url_name: fukuokaex
slide: false
---
（この記事は、「[#NervesJP Advent Calendar 2019](https://qiita.com/advent-calendar/2019/nervesjp)」の7日目です）
昨日は[Yoosuke](https://qiita.com/Yoosuke)さんの「[Nerves と GraphQLsever の組み合わせを考える「ポエム」](https://qiita.com/Yoosuke/items/50fc77bf8230109cfa88)」です！こちらもぜひぜひ！

# はじめに :santa_tone1: 
- [お天気Webサービス（Livedoor Weather Web Service / LWWS）](http://weather.livedoor.com/weather_hacks/webservice)を使わせていただいて天気予報の情報を取得してTwitterにつぶやくことを[Nerves](https://nerves-project.org/)でやってみました
    - [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)
- これをやるときに開発途中で、いちいちmicroSDカードに焼き込んで[Nerves](https://nerves-project.org/)上で動かすことは面倒だとおもいました
- ちょっとだけ困ったことがありました

# ちょっとだけ困ったことの具体例
- [Nerves](https://nerves-project.org/)から動かしていることをアピールするために `"I use Nerves. I like it!"` を差し込みたいとします

```Elixir:lib/weather/forecast.ex 
defmodule Weather.Forecast do
  def run({city, name}) do
    description =
      "http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city}"
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Poison.decode!()
      |> Map.get("description")
      |> Map.get("text")
      |> String.split()
      |> Enum.reduce_while("#{name}\n", fn s, acc ->
        if String.length(acc <> "#{s}\n") < 140 - String.length(i_use_nerves()),
          do: {:cont, acc <> "#{s}\n"},
          else: {:halt, acc}
      end)
      |> Kernel.<>(i_use_nerves())
  end

  def run do
    cities() |> Enum.random() |> run
  end

  defp i_use_nerves do
    "I use Nerves. I like it!"
  end
```
- こう書くと、microSDカードに焼き込んで[Nerves](https://nerves-project.org/)で動かしいているときは問題ないのですが、開発の途中にhost(macOS等)で動かしているときは、 `"I use Nerves. I like it!"` といれたくありません
- 結局最後は、[Nerves](https://nerves-project.org/)で動かすのですから、そんな些細なこと気にしなくてもいいのかもしれません
- このままの状態で、Twitterに投稿するまでをテストしたいときには、`"I use Nerves. I like it!"` が入ってしまうので、ちょっとだけうそつきになります
- なにかコンパイルスイッチというかそういうもので、 **target(Raspberry Pi等)で動かすときはこっち、host(macOS等)で動かすときはそっち** ができないものかと調べてみました

# Mix.target() => (使えません)
- `mix nerves.new hello_nerves` したときにできる `config/config.exs` に `Mix.target()`なる記述がありました

```Elixir:config/config.exs
if Mix.target() != :host do
  import_config "target.exs"
end
```
- これを使って、

```Elixir:lib/weather/forecast.ex 
  defp i_use_nerves do
    if Mix.target() != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end
```
- なんてやると動くのかなと最初はおもいました
- しかしこれをmicroSDカードに焼き込んでRaspberry Pi2で動かしてみても動きません
- Mix.target()なんて使えないよ的なエラーがでます

# 解決策
```Elixir:lib/weather/forecast.ex 
  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end
```

- 他にもいい方法があるのかもしれません
- ここで得た知識は[jbernardo95/cronex](https://github.com/jbernardo95/cronex)を[Nerves](https://nerves-project.org/)アプリケーションで使おうとしたときに、`Mix.env` が使えないよ的なエラーに遭遇したことがありましてそのエラーを調査する際にどこかで聞いた話だなとピンときました

# if(condition, clauses) のconditionを `!=` じゃなくて `==` で書きたい
- 2019/12/22 追記
- `if Application.get_env(:hello_nerves, :target) != :host` の部分
- Nerves on Raspberry Pi 2で動かしてみました

```Elixir
iex> Application.get_env(:hello_nerves, :target)
:rpi2
```
- `MIX_TARGET`に設定した[Targets](https://hexdocs.pm/nerves/targets.html) TAGが返ってくるようです
- `if Application.get_env(:hello_nerves, :target) == :rpi2` と書けないわけではないですが、他のTargetでも動かすことを考える(もっていないけど:santa_tone1:)と、`!=` の書き方のほうがいいかなあとおもっています


# まとめ
- **Leap before you look**

# 次回
次回は[pojiro](https://qiita.com/pojiro)さんの「[作って学ぶNerves、BBBでCO2計測](https://qiita.com/pojiro/items/ffc8f01fed5b02e3b17c)」です！こちらも是非どうぞ～
