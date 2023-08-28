---
title: 天気予報を定期的にTwitterにつぶやく(Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-08-17T16:39:59+09:00'
id: 9135aa5528726abefcad
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 毎朝、私の[Nerves](https://nerves-project.org/)アプリ on Raspberry Pi 2がTwitterへ日本のどこかの地点の天気予報をつぶやくようにしていました
- 2020/8/1からは投稿ができていませんでした
- Livedoor Weather Web Serviceを利用させていただいておりましたが、こちらの通り、2020年7月31日（金）14:00 で終了となっておりました
    - [■サービス終了のお知らせ](https://help.livedoor.com/weather/index.html)
    - いままでありがとうございました :pray: :bow: 
- これは[2020/8/16(日) NervesJP #10 ”やってみた”回](https://nerves-jp.connpass.com/event/185623/) への私の報告です

# [OpenWeather](https://openweathermap.org/)
- こちらを使うことにしました
- いつ取得していたのかは忘れてしまいましたが、ユーザー登録とAPIキーの取得は済んでいたのでそれを使います
- [One Call API](https://openweathermap.org/api/one-call-api)を使います
    - `"https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&lang=ja&units=metric&exclude=current,minutely,hourly&appid=#{appid}"` にHTTP GETすると以下のようなJSONが返ってきます
        - 以下はJsonをMapに変換しています

```elixir
%{
  "daily" => [
    %{
      "clouds" => 75,
      "dew_point" => 24.79,
      "dt" => 1597629600,
      "feels_like" => %{
        "day" => 39.81,
        "eve" => 37.77,
        "morn" => 39.81,
        "night" => 35
      },
      "humidity" => 56,
      "pop" => 0.81,
      "pressure" => 1008, 
      "rain" => 10.79,
      "sunrise" => 1597607962,
      "sunset" => 1597656497,
      "temp" => %{
        "day" => 34.88,
        "eve" => 33.83,
        "max" => 34.88,
        "min" => 30.65,
        "morn" => 34.88,
        "night" => 30.65
      },
      "uvi" => 10.44,
      "weather" => [
        %{
          "description" => "適度な雨",
          "icon" => "10d",
          "id" => 501,
          "main" => "Rain"
        }
      ],
      "wind_deg" => 138,
      "wind_speed" => 1.94
    },
    %{
      "clouds" => 92,
      "dew_point" => 20.43,
      "dt" => 1597716000,
      "feels_like" => %{
        "day" => 35.26,
        "eve" => 32.22,
        "morn" => 31.63,
        "night" => 31.69
      },
      "humidity" => 44,
      "pop" => 0.88,
      "pressure" => 1011,
      "rain" => 2.69,
      "sunrise" => 1597694411,
      "sunset" => 1597742824,
      "temp" => %{
        "day" => 34.12,
        "eve" => 31.05,
        "max" => 34.12,
        "min" => 28.23,
        "morn" => 28.28,
        "night" => 28.23
      },
      "uvi" => 11.12,
      "weather" => [
        %{
          "description" => "小雨",
          "icon" => "10d",
          "id" => 500,
          "main" => "Rain"
        }
      ],
      "wind_deg" => 94,
      "wind_speed" => 3.72
    },
    %{
      "clouds" => 76,
      "dew_point" => 20.66,
      "dt" => 1597802400,
      "feels_like" => %{
        "day" => 38.29,
        "eve" => 34.73,
        "morn" => 31.24,
        "night" => 32.19
      },
      "humidity" => 43,
      "pop" => 0,
      "pressure" => 1011,
      "sunrise" => 1597780859,
      "sunset" => 1597829149,
      "temp" => %{
        "day" => 35.07,
        "eve" => 33.76,
        "max" => 37.26,
        "min" => 27.42,
        "morn" => 27.42,
        "night" => 29.64
      },
      "uvi" => 9.9,
      "weather" => [
        %{
          "description" => "曇りがち",
          "icon" => "04d",
          "id" => 803,
          "main" => "Clouds"
        }
      ],
      "wind_deg" => 186,
      "wind_speed" => 1.08
    },
    %{
      "clouds" => 100,
      "dew_point" => 19.46,
      "dt" => 1597888800,
      "feels_like" => %{
        "day" => 38.65,
        "eve" => 34.57,
        "morn" => 32.67,
        "night" => 33.34
      },
      "humidity" => 36,
      "pop" => 0.04,
      "pressure" => 1012,
      "sunrise" => 1597867307,
      "sunset" => 1597915474,
      "temp" => %{
        "day" => 36.96,
        "eve" => 34.33,
        "max" => 37.99,
        "min" => 28.83,
        "morn" => 28.83,
        "night" => 30
      },
      "uvi" => 10.18,
      "weather" => [
        %{
          "description" => "厚い雲",
          "icon" => "04d",
          "id" => 804,
          "main" => "Clouds"
        }
      ],
      "wind_deg" => 199,
      "wind_speed" => 2.46
    },
    %{
      "clouds" => 0,
      "dew_point" => 19.85,
      "dt" => 1597975200,
      "feels_like" => %{
        "day" => 39.83,
        "eve" => 35.75,
        "morn" => 33.52,
        "night" => 34.14
      },
      "humidity" => 35,
      "pop" => 0.46,
      "pressure" => 1013,
      "rain" => 1.81,
      "sunrise" => 1597953756,
      "sunset" => 1598001798,
      "temp" => %{
        "day" => 37.8,
        "eve" => 34.17,
        "max" => 37.8,
        "min" => 29.16,
        "morn" => 29.16,
        "night" => 29.86
      },
      "uvi" => 10.1,
      "weather" => [
        %{
          "description" => "小雨",
          "icon" => "10d",
          "id" => 500,
          "main" => "Rain"
        }
      ],
      "wind_deg" => 134,
      "wind_speed" => 2.16
    },
    %{
      "clouds" => 88,
      "dew_point" => 20.9,
      "dt" => 1598061600,
      "feels_like" => %{
        "day" => 36.82,
        "eve" => 33.28,
        "morn" => 32.27,
        "night" => 33.27
      },
      "humidity" => 45,
      "pop" => 0.73,
      "pressure" => 1012,
      "rain" => 4.02,
      "sunrise" => 1598040204,
      "sunset" => 1598088120,
      "temp" => %{
        "day" => 34.54,
        "eve" => 31.43,
        "max" => 34.54,
        "min" => 28,
        "morn" => 28,
        "night" => 29.24
      },
      "uvi" => 9.1,
      "weather" => [
        %{
          "description" => "適度な雨",
          "icon" => "10d",
          "id" => 501,
          "main" => "Rain"
        }
      ],
      "wind_deg" => 88,
      "wind_speed" => 2.62
    },
    %{
      "clouds" => 94,
      "dew_point" => 16.87,
      "dt" => 1598148000,
      "feels_like" => %{
        "day" => 32.82,
        "eve" => 33.91,
        "morn" => 31.92,
        "night" => 32.85
      },
      "humidity" => 37,
      "pop" => 0.86,
      "pressure" => 1009,
      "rain" => 9.2,
      "sunrise" => 1598126652,
      "sunset" => 1598174442,
      "temp" => %{
        "day" => 33.14,
        "eve" => 31.49,
        "max" => 33.14,
        "min" => 28.38,
        "morn" => 28.38,
        "night" => 29.02
      },
      "uvi" => 9.02,
      "weather" => [
        %{
          "description" => "適度な雨",
          "icon" => "10d",
          "id" => 501,
          "main" => "Rain"
        }
      ], 
      "wind_deg" => 193,
      "wind_speed" => 3.55
    },
    %{
      "clouds" => 28,
      "dew_point" => 18.94,
      "dt" => 1598234400,
      "feels_like" => %{
        "day" => 40.32,
        "eve" => 33.44,
        "morn" => 31.95,
        "night" => 32.95
      },
      "humidity" => 33,
      "pop" => 0.51,
      "pressure" => 1007,
      "rain" => 1.01,
      "sunrise" => 1598213099,
      "sunset" => 1598260763,
      "temp" => %{
        "day" => 37.7,
        "eve" => 32.03,
        "max" => 37.7,
        "min" => 28.18,
        "morn" => 28.18,
        "night" => 29.07
      },
      "uvi" => 10.05,
      "weather" => [
        %{
          "description" => "小雨",
          "icon" => "10d",
          "id" => 500,
          "main" => "Rain"
        }
      ],
      "wind_deg" => 164,
      "wind_speed" => 0.65
    }
  ],
  "lat" => 36.2,
  "lon" => 140.1,
  "timezone" => "Asia/Tokyo",
  "timezone_offset" => 32400
}
```

- lat, lonは、http://bulk.openweathermap.org/sample/ に圧縮されたJSONファイル(city.list.json)があるのでそれを解凍して使います
- [Nerves](https://nerves-project.org/)プロジェクトの`rootfs_overlay`配下にファイルを置いておくと、[Nerves](https://nerves-project.org/)アプリから読み出すことができます
    - [Overwriting Files in the Root Filesystem](https://hexdocs.pm/nerves/advanced-configuration.html#overwriting-files-in-the-root-filesystem)
    - [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)というワークスペース名のSlackにて、 @pojiro さんの書き込みから知った次第です
        - ありがとうございます！ :pray: :lgtm::lgtm::lgtm: 

```
$ ls rootfs_overlay/usr/local/share 
city.list.json
```
- たとえばこんな感じにプロジェクトに配置しておくと、[Nerves](https://nerves-project.org/)アプリからは`/usr/local/share/city.list.json`というパスでアクセスできます

```elixir
File.read!("/usr/local/share/city.list.json")
|> Jason.decode!()
|> Enum.filter(fn %{"country" => country} -> country == "JP" end)
```

# キモのソースコード

```elixir:lib/weather/forecast.ex
defmodule Weather.Forecast do
  @api_key Application.get_env(:hello_nerves, :open_weather_api_key)
  @city_list_json "/usr/local/share/city.list.json"

  def run(%{"coord" => %{"lat" => lat, "lon" => lon}, "id" => city_id}) do
    %{
      "name" => name
    } =
      current(city_id)
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    %{"daily" => dailies} =
      onecall(lat, lon)
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Jason.decode!()

    description =
      dailies |> Enum.at(0) |> Map.get("weather") |> Enum.at(0) |> Map.get("description")

    temp_max = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("max")
    temp_min = dailies |> Enum.at(0) |> Map.get("temp") |> Map.get("min")

    "#{name}の天気は、#{description}です。\n最高気温は#{temp_max}℃です。最低気温は#{temp_min}℃です。\n\n#{i_use_nerves()}"
  end

  def run do
    cities()
    |> Enum.random()
    |> run()
  end

  defp current(city_id) do
    "http://api.openweathermap.org/data/2.5/weather?id=#{city_id}&lang=ja&units=metric&appid=#{
      @api_key
    }"
  end

  defp onecall(lat, lon) do
    "https://api.openweathermap.org/data/2.5/onecall?lat=#{lat}&lon=#{lon}&lang=ja&units=metric&exclude=current,minutely,hourly&appid=#{
      @api_key
    }"
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end

  defp cities do
    path =
      if Application.get_env(:hello_nerves, :target) != :host,
        do: @city_list_json,
        else: "rootfs_overlay/#{@city_list_json}"

    File.read!(path)
    |> Jason.decode!()
    |> Enum.filter(fn %{"country" => country} -> country == "JP" end)
  end
end
```

- [プルリクエスト](https://github.com/TORIFUKUKaiou/hello_nerves/pull/43)

# その他利用しているもの
- [HTTPoison](https://github.com/edgurgel/httpoison)
    - HTTPクライアント
- [ExTwitter](https://github.com/parroty/extwitter)
    - Twitterクライアントライブラリ
- [Quantum](https://github.com/quantum-elixir/quantum-core)
    - Cronライクなスケジューラ


# Wrapping Up
- `rootfs_overlay`配下にあらかじめ格納しておきたいファイルやバイナリなどをおいておくと、[Nerves](https://nerves-project.org/)アプリから読みだせます :lgtm::lgtm::lgtm: 
- Enjoy [Elixir](https://elixir-lang.org/)!
