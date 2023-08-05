---
title: Qiita記事をGitHubで管理することにしました (use Qiita CLI)
tags:
  - Qiita
  - QiitaCLI
private: false
updated_at: '2023-08-05T11:14:21+09:00'
id: 75854acfcb0460d08237
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

# はじめに

[Qiita CLI](https://github.com/increments/qiita-cli)を使ってみました。  
これを期にGitHubで管理することにしようとおもいます。

# Requirements

いつインストールしたのか、どうやってインストールしたのかさっぱりですが、`npm`や`npx`と`git`が使える必要があります。  
そこんところはよろしくやってください。  

# 導入

では、[Qiita CLI](https://github.com/increments/qiita-cli)を導入してみます。  

基本的には[README.md](https://github.com/increments/qiita-cli/blob/main/README.md)が丁寧に書かれておりますのでその通りにやればよいです。  

まずフォルダを作ります。中に入ります。  

```bash
mkdir qiita_articles
cd qiita_articles
```

[Qiita CLI](https://github.com/increments/qiita-cli)をインストールします。  

```bash
npm install @qiita/qiita-cli --save-dev
```

初期化します。  

```bash
npx qiita init
```

ここまでで以下のファイルができています。  

- .github/workflows/publish.yml
- .gitignore
- package-lock.json
- package.json
- qiita.config.json

Qiitaにログインします。

```bash
npx qiita init
```

`npx qiita init`を実行すると以下のように表示されるので、指示されたURLにアクセスして発行したトークンを入力します。  

```bash
以下のURLにアクセスしてトークンを発行してください。（「read_qiita」と「write_qiita」にチェックを入れてください）
  https://qiita.com/settings/tokens/new?read_qiita=1&write_qiita=1&description=qiita-cli
  
発行したトークンを入力: 
```

トークンは、`~/.config/qiita-cli/credentials.json`に保存されています。  

いままで書いた記事（作品）をダウンロードじゃ〜  

```bash
npx qiita pull --force
```

`public/`フォルダの下に、`*.md`ができます。

```bash
ls public 
009fc0559c70e5e69ca7.md 35454d3faaaa0d142ae6.md 6a4649c1d72bf49c92f0.md 9e00d25ebf1d1077ef2f.md cbede299eeda0111baf1.md
00b5b0a8b8e81ad0ae46.md 35ef3e16bdad9ecd764a.md 6adf153ee3893fd1ad4d.md 9e9e28411d6a7d134a11.md ce141100348a4f558669.md
01452b8dac5e82fbdd1b.md 3604c3d2ee2092087ba2.md 6bcd5bbb80df9e594e9e.md 9ee8276ede477e22c52e.md ce959056e34e9a2a33e3.md
015873cc4272eef15f7f.md 3665a4a6e749ec7ef846.md 6c25e3e0183f12f90c14.md 9f8d380cf5368f1754df.md cebf4729fb4368a68d8a.md
03e87957e995528e5753.md 3689dff13044c0465384.md 6cbea79ccf0eea8777d2.md a02a3a599d1959dd80f2.md cefebdcfccdeee67d151.md
```

こげな感じです。ファイル名は`{記事のID}.md`のようです。  

# 画像

あれ？　画像は？　と思いまして記事の中をみました。  
たとえば`https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c80a4a05-50ea-37e3-927a-8b2eb9286ac7.gif`のように以前Qiitaさんにアップロードさせていただいて、「あーなるほどAWSのS3にあったのですね」の場所が書いてありました。  

これから書く記事はどうしたらいいんだろう？　とこの時点では思いました。  
結論から言うと、Qiitaさんがアップロード場所を月100MB用意してくださっています！！！  
**ありがとうーーーッ！！！**　でございますです。  

# 記事を書く

```bash
npx qiita preview
```

しばらく待っていると、`http://localhost:8888`がブラウザで開きます。  

![スクリーンショット 2023-08-05 10.25.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/44fdae69-9930-e7f4-b798-76777bffc266.png)

左側の「画像をアップロード」ボタンを押すと、ファイルをアップロードできる画面へ遷移します。  

![スクリーンショット 2023-08-05 10.27.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/03feac17-7441-c7fb-7405-14a2e50921a2.png)

アップロードしたファイルのURLを確認する画面もあります。  

![スクリーンショット 2023-08-05 10.28.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7ce77779-9621-5994-e506-500aaa2f63dd.png)

左側の「新規記事作成」ボタンを押すと、記事の雛形ができます。  
あとはお好みのエディタで編集をします。  

![qiita.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c80a4a05-50ea-37e3-927a-8b2eb9286ac7.gif)


# GitHub で記事を管理する

「[GitHub で記事を管理する](https://github.com/increments/qiita-cli/blob/main/README.md#github-%E3%81%A7%E8%A8%98%E4%BA%8B%E3%82%92%E7%AE%A1%E7%90%86%E3%81%99%E3%82%8B)」に従います。  

![スクリーンショット 2023-08-05 10.39.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f0299d6e-de2d-1ebd-7805-1aa82abe9486.png)

あとはGitの操作なのでコマンドだけ記憶を元に羅列しておきます。  
なにか不足しているかもしれませんし、sshの設定は省略しますので、そこんところはよろしくお願いします。  


```bash
git init
git add .
git commit -m 'awesome'
```


GitHubにリポジトリを作ります。  
`https://github.com/[ユーザー名]/[リポジトリ名]/settings/secrets/actions`から、シークレットに`QIITA_TOKEN`という名前で発行した Qiita のトークンを保存します。
以下のコマンドを実行します。  


```bash
git branch -M main
git remote add origin git@github.com:TORIFUKUKaiou/qiita_articles.git
git push -u origin main
```

# さいごに

[Qiita CLI](https://github.com/increments/qiita-cli)を使ってみました。  

この記事は`git push -u origin main`によりGitHub ActionsでQiitaに投稿されるはず！　です。  

迷わずPushしてみます！  Pushしてみればわかるさ！  
GitHub Actionsがコケたり、動かなかったらそれはそれで記事が書けるのでラッキーさ！  

# GitHub Actions失敗 :sob:

うん、私は持っている。  
これは私が記事をRaspberry Piから自動更新しているために起こった問題です。  
`updated_at`で処理を止めていることがすばらしいです。  
この件の対処は後日考えること(Webhookを受け取ってGitHubを自動更新とか?)として、とりあえず`npx qiita pull`でQiita側の変更を取り込んでそれをCommitしてPushしてみます。

今度はきっと成功することでしょう！

![スクリーンショット 2023-08-05 11.03.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/48d3e7b8-f1dc-ea86-6e50-424ed2c8d49b.png)

# 成功しました :tada::tada::tada:

新規記事の`id`や`updated_at`、ちょっとした整形はGitHub Actionsがやってくれました。  
すごいすごい:rocket::rocket::rocket:

![スクリーンショット 2023-08-05 11.09.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/516588c0-bbca-7ace-75b2-fcc04f173ea4.png)

```bash
git pull
# 編集して
git add .
git commit -m 'update'
git push origin main
```

てな具合で書き足しました。



---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
