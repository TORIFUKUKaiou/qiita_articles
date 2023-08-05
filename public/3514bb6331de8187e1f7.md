---
title: >-
  ElixirとSORACOM Beamを使用して、Raspberry Pi 4 と Azure IoT Hub との間でデータを送受信します
  せっかくなのでウェブチカします
tags:
  - Azure
  - Elixir
  - SORACOM
  - QiitaAzure
private: false
updated_at: '2021-12-31T20:45:00+09:00'
id: 3514bb6331de8187e1f7
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/b7811ce1542be54e6efe


# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- [SORACOM](https://soracom.jp/)さんの「[Azure IoT Hub と接続する](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)」を参考に[Azure IoT Hub](https://azure.microsoft.com/ja-jp/services/iot-hub/)にデータを送信してみます
- プロトコルは[MQTT](https://mqtt.org/)を使います
- せっかくなのでウェブチカ[^1]します

[^1]: @nishiuchikazuma さんの「[NervesにPhoenixを入れてHTTPのGETでLEDをウェブチカ〜準備編1/3〜](https://qiita.com/nishiuchikazuma/items/bfd04b36fb4524d49a59)」によると**ウェブチカ**とは、**「とあるURLにアクセスするとNervesにつけているLEDをチカらせることを言ってます」** とのことです。まあこの記事でやっていることもなんとなく雰囲気は似ているということで、**ウェブチカ**の末席に加えさせてください :bow::bow_tone1::bow_tone2::bow_tone3::bow_tone4::bow_tone5: 

![スクリーンショット 2021-10-05 22.04.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/96238593-aa6f-ed26-d8ef-7ff3d73d8097.png)

- [Azure アーキテクチャ アイコン](https://docs.microsoft.com/ja-jp/azure/architecture/icons/)
- [SORACOM アイコンセット](https://users.soracom.io/ja-jp/resources/icon-set/)


# [Azure IoT Hub と接続する](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)
- まずは[SORACOM](https://soracom.jp/)さんの[記事](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)の通りにやってみます
- [Elixir](https://elixir-lang.org/)でやってみる前にまずは成功体験を積むことにします
- 以下、「[Azure IoT Hub と接続する](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)」の見出しごとにコメントしていきます

## ステップ 1: Azure IoT Hub を準備する
### IoT Hub を作成する
- Azureのコンソール画面の感じが少し異なっているような気がしますがなんとなく、[記事](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)を参考に作成できました

### IoT Device を作成する
- ここも同じく[記事](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)を参考に作成できました

### 認証情報を確認する
- 「1. 共有アクセスポリシーを利用する」を選択することにしました
- Azure consoleの言語設定を日本語にしている場合は、以下の読み替えをします

| [記事](https://users.soracom.io/ja-jp/docs/beam/azure-iot/) | Azureコンソール(日本語) |
|:-:|:-:|
| Settings  | 設定  |
| Shared access policies   | 共有アクセス ポリシー  |

## ステップ 2: SORACOM Beam を設定する
### グループを作成する
- 記載の通り

### グループで Beam を設定する
- 基本的に記載の通り
- 認証情報は、以下を入力しました

| 設定名 | 値 |
|:-:|:-:|
| Access Policy Name  | device  |
| Shared access key    | プライマリーキー(or セカンダリキー) |

![スクリーンショット 2021-10-05 20.12.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5a15fb8d-9ecc-d5fa-25cc-a6c1dcf60cc8.png)

## ステップ 3: Beam を使用して Azure IoT Hub にデータを送信する
### デバイスの準備
- 記事の通り、Raspberry Pi 4に`mosquitto-clients`をインストールします

### 送信されたデータ確認の準備
- ここは私のmacOSでは記事の通りいきませんでした
    - 2021/10/19追記: `$ az iot hub monitor-events -n ${iothub-name} -g ${resource-group}`を使うように更新されています :rocket::rocket::rocket: [^2] 
- 記事の通り、`IoT Hub Explorer`なるものをインストールして実行したところ以下のエラーが発生しました

[^2]: @matsujirushi さんがSORACOMさんに連絡してくださいました :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 。ありがとうございます。

```
$ iothub-explorer monitor-events --login $connection_string
--------
DEPRECATION NOTICE: iothub-explorer will be retired on November 31st, 2018
It has been replaced by the Azure CLI IoT Extension (https://aka.ms/iotcli).
--------
The equivalent command in the Azure CLI is: az iot hub monitor-events
--------
Monitoring events from all devices...
/usr/local/Cellar/nvm/0.38.0/versions/node/v14.17.3/lib/node_modules/iothub-explorer/node_modules/azure-event-hubs/node_modules/azure-iot-common/lib/shared_access_signature.js:45
    throw new ReferenceError('Argument \'' + name + '\' is ' + value);
    ^
```

- `The equivalent command in the Azure CLI is: az iot hub monitor-events`をたよりに、azをインストールしました
    - [macOS での Azure CLI のインストール](https://docs.microsoft.com/ja-jp/cli/azure/install-azure-cli-macos)
- IoT Hub の 共有アクセスポリシー (Shared access policies) の、iothubowner 権限が必要となりますので、プライマリ接続文字列 or セカンダリー接続文字列のどちらかを使います

```
$ connection_string='HostName=xxxx.azure-devices.net;SharedAccessKeyName=iothubowner;SharedAccessKey=XXXXXXXXXXXXXXXXXXXXX='

$ az iot hub monitor-events --login $connection_string
```

#### [AK-020](https://soracom.jp/store/5274/)の接続
- 「[MS2372h-607 をセットアップする](https://users.soracom.io/ja-jp/guides/usb-dongles/ms2372h-607/)」を参考に進めれば3Gに繋がりました
- 以下、Raspberry Pi 4での操作です

```
pi@raspberrypi: ~$ curl -O https://soracom-files.s3.amazonaws.com/setup_air.sh
pi@raspberrypi: ~$ sudo bash setup_air.sh
```

```
pi@raspberrypi: ~$ deviceId=myDevice
pi@raspberrypi: ~$ mosquitto_pub -d -h beam.soracom.io -i $deviceId -t "devices/$deviceId/messages/events/" -m "Hello from SORACOM Beam!" -V mqttv311
```



![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3e033128-933d-783e-6608-26e0f695fe21.gif)


- Raspberry Pi 4からAzure IoT Hubにデータを送ることができました :tada::tada::tada:


#### 小話
- 「[Docker コンテナーで Azure CLI を実行する方法](https://docs.microsoft.com/ja-jp/cli/azure/run-azure-cli-docker)」こちらを進めましたがうまくいきませんでした
- 「Microsoft の目標は、Azure CLI のバグをなくし、使いやすいものにすることです。 バグが見つかった場合は、GitHub で問題を報告していただきますよう、よろしくお願いいたします。」と書いてありましたので報告をしておきました
- https://github.com/Azure/azure-cli/issues/19767
- `az feedback --verbose`を実行すると、問題報告の雛形を作ってくれます
- これを大いに活用させてもらいました!


### ステップ 4: Azure IoT Hub からのデータを受信する
- 今度はAzure IoT HubからRaspberry Pi 4にデータを送ってみます
- 記事の通りにやるとRaspberry Pi 4で受信を確認できました :tada::tada::tada:

![スクリーンショット 2021-10-05 20.47.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d26cc022-152d-1d5d-8375-bf20c7286830.png)



**あとはここからはいつものように同じことを[Elixir](https://elixir-lang.org/)でやってみます :rocket::rocket::rocket:**

# [Elixir](https://elixir-lang.org/)でAzure IoT Hub と接続し、Azure IoT Hubから指定された回数分LEDを光らせる
- ウェブチカです

```
$ mix new hello_mqtt
```

```diff:mix.exs
  defp deps do
     [
       # {:dep_from_hexpm, "~> 0.3.0"},
       # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
+      {:tortoise, "~> 0.9"},
+      {:circuits_gpio, "~> 0.4"},
+      {:jason, "~> 1.2"}
     ]
   end
 end
```

```
$ mix deps.get
```

## MyHandler
- `hello_mqtt/deps/tortoise/lib/tortoise/handler/logger.ex` を参考にしています
    - というか**写しています**
    - 少し長いですが安心してください
    - **95%コピペ**です
- 変更箇所は、`handle_message/3`関数を変更したのと、`do_handle/1`関数を追加しています
- `do_handle/1`はやっつけ関数でして、`{"cnt": 5}`というようなデータを受け取ったときに、指定された`cnt`回LEDを光らせています

```elixir:hello_mqtt/lib/hello_mqtt/my_handler.ex
defmodule HelloMqtt.MyHandler do
  @moduledoc false

  require Logger

  use Tortoise.Handler

  defstruct []
  alias __MODULE__, as: State

  def init(_opts) do
    Logger.info("Initializing handler")
    {:ok, %State{}}
  end

  def connection(:up, state) do
    Logger.info("Connection has been established")
    {:ok, state}
  end

  def connection(:down, state) do
    Logger.warn("Connection has been dropped")
    {:ok, state}
  end

  def connection(:terminating, state) do
    Logger.warn("Connection is terminating")
    {:ok, state}
  end

  def subscription(:up, topic, state) do
    Logger.info("Subscribed to #{topic}")
    {:ok, state}
  end

  def subscription({:warn, [requested: req, accepted: qos]}, topic, state) do
    Logger.warn("Subscribed to #{topic}; requested #{req} but got accepted with QoS #{qos}")
    {:ok, state}
  end

  def subscription({:error, reason}, topic, state) do
    Logger.error("Error subscribing to #{topic}; #{inspect(reason)}")
    {:ok, state}
  end

  def subscription(:down, topic, state) do
    Logger.info("Unsubscribed from #{topic}")
    {:ok, state}
  end

  def handle_message(topic, publish, state) do
    Logger.info("#{Enum.join(topic, "/")} #{inspect(publish)}")
    do_handle(publish)
    {:ok, state}
  end

  def terminate(reason, _state) do
    Logger.warn("Client has been terminated with reason: #{inspect(reason)}")
    :ok
  end

  defp do_handle(publish) do
    cnt = Jason.decode!(publish) |> Map.get("cnt")
    {:ok, gpio} = Circuits.GPIO.open(25, :output)

    1..cnt
    |> Enum.each(fn _ ->
      Circuits.GPIO.write(gpio, 1)
      Process.sleep(1000)
      Circuits.GPIO.write(gpio, 0)
      Process.sleep(1000)
    end)

    Circuits.GPIO.close(gpio)
  end
end

```

## Run

```elixir
$ iex -S mix

iex> Tortoise.Supervisor.start_child(
    client_id: "myDevice",
    handler: {HelloMqtt.MyHandler, []},
    server: {Tortoise.Transport.Tcp, host: 'beam.soracom.io', port: 1883},
    subscriptions: [{"devices/myDevice/messages/devicebound/#", 0}])
```

### まずはAzure IoT Hubにデータを送ってみます

```elixir
iex> Tortoise.publish("myDevice", "devices/myDevice/messages/events/", "Hello from the World of Tomorrow !", qos: 0)
```

- `az iot hub monitor-events`でデータが送られていることを確認できました

:rocket::rocket::rocket:

### Azure IoT Hubからのメッセージを受け取って指定された回数分LEDを光らせてみます

![スクリーンショット 2021-10-05 21.24.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/37dc80b3-c70c-d6d5-be8a-a5c5065d946b.png)

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a033045d-521b-1428-5317-f9f747af9220.gif)




ウェブチカできました:tada::tada::tada:

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [SORACOM](https://soracom.jp/)さんの「[Azure IoT Hub と接続する](https://users.soracom.io/ja-jp/docs/beam/azure-iot/)」を参考に、[Elixir](https://elixir-lang.org/)で[Azure IoT Hub](https://azure.microsoft.com/ja-jp/services/iot-hub/)との間でデータを送受信することができました
    - ついでに私なりのはじめての**ウェブチカ**ができました
- [MQTT](https://mqtt.org/)の通信には、[Tortoise](https://github.com/gausby/tortoise)を使いました
    - @tuchiro さんの「[Elixir製MQTTクライアントtortoiseを使ってみた](https://qiita.com/tuchiro/items/e7fb5185f4ac191b94b5)」を参考にしました
    - ありがとうございます！
- 公式ドキュメントの記載内容がわかりやすくてありがたいです！
    - <font color="purple">$\huge{ありがとうございます！}$</font>
- デバイスとの間でメッセージの送受信ができるようになりましたのでいろいろ楽しみが増えそうです！
- Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
