---
title: I was born to love Elixir
tags:
  - Elixir
private: false
updated_at: '2020-12-25T12:52:31+09:00'
id: 33e3471aaab6d863aecf
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は、「[プログラミング技術の変化で得られた知見・苦労話【PR】パソナテック Advent Calendar 2020](https://qiita.com/advent-calendar/2020/pasonatech-experience)」 5日目です。
あいていたので埋めました。
後述の通り、[Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)に記事を投稿することは**私の趣味**です。

関数型言語というもの自体の歴史は古いとおもっています。
ここ2年くらい[Elixir](https://elixir-lang.org/)を「私が」接するようになって、「公式ドキュメントを読みましょう」というごくごく当たり前のことの大切さにようやく「私が」気づいたということを書いています。

---

# 結論
- 公式ドキュメントを読むのが一番いい

# [Elixir](https://elixir-lang.org/)
- Elixir (エリクサー) は並行処理の機能や関数型といった特徴を持つ、Erlangの仮想マシン (BEAM) 上で動作するコンピュータプログラミング言語である。ElixirはErlangで実装されているため、分散システム、耐障害性、ソフトリアルタイムシステム等の機能を使用することができるが、拡張機能として、マクロを使ったメタプログラミング、そしてポリモーフィズムなどのプログラミング・パラダイムもプロトコルを介して実装されている。[^1]

[^1]: [https://ja.wikipedia.org/wiki/Elixir_(プログラミング言語)](https://ja.wikipedia.org/wiki/Elixir_(%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0%E8%A8%80%E8%AA%9E))

## 現在の「私の」位置
- 2020/11/25 [Interface 2021年1月号](https://interface.cqpub.co.jp/magazine/202101/)に[Elixir](https://elixir-lang.org/)([Nerves](https://www.nerves-project.org/))の記事を執筆
    - @takasehideki 先生にお声がけいただいて、この仕事をはじめてから20年くらいたちますが、ようやく雑誌に記事が載りました
    - 名乗るほどのものではない名前を載せてもらいました
        - [IoT向きモダン言語Elixirの研究 第7回　IoTシステム開発にトライ!(サンプル)](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)
- 2020/07/10 [Elixir/Nerves入門！堅牢なIoT Edgeデバイスプログラミングをお手軽に](https://algyan.connpass.com/event/180192/)にて登壇
    - [IoT ALGYAN](https://algyan.connpass.com/)初参加がパネラーとして登壇
    - いいコミュニティです !!! 案内文で特に印象に残っている言葉たちです
        - 参加者の皆さんは「お客様」ではありません。
        - 寛容な気持ちで温かく応援
        - 一緒になって、より良いイベントを作り上げるというスピリッツをお持ちください
    - 2020/12/27 [豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)にも登壇予定です :rocket::rocket::rocket: 
- 2020/06/18-19 [Elixir Conf EU Virtual](https://www.elixirconf.eu/archives/virtual_2020/)にてLT登壇
    - もちろん英語で発表
    - もちろん歌も披露 :microphone: 
        - [歌うアルケミスト](https://twitter.com/piacere_ex/status/1334656415357538304) :microphone: 
    - [資料 ツイート](https://twitter.com/torifukukaiou/status/1274020337223516160)
    - 全力で、[Elixir](https://elixir-lang.org/)好きですと言っているだけ
- 2019/11/09 [ElixirConfJP 2019 小倉城](https://fukuokaex.connpass.com/event/138846/)にてLT登壇
    - [Nerves](https://www.nerves-project.org/)の[Justin Schneck](https://twitter.com/mobileoverlord)氏の前で歌を披露
    - [I was born to love Elixir ♪](https://www.youtube.com/watch?v=vNhhAEupU4g) :microphone: 
    - 全力で、[Elixir](https://elixir-lang.org/)好きですと言っているだけ


## 得られた知見
- 公式ドキュメントを読むのが一番いい
    - [Elixir](https://elixir-lang.org/)に限らず、最終的には公式ドキュメントを読むクセがついた
    - [Elixir](https://elixir-lang.org/)は、最初から公式ドキュメントをあたるのが最短で正解にたどりつく方法 :rocket::rocket::rocket:
- [プログラミングElixir](https://www.ohmsha.co.jp/book/9784274226373/):book:は、[Elixir](https://elixir-lang.org/)を学ぶ上で最高の教材・傑作
    - [1 = a (プログラミングElixir 第2版)](https://qiita.com/torifukukaiou/items/14ad8b9673bd47ce8b8f)
- [Elixir](https://elixir-lang.org/)のコミュニティーには優しく教えてくれる人が多い(優しく教えてくれる人しかいない:bangbang:)

## なれそめ
- 2016年ごろに大学生から$\huge{「これからは関数型です！　副作用がないのです！」}$と言っているのを聞きました[^2]
    - このころは[すごいHaskellたのしく学ぼう!](https://www.amazon.co.jp/dp/4274068854):book:ですこ〜し学んでみましたが、あんまり理解は進みませんでした
- ひょんなことから参加した 2019/01/25 [kokura.ex#1：小倉Elixirコミュニティ発足【セッション／LTと懇親会】](https://fukuokaex.connpass.com/event/116855/)が私と[Elixir](https://elixir-lang.org/)の出会いです
    - 関数型ときいて、難しいんだろうなあという妙な先入観があったのですが、その会では関数型というのを必要以上には強調されなかったです
    - なんとなく[Ruby](https://www.ruby-lang.org/ja/)に書き味が似ていたことも親しみやすかったポイントで、また関数型言語をやってみようかなあという気になりました
    - @piacerex さんが楽しそうにされていたこともよく覚えています
- 昔から再帰プログラムは書けなかった(いまでも苦手ではある)のですが、不思議と[Elixir](https://elixir-lang.org/)では書けました
- その後、いろいろありますがとにかく[QiitaでElixir](https://qiita.com/tags/elixir)タグをつけて記事を投稿しました
    - いつも温かく見守ってくださり、:lgtm:をつけてくださる、みなさまありがとうございます !
    - 励みになっています !
    - 特に @piacerex さん、 @twinbee さん、 @takasehideki 先生、@im_miolab さんからは私の初投稿のころからいっつも:lgtm:をつけていただいておりまして、感謝しても感謝しきれません :joy:
        - 私に海外のカンファレンスに参加、LTしてみようと背中を押してくださった[^3] @zacky1972 先生
        - [OkazaKirin.beam](https://okazakirin-beam.connpass.com/)、[NervesJP](https://nerves-jp.connpass.com/)でほぼ毎週のようになにかとお世話になっている @pojiro さん
        - [Phoenix Guide 日本語訳](https://fukuoka-ex.github.io/phoenix-guide-ja/)や[fukuoka.ex](https://fukuokaex.connpass.com/)でお世話になっている@koga1020 さん
            - [Phoenix入門 API構築からLiveViewまで](https://www.koga1020.com/posts/techbookfest-7):book:へのサイン、ありがとうございます！
            - [Phoenix Guide 日本語訳](https://fukuoka-ex.github.io/phoenix-guide-ja/)は最近、貢献できていなくてすみません :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  
        - ほぼ毎週[Sapporo.beam](https://sapporo-beam.connpass.com/)開催されている @niku さん
        - 最近では、[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2)でたすきをガッチリ受け取ってくださった@mnishiguchiさん
        - と、書き出すと全員分書かないといけなくなるですいません、このへんまでにさせてください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 
    - <font color="purple">$\huge{「ありがとうございます！」}$</font>
- 記事を書くにあたり、できるだけ公式のドキュメントを確認し、そのリンクを貼ることを心がけています
    - だって、公式ドキュメントが一番正しいのですもの

[^2]: だから何:interrobang:　っておもった方、大丈夫です。私はいまだによくわかっていません。簡単に「わかりました」なんて言えない領域だと思っています。並列？　だか並行？　だかその区別も意識していませんが、ただ私から言えることは、[Flow](https://github.com/dashbitco/flow)って書くと速くなる:rocket::rocket::rocket: のです。副作用がないというのはそのへんにつながるのですが、とにかく[Flow](https://github.com/dashbitco/flow)って書くと速くなるとおぼえておけば大丈夫です。それだけ覚えておけば、海外でもLTできます。Amazing!!! Unbelievable!!!, Oh, my お釈迦様ness って叫んでおけばOKです。(注釈なのに言葉足らずですが) 

[^3]: @zacky1972 先生にはそんなつもりは全くなく、私の勝手な思い込み:rocket:なのかも :sweat_smile: 

# [Elixir](https://elixir-lang.org/)プログラム例

```elixir
"https://icanhazdadjoke.com/"
|> HTTPoison.get!(["Accept": "application/json"])
|> Map.get(:body)
|> Jason.decode!()
|> Map.get("joke")
```

- 1. APIのアクセスポイントがあります
- 2. HTTP Getします
- 3. レスポンスから`:body`キーの値を取り出します
- 4. `:body`キーの値をJSONとしてデコードします
- 5. JSONの中から`"joke"`キーの値を取り出します
- パイプ演算子 [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)で言葉に書いた通りにキレイに書けます
    - [HTTPoison](https://github.com/edgurgel/httpoison)と[Jason](https://github.com/michalmuskala/jason)というライブラリの追加が必要です
    - 簡単にできます
    - 手前味噌ですが
        - [Enjoy Elixir #006 HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)
- どうでしょうか、とても**<font color="purple">美しい</font>**ですよね

```elixir:実行結果の例
"If you’re struggling to think of what to get someone for Christmas. Get them a fridge and watch their face light up when they open it."
```

- 「<font color="purple">美しい</font>」と言っているのはなにも私一人だけではありません
- たとえば
    - [プログラミングElixir 第2版](https://www.ohmsha.co.jp/book/9784274226373/):book:
        - **私は、このプログラミングモデルの力と<font color="purple">美しさ</font>についての思想を贈りたい。(はじめに（正当化のむなしい試み、再び）)**
    - [Programming Phoenix 1.4](https://pragprog.com/titles/phoenix14/programming-phoenix-1-4/)
        - **Simply put, Phoenix is about productive, concurrent, <font color="purple">beautiful</font>, interactive, and reliable applications.**(Chapter 1. page 2)[^4]
    - ほんの一例です

[^4]: [Phoenix](https://www.phoenixframework.org/)は[Elixir](https://elixir-lang.org/)あってのWebアプリケーションフレームワークですから、[Elixir](https://elixir-lang.org/)が<font color="purple">beautiful</font>だと言っているのだと私は解釈しています

## Webアプリケーションやるなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTやるなら
- [Nerves](https://nerves-project.org/)


# Wrapping up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- 公式ドキュメントを読むのが一番いい
    - [Elixir](https://elixir-lang.org/)においては特にそうだし
    - たいていの他のことも公式ドキュメントを確認することは良いこと
- 特に[Elixir](https://elixir-lang.org/)は例も豊富で、言語自体の公式ドキュメントと各種ライブラリのドキュメント形式が同じなので読みやすいです
- I was born to love [Elixir](https://elixir-lang.org/).
- We are the Alchemists, my friends.
    - 不老不死の霊薬という意味をもつプログラミング言語[Elixir](https://elixir-lang.org/)の使い手のことを錬金術師ーーアルケミストと呼ばれます
    - :book: [アルケミスト 夢を旅した少年](https://www.amazon.co.jp/dp/404275001X)
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 

# おまけ
- **趣味: [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)を書くこと**

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


https://qiita.com/advent-calendar/2020/my-calendar 
で参加中のカレンダーがみえるでありますよ。

## 私の場合

![スクリーンショット 2020-12-21 23.00.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6831fa7d-3bd9-1b23-4dac-8982e77cef79.png)



