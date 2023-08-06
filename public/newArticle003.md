---
title: 闘魂Mac ーー 新しいMacBook Proのセットアップで詰まったこと
tags:
  - Mac
  - 闘魂
private: false
updated_at: '2023-08-06T22:28:29+09:00'
id: 323ffda3ac2d0329c62f
organization_url_name: null
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

# はじめに

MacBook Pro 16インチ、2023を新調しました。  
Time Machineでホームディレクトリを[データ移行](https://support.apple.com/ja-jp/HT204350)したあとに各種ソフトウェアのインストールを進めようとしたとき詰まったことを書いておきます。  

# Google 日本語入力がインストールできない

[Google 日本語入力](https://www.google.co.jp/ime/)をインストールできませんでした

https://support.google.com/gboard/thread/208195633/mac%E3%81%AEos%E3%82%92ventura%E3%81%AB%E3%81%97%E3%81%A6%E3%81%8B%E3%82%89google%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9B%E3%81%8C%E4%BD%BF%E3%81%88%E3%81%BE%E3%81%9B%E3%82%93%E3%80%82?hl=ja

[macのOSをVenturaにしてからGoogle日本語入力が使えません。](https://support.google.com/gboard/thread/208195633/mac%E3%81%AEos%E3%82%92ventura%E3%81%AB%E3%81%97%E3%81%A6%E3%81%8B%E3%82%89google%E6%97%A5%E6%9C%AC%E8%AA%9E%E5%85%A5%E5%8A%9B%E3%81%8C%E4%BD%BF%E3%81%88%E3%81%BE%E3%81%9B%E3%82%93%E3%80%82?hl=ja)

こちらの記事に助けてもらいました。
開発版をインストールすることで解消しました。

# docker command: not found

[Docker Desktop](https://www.docker.com/products/docker-desktop/)をインストールしました。  
ターミナルから`docker ps`とかってコマンドを打つと、`not found`と言われます。

これらの記事に助けてもらいました。

https://stackoverflow.com/questions/64009138/docker-command-not-found-when-running-on-mac

[Docker command not found when running on Mac](https://stackoverflow.com/questions/64009138/docker-command-not-found-when-running-on-mac)

https://zenn.dev/joo_hashi/articles/ffa50076261963

[Dockerコマンドが反応しない？](https://zenn.dev/joo_hashi/articles/ffa50076261963)

3通り解決策があります。  

1. ls -la ~/.docker/bin をしてみてシンボリックリンクができていたらパスを通す
2. dockerバイナリへのパスを通す
3. アンインストール（上部クジラアイコンをクリックしてTroubleshoot）してから再インストール

私は3でうまくいきました。  

1番はたとえば`~/.zprofile`にこんな感じです。  

```:~/.zprofile
export PATH="$HOME/.docker/bin:$PATH"
```

2番はたとえば`~/.zprofile`にこんな感じです。  

```:~/.zprofile
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
```


# さいごに

そのうち解消されることばかりだとはおもいますが、記録を残しておきます。  
MacBook Pro 16インチ、2023をセットアップ（セラップ）において、[Google 日本語入力](https://www.google.co.jp/ime/)と[Docker](https://www.docker.com/)のインストールがスッといかなかった思い出を書いておきました。  

**元氣があればなんでもできる！** であります。

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>

