---
title: Third-party JS packages on Phoenix 1.6 (2021/12/12)
tags:
  - Elixir
  - Phoenix
  - LiveView
  - autoracex
private: false
updated_at: '2021-12-12T09:45:56+09:00'
id: c006fab0621630398d4a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/12(日)の回です。
前の日は、**水力発電所のオープンソース化**で有名な[kochi.ex](https://kochi-ex.connpass.com/)で活動されている@nishiuchikazumaさんによる『[Nervesにユーザ名／パスワードでSSHログインする](https://qiita.com/nishiuchikazuma/items/80942febe11add1f405c)』でした。
とりあえず[Nerves](https://www.nerves-project.org/)に触れてみましょう！　的なハンズオンなどでファームウェアを配るときに活用するとよいのではないかとおもいました。

# はじめに
[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Phoenix](https://www.phoenixframework.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[#NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)のカレンダーですが、[Phoenix](https://www.phoenixframework.org/)の話題を書きます。

> ぶっちゃけNerves関係ないけど，こんなんやってみたよ！ (ElixirかIoTくらいは絡んでいればおけ

なので:ok:です、きっと。

もっと言うと、[Nerves](https://www.nerves-project.org/)で作ったアプリケーションが会話する先として、[Phoenix](https://www.phoenixframework.org/)を使うことがあるとおもいます。

たとえば

https://github.com/TORIFUKUKaiou/hello_iot_cloud

なプロジェクトの感じです。
@takasehideki 先生に使っていただきました。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">そうです！<br>大事なことを言い忘れてしまった！このデモの仕込みは <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さんにめっちゃ助けてもらいました．awesome!! あざまっす！！ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://twitter.com/hashtag/DSF2021?src=hash&amp;ref_src=twsrc%5Etfw">#DSF2021</a> <a href="https://t.co/IlbfpPu8dI">https://t.co/IlbfpPu8dI</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1456145709481148420?ref_src=twsrc%5Etfw">November 4, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: は[Phoenix](https://www.phoenixframework.org/) 1.5で作りました。

[Chart.js](https://www.chartjs.org/)等を追加したくなることありますよね、これからもきっと。
[Phoenix](https://www.phoenixframework.org/) 1.6になってからどうやって追加すればいいのかちょっと迷った(ほんのちょっとね、迷走、瞑想をしました)ので、私が掴んだ情報を披露しておきます。

:::note info
Esbuild Hexドキュメントを読むと書いてあるよ!!!
:::


# [Phoenix](https://www.phoenixframework.org/) 1.6 

# 気づいたことをつれづれなるままに

1.6からは`mix phx.new hell_world`これで[LiveView](https://github.com/phoenixframework/phoenix_live_view)つきです。
逆に俺にはLiveViewなぞいらぬという御仁のために、`--no-live` Optionが追加されています。

`mix setup`(セラップ)してからの`mix phx.server`して、Visit: `http://localhost:4000`できるようになるまでが、[Phoenix](https://www.phoenixframework.org/) 1.5の時と比べるとメチャクチャ速い:rocket::rocket::rocket:です。
その正体は[Esbuild](https://hex.pm/packages/esbuild) Hexです。
Ownerは[Elixir](https://elixir-lang.org/)作者である[José Valim](https://twitter.com/josevalim)さんで、安心です。

名前がいっしょだから紛らわしいですが結局のところ、**[esbuild](https://esbuild.github.io/) -- An extremely fast JavaScript bundler**が使われています。
詳しいことを知りたい方は、@koga1020 さんが、『[Elixirのesbuildラッパーは何をしているのか](https://zenn.dev/koga1020/articles/f146688545cd93d110ab)』にて解説してくださっていますので、こちらの記事をご参照ください[^1]:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:。

[^1]: と言って、私は足早に立ち去ります。ごめん、私には説明できません。『[Elixirのesbuildラッパーは何をしているのか](https://zenn.dev/koga1020/articles/f146688545cd93d110ab)』はコンパクトにまとまっているし、とてもわかりやすいです。ありがとうございます！ 理解できた気になりました！

![スクリーンショット 2021-11-21 22.50.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/369d91a0-69e6-ab65-b956-7929a7202ed8.png)

(https://esbuild.github.io/)

これです。
まさにこの通りです。
[Phoenix](https://www.phoenixframework.org/) 1.5では、webpackerが使われていました。
[Phoenix](https://www.phoenixframework.org/) 1.6では、**[esbuild](https://esbuild.github.io/) -- An extremely fast JavaScript bundler**が使われています。


## 3rd PartyのJS Packageを追加する

3rd PartyのJS Packageを追加したいとおもいました。
フロントエンドに詳しい方ならなんてことはないのでしょうが、[Phoenix](https://www.phoenixframework.org/) 1.5と1.6では雰囲気が全然違いまして、どうやって追加するのだろう？　私は途方に暮れそうになりました。

```1.5
├── assets
│   ├── .babelrc
│   ├── css
│   │   ├── app.css
│   │   └── phoenix.css
│   ├── js
│   │   └── app.js
│   ├── package.json
│   ├── static
│   │   ├── favicon.ico
│   │   ├── images
│   │   │   └── phoenix.png
│   │   └── robots.txt
│   └── webpack.config.js
```

```:1.6
├── assets
│   ├── css
│   │   ├── app.css
│   │   └── phoenix.css
│   ├── js
│   │   └── app.js
│   └── vendor
│       └── topbar.js
```

なんか少ない...
`package.json`がない...

どうすりゃいいのさ？　って悩んでいるFRIENDもいたみたい。

https://elixirforum.com/t/webpack-config-and-package-json-missing-from-new-liveview-project-mix-phx-new-app-live/43378

## こたえ

https://github.com/phoenixframework/esbuild#third-party-js-packages

に書いてあります。
２つ方法があります。

1. `assets/vendor`にJSを置きましょう
1. `assets`フォルダ配下で、`npm install chart.js --save`

その他公式ドキュメントとしては、

https://hexdocs.pm/phoenix/1.6.2/asset_management.html#content

に、[esbuild](https://esbuild.github.io/)ではないビルドシステムを使う方法が書かれています。

また

https://cloudless.studio/wrapping-your-head-around-assets-in-phoenix-1-6

のブログはわかりやすかったです。
[Esbuild](https://hex.pm/packages/esbuild) Hexは外しちゃって、**[esbuild](https://esbuild.github.io/) -- An extremely fast JavaScript bundler**をJSのまま使うとでも申しましょうか、**esbuild + NPM combo(The best of both worlds)**と紹介されています。
_実を言うと、私は先にこちらに飛びついて、そのあと https://github.com/phoenixframework/esbuild#third-party-js-packages をみつけました_


Thanks!

# `assets`フォルダ配下で、`npm install chart.js --save` 実践

をやってみます。

## 準備
https://hexdocs.pm/phoenix/installation.html#content

を参考にインストールを済ましておいてください。
`npm install ...`ができるようにしておいてください。

## さっそくつくるぜよ

```bash
$ mix phx.new hello --no-ecto
$ cd hello
$ mix setup
$ cd assets
$ npm install chart.js --save
$ cd ..
```

`npm install chart.js --save`で、

- assets/package.json
- assets/package-lock.json

が作られます。

```json:assets/package.json
{
  "dependencies": {
    "chart.js": "^3.6.0"
  }
}
```

https://www.chartjs.org/docs/latest/getting-started/

とりあえずここと同じものを表示してみます。

<font color="purple">$\huge{はい！\ できました}$</font>

![スクリーンショット 2021-11-22 0.02.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8ba1ad2e-ded1-c2be-8ae4-5bba53d7523b.png)

説明が面倒になってきたし、雰囲気でJS -> [Elixir](https://elixir-lang.org/)の置き換えを私はしているだけなのでソースコードを全部載っけておきます。
なんとなく感じてください！！！

ドキュメントは

https://hexdocs.pm/phoenix_live_view/js-interop.html#content

です。

```elixir:lib/hello_web/live/chart_live.ex
defmodule HelloWeb.ChartLive do
  use HelloWeb, :live_view

  def mount(_params, _session, socket) do
    labels = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
    ]
    data = %{
      labels: labels,
      datasets: [%{
        label: "My First dataset",
        backgroundColor: "rgb(255, 99, 132)",
        borderColor: "rgb(255, 99, 132)",
        data: [0, 10, 5, 2, 20, 30, 45],
      }]
    }
    config = %{type: "line",
              data: data,
              options: %{}}

    socket = assign(socket, :config, config)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <canvas id="myChart"
              phx-hook="Chart"
              data-chart-data={ Jason.encode!(@config) }>
      </canvas>
    </div>
    """
  end
end
```

```diff:lib/hello_web/router.ex
   scope "/", HelloWeb do
     pipe_through :browser
 
     get "/", PageController, :index
+    live "/chart", ChartLive
   end
```


```js:assets/js/hooks.js
import Chart from 'chart.js/auto';

let Hooks = {};

Hooks.Chart = {
  mounted() {
    const config = JSON.parse(this.el.dataset.chartData)
    this.chart = new Chart(this.el, config)
  }
}

export default Hooks;
```

```diff:assets/js/app.js
 import {Socket} from "phoenix"
 import {LiveSocket} from "phoenix_live_view"
 import topbar from "../vendor/topbar"
 
+import Hooks from "./hooks";
+
 let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
-let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})
+let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})
```

```json:assets/package.json
{
  "dependencies": {
    "chart.js": "^3.6.0"
  }
}
```

# [Gigalixir](https://www.gigalixir.com/)

ついでに。
知っていることを書いておきます。
[Gigalixir](https://www.gigalixir.com/)にデプロイするときは、`assets/package.json`に書き足しておく必要があるものがあります。

https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html#specify-versions

に書いてあります。

> If you’re using Phoenix v1.6, it uses esbuild to compile your assets but Gigalixir images come with npm, so we will configure npm directly to deploy our assets. Add a assets/package.json file if you don’t have any with the following:

```json:assets/package.json
{
  "scripts": {
    "deploy": "cd .. && mix assets.deploy && rm -f _build/esbuild"
  },
  "dependencies": {
    "chart.js": "^3.6.0"
  }
}
```

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:
Enjoy [Phoenix](https://www.phoenixframework.org/):bangbang::bangbang::bangbang:


**人間五十年 下天の内をくらぶれば、夢幻のごとくなり。一度生を得て滅せぬ者のあるべきか**

**時は今あめが下知る五月かな**

**露と落ち露と消えにしわが身かななにはのことも夢のまた夢**

**親思ふ心にまさる親心 今日のおとづれ何と聞くらん**

---

# おまけ

[Elixir](https://elixir-lang.org/)を始めてみよう！　とおもった、あなたに参考情報(クリスマス🎄プレゼント)を贈ります。:gift::gift::gift:
**思い立ったが吉日です!!!**

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- 角川文庫

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
-  [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
