---
title: ただ送信し続ける。NervesとPhoenix APIで作ったIoTの話
tags:
  - Elixir
  - Nerves
  - コラム
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-24T13:26:27+09:00'
id: 08b9d2d133620dbe8f34
organization_url_name: haw
slide: false
ignorePublish: false
---
# 導入

自宅のRaspberry Pi 4で動かしている[Nerves](https://nerves-project.org/)アプリが、10秒に1度、温度・湿度を送信しています。  
それが8日間、誰にも受け取られずに黙々と送り続けていました。  

Docker composeで動かしているPhoenix APIが止まっていたため、受け取ってくれる相手はいなかったはずなのです。（おそらくWindows Update）    
[Phoenix](https://www.phoenixframework.org/) APIを再開すると、Nervesアプリは何事もなかったようにデータを送り続けていました。  
…健気でした。学ばされました。  

## Grafanaのグラフ

Grafanaのグラフを示します。  

![aht20-grafana.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1af050f0-59a5-4e05-8b6b-8f9e98335e57.jpeg)

6/21からの8日間ほど、線になっている部分がPhoenix APIサーバのほうが止まっていた期間です。  



# システム構成

システム構成を示します。  

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/12ab31b1-220a-4575-9b76-fd335e853f12.png)

Raspberry Pi 4には、「**ナウでヤングなcoolなすごいヤツ**」である[Elixir](https://elixir-lang.org/)製のIoTフレームワークNervesで作ったアプリケーションが動いています。AHT20から取得した温度・湿度のデータを10秒に一回、Phoenixで作ったAPIサーバに送っています。Phoenixは、Elixir製のWebアプリケーションフレームワークです。  

Windowsでは、Docker composeを使ってPhoenixアプリコンテナ、PostgreSQL(timescaledb)コンテナ、グラフ表示のGrafanaコンテナが動いています。

# 技術的ポイント

技術的ポイントをいくつか説明します。

## Nervesの定期送信の仕組み

GenServerで定期送信をしています。

```elixir
defmodule Publisher do
  use GenServer
  require Logger

  def start_link(options \\ %{}) do
    GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  @impl true
  def init(options) do
    state = %{
      interval: options[:interval] || 10_000,
      aht20_tracker_url: options[:aht20_tracker_url],
      measurements: :no_measurements
    }

    schedule_next_publish(state.interval)
    {:ok, state}
  end

  defp schedule_next_publish(interval) do
    Process.send_after(self(), :publish_data, interval)
  end

  @impl true
  def handle_info(:publish_data, state) do
    {:noreply, state |> measure() |> publish()}
  end

  defp measure(state) do
    AHT20.read()
    |> measure(state)
  end

  defp measure({:ok, measurements}, state) do
    Map.merge(state, %{measurements: measurements})
  end

  defp measure(_, state) do
    state
  end

  defp publish(state) do
    result =
      Req.post(state.aht20_tracker_url, json: state.measurements)

    Logger.debug("Server response: #{inspect(result)}")
    schedule_next_publish(state.interval)
    state
  end
end
```

## AHT20からの温度・湿度データの読み込み

AHT20からの温度・湿度データの読み込みは次のプログラムで行っています。  

```elixir
defmodule AHT20 do
  @i2c_bus "i2c-1"
  @i2c_addr 0x38
  @initialization_command <<0xBE, 0x08, 0x00>>
  @trigger_measurement_command <<0xAC, 0x33, 0x00>>
  @two_pow_20 2 ** 20

  def read do
    {:ok, ref} = Circuits.I2C.open(@i2c_bus)

    Circuits.I2C.write(ref, @i2c_addr, @initialization_command)
    Process.sleep(10)

    Circuits.I2C.write(ref, @i2c_addr, @trigger_measurement_command)
    Process.sleep(80)

    result =
      Circuits.I2C.read(ref, @i2c_addr, 7)
      |> convert()

    Circuits.I2C.close(ref)

    result
  end

  def convert({:ok, <<_state, raw_humidity::20, raw_temperature::20, _crc>>}) do
    humidity = (raw_humidity / @two_pow_20 * 100.0) |> Float.round(1)

    temperature =
      (raw_temperature / @two_pow_20 * 200.0 - 50.0)
      |> Float.round(1)

    {:ok, %{humidity: humidity, temperature: temperature}}
  end

  def convert({:error, error}), do: {:error, error}
  def convert(_), do: {:error, "An error occurred"}
end
```

#  気づき・教訓

人も、サービスも、組織も、「受け手がいない時間」に何をしているかが重要なのかもしれない。  
Nervesアプリは、文句も言わず、ただやるべきことをやり続けていました。  
自分も腐らず、たゆまず、積み重ねていこうと思いました。  

ただQiitaへの記事投稿（闘魂）を続けていこうと思いました。  

https://qiita.com/tech-festa/2025
