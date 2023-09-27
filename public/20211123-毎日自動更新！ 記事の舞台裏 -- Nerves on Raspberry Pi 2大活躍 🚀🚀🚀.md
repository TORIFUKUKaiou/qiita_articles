---
title: "毎日自動更新！　記事の舞台裏 -- Nerves on Raspberry Pi 2大活躍 \U0001F680\U0001F680\U0001F680"
tags:
  - Azure
  - Elixir
  - Nerves
  - fukuoka.ex
  - autoracex
private: false
updated_at: '2021-12-18T08:54:14+09:00'
id: a58aa8162422f560ef64
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/nervesjp

# はじめに
[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

マクロの話をします。
[Nerves](https://www.nerves-project.org/) on **Raspberry Pi 2**の話です。
令和３年なのに、**Raspberry Pi 2**です。
まだまだ現役バリバリ、イゴいています[^1]

[^1]: 「動いています」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# 作品群

https://qiita.com/torifukukaiou/items/5105eed1aff115b8a4ef

https://qiita.com/torifukukaiou/items/2db585bf7dbe39ed6f5d

https://qiita.com/torifukukaiou/items/90791d846181a50fc68d

https://qiita.com/torifukukaiou/items/f0f6418d3c50e0e99322

https://qiita.com/torifukukaiou/items/17f05aad2aff239ab6d2

https://qiita.com/torifukukaiou/items/9cfefb20ec347514576b

https://qiita.com/torifukukaiou/items/88a76181df818f500557

毎月イベントを開催してくださった、マイクロソフトさん、Qiitaさんに感謝です。

# マクロ

[Macros](https://elixir-lang.org/getting-started/meta/macros.html)を使っています。
[Macros](https://elixir-lang.org/getting-started/meta/macros.html)を使って量産しています:robot_face:

『[プログラミングElixir（第2版） -- オーム社](https://www.ohmsha.co.jp/book/9784274226373/):book:』の第22章を読んでください。

先述の作品群のポイントとなるソースコードをご披露しておきます。

## 共通部分

各「【毎日自動更新】」記事作成のための共通部分です。

```elixir:lib/qiita/azure.ex
defmodule Qiita.Azure do
  defmacro __using__(opts) do
    item_id = Keyword.get(opts, :item_id)
    title = Keyword.get(opts, :title)
    event_title = Keyword.get(opts, :event_title)
    event_url = Keyword.get(opts, :event_url)
    description = Keyword.get(opts, :description)
    start = Keyword.get(opts, :start)
    ending = Keyword.get(opts, :ending)

    quote do
      def run do
        Qiita.Api.patch_item(
          markdown(),
          false,
          [
            %{"name" => "Elixir"},
            %{"name" => "QiitaAzure"},
            %{"name" => "Azure"},
            %{"name" => "Nerves"}
          ],
          unquote(title),
          unquote(item_id)
        )
      end

      def items do
        start = DateTime.new(unquote(start), ~T[15:00:00.000], "Etc/UTC") |> elem(1)
        ending = DateTime.new(unquote(ending), ~T[15:00:00.000], "Etc/UTC") |> elem(1)

        Qiita.Api.items("tag:QiitaAzure tag:Azure created:>#{unquote(start) |> Date.to_string()}")
        |> Enum.filter(fn %{"created_at" => created_at} ->
          Timex.between?(created_at, start, ending, inclusive: :start)
        end)
        |> Enum.sort_by(fn %{"likes_count" => likes_count} -> likes_count end, :desc)
      end

      defp markdown do
        sorted_items = items()

        """
        #{unquote(event_url)}
        # この記事は
        - [#{unquote(event_title)}](#{unquote(event_url)})
        - というイベントに参加していると**おもわれる**記事の一覧です
          - 「参加ボタン」を押すのをお忘れなく
        - [QiitaAzure](https://qiita.com/tags/qiitaazure)タグと[Azure](https://qiita.com/tags/azure)タグの両方がついていて、`created_at`が募集期間内になっている記事を集めて、LGTM数順に並べています
          - 期間の境界のところは誤りがあるかもしれません
          - そこはご愛嬌ということでお許しください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
        # 総件数
        #{Enum.count(sorted_items)}件 :tada::tada::tada:
        # 総LGTM数 :lgtm::lgtm::lgtm::lgtm::lgtm:
        #{
          Enum.map(sorted_items, fn %{"likes_count" => likes_count} -> likes_count end)
          |> Enum.sum()
          |> Number.Delimit.number_to_delimited(precision: 0)
        } :rocket::rocket::rocket:
        # 全期間 :confetti_ball::military_medal::confetti_ball:
        #{build_table(sorted_items)}
        #{unquote(description)}
        ## QiitaAzure記事投稿キャンペーン
        ### 3月
        https://qiita.com/official-events/a50e99d62dc62d68a9c9
        ### 4月
        https://qiita.com/official-events/22637c675c61a797a24f
        ### 5月
        https://qiita.com/official-events/5a0932fbeb1443ae1094
        ### 6月
        https://qiita.com/official-events/885e4031d03c787eceab
        ### 9月
        https://qiita.com/official-events/b7811ce1542be54e6efe
        ### 10月
        https://qiita.com/official-events/8bc3780a142f8ee8effa
        ### 11月
        https://qiita.com/official-events/2578ba1c949d056847df
        # Wrapping up :lgtm: :qiitan: :lgtm:
        - 自動更新は、[Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で作られた[Nerves](https://www.nerves-project.org/)という[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)を使ってつくったアプリケーションで行っております
          - [Nerves](https://www.nerves-project.org/)の始め方につきましては下記の記事が詳しいです
          - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
          - Raspberry Pi 2が定期的に記事を自動更新しているのであります
        - [ソースコード TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
        # 最後の最後に
        ## [Elixir](https://elixir-lang.org/)ってなによ:interrobang:という方へ
        ![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/601aeb87-9d1d-6a9d-b30b-338507dc593e.png)
        - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 2020/12/26時点くらいのスクリーンショット
        - [Elixir](https://elixir-lang.org/)についてもっと知りたい方は下記の本:books:をオススメします
            - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
            - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
        - [elixir.jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)の`#autoracex`というところに私は入り浸っておりますのでお気軽にお声がけください
        - [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)
            - [Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
        - [勉強会が頻繁に行われています](https://twitter.com/piacere_ex/status/1364109880362115078)
            - 私がよく参加している勉強会です
            - [autoracex](https://autoracex.connpass.com/) 【毎週土曜〜月曜】 主催
            - [Sapporo.beam](https://sapporo-beam.connpass.com)　　【毎週水曜】
            - [OkazaKirin.beam](https://okazakirin-beam.connpass.com)　【毎週木曜】
            - [fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com)　【毎月2～3回】
            - [NervesJP](https://nerves-jp.connpass.com/) 　【毎月1回】
        - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)
            - @kn339264 さん作 :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:
        ![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
        (@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)
        """
      end

      defp build_table(items) do
        Enum.with_index(items, 1)
        |> Enum.reduce(
          "|No|title|created_at|updated_at|LGTM|\n|---|---|---|---|---:|\n",
          fn {item, index}, acc_string ->
            %{
              "title" => title,
              "likes_count" => likes_count,
              "created_at" => created_at,
              "updated_at" => updated_at,
              "url" => url,
              "user_id" => user_id
            } = item

            acc_string <>
              "|#{index}|[#{String.replace(title, "|", "&#124;")}](#{url})<br>@#{user_id}|#{
                created_at |> Timex.to_date() |> Date.to_string()
              }|#{updated_at |> Timex.to_date() |> Date.to_string()}|#{
                Number.Delimit.number_to_delimited(likes_count, precision: 0)
              }|\n"
          end
        )
      end
    end
  end
end
```

上記はゴチャゴチャあれこれ書いているからわかりにくいとおもいます。
骨格だけに削ぎ落としてみます。
大事なところは、単純なのです。

```elixir:bone.ex
defmodule Qiita.Azure do
  defmacro __using__(opts) do
    item_id = Keyword.get(opts, :item_id)

    quote do
      def run do
        ...
        unquote(item_id)
        ...
      end
    end
  end
end
```

`use Qiita.Azure`で共通部分を取り込んだ個別部分のモジュール(後述)は、`run/0`関数を使えるようになります。
[use/2](https://hexdocs.pm/elixir/Kernel.html#use/2)は、第1引数がモジュール名、第2引数がキーワードリスト(厳密には違うかも?)です。
上記の`bone.ex`では、`use Qiita.Azure, item_id: "5105eed1aff115b8a4ef"`といった形式で呼び出されることを期待しています。
`Qiita.Azure`から見た場合に、個別部分のモジュールのほうに追加をしてあげたい`run/0`関数は[quote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2)の中に書きます。
`item_id`等、[quote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2)の外にある変数の値を使いたい場合には、[unquote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#unquote/1)して使用します。
これが骨格です。

::: note
quote: 引用する、引き合いに出す
unquote: 引用を終わらせる
:::


## 個別部分

`use Qiita.Azure`で共通部分を取り込んで、個別の事情をイベントごとにモジュールを作っています。
イベントが追加となるたびに以下のようなモジュールを夜なべしているわけです。
以下、2021/11/23時点で最新のイベントのものです。

```elixir:lib/qiita/azure/microsoft_certification.ex
defmodule Qiita.Azure.Certification do
  use Qiita.Azure,
    item_id: "5105eed1aff115b8a4ef",
    title: "【毎日自動更新】マイクロソフト認定資格を取得する際の学習方法や経験談、おすすめ学習リソースなどを紹介しよう！(2021/11/11–2021/12/10) LGTMランキング！",
    event_title: "マイクロソフト認定資格を取得する際の学習方法や経験談、おすすめ学習リソースなどを紹介しよう！",
    event_url: "https://qiita.com/official-events/2578ba1c949d056847df",
    description: """
    # [Azure認定資格・試験](https://docs.microsoft.com/ja-jp/learn/certifications/browse/?Dev_TF=PET3035074&products=azure)と私
    - :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: [AWS Certified Solutions Architect – Associate](https://aws.amazon.com/jp/certification/certified-solutions-architect-associate/)なら持っています
      - そろそろ期限がきれそう...
    - このイベントをきっかけに[Azure認定資格・試験](https://docs.microsoft.com/ja-jp/learn/certifications/browse/?Dev_TF=PET3035074&products=azure)を取得してみようかとおもっています[^1]
    - 私だけの感じ方かもしれません[^2]が、自分が書いた記事が他の方の記事からリンクされると、Qiitaの画面の上のほうで「**あなたの記事にリンクしました**」とお知らせがくることがありますよね
    - あれが私はうれしいです
    - イベントですし、お祭りということで勝手に応援させてください :lgtm::tada::tada::tada::lgtm:
    [^1]: 思っています。あくまでもおもっています。
    [^2]: 矢吹丈がそんな言い方を乾物屋の紀ちゃんにするシーンがあって、私は多用しています
    """,
    start: ~D[2021-11-10],
    ending: ~D[2021-12-10]
end
```

上記のような調子でイベントごとにモジュールを作っています。

- [Qiita.Azure.MicrosoftAI](https://github.com/TORIFUKUKaiou/hello_nerves/blob/56839d550d38583856c332d6294eb41cf98e4f08/lib/qiita/azure/microsoft_ai.ex)
- [Qiita.Azure.MicrosoftBuild](https://github.com/TORIFUKUKaiou/hello_nerves/blob/56839d550d38583856c332d6294eb41cf98e4f08/lib/qiita/azure/microsoft_build.ex)
- [Qiita.Azure.MicrosoftIoT](https://github.com/TORIFUKUKaiou/hello_nerves/blob/56839d550d38583856c332d6294eb41cf98e4f08/lib/qiita/azure/microsoft_iot.ex)
- [Qiita.Azure.MicrosoftJava](https://github.com/TORIFUKUKaiou/hello_nerves/blob/56839d550d38583856c332d6294eb41cf98e4f08/lib/qiita/azure/microsoft_java.ex)
- [Qiita.Azure.K8s](https://github.com/TORIFUKUKaiou/hello_nerves/blob/56839d550d38583856c332d6294eb41cf98e4f08/lib/qiita/azure/microsoft_k8s.ex)


## ソースコード

ソースコードの全体は、GitHubにあります。

https://github.com/TORIFUKUKaiou/hello_nerves


一体、このプロジェクトは何なのでしょう？
いろいろなもの~~がごった煮されています~~をごった煮しています。
その張本人は私です。
複雑に入り組んだ現代社会の縮図であり、私自身の人生なのかもしれません。
もちろん複雑に入り組んだ現代社会に鋭いメスはいれていません。

## 参考記事

手前どもの熟成味噌をご披露いたします。

[[Elixir]SlackのAPIを例にuseするものを自分で作って使ってみる](https://qiita.com/torifukukaiou/items/c1d6fd54117197ea9991)

# Wrapping up:lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:

『[【毎日自動更新】マイクロソフト認定資格を取得する際の学習方法や経験談、おすすめ学習リソースなどを紹介しよう！(2021/11/11–2021/12/10) LGTMランキング！](https://qiita.com/torifukukaiou/items/5105eed1aff115b8a4ef)』等の記事制作の舞台裏をお見せしました。

**私の趣味は、[Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021)[^5]に毎日記事を投稿することです。**
私の勝手な都合ですが、これを達成するためには11月のうちからある程度の記事を量産しておく必要があります。
11月中に半分は埋めておかないと12月がきついです。
11月中に半分埋めておけば、のこりは2日に一本のペースで書けばよく、これは理想です。
調査・構想に1日、次の日にそれを記事にまとめるという寸法です。
前日インプットしたものを翌日、思いの丈を爆発させてアウトプットするという格好です。

[^5]: 「[Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021)」に書くことが趣味です。「[Qiita Advent Calendar 2022](https://qiita.com/advent-calendar/2022)」に書くことまで趣味と言ってはいません。それに来年のことを言うと鬼に笑われます。

「書くことがない」という方に余計な老婆心から私が何を考えているのかお伝えしますと、「**something** x [Elixir](https://elixir-lang.org/)」でいくらでも量産できます。
**something**は、たとえば

- [slack](https://qiita.com/advent-calendar/2021/slack)
- [docker](https://qiita.com/advent-calendar/2021/docker)
- [.NET](https://qiita.com/advent-calendar/2021/microsoft) :gift: 
- [競技プログラミング](https://qiita.com/advent-calendar/2021/pre-competitive) :gift:
- [完全理解](https://qiita.com/advent-calendar/2021/easyeasy)

などです。
またまた老婆心ながら、私が参加予定の[Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021)の各種カレンダーへのリンクとなっております。
(どの立場から言っているのか不明ですが）みなさんも奮ってご参加ください:fire::fire::fire:


[Advent Calendar 2021 / IoT・ハードウェア / #NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)にまだまだ空きがあった[^3]ので[#NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)に投稿させていただきました。
「一人で何個も投稿するんじゃねえ！」というお叱りはごもっともですし、その際にはどこか別のカレンダーに移動いたします[^4]。

[^3]: 2021/11/23時点

[^4]: ひとりアドベントカレンダーやればいいんじゃないの？　それはごもっともですが、誰も読まれないところでこっそりシコシコやるのはさびししいです。自分自身ではない、だれか他の人がはじめてくださったアドベントカレンダーに投稿することに意味があるとおもっています。

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



