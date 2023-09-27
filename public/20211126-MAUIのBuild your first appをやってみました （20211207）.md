---
title: MAUIのBuild your first appをやってみました （2021/12/07）
tags:
  - .NET
  - Elixir
  - MAUI
private: false
updated_at: '2021-12-13T07:55:14+09:00'
id: cefebdcfccdeee67d151
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/microsoft

2021/12/07(火)の回です。
前日は、@yakumomoさんの「[.NET6でできることをサンプルを交えて](https://qiita.com/yakumomo/items/435632132ab898c605ce)」でした。
**某電子書籍サイトの無料マンガの一覧を表示する**アプリを作られたそうです:+1::+1_tone1::+1_tone2::+1_tone3::+1_tone4::+1_tone5:
すごい:rocket:


# はじめに

[.NET](https://docs.microsoft.com/ja-jp/dotnet/)を楽しんでいますか:bangbang::bangbang::bangbang:
「[.NET Tutorial - Hello World in 5 minutes から取り組みはじめてみました -- .NET 💜 Azure](https://qiita.com/torifukukaiou/items/107cd5a32d0e1a78da1f)」と題した記事を初日に書きました。
`Hello World`の次は何をやろうかとおもっておりましたところ、アドベントカレンダーの登録状況をみますと**[MAUI](https://docs.microsoft.com/ja-jp/dotnet/maui/)**という単語をよくみました。
[.NET](https://docs.microsoft.com/ja-jp/dotnet/)初心者の私がやりきれるのかどうか当初は不安でしたが、とりあえずやってみたら、ガイドがしっかりしていたので詰まることなく**一周できました**。
**案ずるより産むが易し**。

## 2021-11-18 時点の「[祝 .NET 6 GA！.NET 6 での開発 Tips や試してみたことなど、あなたの「いち推し」ポイントを教えてください【PR】日本マイクロソフト](https://qiita.com/advent-calendar/2021/microsoft)」カレンダーの登録状況

![スクリーンショット 2021-11-18 10.46.02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fc860396-f4c7-e014-b1e3-7ebf61c35834.png)

# What is MAUI?

> .NET Multi-platform App UI (.NET MAUI) is a cross-platform framework for creating native mobile and desktop apps with C# and XAML.

---

> .NET マルチプラットフォーム アプリ UI (.NET MAUI) は、C# と XAML を使用してネイティブ モバイル アプリとデスクトップ アプリを作成するためのクロスプラットフォーム フレームワークです。

https://docs.microsoft.com/en-us/dotnet/maui/what-is-maui

![maui.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4fabe0d2-1ca4-d2b3-a1ef-50a742e9e7d9.png)

ほうほう！　
**Multi-platform App UI => MAUI**なのね:rocket::rocket::rocket:
`C#`と`XAML`を覚えたらいろいろな環境でイごく[^1]アプリケーションを作れるっちゅうわけですね。
**すごい**、**すごい** !!!

[^1]: 「動く」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# Get started!

https://docs.microsoft.com/ja-jp/dotnet/maui/get-started/installation

ここから順番にやっていけば特に詰まることなく一周できました :tada::tada::tada:

- Windows 11 Home editionを使いました
- Visual Studio Communityをインストールしました

[android](https://developer.android.com/?hl=ja)エミュレータでボタンポチポチすると、カウントアップするアプリケーションです。

![running-app.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/29f16a06-0878-f17b-97a4-967010856e9c.png)


動画を撮っておきましたですよ。
[iMovie](https://www.apple.com/jp/imovie/)で編集して、YouTubeにアップロードしておきました[^3]。

<font color="purple">$\huge{Hot\ Reloadの様子を動画に収めました}$</font>

<iframe width="816" height="459" src="https://www.youtube.com/embed/0y49pgt6qXM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


[^3]: 齢40をすぎてはじめて動画をYouTubeにアップロードしました。YouTubeに出してもらった経験はあります。 https://www.youtube.com/watch?v=R3o8vR1A9ao

# おわりに

[MAUI](https://docs.microsoft.com/ja-jp/dotnet/maui/)にこれからも注目していこうとおもいます。
例の「**完全に理解した**[^4]」レベルにすらまだ決して到達はしておりませんので精進を重ねたいとおもいます。

[^4]: https://twitter.com/ito_yusaku/status/1042604780718157824

## 試してみたこと

https://docs.microsoft.com/ja-jp/dotnet/maui/get-started/installation

を一周やってみました。
詰まることなく、日本野鳥の会のみなさんが使っているカウンターのようなボタンを押すとカウントアップする[android](https://developer.android.com/?hl=ja)アプリを作成することができました。

## Tips

パソコンの電源をOFFしたあとに次回またプロジェクトを立ち上げる場合には、以下のファイルをダブルクリックするとよいです。

- 例: C:\Users\username\source\repos\MauiApp1\MauiApp1.sln

なぜだか？　私のパソコンがおかしいだけだとおもいますが、一回目は「ソリューションを準備しています」というポップアップにバーが表示された状態で待てど暮らせど先に進む気配がありません。
我慢できずに、もう一回`MauiApp1.sln`をダブルクリックすると、Visual Studio Communityがもう一個立ち上がってきて、そちらで操作ができました。
まあ、私のパソコンがおかしいだけだとおもいます。
試行回数 2/ 2

![vs.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4ce9d285-22d5-d0ab-c5db-593082da6419.png)



## いち推し

<font color="purple">$\huge{MAUI}$</font>[^5]

https://www.youtube.com/watch?v=0y49pgt6qXM

[^5]: 私が大好きな[Elixir](https://elixir-lang.org/)界では、[elixir-desktop/desktop](https://github.com/elixir-desktop/desktop) Hexが絶賛開発中のようです :rocket::rocket::rocket: 

---

本編は以上です。
ここからは**おまけ**です。

私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです💜
ここからは、[Elixir](https://elixir-lang.org/)の話をします。

MAUIが

> .NET Multi-platform App UI (.NET MAUI) is a cross-platform framework for creating native mobile and desktop apps with C# and XAML.

ということを知って、[Elixir](https://elixir-lang.org/)でも最近おなじような話を聞いたことを思い出しました。
[elixir-desktop/desktop](https://github.com/elixir-desktop/desktop)です。

https://github.com/elixir-desktop/desktop

> Building native-like Elixir apps for Window, MacOS, Linux, iOS and Android using Phoenix LiveView!

[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)一本で、Windowsアプリ、MacOSアプリ、Linuxアプリ、iOSアプリ、Androidアプリを楽しみながら作れるスグレモノ(意訳)ということです。

https://docs.microsoft.com/ja-jp/dotnet/maui/get-started/first-app

本編で紹介したMAUIのガイドと同じように[android](https://developer.android.com/?hl=ja)のサンプルアプリケーションをイゴかしてみます[^1]。
|> イゴかしてみました[^1]。

https://qiita.com/torifukukaiou/items/5458458e2ec1bcee5152

「[elixir-desktop/desktop のandroidサンプルをイゴかす](https://qiita.com/torifukukaiou/items/5458458e2ec1bcee5152)」と題して別の記事にしました。
TODOアプリが動きました。

![Screenshot_20211202_002205_io.elixirdesktop.example.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4d7f4523-e38e-0f5e-988f-3a6c54c96cc8.jpeg)

---

# いち推し

<font color="purple">$\huge{MAUI}$</font>[^5]

ひとつ覚えたらなんでも作れるよ〜　はいいですよね:bangbang::bangbang::bangbang:


https://docs.microsoft.com/ja-jp/dotnet/maui/


---

明日は、@proudustさんによる「[Xamarin.Froms プロジェクトを .NET6 へアップグレードする](https://zenn.dev/proudust/articles/2021-12-12-xamarin-upgrade-to-dotnet6)」です:bangbang::bangbang::bangbang:
楽しみにしています:tada::tada::tada:



