---
title: PelemayのサンプルDemoを動かしてみる
tags:
  - Elixir
private: false
updated_at: '2019-09-13T12:25:32+09:00'
id: 76b31703538a62cf83c2
organization_url_name: fukuokaex
slide: false
---
# はじめに
- Hastega改め[Pelemay](https://github.com/zeam-vm/pelemay)と言うそうです
- [山崎先生](https://twitter.com/zacky1972)のプレゼンテーション [ElixirConf 2019 - Return of Wabi-Sabi: Hastega Will Bring More and... - Susumu Yamazaki](https://www.youtube.com/watch?v=uCkPyfFhPxI) の29分ころからはじまるDemoをやってみたいとおもいます
- 私のMacには、[Homebrew](https://brew.sh/index_ja)でインストールした[Elixir](https://elixir-lang.org/)がインストールされています

```bash
$ elixir -v
Erlang/OTP 22 [erts-10.4.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Elixir 1.9.0 (compiled with Erlang/OTP 22)
```

# Demoをやってみる

```bash
$ git clone https://github.com/zeam-vm/pelemay.git
$ cd pelemay/
$ mix deps.get
$ mix bench
(略)
## LogisticMapBench
benchmark na iterations   average time 
Accelerated        5000   739.98 µs/op
Enum               1000   1566.13 µs/op
Flow                500   3899.45 µs/op
```

- 実行しているマシンが違うので結果は[YouTube](https://www.youtube.com/watch?v=uCkPyfFhPxI)とは違いますが傾向は同じなので成功でしょう
    - git clone しかしていないような……
    - いやいや `mix bench` なるものははじめて知ったし、「人類にとっては小さな一歩だが、[@torifukukaiou](https://twitter.com/torifukukaiou)にとっては大きな飛躍である!」 
        - あれ！？
- 私が実行しているマシン
    - macOS Mojave バージョン 10.14.6
    - MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
    - プロセッサ 2.5GHz Intel Core i7
    - メモリ 16 GB 2133 MHz LPDDR3
    - グラフィックス Intel Iris Plus Graphics 640 1536 MB

# 少し中身をみてみる
- lib/sample.exの中に以下が定義されている
    - [Sample.logistic_map](https://github.com/zeam-vm/pelemay/blob/7efbe5a2757466a77a7b2450ec15737efa7b62f2/lib/sample.ex#L51): use [Pelemay](https://github.com/zeam-vm/pelemay)
        - defpelemayっていうので包まれている感じ
    - [Sample.flow_logistic_map](https://github.com/zeam-vm/pelemay/blob/7efbe5a2757466a77a7b2450ec15737efa7b62f2/lib/sample.ex#L80): use [Flow](https://github.com/plataformatec/flow)
    - [Sample.enum_logistic_map](https://github.com/zeam-vm/pelemay/blob/7efbe5a2757466a77a7b2450ec15737efa7b62f2/lib/sample.ex#L66): use [Enum](https://hexdocs.pm/elixir/Enum.html)
- defpelemayの下のいくつかの関数はベンチマークのDemoには関係なさそうにみえたので消してみる
    - `mix bench` うん、うごいた、うごいた

```diff
diff --git a/lib/sample.ex b/lib/sample.ex
index ca73ee0..855d56c 100644
--- a/lib/sample.ex
+++ b/lib/sample.ex
@@ -20,34 +20,6 @@ defmodule Sample do

   defpelemay do
-    def list_minus_2(list) do
-      list
-      |> Enum.map(&(&1 - 2))
-    end
-
-    def list_plus_2(list) do
-      list
-      |> Enum.map(fn x -> x + 2 end)
-    end
-
-    def list_mult_2(list) do
-      list
-      |> Enum.map(fn x -> x * 2 end)
-    end
-
-    def list_div_2(list) do
-      list
-      |> Enum.map(&(&1 / 2))
-    end
-
-    def list_mod_2(list) do
-      list |> Enum.map(&rem(&1, 2))
-    end
-
-    def list_mod2_plus1(list) do
-      list |> Enum.map(&(rem(&1, 2) + 1))
-    end
-
     def logistic_map(list) do
       list
       |> Enum.map(&rem(22 * &1 * (&1 + 1), 6_700_417))
```
- 余りを計算することを繰り返しているとおもうのですが、6700417ってなにだろう?
    - [第五フェルマー数の余素因数](http://integers.hatenablog.com/entry/2016/05/09/212026)
    - これかな?
    - あっていたとしても ??? なのですがアタクシには

- bench/logistic_map_bench.exs にベンチマーク用のコードが書いてある




