---
title: 「LiveViewJP#21：Livebookコードを眺めてみんなで震えて納涼する会」レポート
tags:
  - Qiita
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-09-27T20:30:32+09:00'
id: fe40f6a16d8ac11ec297
organization_url_name: fukuokaex
slide: false
---
2023年9月26日(火) 19:30、私は「[LiveViewJP#21：Livebookコードを眺めてみんなで震えて納涼する会](https://liveviewjp.connpass.com/event/294500/)」に参加しました。
このイベントは、[Elixir](https://elixir-lang.org/)コミュニティの中で非常に注目されており、私の期待も高まっていました。以下はそのレポートです。

# 「LiveViewJP」とは？

「[LiveViewJP](https://liveviewjp.connpass.com/)」は、「We are party of Elixir/LiveView.」です。

LiveViewは、ReactやVue.js同様のリアルタイムフロント開発やSPA開発を、サーバサイドのコーディングのみで実現できるElixirライブラリです。
2019年にデビューし、Phoenix 1.5で標準装備となり、2021年8月のPhoenix 1.6リリースで本格的にコアプロダクト化したこのLiveViewを、プロダクション導入したり、LiveViewの技術面やスタックで盛り上がるコミュニティです。
たとえば、LiveView／phx_gen_auth／tailwind componentsの融合や、LiveBook／Nx／Axonの融合と言ったユースケースも紹介していきます。
Zoom接続さえできれば、本人でも、SnapCameraでも、2Dアバター／3D（VR）アバターでも、お好きな姿・形（18禁はお断り）でご参加OKの、「対面」と「アバター」が混在する「未来指向の技術コミュニティ」でもあります…司会もVRアバターです。
閉会後の「リモート呑み会」では、「LiveView」や「LiveViewのお仕事情報を聞きたい」など、本会では聞けなかった突っ込んだ話、現場のリアルなんかを、登壇者や参加者とワイワイする時間帯もあります。

# 乾杯スタートしました :beers:

イベントは「乾杯」の音頭でスタートし、参加者たちは笑顔で情熱的なトークに身を委ねました。この瞬間から、[Elixir](https://elixir-lang.org/)の世界への探求心が高まりました。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">納涼Livebookハック会、はじまったー <a href="https://twitter.com/hashtag/LiveViewJP?src=hash&amp;ref_src=twsrc%5Etfw">#LiveViewJP</a><a href="https://t.co/tlHSq67Wmg">https://t.co/tlHSq67Wmg</a> <a href="https://t.co/6ZtWGAP7kr">pic.twitter.com/6ZtWGAP7kr</a></p>&mdash; piacere @ 技術（Elixir／UX／xR）で現実をデジタル&amp;バーチャルから改変 (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1706620071332954117?ref_src=twsrc%5Etfw">September 26, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 本編レポート

本編のレポートです。

## みんなでDiscordに自己紹介タイム

https://00m.in/rk8Q1

で「elixirと見習い錬金術師」サーバーに入って自己紹介をしあいました。

## Livebook実行環境構築ハンズオン

Livebookのnotebookに画像をダウンロードして、表示するデモが行われました。
@tuchiro さんに解説していただきました。

![スクリーンショット 2023-09-26 19.50.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e1cdeb1-db97-3788-eab6-fb048b2ec326.png)


```elixir
Mix.install([{:kino, "~> 0.3.1"}, {:download, "~> 0.0.4"}])
```

```elixir
Download.from("https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png")
|> elem(1)
|> File.read!
|> Kino.Image.new(:jpeg)
```

たったこれだけのコードで完成です。
すごい！

## Livebookコードを眺めてみんなで震えて納涼する

@piacerex さんがリードしてくださいました。

[Livebook](https://github.com/livebook-dev/livebook)のソースコードはここにあります。

https://github.com/livebook-dev/livebook

- まずは、 router をみよう。
  - https://github.com/livebook-dev/livebook/blob/main/lib/livebook_web/router.ex
- `socket` の `assigns` が大事。[IO.inspect/2](https://hexdocs.pm/elixir/1.15.6/IO.html#inspect/2)で表示してみるといいよ。
- debug_heex_annotations

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">I tried debugging LiveView 0.20...I removed LiveDashboard and put debug_heex_annotations in dev.exs and it identifies the LiveView code, awesome!😆<br><br>LiveView 0.20デバッグを試した…LiveDashboard外し、dev.exsにdebug_heex_annotationsを入れたら、LiveViewコードが特定される、スゲェ！😆 <a href="https://t.co/W65yuPtElF">https://t.co/W65yuPtElF</a> <a href="https://t.co/awwa1w9RoP">pic.twitter.com/awwa1w9RoP</a></p>&mdash; piacere @ 技術（Elixir／UX／xR）で現実をデジタル&amp;バーチャルから改変 (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1705469187047694374?ref_src=twsrc%5Etfw">September 23, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

- その他にもいろいろとハックしてくださいました！

ありがとうーーーーッ！！！　でございます。
震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">たった1時間の短時間で、<br><br>・Livebookホーム画面<br>・ユーザー設定<br>・セッション（起動されたNotebookのこと）<br>・コードエディタ部分<br>・コード実行部分<br><br>のハックや改造ができました😆 <a href="https://twitter.com/hashtag/LiveViewJP?src=hash&amp;ref_src=twsrc%5Etfw">#LiveViewJP</a><br><br>今回、初めてLivebookハックしてみましたが、いつものElixirらしく読みやすいコードでハッピーでした😍 <a href="https://t.co/EhohlbKTmA">pic.twitter.com/EhohlbKTmA</a></p>&mdash; piacere @ 技術（Elixir／UX／xR）で現実をデジタル&amp;バーチャルから改変 (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1706658075321704577?ref_src=twsrc%5Etfw">September 26, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 次回の[LiveViewJP](https://liveviewjp.connpass.com/)

次回の[LiveViewJP](https://liveviewjp.connpass.com/)は、募集を開始されています。

https://liveviewjp.connpass.com/event/296643/

2023年10月24日(火) 19:30- [LiveViewJP#22：画像識別AIや音声識別AI、お絵描きAIをハンズオンで作成](https://liveviewjp.connpass.com/event/296643/)

万障お繰り合わせの上、ぜひぜひご参加ください。


# さいごに

この記事は、2023年9月26日(火) 19:30より行われた「[LiveViewJP#21：Livebookコードを眺めてみんなで震えて納涼する会](https://liveviewjp.connpass.com/event/294500/)」のイベントレポートです。
このイベントに参加し、Elixirの未来や情熱的なコミュニティメンバーたちと交流できたことを誇りに思います。私たちは、新たな発見と創造を追求し続けます！

震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。震えました。

**We are the Alchemists, my friends!!!**

次回の「2023年10月24日(火) 19:30- [LiveViewJP#22：画像識別AIや音声識別AI、お絵描きAIをハンズオンで作成](https://liveviewjp.connpass.com/event/296643/)」も期待大、楽しみです！

最後に、[Qiita](https://qiita.com/)の素晴らしさを再確認し、将来の共同投稿を楽しみにしています。みなさん、一緒に学び、成長しましょう！

それではごいっしょに！
「いやぁ、[Qiita](https://qiita.com/)って本当にいいもんですね～。それではまたご一緒に投稿を楽しみましょう」

<iframe width="960" height="540" src="https://www.youtube.com/embed/TsYL6oN8SXs" title="水野晴郎さん　映画って本当にいいもんですね" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

