---
title: ローカルで動いているのにCIではmix dialyzerが通らない -> それ、dialyxirの追加の仕方に問題あるのだとおもうよ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-05T21:44:25+09:00'
id: 35454d3faaaa0d142ae6
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**できない理由はできることの証拠だ。できない理由を解決すればよい。**

Advent Calendar 2022 34日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

<font color="purple">$\huge{私が悪い}$</font>
のです。
**さきに謝っておきます**。

先日参加した「[tokyo.ex #15 ハンズオン回](https://beam-lang.connpass.com/event/237008/)」で、私は苦戦したことがありました。

https://beam-lang.connpass.com/event/237008/

それは、ローカルで動いている`mix dialyzer`が、[CircleCI]()で動かそうとすると、動かないのです。

もう一度いいます。
<font color="purple">$\huge{悪いのは私め}$</font>
でございます。
申し訳ありません。
なにが原因だったのかを記録しておきます。
そして私の記憶に定着させます。

「[tokyo.ex #15 ハンズオン回](https://beam-lang.connpass.com/event/237008/)」のレポートは以下に書いております。
[資料](https://github.com/ohr486/ElixirHandsOn20220130)がとても充実しています！

https://qiita.com/torifukukaiou/items/66712937788863cc9f18


# 失敗例

https://app.circleci.com/pipelines/github/TORIFUKUKaiou/tokyoex15_demo/6/workflows/d5b9f355-0604-470a-9947-b10e39fbb1cc/jobs/6

![スクリーンショット 2022-02-04 4.31.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cd48b9ab-ff49-2ec9-3c1e-f63874d8800b.png)

Mixタスクがみつからないですと〜〜〜 :sob::sob::sob: 

## 関連するファイル

https://github.com/jeremyjh/dialyxir/blob/a1438f7810d7506485747194e6ac9ea358793e09/README.md の記載をそのままコピペしました


```elixir:mix.exs
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false}
    ]
  end
```


```yml:.circleci/config.yml
version: 2

jobs:
  build:
    docker:
      - image: circleci/elixir:1.13-node
        environment:
          MIX_ENV: test
          MIX_TEST_DB_HOST: localhost

      - image: circleci/postgres:9.6
        environment:
          POSTGRES_USER: postgres
          POSTGRES_DB: demo_test
          POSTGRES_PASSWORD: postgres

    working_directory: ~/app

    steps:
      - checkout
      - run: mix local.hex --force
      - run: mix local.rebar --force
      - run: mix archive.install --force hex phx_new
      - run: mix do deps.get, compile
      - run: mix test
      - run: mix dialyzer
```

これだと、`** (Mix) The task "dialyzer" could not be found`なわけです。

# 正解例 :tada::tada::tada:

`:test`を追加しています。

```elixir:mix.exs
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false}
    ]
  end
```

だって、`MIX_ENV: test`なのですから。
`.circleci/config.yml`は、さきほどと変わっていません。

```yml:.circleci/config.yml
version: 2

jobs:
  build:
    docker:
      - image: circleci/elixir:1.13-node
        environment:
          MIX_ENV: test
          MIX_TEST_DB_HOST: localhost

      - image: circleci/postgres:9.6
        environment:
          POSTGRES_USER: postgres
          POSTGRES_DB: demo_test
          POSTGRES_PASSWORD: postgres

    working_directory: ~/app

    steps:
      - checkout
      - run: mix local.hex --force
      - run: mix local.rebar --force
      - run: mix archive.install --force hex phx_new
      - run: mix do deps.get, compile
      - run: mix test
      - run: mix dialyzer
```

そうすると、`test/`配下も対象になっちゃうからまあ外しておいてもいいかな。
ignoreかな〜

```elixir:.dialyzer_ignore.exs
[
  ~r/test\/.+\.ex/,
]
```

# 「[tokyo.ex #15 ハンズオン回](https://beam-lang.connpass.com/event/237008/)」での成果

成果物は

https://github.com/TORIFUKUKaiou/tokyoex15_demo

です。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


ローカルで動いたはずなのにCIで`mix dialyzer`などのMixタスクが通らない場合には、以下を確認してみてください。

- CIでのMIX_ENVは何にして動かしていますでしょうか
- `mix.exs`のHexの追加の仕方をみなおすか、CIの設定ファイルの方を変えるかしてみましょう

以上です。




---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-03])
110
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


---


# [Elixir](https://elixir-lang.org/)

最後の最後に、[Elixir](https://elixir-lang.org/)について紹介します。

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でスイスイ、プログラミングしていくことができる素敵なプログラミング言語です
- さっそくプログラムの例を示します
- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています
- ここでは雰囲気をつかんでいただければ大丈夫です

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## もっと[Elixir](https://elixir-lang.org/)のことを知りたい方へオススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト − 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- KADOKAWA

## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
([EDI／fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com/) ＆ [LiveView JP](https://liveviewjp.connpass.com/) の @piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)



# <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方 －国内オンライン編－**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian
[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@kn339264) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)



---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





