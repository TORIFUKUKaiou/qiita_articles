---
title: Amazon Q Developer CLIに闘魂注入！？
tags:
  - AWS
  - 猪木
  - 闘魂
  - AmazonQ
  - AIではなく人間が書いてます
private: false
updated_at: '2025-08-12T11:05:38+09:00'
id: f2768a6704e0e86ad8da
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
English: [Injecting Toukon (Self-Mastery Spirit) into Amazon Q Developer CLI!?](https://dev.to/torifukukaiou/injecting-toukon-self-mastery-spirit-into-amazon-q-cli-3ddb)

## はじめに

[Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli)をご存知でしょうか。`q`とターミナルに打ち込んで、チャットしながら開発を進めるAIツールです。  

これをインストールすると、もれなく[Command line assistance features](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-assistance.html)というターミナルでのコマンド操作を便利にしてくれるツールも手に入ります。あとで知ることになりますが、この機能の元は、どうやら[Fig](https://github.com/withfig/fig)というツールが前身のようです。[Fig](https://github.com/withfig/fig)という名前で検索してみると、前身時代にも話題になっていたようで記事がちらほらみつかります。  

`q --help-all`すると、`theme`というサブコマンドがありました。何だろう、テーマって？　と思って、いろいろと調べ、歩み、挑戦をした旅の記録です。  

私のテーマはもちろん「:fire:闘魂:fire:」です。  

### ヘルプミー

まずはヘルプで確認してみました。  

```bash
$ q theme --help

Get or set theme

Usage: q theme [OPTIONS] [THEME]

Arguments:
  [THEME]  

Options:
      --list        
      --folder      
  -v, --verbose...  Increase logging verbosity
  -h, --help        Print help
```

あっさりしています。なんだかわかりません。[Amazon Q CLI command reference](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-reference.html)をみてもよくわかりません。  

---

## 第一章：発見の瞬間

`q theme --list` を打つとテーマ名のようなものが羅列されました。`q theme --folder`をすると、私のmacOSでは`/Applications/Amazon Q.app/Contents/Resources/themes`でした。`ls`してみると、`.json`が置かれていて、`q theme --list`したときにみた名前と一致していることがわかりました。  

ためしに、`palenight`テーマに変えてみました。  

```bash
q theme palenight

› Switching to theme 'palenight' by Jamie Weavis
  🐦 @jamieweavis
  💻 github.com/jamieweavis
```


そこには作者の名前、GitHubアカウント、Twitterハンドルが表示されていました。  
「私のテーマも、ここに載せてもらえるのではないか？」と思いました。  


## 第二章：Fig という前身

調査を進めると、[Amazon Q CLI](https://github.com/aws/amazon-q-developer-cli)の[Command line assistance features](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-assistance.html)機能の前身に「[Fig](https://github.com/withfig/fig)」というプロジェクトの存在が浮かび上がりました。  

[Fig](https://github.com/withfig/fig)のGitHubリポジトリはPublic Archiveされており、[公式ページ](https://fig.io/)には、「Fig has been sunset, migrate to Amazon Q」と書いてありました。Public Archiveされたリポジトリの案内には、[amazon-q-developer-cli](https://github.com/aws/amazon-q-developer-cli)で手に入るとのことでしたので、まずは[amazon-q-developer-cli](https://github.com/aws/amazon-q-developer-cli)を解析してみることにしました。  


## 第三章：Amazon Q Developer CLIとの対話

[amazon-q-developer-cli](https://github.com/aws/amazon-q-developer-cli)を解析してみます。  

奇しくも、Amazon Q Developer CLI のコードを解析するのは Amazon Q Developer CLI自身にやってもらいました。  
「**君は自分自身を解析できるのか？**」  
AIとの奇妙な共同作業が始まりました。  
小宇宙（コスモ）を感じました。  

しかし、調査は難航をきわめます。[Fig](https://github.com/withfig/fig)の形跡らしきものが見つかりません。`theme`サブコマンドまでの道のりは遠そうです。  


## 第四章：autocomplete リポジトリの発見

それは険しい道のりでした。いばらの道でした。しかし、猪木さんがおっしゃったように笑って歩きました。  
Amazon Q Developer CLIが頑張ってくれました。  
[amazon-q-developer-cli/crates/chat-cli/src/cli/feed.json](https://github.com/aws/amazon-q-developer-cli/blob/5ba7b8db9f3d8203c6578c9c1bf22127959bf70e/crates/chat-cli/src/cli/feed.json) の中に、[amazon-q-developer-cli-autocomplete](https://github.com/aws/amazon-q-developer-cli-autocomplete)リポジトリへの参照が大量に見つかりました。

ここまでくれば、あとは楽勝です。ついに発見しましたよ！[amazon-q-developer-cli-autocomplete](https://github.com/aws/amazon-q-developer-cli-autocomplete)の中に。
[build.py の718行目](https://github.com/aws/amazon-q-developer-cli-autocomplete/blob/e44ee53d76813a5ef107dcd0d6181b089cb5b2f2/build-scripts/build.py#L718)に隠された真実：

https://github.com/aws/amazon-q-developer-cli-autocomplete/blob/e44ee53d76813a5ef107dcd0d6181b089cb5b2f2/build-scripts/build.py#L718

_（↑↑↑ Qiitaさんの最近のアップデートで入った機能です。GitHubのURLを書いておくといい感じに表示してくれます！！！）_

[Fig](https://github.com/withfig/fig)のテーマを集めたリポジトリからコピーしていることを発見しました。  

世界的なソフトウェアの心臓部（否、上っ面？）に、闘魂を注入する道筋が見えてきました。  


## 第五章：闘魂の実装

「**闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくこと**」との猪木さんの教えをAmazon Q CLIに伝え、ストロングスタイルの黒をベースに、燃える闘魂を表現したテーマ(`toukon.json`)を作ってもらいまいました。

```json:toukon.json
{
  "$schema": "../schema.json",
  "author": {
    "name": "Awesome YAMAUCHI",
    "twitter": "@torifukukaiou",
    "github": "TORIFUKUKaiou"
  },
  "version": "1.0",
  "theme": {
    "textColor": "#FFD700",
    "backgroundColor": "#000000",
    "matchBackgroundColor": "#CC0000",
    "selection": {
      "textColor": "#FFFFFF",
      "backgroundColor": "#CC0000",
      "matchBackgroundColor": "#FFD700"
    },
    "description": {
      "textColor": "#CCCCCC",
      "borderColor": "#CC0000",
      "backgroundColor": "#1A1A1A"
    }
  }
}
```

一応動作確認のため、`"/Applications/Amazon Q.app/Contents/Resources/themes/toukon.json"`をおきました。ターミナルを使って書き込む際には、macOSの設定でアプリを書き換える許可が必要です。macOSのバージョンによってたまに設定の位置がかわるのでバージョンを披瀝しておきますと、15.6です。スクリーンショットを貼っておきます。  

![スクリーンショット 2025-08-11 17.14.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fd803e39-36bd-472f-bdd3-fa2d9b3392f4.png)


まあまあ、危険で過激なことをしている気がしますが、 **危ぶめば道はなし** です。 **踏み出せばその一足が道となり、その一足が道となり** ます。迷わず行きました！　行けばわかりましたよッ！ **猪木さん**！！！

```bash
cat > "/Applications/Amazon Q.app/Contents/Resources/themes/toukon.json" << 'EOF'
{
  "$schema": "../schema.json",
  "author": {
    "name": "Awesome YAMAUCHI",
    "twitter": "@torifukukaiou",
    "github": "TORIFUKUKaiou"
  },
  "version": "1.0",
  "theme": {
    "textColor": "#FFD700",
    "backgroundColor": "#000000",
    "matchBackgroundColor": "#CC0000",
    "selection": {
      "textColor": "#FFFFFF",
      "backgroundColor": "#CC0000",
      "matchBackgroundColor": "#FFD700"
    },
    "description": {
      "textColor": "#CCCCCC",
      "borderColor": "#CC0000",
      "backgroundColor": "#1A1A1A"
    }
  }
}
EOF
```

ついに `q theme toukon` が効きます。私のローカルマシンのAmazon Q CLI - [Command line assistance features](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-assistance.html)に闘魂を注入しました。世界に一台だけです。唯一です。オンリーワンです。  

それで本家にプルリクを送りました。   


## エピローグ：世界への闘魂注入

[プルリクエスト #37](https://github.com/withfig/themes/pull/37) を送りました。  
マージされれば、世界中の開発者が **闘魂** を体験できます。取り込まれれば、どこかのリリースタイミングでビルドフローに乗ると思いますので、私のように **危険かつ過激** なことをしなくても、みなさまの手もとでも`q theme toukon`とすれば、 **闘魂注入** が可能となります。放置されたテーマのプルリクが順番待ちをしているので、マージされるのは難しいだろうとは思います。 

[Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli) というツールを使って、[Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli) を解析し、そして [Amazon Q Developer CLI](https://github.com/aws/amazon-q-developer-cli)  に **闘魂を注入** するまでの物語でした。


## 技術的な発見のまとめ

この冒険を通じて発見した技術的なポイントをまとめておきます：

1. **Fig の遺産**: Command line assistance features は Fig プロジェクトの技術を継承している
2. **テーマシステム**: ビルド時に [withfig/themes](https://github.com/withfig/themes) リポジトリから自動的にテーマをクローンする仕組み
3. **テーマファイル構造**: JSON形式でスキーマ、作者情報、カラー定義を含む
4. **貢献方法**: 新しいテーマは withfig/themes リポジトリへのプルリクエストで追加可能 !?

**闘魂とは己に打ち克つこと**。この技術探求もまた、未知への挑戦という己との闘いでした。

---

*この記事が、Amazon Q Developer CLI を使う開発者の皆さんの参考になれば幸いです。そして、いつか世界中の開発者が `q theme toukon` で闘魂を体験できる日が来ることを願っています。*
