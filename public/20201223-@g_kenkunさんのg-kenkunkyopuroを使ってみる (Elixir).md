---
title: '@g_kenkunさんのg-kenkun/kyopuroを使ってみる (Elixir)'
tags:
  - Elixir
private: false
updated_at: '2021-01-03T14:04:42+09:00'
id: 0d9af23244d599cb60d0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) **25日目(最終日)** です。
前日は [@tamanugiさんのex_at_coderを使ってみる (Elixir)](https://qiita.com/torifukukaiou/items/3cb86dede8aefa2cd7c0) でした。
走りきりました！
@mnishiguchi さん、ありがとうございます！

---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang:
- @g_kenkunさんの[g-kenkun/kyopuro](https://github.com/g-kenkun/kyopuro)を使ってみます
    - 2020/12/23現在、[AtCoder](https://atcoder.jp/)と[YukiCoder](https://yukicoder.me/)に対応しているとのことです

## What is [AtCoder](https://atcoder.jp/)?
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、最近はじめました

# プロジェクト作成

```
$ mkdir awesome_at_coder2
$ cd awesome_at_coder2
$ asdf local elixir 1.10.2-otp-22
$ mix new .
```
- 2020/12/20現在、[AtCoder](https://atcoder.jp/)で使える[Elixir](https://elixir-lang.org/)のバージョンが`1.10.2`なのであわせています
    - あ、私は[asdf](https://asdf-vm.com/#/)でバージョンの切り替えを行っています

> このパッケージで使用しているhtml5everパッケージはNifsにRustを使用しているので、予めRustの環境を構築する必要があります。

とのことです。
[Rust をインストール](https://www.rust-lang.org/ja/tools/install) に従いインストールしました。
<font color="purple">$\huge{Rust をインストール}$</font>
あ、私はmacOS 10.15.7を使っています

```
$ curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
$ source $HOME/.cargo/env
$ rustc --version
rustc 1.48.0 (7eac88abb 2020-11-16)
```

```elixir:mix.exs
  defp deps do
    [
      {:kyopuro, "~> 0.4.0"}
    ]
  end
```

```
$ mix deps.get
```

とりあえずここで、`mix test`やってみよう。

```elixir
$ mix test
...
==> kyopuro
warning: the dependency :kyopuro requires Elixir "~> 1.11" but you are running on v1.10.2
Compiling 10 files (.ex)

== Compilation error in file lib/kyopuro/at_coder/client.ex ==
** (CompileError) lib/kyopuro/at_coder/client.ex:8: cannot find or invoke local is_struct/2 inside guard. Only macros can be invoked in a guard and they must be defined before their invocation. Called as: is_struct(error, Mint.TransportError)
    (elixir 1.10.2) lib/kernel/utils.ex:213: Kernel.Utils.defguard/3
    (elixir 1.10.2) expanding macro: Kernel.Utils.defguard/2
    lib/kyopuro/at_coder/client.ex: Kyopuro.AtCoder.Client.is_transport_error/1
could not compile dependency :kyopuro, "mix compile" failed. You can recompile this dependency with "mix deps.compile kyopuro", update it with "mix deps.update kyopuro" or clean it with "mix deps.clean kyopuro"
```

- なんかエラーがでた
- たぶん、Elixir 1.11以上を使えばいいのかな

```elixir
$ asdf local elixir 1.11.2-otp-23

$ elixir -v
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.11.2 (compiled with Erlang/OTP 23)

$ mix test

...
Generated awesome_at_coder2 app
..

Finished in 0.03 seconds
1 doctest, 1 test, 0 failures
```



- 準備は整いました :tada::tada::tada:

# https://atcoder.jp/contests/abc185 をやってみます
- [README](https://github.com/g-kenkun/kyopuro/blob/6d15826861dc2c3fea46a9b1ec598d48b6118bdc/README.md)に従って進めます

```elixir:config/config.exs
import Config

config :kyopuro,
    username: "awesomey", # ← 雑魚🐟　ご自身のアカウントに置き換えてね。いまは雑魚だけどいつまでも雑魚だとは言わない。いつかは大海原を自由に泳ぎ回りたい。
    password: "secret"
```

```elixir
$ mix kyopuro.login

...
==> awesome_at_coder2
Compiling 1 file (.ex)
Generated awesome_at_coder2 app
* creating .cookie
```

```elixir
$ mix kyopuro.new abc185

* creating lib/awesome_at_coder2/abc185/a.ex
* creating test/awesome_at_coder2_test/abc185/a_test.exs
* creating lib/awesome_at_coder2/abc185/b.ex
* creating test/awesome_at_coder2_test/abc185/b_test.exs
* creating lib/awesome_at_coder2/abc185/c.ex
* creating test/awesome_at_coder2_test/abc185/c_test.exs
* creating lib/awesome_at_coder2/abc185/d.ex
* creating test/awesome_at_coder2_test/abc185/d_test.exs
* creating lib/awesome_at_coder2/abc185/e.ex
* creating test/awesome_at_coder2_test/abc185/e_test.exs
* creating lib/awesome_at_coder2/abc185/f.ex
* creating test/awesome_at_coder2_test/abc185/f_test.exs
```

- すごい! すごい! めちゃ速い :rocket::rocket::rocket:
- 問題ページからテストケースが作成されたっぽい
- とりあえずA問題のテストを実施してみます


```elixir
$ mix test

...
Finished in 0.1 seconds
1 doctest, 20 tests, 19 failures
```

- 期待通り失敗

# [A - ABC Preparation](https://atcoder.jp/contests/abc185/tasks/abc185_a)を解く
- ここからは自分の力を信じてがんばるしかありません
- がんばってみましょう 💪
- 問題文はリンク先をご参照ください


## ひとりごと
<details><summary>自分で解きたい人はみないでください</summary>
ふむふむ、4つ整数を読み取って最小のものを答えにすればいいのだな
こんな感じだな
![スクリーンショット 2020-12-25 0.26.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/39befc35-33d5-d70e-0e5f-31aee125ffd5.png)


コードスニペット貼るとうまく折りたたまれなかったので画像です
</details>

## ソースコードができたらもう一回テストしてみましょう

```elixir
$ mix test test/awesome_at_coder2_test/abc185/a_test.exs 
Compiling 1 file (.ex)
..

Finished in 0.03 seconds
2 tests, 0 failures
```

- Yay!!! :tada::tada::tada:
- これで自信をもって提出できます :rocket::rocket::rocket:

# 提出

```
mix kyopuro.submit abc185 a
```

- [提出結果](https://atcoder.jp/contests/abc185/submissions/18945226)
    - やったね :tada::tada::tada:
- そういえば提出のときにモジュール名を`Main`にしてくれているなあー :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:
    - https://github.com/g-kenkun/kyopuro/blob/6d15826861dc2c3fea46a9b1ec598d48b6118bdc/lib/kyopuro/at_coder.ex#L225-L226
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- すごいです！　便利です！
- 問題文をスクレイピングして自動でテストケース作ってくれて<font color="purple">ありがとナイス:flag_cn:</font>です
- 私は「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」という記事を書いたことがあります
    - この記事では[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書いて解いていきましょう！　みたいなことを**すゝめ**ています
    - 手動で作っています
    - 私は、**いつも手動です**
    - **いつもいつもいつも手動です**
    - **本当に根っからいつもいつもいつもいっつも手動です**
    - [AtCoder](https://atcoder.jp/)をやったことある人ならわかるとおもいますが、コピペで[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)を書くにはつらいInputやOutputがあるわけです
    - それでもコピペでできるので、いつも同じことを繰り返していました
- こんなところをちょっと立ち止まって自動化してみよう！ という発想ができることがうらやましいです
    - 私はこういうことがそもそも思いつかない頭の回路になっているようです :japanese_ogre:
    - 育っててきた環境が違うから好き嫌いは否めない セロリが好きだったりするのね :microphone::microphone::microphone:
- そして思いついた不便を解消することを実現されている! 
    - ただただすごいです！
- [g-kenkun/kyopuro](https://github.com/g-kenkun/kyopuro)のソースコードは斜め読みくらいしかできていませんが、キレイに書かれていてやっていることはだいたいわかった(何、目線:sunglasses::interrobang:)ので、これからも使っていってもしなにかあったら[Issues](https://github.com/g-kenkun/kyopuro/issues)をあげるとともにできることなら改善案もご提案したいとおもっています :rocket::rocket::rocket: (もしなにかあったら)
    - **おもっています** (あくまでも、**おもっています**)
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:

この記事を書いた時間 45 分くらい。

ありがとう！ [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)
<font color="purple">$\huge{毎日が12月だったらいいのに！}$</font>

![スクリーンショット 2020-12-23 22.32.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1fa98310-06ea-8a66-4f1b-7aee150db15a.png)

![スクリーンショット 2020-12-23 22.33.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/65b560d2-65ea-6dcf-91dd-1f15809e40b7.png)


|日にち|タイトル|カレンダー|
|-----------:|:------------|:------------:|
|2020/12/01|[「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる](https://qiita.com/torifukukaiou/items/a7b1b1545a93170eee62)|[求ム！Cloud Nativeアプリケーション開発のTips！【PR】日本マイクロソフト](https://qiita.com/advent-calendar/2020/azure-cloudnative)|
|2020/12/01|[[87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]](https://qiita.com/torifukukaiou/items/badb4725a9c17788f8b1)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/02|[LiveView uploadsを動かす 🎉🎉🎉(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/c2b21e3658059927b577)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/03|[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)|[Elixir](https://qiita.com/advent-calendar/2020/elixir)|
|2020/12/03|[ElixirでAtCoderのABC123を解いてみる！](https://qiita.com/torifukukaiou/items/75d5db21d98fdf4459e2)|[fukuoka.ex Elixir／Phoenix](https://qiita.com/advent-calendar/2020/fukuokaex)|
|2020/12/03|[Surfaceをつかってみる(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/b5ae9eac42bd304b7aa3)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/03|[Nervesで湯婆婆を実装してみる](https://qiita.com/torifukukaiou/items/5f68fbc1b151b137d5d1)|[#NervesJP](https://qiita.com/advent-calendar/2020/nervesjp)|
|2020/12/03|[Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9)|[湯婆婆](https://qiita.com/advent-calendar/2020/yubaba)|
|2020/12/04|[とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 (Elixir)](https://qiita.com/torifukukaiou/items/100afafe1920eb72b339)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/05|[二次元リストの操作(Elixir)](https://qiita.com/torifukukaiou/items/8d67e857cdfb8fa4657c)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/05|[I was born to love Elixir](https://qiita.com/items/33e3471aaab6d863aecf)|[プログラミング技術の変化で得られた知見・苦労話【PR】パソナテック](https://qiita.com/advent-calendar/2020/pasonatech-experience)|
|2020/12/06|[次の関数の第二引数なんだよなー(Elixir)](https://qiita.com/torifukukaiou/items/6d6ac7b4938b9ff5e6db)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/07|[WindowsでIExで日本語を使う(iex --werl) (Elixir)](https://qiita.com/torifukukaiou/items/34406dd5b6b386f1ef9e)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/07|[Azure Container InstancesでNervesアプリを開発する](https://qiita.com/torifukukaiou/items/998d6539e4adcd1816b3)|[Docker](https://qiita.com/advent-calendar/2020/docker)|
|2020/12/08|[CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/1e266c7b213cdd3fd58e)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/09|[Nervesで書き込める場所 (Elixir)](https://qiita.com/torifukukaiou/items/9dd5cfa81109a2e0a5eb)|[#NervesJP](https://qiita.com/advent-calendar/2020/nervesjp)|
|2020/12/09|[HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get (Elixir)](https://qiita.com/torifukukaiou/items/3890d4ea8220f44c7e0a)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/10|[1 = a (プログラミングElixir 第2版)](https://qiita.com/torifukukaiou/items/14ad8b9673bd47ce8b8f)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/10|[Raspberry Pi 4 + Grove Base HAT for Raspberry Pi + Grove Buzzer + Grove ButtonでつくるNervesアラーム](https://qiita.com/torifukukaiou/items/d24749203b1586b5685a)|[Raspberry Pi](https://qiita.com/advent-calendar/2020/raspberry-pi)|
|2020/12/11|[NimbleCSVのご紹介(Elixir)](https://qiita.com/torifukukaiou/items/9e9e28411d6a7d134a11)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/11|[Nervesならできるもん！ &#124;> 本当にできんのか！ (Elixir)](https://qiita.com/torifukukaiou/items/dc54108e4a1f1cb3a650)|[Raspberry Pi](https://qiita.com/advent-calendar/2020/raspberry-pi)|
|2020/12/12|[String.replace/3 (Elixir)](https://qiita.com/torifukukaiou/items/71f4b80d8f7dddf87293)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/12|[「kentaro/mix_tasks_upload_hotswap」を試してみる！　ご本人が参加していらっしゃるカレンダーにて](https://qiita.com/torifukukaiou/items/6adf153ee3893fd1ad4d)|[#NervesJP](https://qiita.com/advent-calendar/2020/nervesjp)|
|2020/12/13|[GigalixirでPORTを4000以外の値にするのはだめよ (Elixir)](https://qiita.com/torifukukaiou/items/a570e8baa337c73f011a)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/13|[Grove Base HAT for RasPiは真っ直ぐグイっとさす](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad)|[Seeed UG](https://qiita.com/advent-calendar/2020/seeed_ug)|
|2020/12/14|[Grove - Buzzer をNervesで鳴らす](https://qiita.com/torifukukaiou/items/19fecf95b9313b8a2b8a)|[Seeed UG](https://qiita.com/advent-calendar/2020/seeed_ug)|
|2020/12/15|[グラフうねうね (動かし方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/3926fe3740e229594c8f)|[#NervesJP](https://qiita.com/advent-calendar/2020/nervesjp)|
|2020/12/16|[Macro.camelize/1 (Elixir)](https://qiita.com/torifukukaiou/items/7d37d43349d6efb8329e)|[何でもOKなカレンダー](https://qiita.com/advent-calendar/2020/allgenresfk)|
|2020/12/17|[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)|[競技プログラミング](https://qiita.com/advent-calendar/2020/competitive-programming)|
|2020/12/18|[GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified) 〜Nervesならできるもん！〜](https://qiita.com/torifukukaiou/items/0b1faacfdaa1cf217bec)|[Seeed UG](https://qiita.com/advent-calendar/2020/seeed_ug)|
|2020/12/19|[0埋め (Elixir)](https://qiita.com/torifukukaiou/items/df3c28dd6ee5cb9c526e)|[何でもOKなカレンダー](https://qiita.com/advent-calendar/2020/allgenresfk)|
|2020/12/20|[[Elixir]Qiitaの自分の記事をエクスポートする](https://qiita.com/torifukukaiou/items/5ed277b219da1731dc78)|[何でもOKなカレンダー](https://qiita.com/advent-calendar/2020/allgenresfk)|
|2020/12/21|[1260 (Elixir 1.11.2-otp-23)](https://qiita.com/torifukukaiou/items/a8f2eb1cf96e9cf385d8)|[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/21|[ここがへんだよ GET /api/v2/items (Elixir)](https://qiita.com/torifukukaiou/items/6ea18016983cd66bdebd)|[何でもOKなカレンダー](https://qiita.com/advent-calendar/2020/allgenresfk)|
|2020/12/22|[String.jaro_distance/2 (Elixir)](https://qiita.com/torifukukaiou/items/183f688f86bf6210ff03)|[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/23|[「動的計画法を使う問題をElixirで関数型っぽく解いてみる」のFibonacci3をガード節を使って書き直してみる](https://qiita.com/torifukukaiou/items/5cb11e04d3041b6ac3ca)|[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/24|[@tamanugiさんのex_at_coderを使ってみる (Elixir)](https://qiita.com/torifukukaiou/items/3cb86dede8aefa2cd7c0)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/25|[@g_kenkunさんのg-kenkun/kyopuroを使ってみる (Elixir)](https://qiita.com/torifukukaiou/items/0d9af23244d599cb60d0)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/25|[グラフうねうね (作り方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/e3056efc3d2c62600fa2)|[名前は聞いたことあるけど使ったことないやつをせっかくだから使ってみる](https://qiita.com/advent-calendar/2020/sekkaku)|


ありがとう！ [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)
<font color="purple">$\huge{毎日が12月だったらいいのに！}$</font>

こちらに[Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)の私のまとめを書きました。
ぜひご覧ください :rocket::rocket::rocket: 
:christmas_tree::gift::point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5::gift::christmas_tree: 
**[グラフうねうね (作り方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/e3056efc3d2c62600fa2)**
:christmas_tree::gift::point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5::gift::christmas_tree:

