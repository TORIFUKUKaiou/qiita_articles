---
title: 闘魂mkdir ── mkdirしたらcdしてついでにVisual Studio Codeを立ち上げることにしました
tags:
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-08-16T20:46:29+09:00'
id: c4c27c9453065f83f0a7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

# はじめに

:::note warn
本記事の内容は、macOS Ventura 13.5でのみ試しています。
:::

`mkdir`するときって、私はだいたい決まって以下の手順を行います。  

```bash
mkdir awesome
cd awesome
code .
```

これを一気に行うコマンドを作ってみます。  

ちなみに25年くらい前の私が最初にコマンドって素晴らしいですねと感動したコマンドが`mkdir`でした。  
これを知らなくて、ホームディレクトリ配下に大量の`.c`ファイルやら`~`ではじまるファイルやら、実験データなどが散乱していたことを覚えています。  

「[mkdirで作成したディレクトリに作成と同時に移動する](http://nasec.jugem.jp/?eid=20)」こちらの記事をとても参考にしました。ありがとうございます！

http://nasec.jugem.jp/?eid=20

# シェルスクリプトで実現する

シェルスクリプトで実現してみます。  

:::note warn
ファイル名や配置場所などもっとよいやり方がありましたらぜひ教えてください
:::

```:~/mkcdcode
mkdir -p $1 && cd $1 && code .
```

`~/mkcdcode`というファイルを作りました。中身は上記の通りです。  
shebangを書いていません。

```bash
chmod +x ~/mkcdcode
```

`~/.zprofile`ファイルに以下を書き足しました。

```:~/.zprofile
alias mkcdcode='source $HOME/mkcdcode'
```

あとは、`source ~/.zprofile`とやるかターミナルを立ち上げ直してください。  
使い方はたとえば`awesome`というすごいディレクトリを作る際には以下のように実行します。  

```bash
mkcdcode awesome
```

これを実行すると、`awesome`というすごいディレクトリが作成されて、`awesome`ディレクトリへChange Directoryして、[Visual Studio Code](https://code.visualstudio.com/)で開かれます。

# escriptで実現する

[Elixir](https://elixir-lang.org/)という素敵な言語がありましてですね、簡単にCLIアプリケーションを作れます。  
「[Executables](https://elixirschool.com/en/lessons/intermediate/escripts)」が詳しいです。  

https://elixirschool.com/en/lessons/intermediate/escripts

私が作ったものをGitHubにあげています。  

https://github.com/TORIFUKUKaiou/mkdir_cd_code

[Elixir](https://elixir-lang.org/)はインストール済みで`mix`コマンドが使用できる環境をお持ちであることを前提に筆を進めています。

:::note alert
~~ただね、`cd`がうまくいっとらんとです。~~ 
~~解決策がわかる方はぜひ教えてください。~~
:::

:::note info
@zacky1972 先生のコメントで解決できました。
ありがとうございます！
:::


https://qiita.com/torifukukaiou/items/c4c27c9453065f83f0a7#comment-5e1570fb538211526524

---

_以下、「`cd`がうまくいきませんでした」の内容（思い出）をそのまま残しておきます。_

![スクリーンショット 2023-08-14 14.17.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6f4d8d2c-2da2-df5c-b705-2767fc779530.png)

_参考にさせていただいた記事「[mkdirで作成したディレクトリに作成と同時に移動する](http://nasec.jugem.jp/?eid=20)」のこのへんの事情と同じだとおもいます。_
_[Elixir](https://elixir-lang.org/)のプログラム実行中には確かに移動できていますが、プログラムが終わったあとの実行元のOSのプロセスには影響を及ぼさないみたいな。_

_ちなみに`source mkdir_cd_code hoge`や`. mkdir_cd_code hoge`では以下のエラーでうまくいきませんでした。_  

```
source mkdir_cd_code hoge
/Users/osamu/.asdf/installs/elixir/1.15.4-otp-26/.mix/escripts/mkdir_cd_code:fg:2: no current job
/Users/osamu/.asdf/installs/elixir/1.15.4-otp-26/.mix/escripts/mkdir_cd_code:fg:3: no current job
/Users/osamu/.asdf/installs/elixir/1.15.4-otp-26/.mix/escripts/mkdir_cd_code:4: bad pattern: PK^C^D^T^@^@^@^H^@^Wp^NW؎I\M-(\M-^U^E^@^@^P^H^@^@^Z^@^@^@mkdir_cd_code_escript.beammU[l^TU^X\M-^^ٳ\M-]^]\M-6\M-^]r\M-:3\M-]m\M-9u\M-h\M-v\M-Bm/-^P\M-(^H\M-^Y^V\M-^W\M-%\M-4\M-T\M-J%\M-\n^ON\M-'
```

それで私は何をやったかというと、~~ターミナルアプリを新しく起動するという方法を採りました。~~ @zacky1972 先生にいただいた[コメント](https://qiita.com/torifukukaiou/items/c4c27c9453065f83f0a7#comment-5e1570fb538211526524)を参考に`cd $(mkdir_cd_code hoge)`とすることにしました。


以下ざっと本件を例にescriptの作り方を書いておきます。  

escriptについては、

https://qiita.com/ohr486/items/ab8c69fdc5358e649fd8

の記事も詳しいです。

## プロジェクトの作成

プロジェクトを作成します。  
`cd`、`code`も行います。

```bash
mix new mkdir_cd_code
cd mkdir_cd_code
code .
```

## ソースコードの作成

ソースコードを作成します。  
2つのファイルです。  

### mix.exs

`mix.exs`に`escript: [main_module: MkdirCdCode.CLI]`を書き足します。

```elixir:mix.exs
defmodule MkdirCdCode.MixProject do
  use Mix.Project

  def project do
    [
      app: :mkdir_cd_code,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: MkdirCdCode.CLI] # add
    ]
  end
```

### lib/mkdir_cd_code/cli.ex

`lib/mkdir_cd_code/cli.ex`を実装します。

```elixir:lib/mkdir_cd_code/cli.ex
defmodule MkdirCdCode.CLI do
  def main([]) do
    # ディレクトリ名が指定されなかった場合は使い方を説明して終了
    # https://qiita.com/torifukukaiou/items/c4c27c9453065f83f0a7#comment-9ddd3d0ccf767d6e74a7
    IO.puts(:stderr, "Usage: mkdir_cd_code dir_name")
    IO.puts(".")
  end

  def main(args) do
    [dir | _] = args
    :ok = File.mkdir_p(dir)

    if System.find_executable("code") do
      System.cmd("code", [dir])
    end

    IO.puts(dir) # 移動先のディレクトリのみを標準出力に表示する
  end
end
```

## インストール

プロジェクトのルートで下記のコマンドを実行します。

```bash
mix escript.install
```

または私の制作したものを使用してくださるのなら以下のコマンドでもインストールできます。  

```bash
mix escript.install github TORIFUKUKaiou/mkdir_cd_code
```

もう一度繰り返しておきます。

:::note warn
本記事の内容は、macOS Ventura 13.5でのみ試しています。
:::

~~`open -a Terminal awesome`なんてmacOS以外動きません。~~

ちなみに`mix escript.install`の使い方は、`mix help escript.install`を引いてみてください。  


そのあとは、インストール場所が示されるのでパスを控えておいてください。  
パスがわからなくなったら`mix escript`コマンドで調べることができます。  

私は`~/.zshrc`に以下のような関数を追加しました。  

```:~/.zshrc
mkcdcode() {
    cd $($HOME/.asdf/installs/elixir/1.15.4-otp-26/.mix/escripts/mkdir_cd_code $1)
}
```

:::note warn
Elixirの新しいバージョンをインストールしたらどうしよう。
都度これを書き直すことになるのでしょうが、忘れそうです。
忘れないようにするためにQiitaに書いたとも言えます。
もっといい指定の仕方をご存知の方はぜひ教えてください！
:::

## 使い方

使い方を示します。  

```bash
mkcdcode hoge
```

`hoge`というディレクトリができて、[Visual Studio Code](https://code.visualstudio.com/)が立ち上がって、ターミナルは`hoge`ディレクトリへ移動します。  

---

# さいごに

mkdirしたらcdしてついでにVisual Studio Codeを立ち上げることにしました。  
シェルスクリプト版は、シェルスクリプトの配置場所、ファイル名、`alias`を書く場所など「こうしたほうがいい」があるかもしれませんが（ぜひコメントください:pray:）、当初やりたかったことを実現できました。  

私は[Elixir](https://elixir-lang.org/)が好きですし、簡単にコマンドラインツールが作れるので、[Elixir](https://elixir-lang.org/)でやったらおもしろそう！　と取り組んでみたところ`cd`がうまくいきませんでした。
~~こちらはわかるかたはぜひ教えてください！~~ => @zacky1972 先生の[コメント](https://qiita.com/torifukukaiou/items/c4c27c9453065f83f0a7#comment-5e1570fb538211526524)により解決できました！　ありがとうーーーーッ！！！　ございますです。

「教えてください」が多目の記事となりました。こんな話を思い出しましたので最後にツイートを貼っておきます。  


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">もう一つ気に入ってるスティーブ・ジョブズの成功哲学。彼からしてみるとこの単純な事ができるだけでも人生はかなり好転すると。逆にいうとそれをしない人が多すぎる。本当にかなり単純な事なんだけど、それが意外と出来なかったりしますよね。 <a href="https://t.co/hfinRbPsQp">pic.twitter.com/hfinRbPsQp</a></p>&mdash; Brandon K. Hill | CEO of btrax 🇺🇸x🇯🇵/2 (@BrandonKHill) <a href="https://twitter.com/BrandonKHill/status/1684429849061105665?ref_src=twsrc%5Etfw">July 27, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>




---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>


