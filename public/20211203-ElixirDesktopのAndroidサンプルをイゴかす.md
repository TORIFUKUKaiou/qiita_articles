---
title: ElixirDesktopのAndroidサンプルをイゴかす
tags:
  - Android
  - Elixir
  - ElixirDesktop
private: false
updated_at: '2022-12-11T21:26:30+09:00'
id: 5458458e2ec1bcee5152
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/03(金)の回です。

@MzRyuKa さんの
[【無料版】Elixirへのいざない　ネイティブアプリを錬金しよう（free版）](https://mzryuka.booth.pm/items/3546479):book:
の中でこの記事（コラム）が紹介されています!!! :congratulations:
原題のまま「イゴかす[^1]」で掲載されているのが、これまたよい:thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:です。 

# はじめに
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
空いていたので埋めます。
[Nerves](https://www.nerves-project.org/)のことではないです。

[Elixir](https://elixir-lang.org/)ですし、Youngなプロジェクトの紹介です。
<font color="purple">$\huge{すげー}$</font>のがでてきました。

なにが**すげー**って、あのコントリビュート(畏敬の念を込めて「草」)の量がハンパない[Kian Meng Ang](https://github.com/kianmeng)さんがすでにコントリビュートされている注目のプロジェクトです。

https://github.com/elixir-desktop/desktop

> Building native-like Elixir apps for Window, MacOS, Linux, iOS and Android using Phoenix LiveView!


[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)ひとつで、Windows、MacOS、Linux、iOS、Android全部のアプリが作れちゃうよ〜:rocket::rocket::rocket:

まさに[.NET マルチプラットフォーム アプリ UI (.NET MAUI) ](https://docs.microsoft.com/ja-jp/dotnet/maui/)の[Elixir](https://elixir-lang.org/)版です。

# androidアプリのサンプルをイゴかしてみました[^1]

https://github.com/elixir-desktop/android-example-app

をイゴかしてみました。
開発マシンはmacOSです。
[asdf](https://asdf-vm.com/)でErlangやElixirをインストールできるだけの準備(各種ライブラリ？　ミドルウェア?)は整えてあるマシンです。

1. [Android Studio](https://developer.android.com/studio)をインストールします
1. [Android Studio](https://developer.android.com/studio)で、[NDK と CMake をインストールする](https://developer.android.com/studio/projects/install-ndk?hl=ja)
1. [Android Studio](https://developer.android.com/studio)で、「Go to "Files -> New -> Project from Version Control" and enter this URL: https://github.com/elixir-desktop/android-example-app/ 」
1. 必要に応じて「[Android Gradle plugin requires Java 11と言われてSyncできないときの対処法](https://qiita.com/takahirom/items/5e8d7b69e873edb3dcaf)」を実施[^4]
1. `brew install kerl`
1. さっぱりわからんけど、サンプル通り`~/projects`フォルダを作って、`kerl build`して〜、`kerl install`します

[^4]: めちゃくちゃ助かりました！ @takahiromさんありがとうございます！

```
mkdir -p ~/projects/
kerl build git https://github.com/diodechain/otp.git diode/beta 24.beta
kerl install 24.beta ~/projects/24.beta
```

## 2022-07-20 追記

以降、`run_mix`でPhoenixアプリ([TodoApp: A Desktop Sample App](https://github.com/elixir-desktop/desktop-example-app))のダウンロードを行います。
2022-07-20現在、[android-example-app](https://github.com/elixir-desktop/android-example-app)と[TodoApp: A Desktop Sample App](https://github.com/elixir-desktop/desktop-example-app)最新の組み合わせでは以下のエラーに遭遇します。

```
% ./run_mix
warning: use Mix.Config is deprecated. Use the Config module instead
  config/prod.exs:1

==> desktop
Compiling 1 file (.erl)
src/desktop_wx.erl:13:22: undefined macro 'wxID_EXIT'
%   13|   get(wxID_EXIT) -> ?wxID_EXIT;
%     |                      ^

src/desktop_wx.erl:3:4: function get/1 undefined
%    3|   -export([get/1]).
%     |    ^

could not compile dependency :desktop, "mix compile" failed. Errors may have been logged above. You can recompile this dependency with "mix deps.compile desktop", update it with "mix deps.update desktop" or clean it with "mix deps.clean desktop"
```

そこで、ビルドが通るリビジョンの[TodoApp: A Desktop Sample App](https://github.com/elixir-desktop/desktop-example-app)を使うことでこの問題を回避します。
具体的には、`run_mix`ファイルを以下のように書き換えてください。

```run_mix
if [ ! -d "elixir-app" ]; then
  git clone https://github.com/elixir-desktop/desktop-example-app.git elixir-app
  cd elixir-app
  git checkout -b hoge 2f0ce926cc5c258fbc0c60b3c0d557d3023fe1e7
  mix deps.get
else
  cd elixir-app
fi
```

`git checkout -b hoge 2f0ce926cc5c258fbc0c60b3c0d557d3023fe1e7`を追加しています。


---


ここからはREADMEの通りにはうまくいかなかったので、私独自です。
androidアプリの開発経験はそれなりにあって、それなりの心得があることが幸いしました。

1. `run_mix`ファイルを書き換える。https://github.com/elixir-desktop/android-example-app/pull/2/files たぶんパスの誤り？　だとおもうのでプルリクをしたためて出してみました
1. どうもうまくいかんので、 https://github.com/elixir-desktop/android-example-app/blob/4cb9b92cd3dfe5edf92f3ec5bd1ff20ab78ce623/app/build.gradle#L10-L16 はざっくり消してしまう(ガセネタかも?)
1. `./run_mix`をターミナルで実行する => `/app/src/main/assets/app.zip.xz`なるものができる(おそらく、たぶんErlangやElixir、LiveViewアプリそんなものたちがよしなに詰め込まれているのだとおもう。[^3])
1. [Connect your Phone](https://developer.android.com/studio/run/device) to Android Studio
1. [Android Studio](https://developer.android.com/studio)で、緑のRunボタンを押す


そうするとTODOアプリが立ち上がりますよ。


![Screenshot_20211202_002205_io.elixirdesktop.example.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4d7f4523-e38e-0f5e-988f-3a6c54c96cc8.jpeg)

[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)のアプリがイゴきます[^1]:tada::tada::tada:
<font color="purple">$\huge{オフラインモードでもイゴきます!!!}$</font>

# `/app/src/main/assets/app.zip.xz`なるものができる(おそらく、たぶんErlangやElixir、LiveViewアプリそんなものたちがよしなに詰め込まれているのだとおもう

https://github.com/elixir-desktop/android-example-app#architecture

> The Android App is initializing the Erlang VM and starting it up with a new environment variable BRIDGE_PORT. This environment variable is used by the Bridge project to connect to a local TCP server inside the android app. Through this new TCP communication channel all calls that usually would go to wxWidgets are now redirected. The Android side of things implements handling in Bridge.kt.

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/30b86805-9c38-66d9-3c84-193f2567fd25.png)


たぶん、想像通りで合っているのだとおもいます。

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

ちょっと雑ですが、とりあえず、俺「[#NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)アドベントカレンダーを全日埋めたいっす:smile:」という気持ちでいっぱいという気持ちをいっぱいにして書くという気持ちを大切にするという気持ちで書きました。


Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 



[^1]: 「動かしてみました」の意。おそらく、西日本の方言、たぶん。NervesJPではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。 

[^3]: androidスマホをオフラインモードにしてもTODOアプリはイゴきました[^1]。そのため、スマホがどこかのサーバと通信をしてサーバの上でイゴいている[^1]LiveViewアプリケーションをスマホで動かしているわけではなく、androidアプリ(.apk)の中にErlangやElixir、LiveViewアプリそんなものたちがよしなに詰め込まれているのだとおもいました。
