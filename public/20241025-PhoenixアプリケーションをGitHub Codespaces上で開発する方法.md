---
title: PhoenixアプリケーションをGitHub Codespaces上で開発する方法
tags:
  - Elixir
  - Phoenix
  - Codespaces
  - 猪木
  - 闘魂
private: false
updated_at: '2025-05-04T14:48:33+09:00'
id: 5dd716cb04db9b46bc92
organization_url_name: haw
slide: false
ignorePublish: false
---
**「道を切り開く者こそ、未来を手にする者である」。技術の進歩は、挑戦を通じて道が拓かれるものです。[GitHub Codespaces](https://github.co.jp/features/codespaces)と[Phoenix](https://www.phoenixframework.org/)の組み合わせは、効率的かつスピーディにアプリケーションを作成するための強力なツールです。さあ、次なるステップに進みましょう。**

# [Phoenix](https://www.phoenixframework.org/)アプリケーションを[GitHub Codespaces](https://github.co.jp/features/codespaces)上で開発する方法

[Phoenix](https://www.phoenixframework.org/)アプリケーションを[GitHub Codespaces](https://github.co.jp/features/codespaces)上で開発する方法を説明します。

[paiza×Qiita記事投稿キャンペーン「プログラミング問題をやってみて書いたコードを投稿しよう！」](https://qiita.com/official-events/9ab96aa95d62fe3cbdd7)にて最優秀賞（Apple Watch Series 9（GPSモデル））を獲得した @haw_ohnuma や [日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)（FLEXISPOT スタンディングデスク 電動式 昇降デスク ＆ 天板）を獲得した @torifukukaiou が所属する[ハウインターナショナル](https://www.haw.co.jp/)では、AI補助制度というものがありまして、たとえば[ChatGPT Plus](https://openai.com/index/chatgpt-plus/)や[GitHub Copilot](https://github.com/features/copilot)の利用料を会社が負担してくれます。
今回は、[ChatGPT Plus](https://openai.com/index/chatgpt-plus/)で、「**Write on Qitta about to create Phoenix app on a GitHub Codespace**」とだけ打ち込んで大部分ができあがってしまったマークダウンを微修正して記事を投稿（闘魂）しています。

また月末の最終金曜日は、社内ハッカソン、その名も[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)を実施しており、その成果物でもあります。

## 1. GitHub Codespacesとは？

[GitHub Codespaces](https://github.co.jp/features/codespaces)は、クラウド上で完全な開発環境を即座に立ち上げることができるサービスです。ローカルにソフトウェアをインストールすることなく、どこからでもブラウザを通じて開発が可能になります。特にチームでの協働や、素早いプロトタイプ作成に非常に有効です。

2024-10-25現在、月あたりで120 core時間の無料利用枠があります。2 coreが一番下のスペックなので、月60時間までは無料で使えるというわけです。

https://docs.github.com/ja/billing/managing-billing-for-your-products/managing-billing-for-github-codespaces/about-billing-for-github-codespaces

## 2. Phoenixとは？

[Phoenix](https://www.phoenixframework.org/)は、[Elixir](https://elixir-lang.org/)言語で構築されたWebアプリケーションフレームワークであり、高いパフォーマンスとリアルタイム機能が特徴です。スケーラブルなアプリケーション開発に適しており、現代のWebアプリケーションに求められる要件を十分に満たしています。

## 3. Developing inside a Container とは？

[Developing inside a Container](https://code.visualstudio.com/docs/devcontainers/containers) は、開発環境をコンテナ化することで、どこでも一貫した開発環境を提供する仕組みです。[Visual Studio Code](https://code.visualstudio.com/)と[Docker](https://www.docker.com/ja-jp/)を使用して、ローカル環境や異なるマシン間でも同じ設定を使用できるため、依存関係や構成の違いに悩むことなく開発を進めることができます。

具体的には、 プロジェクトのルートに、 `.devcontainer` というフォルダを作って `Dockerfile` 等を置いておきます。

それで、  `.devcontainer` を作っておくと、[GitHub Codespaces](https://github.co.jp/features/codespaces)で開発する手段も自動で手に入ります。

## 4. `.devcontainer` フォルダの中身はどうやって作るの？

https://github.com/microsoft/vscode-dev-containers/tree/main/containers

にサンプル集がありますのでこれを使うとよいでしょう。

Javaでの開発サンプル、Ruby on Railsでの開発サンプル、Pythonでの開発サンプルなどがあります。
ただし **This repository has been archived by the owner on Nov 30, 2023. It is now read-only.** とのことで、内容が古いところもありますので適宜お好みでカスタマイズしてください。

私は、 [elixir-phoenix-postgres](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/elixir-phoenix-postgres) をベースに作りました。

ここがこの記事のポイント、レゾンデートル（存在意義）です。他にもうだうだ（[ChatGPT Plus](https://openai.com/index/chatgpt-plus/)が）書いていますが、この記事からあなたが得るべき知見はここだけです。

## 5. phx_devcontainer を作りました

[elixir-phoenix-postgres](https://github.com/microsoft/vscode-dev-containers/tree/main/containers/elixir-phoenix-postgres) をベースに[phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer) を作りました。
公開しておりますのでご自由にお使いください。

~~一点解決できていない問題は、Ubuntuのnoble (24) バージョンのDockerイメージを指定するとうまく動かないことです。~~
~~そのうち気がむいたら解決したいと思っています（あくまでも思っています）。~~
**Ubuntu 24.04に対応しています。（2025年5月4日げんざ）**

## 6. phx_devcontainer を利用してPhoenixアプリケーションを開発する

[phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer) を利用して[Phoenix](https://www.phoenixframework.org/)アプリケーションを開発する手順を説明します。


### Open in a codespace

![スクリーンショット 2025-05-04 14.21.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/79aedae8-2e70-4011-aaf8-4c044fcb6991.png)


1. https://github.com/TORIFUKUKaiou/phx_devcontainer を開きます
1. Use this template > Open in a codespace

これだけです。

ブラウザ上の[Visual Studio Code](https://code.visualstudio.com/)で開発していきます。
[Docker](https://www.docker.com/ja-jp/)の存在を意識せずに、Linuxマシンでコマンドを実行しているかのような開発体験が得られます。


少し待つと、以下のように、Codespaceでの開発環境がセットアップされます。
裏で、 `docker build` が終わり、意識することもなく `docker compose up` でコンテナの立ち上げが自動でされているものと思われます。

![スクリーンショット 2024-10-25 15.32.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b120b265-6e67-b4ee-f1ea-e74a236cf816.png)


### [Phoenix](https://www.phoenixframework.org/)アプリケーションの開発

あとは、[Phoenix](https://www.phoenixframework.org/)アプリケーションを開発するだけです。
[Phoenix](https://www.phoenixframework.org/)公式の[Up and Running](https://hexdocs.pm/phoenix/up_and_running.html)に書いてあることとほぼ同じです。



```
mix phx.new --app hello --module Hello .
mix setup
```

- `--app` オプションと `--module` オプションを使うことで、プロジェクトの名前やモジュール名を自由に指定できます
- `mix phx.new`で `--app`オプションと`--module` オプションを指定しているのは、付けずに `mix phx.new .`と実行するとカレントディレクトリの `workspace` になっちゃうからです
- `mix phx.new hello` と`hello`プロジェクト（フォルダ）を作成する方法も選択肢のひとつです
    - ~~[ElixirLS: Elixir support and debugger](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)プラグインがルートに `mix.exs` が存在することを期待しているので、「Elixir LS: Project Dir」を設定してあげる必要があります~~
    - ~~設定しないと、シンタックスハイライトの色が付きません~~
    - ~~設定方法は、 [ElixirLS: Elixir support and debugger](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)プラグインの設定で、ワークスペース限定設定において「Elixir LS: Project Dir」に相対パス（例: `./hello`）を入れておけばよいでしょう~~
    - ~~正確な情報ではありませんが、設定を変えても即座に反映されないことがありましたので、一度Codespaceを停止させて、もう一度立ち上げ直すと反映されました~~
    - 2025-05-04現在特に何もせずとも、`workspace/hello`フォルダでもシンタックスハイライトが効くようになっています

![スクリーンショット 2024-10-25 15.41.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d8d010e1-d760-db44-6e47-bcdc25b9dd84.png)



ここまで準備ができたらあとは、**迷わず**Runするのみです。

```
mix phx.server
```

![スクリーンショット 2024-10-25 15.47.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c64ac5dd-6baa-d46a-7d69-cf92b0886a28.png)

右下のほうの「ブラウザーで開く」緑ボタンを **迷わず** 押しましょう！
見事に[Phoenix](https://www.phoenixframework.org/)アプリケーションが立ち上がります！！！

:::note warn
もしブラウザから接続ができない場合には、ポートタブにて4000番ポートの「表示範囲」を一度`Public`にしてすぐに`Private`に戻してから、Phoenixアプリのページをリロードしてみてください。私はこれで解消しています。
:::


![スクリーンショット 2024-10-25 15.48.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d75ea1a6-e17b-3a1e-5ff7-7072104b7a24.png)



## 7. 結論

[GitHub Codespaces](https://github.co.jp/features/codespaces)を使うことで、迅速に開発環境を整え、[Phoenix](https://www.phoenixframework.org/)アプリケーションを構築することができます。ローカル環境に依存せず、どこからでも開発を進められるこの手法は、プロジェクトの立ち上げやコラボレーションに非常に適しています。


初学者向けのハンズオンを行う際に、必ず鬼門となる環境構築の壁をなくすという使い方もできそうです。初学者はDockerのインストールで躓く場合がありますからね。[GitHub Codespaces](https://github.co.jp/features/codespaces)を利用すればもうその心配はありません。

ぜひ試してみて、[GitHub Codespaces](https://github.co.jp/features/codespaces)と[Phoenix](https://www.phoenixframework.org/)の組み合わせがどれだけ生産性を向上させるか体感してください。


**「【闘魂】とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います」とアントニオ猪木さんは言いました。**
**新しい技術を取り入れ、未知の領域へと踏み出す勇気を持って、共に次のステージへ進みましょう。**

---

このような流れでQiitaに記事を書けます。GitHub Codespacesの利便性とPhoenixの強力さを強調しながら、読者に実践的な情報を提供する構成です。
