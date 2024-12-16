---
title: GitHub CodespacesでElixir Livebookを爆速セットアップ！
tags:
  - Microsoft
  - Elixir
  - Codespaces
  - 猪木
  - 闘魂
private: false
updated_at: '2024-12-15T23:30:09+09:00'
id: bc4cdcd7025bce09bffe
organization_url_name: null
slide: false
ignorePublish: false
---
![DALL·E 2024-12-15 12.22.31 - A vibrant illustration depicting the concept of GitHub Codespaces and Livebook development. The image shows a futuristic workspace in the cloud, with .png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/40f31852-8b54-bf87-f871-6c0e6e3be467.png)


:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:qiitan::qiitan::qiitan:

_クイズです。Qiitanは何体いるでしょうかーーーッ！？_


# はじめに

[GitHub Codespaces](https://github.co.jp/features/codespaces)で[Elixir](https://elixir-lang.org/)の開発ノートブック[Livebook](https://livebook.dev/)を動かす方法を説明します。

すぐにお試しいただけるように、GitHubにリポジトリを公開しております。
Livebookの立ち上げ方はもちろん、その中身も少し説明します。

プログラミング初学者の環境として利用する使い方もあるかもしれません。（GitHubのアカウントの作成が必要にはなります）

ただしLivebookの使い方は説明しません。「習うより慣れろ」ですし、 @RyoWakabayashi さんが良記事を闘魂（投稿）されていますのでそちらをご参照ください。

もちろん、猪木さんや闘魂についても語ります。ある意味、**闘魂**を書きたいから記事を書いています。Qiitanも欲しいです。:qiitan::qiitan::qiitan:

## 概要

本記事の概要を図示しておきます。(Powered by https://app.napkin.ai/)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0174c15f-4746-2cd7-e2c8-6d394d0ceead.png)



## GitHub Codespacesとは

すごくざっくり言うと、ブラウザがあれば開発ができます。開発マシン（リソース）はクラウド側にあります。

「習うより慣れろ」、「見る前に飛べ」、「崖を下りながら飛行機を組み立てろ」です。つまり、「危ぶむなかれ　危ぶめば道は無し　踏み出せばその一足が道となり　その一足が道となる　迷わず行けよ　行けばわかるさ」な代物です。使ってみたほうがよくわかります。

公式ページを紹介しておきます。

https://github.co.jp/features/codespaces

有料のサービスですが、最低スペックのマシンリソースを選んでおけば、2024-12-15現在、月に80時間分を無料で使えるので、普段使いでも十分です。

https://docs.github.com/ja/billing/managing-billing-for-your-products/managing-billing-for-github-codespaces/about-billing-for-github-codespaces

[devcontainer](https://code.visualstudio.com/docs/devcontainers/containers)についての知識もあると良いですが、使う分には知らなくてもなんとかなるので、ここでは割愛します。興味のある方はリンク先をご参照ください。ざっくり言うとDockerコンテナで開発をするわけですが、それがVisual Studio CodeやGitHub Codespacesとうまく統合されていて、もうMicrosoft様無しには開発ができなくなるわけです。いきなりコンテナの中から開発が始まりまして、ふつうにLinuxマシンの中で開発しているような感覚です。Dockerのコンテナであることを意識する場面はほぼありません。

## Livebook

Livebookはこれもざっくり言うと、Elixirのノートブック環境です。
動かし方はローカルマシンにElixirをインストールする方法とDockerで動かす方法などがあります。

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fc16ea8a-42c1-c846-9f42-49efc1cfd0f4.png)

Dockerで動くのなら、[GitHub Codespaces](https://github.co.jp/features/codespaces)でも動くはずだと試してみた、そしてその成果を共有したいというのが動機です。

前置きはこのくらいにしておきます。

---

# 使い方

[livebook-devcontainer](https://github.com/TORIFUKUKaiou/livebook-devcontainer)を公開しておきます。
まずはこれの使い方を紹介しておきます。

2つあります。

1. 【パスワード固定版】Livebookのパスワードを`securesecret`で立ち上げる
1. 【パスワード自動生成版】Livebookのパスワードを自動生成して立ち上げる

なぜ2つあるのかについてはのちほどリポジトリの説明のところで語ります。

また、私のことを信用できず、そのまま使いたくはないという方もいらっしゃると思います。当然だと思います。そのくらいの慎重さがないとすぐにマルウェアに引っかかってしまいます。

のちほどリポジトリの説明をしておりますので、中身を理解した上でご利用されるか、forkなりコピペなりして気になるところを修正してお使いいただくとよいです。さらにより善くするアイデアをお持ちでしたらプルリクをくださるか、forkしたあなたのリポジトリが本家となることでもよいです。


## 1. 【パスワード固定版】Livebookのパスワードを`securesecret`で立ち上げる

Livebookのイメージを使って立ち上げているので起動は速いです。
最低スペックのMachine type 2-coreでも約2分弱でLivebook環境が手に入ります。


Livebookのパスワードを`securesecret`で立ち上げる方法を紹介します

1. [livebook-devcontainer](https://github.com/TORIFUKUKaiou/livebook-devcontainer) にブラウザで訪れる
1. 【<> Code(緑)】 > 【Codespaces】 > ⋮ > 【+ New with options】

    ![スクリーンショット 2024-12-15 10.03.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/246b3e02-99b2-db8e-c1fa-f4b83e667f22.png)

1.  Branchを`main`にし、その他の値はお好みで変更して、迷わず【Create codespace】ボタンを押してください

    ![スクリーンショット 2024-12-15 10.09.22.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/88bddf86-ed08-7f77-0145-96f229974e40.png)

1.  1分23秒くらい待っていると以下のような画面が立ち上がりますので、下側の【ポート】タブを開いて、8080ポートの行の【転送されたアドレス】付近にマウスカーソルを動かすと、地球マークみたいなうっすらボタンが押せますので迷わず押してみましょう

    ![スクリーンショット 2024-12-15 10.12.15.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f92b0e13-49e6-c313-5db0-8fa53c08562d.png)

1. 上記で表示範囲が「Private」となっていることにお気づきでしょうか？　Codespaceを作成したGitHubアカウントでログインした状態でしか利用できないことを表しています

1. Livebookが立ち上がります :tada::tada::tada: ので、`securesecret`を迷わず入力してLivebookでの開発をお楽しみください！！！　あとは楽しむだけです！

    ![スクリーンショット 2024-12-15 10.19.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/06dc1e19-3c23-5376-ff2e-cc73cefd9137.png)

### 問題点

一部動かないノートブックがあります。JS系を使うものです。
たとえば、2024-12-15現在、Livebook 0.14.5に同梱されている学習コンテンツ（ノートブック）にある「Exploring built-in Kinos」の一部が動きません。（Learn > 01 Exploring built-in Kinos）

動かし方としては、上記手順の5番の表示範囲を「Public」に変更すると動くようになります。
変更方法は、右クリックから【ポートの表示範囲】で設定を変えます。

「Public」にすると文字通り、全公開で誰でも使えることになります。
パスワードが`securesecret`と弱いので誰かに意図せず使われてしまって、**後悔**することになるかもしれません。

_Livebookにちょっと詳しい方ならば、パスワードを自動生成に任せればいいのでは？　というアイデアが浮かぶと思います。私もそうしたかったのですが、Codespaceで立ち上がってきたときにはすでにDockerコンテナの中に入っている状態でして、クラウドの向こう側にあるはずのホストマシンにはアクセスできません。例のトークン付きのログはホストマシンの標準出力なわけで、コンテナの中からはどうにもなりません。devcontainerのログなどを探し回ったりしましたが、私には見つけられませんでした。もう一つほかのアイデアとしてはLivebookノードに接続[^1]をして、 `LivebookWeb.Endpoint.access_url()`をコールするというものです。しかし、いろいろと試してはみましたが、私には解決できませんでした。解決できた方はぜひコメント欄にてお知らせください:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:_

[^1]: たぶん、このへんのことを頑張れば、Livebookノードに接続できると思う：  https://hexdocs.pm/iex/1.17.3/IEx.html#module-remote-shells 

もちろん他にも動かないものがあるかもしれません。

【ポートの表示範囲】を「Public」（公開）にして、意図せず知らない誰かに使われて**後悔**したくはないわけです。

それで、第2の方法【2. Livebookのパスワードを自動生成して立ち上げる】へとつながるわけです。

## 2. 【パスワード自動生成版】Livebookのパスワードを自動生成して立ち上げる

Livebookを自分でビルドして、自分で立ち上げるという方法です。
そうすると起動時のログをもちろん見ることができます。

手順は先程とほぼ同じです。手順3番でBranchを`run-Livebook-directly-from-source`にしてください。
Elixirのインストールから始まるので立ち上がるまでに4分9秒[^2]くらい待ってください。猪木さんの引退試合[^3]でも観ていてください。

[^2]: 猪木さんの引退試合は4分9秒でグランドコブラで、ドン・フライ選手を沈め見事勝利で引退の花道を飾りました：　https://www.asahi-net.or.jp/~yf7m-on/match5.html

[^3]: https://www.dailymotion.com/video/x95qrz6

手順4へ移る前にLivebookを手動で立ち上げる必要があります。

![スクリーンショット 2024-12-15 10.58.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a4b4f98d-5b21-de48-bad3-fe3d2b33e76e.png)

以下、先程とは手順の変わるところのみを示します。

1. `/home/vscode/livebook/config/prod.exs`を編集

    心得のある方ならおわかりだと思います。ロードバランサー的なインターネットと接する前段のsomethingからPhoenixアプリ（ここではLivebook）へアクセスできるように、IPの設定を変えます。変更箇所は以下です。`/home/vscode/livebook/config/prod.exs`を編集します。`{127, 0, 0, 1}`を`{0, 0, 0, 0}`に変えます。（※ ロードバランサー的なもののホスト名はわかるので、それのIPを`nslookup`で引いてみて、そのIPを設定することを試みてみましたが、Phoenixが立ち上がりませんでした）

    ![スクリーンショット 2024-12-15 11.02.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3dfc6b13-906b-b786-7a62-b77fec401958.png)


1. 【ターミナル】タブで、+ > 【bash】という具合にコマンドを打てる状態にして、`mix phx.server`でLivebookを起動し、`token`の値を控えておく(`token`の値は起動の都度変わりますので堂々と公開しています）


    ![スクリーンショット 2024-12-15 11.29.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4e81de40-6070-3cba-c214-b5a9a5feb1d1.png)


1. あとは先ほどの手順4と同じです。パスワードには`token`の値を入力してください。

JS系のsomethingを動かしたい場合には、さきほどと同じように【ポートの表示範囲】を`Public`に変えてください。
`securesecret`よりは誰かにログインされてしまうことは少なくなるとは思いますが、完全ではありませんので自己責任でお使いください。



---

# リポジトリの説明

[livebook-devcontainer](https://github.com/TORIFUKUKaiou/livebook-devcontainer)リポジトリの説明をしておきます。

## mainブランチ

`securesecret`で立ち上げる方法で使用するブランチです。


https://github.com/livebook-dev/livebook
で紹介されているDockerコマンドをdevcontainerに仕立てました。
Dockerイメージは公式が使っているものと同じです。

環境変数`LIVEBOOK_PASSWORD`に`securesecret`をセットしています。

## run-Livebook-directly-from-sourceブランチ

- Microsoft様が公開されている[Base Development Container Images](https://hub.docker.com/r/microsoft/devcontainers-base)のUbuntu-24.04をベースにして、あたかもLinuxマシンで開発しているかのような体験を実現
- ElixirとErlangをインストール
    - 「[Phoenix公式ページのデザインが刷新！変化した点を徹底解説](https://qiita.com/torifukukaiou/items/6c9025039ce2843209dd)」で紹介したElixir公式がメンテナンスしている[インストールスクリプト](https://new.phoenixframework.org/myapp)を「**早速**」利用
- Livebookをgit clone, mix deps.get, mix compileまで実施済み
- `mix phx.server`を自分で打ち込んで実行してもらうことで、`token`が自動生成され、ご自身で確認できるようになる

ざっくりこんなところです。

---

# 求む！！！　より善い解決策を！

`run-Livebook-directly-from-source`はイケていません。私もよくわかっています。【ポートの表示範囲】を`Public`（公開）にして後悔したくはありません。この記事で紹介した方法は誤りがあるかもしれません。正しい解決法がおわかりの方はぜひコメント欄にてお便りをお寄せください。

## 問題だと思っていること

問題だと思っていること、もしくはもっとよい解決策があるかもしれないと思っていることを列挙しておきます。
ただ私の２０年以上のキャリアが言うにはそんなに間違ったことはしていないと思います。

- 公式のLivebookイメージからCodespaceでコンテナを立ち上げたときに、自動生成された`token`をどうにか取得したい
- JS系の機能を使うときに【ポートの表示範囲】を`Public`（公開）にしなくても使えるようにならないの？
- `/home/vscode/livebook/config/prod.exs`の`:ip`は、`{0, 0, 0, 0}`以外に絞る方法で設定できないの？
- 他にもLivebookとして動かないことはないの？

お気づきの点がございましたらぜひ、コメント欄にてお便りをお待ちしております！

---

# やりたいこと

やりたいと思っていることです。

Livebook、Elixir、Erlangのバージョンを2024-12-15現在の最新で指定しておりますので今後も更新を続けようと思っていますが、更新を忘れてしまうことがありそうで、仕組みで解決したいです。

- 自動化したいです
    - たぶん、GitHub Actionsでできると言っています
        - GitHub Actionsにおいて、定期実行は知っていますし、Git Pushの経験もあります
        - テキストの整形をコマンドでやる知識(`sed`?)が足りていませんが、ChatGPT Plusに相談すれば簡単かもしれませんし、スクリプトで解決する手もありそうです

---

# 未使用のCodespaceは`delete`で課金を抑える

必要になったらまた作ればいいので、

https://github.com/codespaces

[codespaces](https://github.com/codespaces)で、使用しないCodespaceを削除しておくと課金を抑えられます。
作って壊して、また作って……　が手軽にできるのがクラウドのよさだと思います。


![スクリーンショット 2024-12-15 12.13.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0d90fa85-fc78-d7db-8344-702ba6ea0158.png)


---

# 初学者向けハンズオンで使うときの注意点

「はじめに」で、「プログラミング初学者の環境」について言及しました。
使えると思います。

ただ私はハンズオンを想定した使い方はしていないので、よくリハーサルをしてからご利用されることをオススメします。以下のポイントでリハーサルをされることをオススメします。

- ハンズオンの内容を実行できるのか（【ポートの表示範囲】をPrivateのまま実行できる範囲にとどめておくことが、お互いに**後悔**をしない）
- [GitHub Codespaces のタイムアウト期間を設定する](https://docs.github.com/ja/codespaces/setting-your-user-preferences/setting-your-timeout-period-for-github-codespaces) を参照して、必要に応じてハンズオン中には適切なタイムアウト値を設定する

またGitHubのアカウントがない「本当の初学者」には、以前としてハードルは高いだろうと思うことを申し添えておきます。

---

# まとめ

[GitHub Codespaces](https://github.co.jp/features/codespaces)で[Elixir](https://elixir-lang.org/)の開発ノートブック[Livebook](https://livebook.dev/)を動かす方法を説明しました。



以下のアクションを通じて、実際に試してみてください：

1. **セットアップに挑戦**
   - [livebook-devcontainer](https://github.com/TORIFUKUKaiou/livebook-devcontainer)を利用し、手順に沿ってLivebookを動かしてみましょう。（フォークしなくても使えます）
2. **問題点を改善するアイデアを共有**
   - 記事で挙げた課題について、コメント欄やプルリクエストで意見をお寄せください。
3. **ハンズオンや学習用途での活用**
   - 初学者向けのハンズオンや、自身のプロジェクトでの活用を検討してみてください。

猪木さんが言うように、**「迷わず行けよ、行けばわかるさ」** の精神で挑戦し、技術力を磨いていきましょう！







