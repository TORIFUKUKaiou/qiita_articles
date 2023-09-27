---
title: docker runでElixirを楽しむ
tags:
  - Elixir
  - Docker
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-07T22:36:49+09:00'
id: 4f4a250df934f7fa8fe7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

[Elixir](https://elixir-lang.org/)を手軽に[Docker](https://www.docker.com/)で楽しんでみます。

# 題材

csvファイルをダウンロードして、縦計を計算して、csvファイルに書き足すというものです。
csvファイルは以下を利用させていただきます。感謝申し上げます。

https://raw.githubusercontent.com/kujirahand/book-mlearn-gyomu/master/src/ch2/iris/iris.csv

AI、機械学習の初級編の「アヤメの分類」データだとおもいます。


# プログラム

```elixir:sample.exs
Mix.install([{:req, "~> 0.3.1"}, {:nimble_csv, "~> 1.2"}])

NimbleCSV.define(MyParser, [])

defmodule Sample do
  @url "https://raw.githubusercontent.com/kujirahand/book-mlearn-gyomu/master/src/ch2/iris/iris.csv"
  @iris_csv @url |> String.split("/") |> Enum.at(-1)
  @output "output.csv"

  def run do
    [header | rows] =
      download_csv(@url)
      |> tap(&File.write(@iris_csv, &1))
      |> MyParser.parse_string(skip_headers: false)

    subtotallings =
      rows
      |> Enum.reduce([0, 0, 0, 0], fn row, acc ->
        row
        |> Enum.slice(0, 4)
        |> Enum.map(&String.to_float/1)
        |> plus(acc)
      end)
      |> Kernel.++([""])

    ([header] ++ rows ++ [subtotallings])
    |> MyParser.dump_to_iodata()
    |> IO.iodata_to_binary()
    |> then(&File.write(@output, &1))
  end

  defp download_csv(url) do
    Req.get!(url)
    |> Map.get(:body)
  end

  defp plus(list_a, list_b) do
    list_a
    |> Enum.zip(list_b)
    |> Enum.map(fn {a, b} -> a + b end)
  end
end

Sample.run()
```

少し説明をします。
上から順に説明します。

- [Mix.install/2](https://hexdocs.pm/mix/Mix.html#install/2)にて依存ライブラリをインストールします
    - [Req](https://hex.pm/packages/req): Req is a batteries-included HTTP client for Elixir.
    - [NimbleCSV](https://hex.pm/packages/nimble_csv): A simple and fast CSV parsing and dumping library
- `Sample`モジュールを定義しています
- エントリポイントは`run/0`関数です
    - CSVファイルをダウンロードそのまま保存
    - 縦計を計算
    - もとのCSVの最終行に縦計算を追加して保存
- `Sample.run`の実行

ということをやっております。




# docker run

`sample.exs` を用意しておいて、ファイルを保存した同じディレクトリにて以下を実行してください。

```
docker pull hexpm/elixir:1.14.0-erlang-25.1-ubuntu-jammy-20220428

docker run --rm -v $PWD:/app hexpm/elixir:1.14.0-erlang-25.1-ubuntu-jammy-20220428 bash -c "mix local.hex --force && mix local.rebar --force && cd /app && elixir sample.exs"
```

実行が無事完了すると、2つのファイルができているはずです。

- iris.csv
- output.csv

## 追記
イメージのサイズが小さな alpine でも楽しめると読者の方からお便りをいただきました。

```
docker pull hexpm/elixir:1.14.0-rc.1-erlang-24.3.4.6-alpine-3.14.8

docker run --rm -v $PWD:/app hexpm/elixir:1.14.0-rc.1-erlang-24.3.4.6-alpine-3.14.8 sh -c "mix local.hex --force && mix local.rebar --force && cd /app && elixir sample.exs"
```
@mnishiguchi さん、お便りありがとうございます！



# [hexpm/elixir](https://hub.docker.com/r/hexpm/elixir)

[Phoenix](https://www.phoenixframework.org/)の[Deploying with Releases](https://hexdocs.pm/phoenix/releases.html)ガイドで使用されていました。
ここにあるものが由緒正しいものだろうとおもって使いました。


# おわりに

docker runでElixirを楽しんでみました。

`docker run --rm -v $PWD:/app hexpm/elixir:1.14.0-erlang-25.1-ubuntu-jammy-20220428 mix local.hex --force && elixir sample.exs`
これを書いておきたかっただけでもあります。
Qiitaに書くと脳に定着するんです、私の場合。
Qiitaはすごいなあ。ありがとうございます！

:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan: 
