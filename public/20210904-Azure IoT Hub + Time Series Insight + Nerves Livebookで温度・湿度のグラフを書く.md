---
title: Azure IoT Hub + Time Series Insight + Nerves Livebookで温度・湿度のグラフを書く
tags:
  - Azure
  - Elixir
  - Nerves
private: false
updated_at: '2021-09-28T23:47:10+09:00'
id: f630fb9b4caee8ead094
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- [Nerves Livebook](https://github.com/fhunleth/nerves_livebook)を用いて、[AHT20](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)というモジュールを用いて温度・湿度を測ってAzureでグラフ表示したいとおもいます
    - もし[AHT20](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)　もしくは代替のものがご用意いただけない場合にはランダムな値でも送ってみましょう

## 必要なもの
- Azureアカウント
- Raspberry Pi 4
- microSDカード 16GB
- ACアダプター
- [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
- [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
    - 手先が[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)な私でもSeeedさんの製品を使うことで、IoTを楽しめます
    - もし同じものもしくはなにかを測定できる代替のモノをお持ちではない方は、ランダムな値でグラフを書いてみましょう

## 参考
- [くらでべ IoT 10 分間クッキング](https://www.youtube.com/watch?v=LTmaXK1bEZc) :video_camera: 
- [Device - Send Device Event](https://docs.microsoft.com/ja-jp/rest/api/iothub/device/send-device-event)
- [Azure IoT HubにHTTP POSTでメッセージを送信するメモ](https://qiita.com/tmitsuoka0423/items/bfcc91d50cd0fe312f6c)
    - @tmitsuoka0423 さん
    - こちらの記事にとても助けていただきました
    - ありがとうございました！
    - こちらの記事のおかげでIoT HubにおけるHTTPSにたどり着くことができました

# [Nerves Livebook](https://github.com/fhunleth/nerves_livebook)
- 手前味噌の「[Nerves Livebook Firmwareを使って温度・湿度のグラフをかいてみる](https://qiita.com/torifukukaiou/items/dfe1577004f36b8b77d7)」を参考に、microSDカードに[Nerves Livebook](https://github.com/fhunleth/nerves_livebook)をこんがり焼いて、電源ONするところまで進めてください


![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e3143f4-e959-7914-850a-bdb4758051e3.gif)[^1]

[^1]: ブレッドボードとLチカは今回の記事とはなんら関係ありません

# Azure IoT Hub
- ポータル画面 https://portal.azure.com/#home から、`リソースの作成 > IoT Hub`と進んで**作成**してみましょう
- 必須入力項目を入力して、選択するところは基本はデフォルトのままにしておいて、**価格とスケールティア**は`F1`を選びました

![スクリーンショット 2021-09-04 10.42.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/debf9151-374f-b73f-1a57-1cf3943f2186.png)

- :coffee: でも飲んで待ちましょう

## IoTデバイス
- Azure IoT Hubができあがったら、IoTデバイスを追加します

![スクリーンショット 2021-09-04 11.42.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/23550701-f611-16a0-d710-efc7e161857b.png)

- **デバイスの追加**


![スクリーンショット 2021-09-04 11.43.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4b2633d3-5c9f-4365-1522-1aedf4d793c2.png)

- デバイスIDは`livebook`と名付けました

# SASトークンをつくる
- このあとHTTPSでIoT Hubにデータを送ります
- その際に必要となるのがSASトークンです

## 注意喚起
- @matsujirushi さんからとっ〜〜〜ても大事なコメントをいただきました :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
    - ありがとうございます！
- https://qiita.com/torifukukaiou/items/f630fb9b4caee8ead094#comment-2e0e68b904cd64017de0
- この記事に書いてあることをそのままやるといずれ有効期限を迎えてしまうとのことです
    - Azureの料金が気になってすぐに止めてしまったので気づきませんでした

## 参考
- [Shared Access Signature とセキュリティ トークンを使用して IoT Hub へのアクセスを制御する](https://docs.microsoft.com/ja-jp/azure/iot-hub/iot-hub-dev-guide-sas?tabs=node)
- [az iot hub generate-sas-token](https://docs.microsoft.com/ja-jp/cli/azure/iot/hub?view=azure-cli-latest#az_iot_hub_generate_sas_token)
- [Docker コンテナーで Azure CLI を実行する方法](https://docs.microsoft.com/ja-jp/cli/azure/run-azure-cli-docker)

## [Docker](https://www.docker.com/)を使ってSASトークンをつくってみました

```
$ docker run -it mcr.microsoft.com/azure-cli

bash-5.1# az login
```
- 指示通りにブラウザでURLを開いて
![スクリーンショット 2021-09-04 14.36.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0f401ab7-443c-2dfc-5869-cc0658677761.png)

- `az login`実行時に書いてあるcodeを打ち込みます
- あとは画面の指示通りに進んでいくとサインインが成功してまたターミナルにコマンドを打ち込めるようになります

```
bash-5.1# az iot hub generate-sas-token --hub-name {IOT_HUB_NAME}
```

- 私の場合は以下のようになります

```
bash-5.1# az iot hub generate-sas-token --hub-name iot-hub-awesome
```

- 実行結果をメモしておきます
- `"SharedAccessSignature sr=xxxx"`を使います

# Run!!!
- [Nerves Livebook](https://github.com/fhunleth/nerves_livebook)で操作をします
- http://nerves.local にアクセスして、Authenticationは`nerves`を入力
- あとは右上の`New notebook`から[Elixir](https://elixir-lang.org/)のプログラミングを楽しみましょう

## AHT20から温度・湿度を取得するプログラム

```elixir
defmodule Aht20.Reader do
  alias Circuits.I2C

  @i2c_bus "i2c-1"
  @i2c_addr 0x38
  @initialization_command <<0xBE, 0x08, 0x00>>
  @trigger_measurement_command <<0xAC, 0x33, 0x00>>
  @two_pow_20 :math.pow(2, 20)

  def read do
    {:ok, ref} = I2C.open(@i2c_bus)

    I2C.write(ref, @i2c_addr, @initialization_command)
    Process.sleep(10)

    I2C.write(ref, @i2c_addr, @trigger_measurement_command)
    Process.sleep(80)

    ret = I2C.read(ref, @i2c_addr, 7)

    I2C.close(ref)

    value(ret)
  end

  defp value({:ok, val}), do: {:ok, convert(val)}

  defp value(_), do: :error

  defp convert(<<_, raw_humi::20, raw_temp::20, _>>) do
    humi = Float.round(raw_humi * 100 / @two_pow_20, 1)
    temp = Float.round(raw_temp * 200 / @two_pow_20 - 50.0, 1)

    {temp, humi}
  end
end
```

- [AHT20](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)もしくは代替のセンサーのご用意がない場合はランダムな値を返すようにしてみましょう

```elixir
defmodule Aht20.Reader do
  def read do
    {:ok, {Enum.random(250..300) / 10, Enum.random(600..800) / 10}}
  end
end
```

## IoT Hubへデータを送り込むプログラム
```elixir
f = fn -> 
  url = 'https://iot-hub-awesome.azure-devices.net/devices/livebook/messages/events?api-version=2020-03-13'

  :inets.start
  :ssl.start

  {:ok, {temp, humi}} = Aht20.Reader.read()
  {:ok, datetime} = DateTime.now("Etc/UTC")
  time = datetime |> DateTime.to_unix()

  json = Jason.encode!(%{value: %{temperature: temp, humidity: humi, time: time}}) |> String.to_charlist()
  request = {url, [{'Authorization', 'SharedAccessSignature sr=xxx'}], 'application/json', json}
  IO.inspect(request)

  :httpc.request(:post, request, [], [])
end

f.()
```

- `SASトークンをつくる`のところで作ったトークンを指定します
- urlは以下の形式です
    - `https://fully-qualified-iothubname.azure-devices.net/devices/{id}/messages/events?api-version=2020-03-13`
    - https://docs.microsoft.com/ja-jp/rest/api/iothub/device/send-device-event

```elixir
{:ok,
 {{'HTTP/1.1', 204, 'No Content'},
  [
    {'date', 'Sat, 04 Sep 2021 05:56:41 GMT'},
    {'server', 'Microsoft-HTTPAPI/2.0'},
    {'vary', 'Origin'},
    {'content-length', '0'},
    {'x-ms-request-id', '1f8cfa57-c449-446d-bca0-0d11c02965f4'}
  ], []}}
```
- こんな応答が返ってきたら成功です

## 定期的にIoT Hubへデータを送り込むプログラム

```elixir
defmodule Ticker do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    :timer.send_interval(1000 * 20, self(), :tick)
    {:ok, state}
  end

  def handle_info(:tick, state) do
    send()
    {:noreply, state}
  end

  defp send do
    url = 'https://iot-hub-awesome.azure-devices.net/devices/livebook/messages/events?api-version=2020-03-13'

    :inets.start
    :ssl.start

    {:ok, {temp, humi}} = Aht20.Reader.read()
    {:ok, datetime} = DateTime.now("Etc/UTC")
    time = datetime |> DateTime.to_unix()

    json = Jason.encode!(%{value: %{temperature: temp, humidity: humi, time: time}}) |> String.to_charlist()
    request = {url, [{'Authorization', 'SharedAccessSignature sr=iot-hub-awesome.azure-devices.net&sig=XSUR%2BX3tP9Em%2FVqQx5Q%2FwSIeq5qUiYGyD8BG3Bog51g%3D&se=1630737793&skn=iothubowner'}], 'application/json', json}
    IO.inspect(request)

    :httpc.request(:post, request, [], [])
  end
end

Ticker.start_link([])
```

- 20秒ごとにセンサーからの値取得、IoT Hubへの送信を行っています
- このまましばらく放置しておきます
- :coffee: でも飲んで待っていると、デバイスからのデータが届いていることがわかります
    - 図はIoT Hubの概要

![スクリーンショット 2021-09-04 15.13.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2a7d7db8-9e0b-dce0-489e-c27b52565015.png)



# Time Series Insight
- Time Series Insightでグラフ表示をしてみます

![スクリーンショット 2021-09-04 15.07.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c3e99d48-637e-a8d5-fd9d-eb652385820d.png)

- 「作成」を迷わず押して
- あとはカンで値を入力して、Time Series Insightをデプロイしましょう

![スクリーンショット 2021-09-04 15.11.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c861602b-456c-d8d7-5060-d23c3b24e952.png)

- :coffee:でも飲んでデプロイが終わって、「リソースに移動」
- さらに「TSIエクスプローラーに移動」
- そうするとこんな画面になります

![スクリーンショット 2021-09-04 15.19.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/28f29b7a-8899-7a1a-59f3-c50d877d5fe6.png)

- `null`のところを触って、あとは雰囲気で`value.humidity`と`value.temperature`にチェックをいれましょう
- そうすると以下のようなグラフが表示されます :tada::tada::tada: 

![スクリーンショット 2021-09-04 15.23.01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7ff0f5a5-ff9a-552e-c130-b30f2b3e5cdb.png)

- ランダム値を送り込むプログラムでの結果です
- 温度・湿度なのでそれほど激しくはうごきません


# Wrapping Up :lgtm::lgtm::lgtm::lgtm: 
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:

# 最後の最後に
- [Nerves](https://www.nerves-project.org/)とは、[Elixir](https://elixir-lang.org/)でIoTを楽しめる[ナウでヤングでcoolなすごいヤツ](https://www.slideshare.net/takasehideki/elixirnervescool-249038510)です
- ここで[NervesJP](https://nerves-jp.connpass.com/)の紹介です
    - 月1回程度、ワイワイガヤガヤ オンラインで集まっています
    - [Nerves](https://www.nerves-project.org/)に興味をもっていだけましたらぜひぜひご参加ください
- 愉快なfolksたちがあなたの参加を待っています
- れっつじょいな〜す
- https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk
- ぜひぜひSlackにご参加ください :rocket::rocket::rocket::rocket::rocket:



![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  
