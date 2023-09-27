---
title: Nervesを使って毎朝天気予報をRaspberry Pi 2にしゃべらせる(できた！)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-11-04T23:51:00+09:00'
id: 795ee5a112845dbf7730
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
（この記事は、「[#NervesJP Advent Calendar 2019](https://qiita.com/advent-calendar/2019/nervesjp)」の10日目です）
昨日は[私](https://qiita.com/torifukukaiou)の「[Nervesを使ってRaspberry Pi 2でLEDをチカチカさせる 〜クリスマスの飾り付けをしよう〜](https://qiita.com/torifukukaiou/items/bf0354db8cd0628f161e)」です！こちらもぜひぜひ！

# 2020/11/04 追記
- 記事中で紹介している、[livedoor](http://www.livedoor.com/)様の[お天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice) は[サービスが終了](https://help.livedoor.com/weather/index.html)しております
- 代わりに[OpenWeather](https://openweathermap.org/)を利用する記事を書いております
    - [天気予報を定期的にTwitterにつぶやく(Elixir)](https://qiita.com/torifukukaiou/items/9135aa5528726abefcad)

# はじめに :santa_tone1: 
- [Nerves](https://nerves-project.org/)を使って毎朝天気予報をRaspberry Pi 2にしゃべらせてみます
- できました :rocket: 
  - [Nerves](https://nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTでナウでヤングなクールなすごいやつです

# まとめ
- Raspberry Pi 2にスピーカーをとりつける
- [nerves-project/nerves_system_rpi2](https://github.com/nerves-project/nerves_system_rpi2#audio) に書いてある! 通りにやる

```
iex(1)> :os.cmd('espeak -ven+f5 -k5 -w /tmp/out.wav IwasWornToLoveElixir')
iex(2)> :os.cmd('aplay -q /tmp/out.wav')
```
- これでできたも同然でしょう!
- 天気予報を取得して、音声合成してファイルに保存して、`aplay`コマンドを実行するのみです

![ELB08xzUcAYD0G8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4e5838ec-f6c9-91a1-8c64-bde35fa0a954.jpeg)

- [my application with Nerves on rpi2 says about japanese weather forecast at every morning. and, it posts to twitter. i use nerves, i like it!](https://twitter.com/torifukukaiou/status/1202589696053796864)

# 感謝
- [livedoor](http://www.livedoor.com/)様の[お天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice) ありがとうございます!
- [docomo Developer support](https://dev.smt.docomo.ne.jp/)様の [音声合成【Powered by NTTテクノクロス】](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01) ありがとうございます!
- [Nerves](https://nerves-project.org/) ありがとうございます!
- [Elixir](https://elixir-lang.org/) ありがとうございます!
- [Erlang](https://www.erlang.org/) ありがとうございます! 
  - あなたはまだ直接書いたことがありません
- Raspberry Pi 2 ありがとうございます!
- [アドミラル・グレース・マーレー・ホッパー](https://en.wikipedia.org/wiki/Grace_Hopper) ありがとうございます！
- [アラン・チューリング](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%A9%E3%83%B3%E3%83%BB%E3%83%81%E3%83%A5%E3%83%BC%E3%83%AA%E3%83%B3%E3%82%B0) ありがとうございます!
- [ジョン・フォン・ノイマン](https://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%B3%E3%83%BB%E3%83%95%E3%82%A9%E3%83%B3%E3%83%BB%E3%83%8E%E3%82%A4%E3%83%9E%E3%83%B3) ありがとうございます!
- 私の知識不足によりここにあげられていない数多くの発明があることでしょう
- 感謝します!
- 私にプログラミングの楽しさを教えてくれたすべてのコト、モノ、人に感謝します!
    - 一見何も関係なかったようにみえる出来事もきっと私がプログラムを少しだけ書けるようになったことに関係しているのでしょう
- ひとつとして欠けると私には何もできなかったことでしょう
- あなたがいて、私がいる。私がいてあなたがいる。すべてに感謝ーーすべてはつながっているーー**縁起**

# 作品
- [hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)

# 音声サンプル
- [audio_sample.exs](https://gist.github.com/TORIFUKUKaiou/ab985862b3f10b1a44fbceaf40f494ca)
- これを[ダウンロード](https://gist.github.com/TORIFUKUKaiou/ab985862b3f10b1a44fbceaf40f494ca/archive/969f27e97ad2e7eff7ececf72681c040c1de5b23.zip)して`iex`で

```
iex(1)> c "audio_sample.exs"
iex(2)> AudioSample.create
```
- とやってみてください。.wavファイルが2つできているので再生プレイヤーで再生してみてください。
- macOS 10.14.6では再生(iTunes)できました
- [Elixir](https://elixir-lang.org/)は、`Elixir 1.9.4 (compiled with Erlang/OTP 22)`を使いました

# 関連記事
- [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)
- [Nervesでcron的なことをする](https://qiita.com/torifukukaiou/items/19a6aef76e28f9a1f319)

# 対応内容
- [https://github.com/TORIFUKUKaiou/hello_nerves/commit/e2c3e171f2eeb55e8d05c1824db410fd94408813](https://github.com/TORIFUKUKaiou/hello_nerves/commit/e2c3e171f2eeb55e8d05c1824db410fd94408813)
- 以下、ポイント部分のみ記載します

## 天気予報取得
- [livedoor](http://www.livedoor.com/)様の[お天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice) を利用させていただいております
- HTTP Getして返されたJSONから、`"description" |> "text"` とたどって値を取得しています

### Weather.Forecast.text()
```Elixir:lib/weather/forecast.ex
defmodule Weather.Forecast do
  def text(city) do
    "http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city}"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Poison.decode!()
    |> Map.get("description")
    |> Map.get("text")
  end
```

## 音声合成

### Torifuku.TextToSpeech.text_to_speech()
- [docomo Developer support](https://dev.smt.docomo.ne.jp/)様の[音声合成【Powered by NTTテクノクロス】](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01) を利用させていただいております
- 文字列を音声データに変換します
- やっていることはAPIの仕様に従ってHTTP Postしているだけです

```Elixir:lib/torifuku/text_to_speech.ex
defmodule Torifuku.TextToSpeech do
  # Please refer to https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_7#tag01 .
  def text_to_speech(
        text,
        speaker_id \\ 1,
        style_id \\ 1,
        speech_rate \\ 1.0,
        power_rate \\ 1.0,
        voice_type \\ 1.0,
        audio_file_format \\ 2
      ) do
    url =
      "https://api.apigw.smt.docomo.ne.jp/crayon/v1/textToSpeech?APIKEY=#{
        Application.get_env(:hello_nerves, :text_to_speech_api_key)
      }"

    headers = [{"Content-Type", "application/json"}]

    json_data =
      %{
        Command: "AP_Synth",
        SpeakerID: speaker_id,
        StyleID: style_id,
        TextData: text,
        SpeechRate: speech_rate,
        PowerRate: power_rate,
        VoiceType: voice_type,
        AudioFileFormat: audio_file_format
      }
      |> Poison.encode!()

    HTTPoison.post!(url, json_data, headers) |> Map.get(:body)
  end
end
```

## 組み合わせる

- 天気情報文字列の取得と音声データに変換 はできたのであとは部品を組み合わせます
- **もちろん `|>` で組み合わせましょう！**
- [Nerves](https://nerves-project.org/)で動かす場合、`/tmp`配下にファイルを書き込めるようです
- ファイルを書き込む位置と音声ファイルの再生につかうコマンドを [if macro](https://hexdocs.pm/elixir/Kernel.html#if/2)で場合わけしていますが、[Nerves](https://nerves-project.org/)じゃないときの動作はmacOSでしか確認していないです

### HelloNerves.sound_forecast
```Elixir:lib/hello_nerves.ex
defmodule HelloNerves do
  def sound_forecast(city) do
    content =
      Weather.Forecast.text(city)
      |> String.split()
      |> Enum.take(2)
      |> Enum.join()
      |> Torifuku.TextToSpeech.text_to_speech()

    if Application.get_env(:hello_nerves, :target) != :host do
      File.write("/tmp/output.wav", content)
      :os.cmd('aplay -q /tmp/output.wav')
    else
      # macOS
      File.write("output.wav", content)
      :os.cmd('afplay output.wav')
    end
  end
```

- 毎朝実行させる方法は下記の記事をご参照ください
    - [Nervesでcron的なことをする](https://qiita.com/torifukukaiou/items/19a6aef76e28f9a1f319)

# 焼き込む
```
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=secret
$ export TWITTER_CONSUMER_KEY=xxx
$ export TWITTER_CONSUMER_SECRET=yyy
$ export TWITTER_ACCESS_TOKEN=zzz
$ export TWITTER_ACCESS_TOKEN_SECRET=aaa
$ export TEXT_TO_SPEECH_API_KEY=ttt
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```

## WiFi越しにfirmware updateできます！
- [pojiro](https://qiita.com/pojiro)さんの[作って学ぶNerves、BBBでCO2計測](https://qiita.com/pojiro/items/ffc8f01fed5b02e3b17c)の記事で知りました!
    - ありがとうございます!
- つい先日までこれを知らなくて、**毎回、Raspberry Pi 2からmicroSDカードを抜いて、macに挿して焼いて、macから抜いて、Raspberry Pi 2に挿して電源ONを毎回繰り返して**いました

```
$ mix firmware.gen.script            # upload.shができています
$ mix firmware
$ ./upload.sh 192.168.1.10
```
- `192.168.1.10` は私の家のRaspberry Pi 2の話です
- これは便利なのでぜひ使うといいとおもいます！
- [Pushing firmware updates to devices](https://hexdocs.pm/nerves_firmware_ssh/readme.html#pushing-firmware-updates-to-devices)

# 次回
- 明日は[zacky1972](https://qiita.com/zacky1972)先生の[Nerves の可能性は IoT だけじゃない(前編)〜ElixirとPelemayで世界の消費電力を抑える](https://qiita.com/zacky1972/items/2c82a593fbb2e4c949d2)です
- こちらもぜひぜひ！ :santa_tone1: 

**今年あらかじめ事前登録していた分はすべて書ききりました！** :rocket: 





