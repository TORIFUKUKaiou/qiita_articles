---
title: グラフうねうね (作り方 編) (Elixir/Phoenix)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2021-11-28T11:26:47+09:00'
id: e3056efc3d2c62600fa2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
この記事は、[名前は聞いたことあるけど使ったことないやつをせっかくだから使ってみる Advent Calendar 2020](https://qiita.com/advent-calendar/2020/sekkaku) **25日目(最終日)** です。

---

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [Phoenix](https://www.phoenixframework.org/)というWebアプリケーションフレームワークがありましてですね、今回はこれを楽しみたいとおもいます
- macOS 10.15.7 を使っています

# 準備
- ここがまあ、いろいろあるわけですが
- 公式の[Installation](https://hexdocs.pm/phoenix/installation.html#content)に従ってください
    - [Elixir](https://elixir-lang.org/) 1.6 or later(2020/12/24現在の最新は1.11)
    - [Erlang](https://www.erlang.org/) 20 or later(2020/12/24現在の最新は23)
    - phx_new
    - node.js
    - PostgreSQL
        - Phoenix assumes that our PostgreSQL database will have a postgres user account with the correct permissions and a password of "postgres".
    - inotify-tools (for linux users)
    - リンクも豊富に貼ってありますので、**思い切って僕の胸に飛び込んで来てほしい**
- [Elixir](https://elixir-lang.org/)のインストールは、手前味噌ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などをご参照ください

## うまくいかなかったら
- 何事にも準備が肝心です
- ここが一番つまらないし、謎にハマってしまうことが多いのですが、がんばってください！
- うまくいかなかったら、**思い切って僕の胸に飛び込んで来てほしい** (by 長嶋茂雄 読売ジャイアンツ終身名誉監督)
    - [elixirjp.slack.com slack workspace](https://elixirjp.slack.com/join/shared_invite/enQtODE0NjM3NTIyNTMzLTU5NmViZDE4N2Q3MGUyMmI5YTdlNmQ2ZDI4ZDgxZGZiYTVlYmJjOTMzYzk2NGUyMjBhMTBiNDdjYTg3ZjhmYWI)か[NervesJP workspace](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)に入ってきていただいて、`@torifukukaiou`へご質問ください
    - たとえ私が答えられなくても、マジみんな親切で優しい人が多いので、きっと解決できるでしょう:bangbang:

# mix phx.new

```
$ mix phx.new nerves_jp_chart --live
$ cd nerves_jp_chart
$ mix setup
$ mix phx.server
```

- visit http://localhost:4000 or http://127.0.0.1:4000

![welcome-to-phoenix.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d10d94d9-9bd2-9a63-0ed6-324a503f02f0.png)

- こんなのがブラウザに表示されましたでしょうか
- もし表示されない場合はなにかしら不足している等でエラーがでているとおもいますので、エラーをひとつひとつ根気よく丁寧につぶしてください
- ここを確実にしておかないと、楽しめないですよ！

# ソースコードを書く

:::note warn
この記事は2020年12月24日に書いたものです。その後の見直しはしていません。ソースコードではChart.js 2.9.4を使っています。その当時もバージョン3は合ったような気がしますが、イゴくことを優先してまた執筆当時事例が多かった2系を使いました。Phoenixのバージョンが古いです。とりあえず動いてはいますが、Elixirで書いたプログラムをはじめいろいろなところが穴だらけです。:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:更新したいとはおもっています（あくまでも、おもっています)。
:::

https://github.com/NervesJP/nerves_jp_chart/blob/2a1ca2108e200a0efe887fa928bded9e2388ca1b/lib/nerves_jp_chart_web/live/chart_live.ex#L38

Chart.jsの注意点については、@mnishiguchiさんがコメントを寄せてくれました。
参考にしてください。

https://qiita.com/torifukukaiou/items/e3056efc3d2c62600fa2#comment-3a639f68ad42f0ff17cc


## 完成品
- [NervesJP/nerves_jp_chart](https://github.com/NervesJP/nerves_jp_chart)
    - `git diff 8b19624..`の差分を全部取り込めば同じものができあがります :rocket::rocket::rocket:
- これだと乱暴がすぎるので、
- サンプルのグラフうねうねが動くところまでいっしょにやってみましょうかね

```elixir:lib/nerves_jp_chart_web/live/chart_sample_live.ex
defmodule NervesJpChartWeb.ChartSampleLive do
  use NervesJpChartWeb, :live_view

  def mount(_params, _session, socket) do
    :timer.send_interval(1_000, self(), :next_values)
    socket = assign(socket, values: Jason.encode!([]), users: Jason.encode!([]), cnt: 0)
    {:ok, socket}
  end

  def handle_info(:next_values, socket) do
    new_cnt = socket.assigns.cnt + 1
    new_cnt = min(100, new_cnt)
    values = 1..new_cnt |> Enum.map(fn _ -> :random.uniform() end)
    users = 1..new_cnt |> Enum.map(&"user#{&1}")

    {:noreply,
     assign(socket,
       values: Jason.encode!(values),
       users: Jason.encode!(users),
       cnt: new_cnt
     )}
  end

  def render(assigns) do
    ~L"""
    <div id="data" data-values="<%= @values %>" data-users="<%= @users %>">
    <div phx-update="ignore">
      <canvas id="myChart" phx-hook="chart" width="200" height="200"></canvas>
    </div>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.9.4"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chartjs-plugin-streaming@latest/dist/chartjs-plugin-streaming.min.js"></script>
    <pre><%= @values %></pre>
    """
  end
end
```

```elixir:lib/nerves_jp_chart_web/router.ex
  scope "/", NervesJpChartWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/chart-sample", ChartSampleLive # add
  end
```

```js:assets/js/app.js
/* add start */
let hooks = {}
hooks.chart = {
  mounted() {
    let colors = [
      'rgb(128, 128, 0)',
      'rgb(255, 255, 0)',
      'rgb(255, 0, 255)',
      'rgb(192, 192, 192)',
      'rgb(0, 255, 255)',
      'rgb(0, 255, 0)',
      'rgb(255, 0, 0)',
      'rgb(128, 128, 128)',
      'rgb(0, 0, 255)',
      'rgb(0, 128, 0)',
      'rgb(128, 0, 128)',
      'rgb(0, 0, 0)',
      'rgb(0, 0, 128)',
      'rgb(0, 128, 128)',
      'rgb(128, 0, 0)',
    ]

    var ctx = this.el.getContext('2d');
    new Chart(ctx, {
      // The type of chart we want to create
      type: 'line',
      // The data for our dataset
      data: {
        datasets: []
      },
      // Configuration options go here
      options: {
        scales: {
          xAxes: [{
            type: 'realtime',
            realtime: {
              delay: 2000,
              onRefresh: function(chart) {
                let len_datasets = chart.data.datasets.length;
                let dataEl = document.querySelector('#data');
                let len_users = JSON.parse(dataEl.dataset.users).length;
                for (let i = 0; i < (len_users - len_datasets); i++) {
                  chart.data.datasets.push({borderColor: colors[Math.floor(Math.random() * colors.length)], data: []})
                }

                chart.data.datasets.forEach(function(dataset, index) {
                  dataset.label = JSON.parse(dataEl.dataset.users)[index]
                  dataset.data.push({
                    x: Date.now(),
                    y: JSON.parse(dataEl.dataset.values)[index]
                  });
                });
              }
            }
          }]
        }
      }
    });
  }
}
/* add end */

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks}) /* hooks を追加 */
```

- この変更を加えたあとに
- visit http://localhost:4000/chart-sample or http://127.0.0.1:4000/chart-sample
- に訪れてみてください
- なかなかのうねうねが見えるのではないでしょうか :interrobang:

# `git diff 8b19624..`にはもっと多くの差分があるよ
- Yes, it is.
- 2020/12/27開催の[【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)では、みなさまのRaspberry Piからデータを打ち上げてもらうハンズオンを行いました(もう過去形:bangbang:)
- その関係でいろいろありますですよ
    - データ保存関係のいろいろを追加しています
    - Dockerで動かすためのいろいろを追加しています
    - デプロイしやすいように変更を加えています
    - まあ、そんなところです
- JS側の`onRefresh`で1秒ごとのタイミングをとって描画しているのですが、もっといい[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)らしい書き方があるかもしれません
    - <font color="purple">$\huge{ぜひおしえてください!!!}$</font>


```
$ git diff 8b19624.. --stat
 .env.sample                                                     |   3 +
 .gitignore                                                      |   2 +
 Dockerfile                                                      |  53 +++++++++++++++++
 README.md                                                       |  14 +++++
 assets/js/app.js                                                |  62 +++++++++++++++++++-
 config/prod.exs                                                 |   7 ++-
 config/{prod.secret.exs => releases.exs}                        |   6 +-
 docker-compose.yml                                              |  33 +++++++++++
 elixir_buildpack.config                                         |   2 +
 entrypoint.sh                                                   |  14 +++++
 lib/mix/tasks/db_all_delete.ex                                  |  10 ++++
 lib/nerves_jp_chart/accounts.ex                                 |  25 ++++++++
 lib/nerves_jp_chart/accounts/user.ex                            |  18 ++++++
 lib/nerves_jp_chart/measurements.ex                             | 113 +++++++++++++++++++++++++++++++++++++
 lib/nerves_jp_chart/measurements/value.ex                       |  20 +++++++
 lib/nerves_jp_chart/release.ex                                  |  24 ++++++++
 lib/nerves_jp_chart_web/controllers/fallback_controller.ex      |  24 ++++++++
 lib/nerves_jp_chart_web/controllers/humidity_controller.ex      |  26 +++++++++
 lib/nerves_jp_chart_web/controllers/temperature_controller.ex   |  26 +++++++++
 lib/nerves_jp_chart_web/controllers/value_controller.ex         |  46 +++++++++++++++
 lib/nerves_jp_chart_web/live/chart_humidity_live.ex             |  63 +++++++++++++++++++++
 lib/nerves_jp_chart_web/live/chart_live.ex                      |  54 ++++++++++++++++++
 lib/nerves_jp_chart_web/live/chart_sample_live.ex               |  37 ++++++++++++
 lib/nerves_jp_chart_web/live/chart_temperature_live.ex          |  63 +++++++++++++++++++++
 lib/nerves_jp_chart_web/router.ex                               |   8 +++
 lib/nerves_jp_chart_web/templates/layout/root.html.leex         |   3 +
 lib/nerves_jp_chart_web/views/changeset_view.ex                 |  19 +++++++
 lib/nerves_jp_chart_web/views/humidity_view.ex                  |  12 ++++
 lib/nerves_jp_chart_web/views/temperature_view.ex               |  12 ++++
 lib/nerves_jp_chart_web/views/value_view.ex                     |  16 ++++++
 phoenix_static_buildpack.config                                 |   1 +
 priv/repo/migrations/20201106233307_create_users.exs            |  13 +++++
 priv/repo/migrations/20201106234127_create_values.exs           |  14 +++++
 priv/repo/migrations/20201111115618_add_kind_time_to_values.exs |  12 ++++
 test/nerves_jp_chart/measurements_test.exs                      |  70 +++++++++++++++++++++++
 test/nerves_jp_chart_web/controllers/value_controller_test.exs  |  42 ++++++++++++++
 36 files changed, 962 insertions(+), 5 deletions(-)
```

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- この25日間を通して以下のものにはじめて触れたり、理解が進んだりしました
    - [Azure](https://azure.microsoft.com/ja-jp/) :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:
        - [「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる](https://qiita.com/torifukukaiou/items/a7b1b1545a93170eee62):lgtm::lgtm::lgtm:
    - 工作(I2Cとか)
        - [GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified) 〜Nervesならできるもん！〜](https://qiita.com/torifukukaiou/items/0b1faacfdaa1cf217bec)
        - [Nervesならできるもん！ |> 本当にできんのか！ (Elixir)](https://qiita.com/torifukukaiou/items/dc54108e4a1f1cb3a650)
        - [Seeed株式会社](https://www.seeed.co.jp/)様の製品を使うことで**[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)**な私でもはめ込み式で手軽に電子工作を楽しめます!!!
        - <font color="purple">$\huge{Thanks!!!}$</font>
    - [CircleCI](https://circleci.com/)
        - [CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/1e266c7b213cdd3fd58e)
    - [Docker](https://www.docker.com/)
        - [グラフうねうね (動かし方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/3926fe3740e229594c8f)
    - <font color="purple">$\huge{Qiitaの記事中で文字に色をつけたり、でっかくしたりできるようになった}$</font>
```
<font color="purple">$\huge{Qiitaの記事中で文字に色をつけたり、でっかくしたりできるようになった}$</font>
```
- みなさんのカレンダーはどんなですか？　ぜひログインした状態でここ:point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5:を開いて振り返ってみてください
    - https://qiita.com/advent-calendar/2020/my-calendar
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:

**ありがとう！ [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)**
<font color="purple">$\huge{毎日が12月だったらいいのに！}$</font>

![スクリーンショット 2020-12-23 22.32.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1fa98310-06ea-8a66-4f1b-7aee150db15a.png)

![スクリーンショット 2020-12-23 22.33.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/65b560d2-65ea-6dcf-91dd-1f15809e40b7.png)


|日にち|タイトル|カレンダー|
|-----------:|:------------|:------------:|
|2020/12/01|[「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる](https://qiita.com/torifukukaiou/items/a7b1b1545a93170eee62) :lgtm::lgtm::lgtm:|[求ム！Cloud Nativeアプリケーション開発のTips！【PR】日本マイクロソフト](https://qiita.com/advent-calendar/2020/azure-cloudnative)|
|2020/12/01|[[87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]](https://qiita.com/torifukukaiou/items/badb4725a9c17788f8b1)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/02|[LiveView uploadsを動かす 🎉🎉🎉(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/c2b21e3658059927b577)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/03|[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)|[Elixir](https://qiita.com/advent-calendar/2020/elixir)|
|2020/12/03|[ElixirでAtCoderのABC123を解いてみる！](https://qiita.com/torifukukaiou/items/75d5db21d98fdf4459e2)|[fukuoka.ex Elixir／Phoenix](https://qiita.com/advent-calendar/2020/fukuokaex)|
|2020/12/03|[Surfaceをつかってみる(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/b5ae9eac42bd304b7aa3)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/03|[Nervesで湯婆婆を実装してみる](https://qiita.com/torifukukaiou/items/5f68fbc1b151b137d5d1)|[#NervesJP](https://qiita.com/advent-calendar/2020/nervesjp)|
|2020/12/03|[Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9)|[湯婆婆](https://qiita.com/advent-calendar/2020/yubaba)|
|2020/12/04|[とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 (Elixir)](https://qiita.com/torifukukaiou/items/100afafe1920eb72b339)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/05|[二次元リストの操作(Elixir)](https://qiita.com/torifukukaiou/items/8d67e857cdfb8fa4657c)|[Elixir その2](https://qiita.com/advent-calendar/2020/elixir2)|
|2020/12/05|[I was born to love Elixir](https://qiita.com/items/33e3471aaab6d863aecf) :lgtm::lgtm::lgtm:|[プログラミング技術の変化で得られた知見・苦労話【PR】パソナテック](https://qiita.com/advent-calendar/2020/pasonatech-experience)|
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


**ありがとナイス:flag_cn:！ [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)**
<font color="purple">$\huge{毎日が12月だったらいいのに！}$</font>

れっつじょいなす(Let's join us) :bangbang::bangbang::bangbang:
:point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5: 
[NervesJP Slackへの参加URL](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 


![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)

