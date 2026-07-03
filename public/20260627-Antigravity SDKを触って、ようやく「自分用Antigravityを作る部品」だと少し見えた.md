---
title: Antigravity SDKを触って、ようやく「自分用Antigravityを作る部品」だと少し見えた
tags:
  - Google
  - AI
  - Gemini
  - 闘魂
  - Antigravity
private: false
updated_at: '2026-06-28T00:31:14+09:00'
id: 7f041125bcf109c5e2c7
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 9d632f51614ebd7b333c
agreed_posting_campaign_term: true
---
## はじめに

[Antigravity SDK](https://antigravity.google/docs/sdk/overview)というものがあります。

名前からして気になります。  
Antigravity。反重力。

Pythonには昔から、こんな隠しコマンドのようなものがあります。

```python
import antigravity
```

これを実行すると、ブラウザで xkcd の有名な [Python コミック](https://xkcd.com/353/)が開きます。

[xkcd](https://xkcd.com/) は、プログラミング、数学、科学、言語、日常の皮肉などを題材にしたWebコミックです。  
技術者界隈ではかなり有名です。

`import antigravity` で開くのは、xkcd の [Python](https://xkcd.com/353/) という回です。

内容をざっくり言うと、

> Pythonを使うと、いろいろなことがあまりにも簡単にできる。  
> ついには反重力までできてしまう。

というプログラマー向けのジョークです。

いわゆるイースターエッグです。  
日本語で言うなら、隠しコマンド、隠し要素、開発者の遊び心、といったところでしょうか。

そんな名前を冠した [Google Antigravity](https://antigravity.google/docs/home)。  
さらにその SDK。

これは気になります。

しかし、正直に言うと、最初は意味がよくわかりませんでした。

「Antigravity SDK」とは何なのか。  
普通の Gemini API と何が違うのか。  
エージェントを作る SDK とは、つまり何なのか。

わからない。

わからないなら、動かすしかありません。

## SDKという言葉は知っている

SDKという言葉自体は知っています。

LINE SDKやSlack SDKなら、意味はわかります。  
APIを直接HTTPで叩く代わりに、認証やリクエスト、レスポンス処理を使いやすく包んでくれる道具です。

APIを便利に扱うための道具。  
その意味では、SDKという言葉には馴染みがあります。

しかし、Antigravity SDKは最初よくわかりませんでした。

これは何をラップしているのか。  
Gemini APIなのか。  
Antigravity 2.0のアプリなのか。  
それとも、エージェントという作業単位そのものなのか。

そこがわからなかったので、まずは動かしてみることにしました。

## global に入れたくないので uv を使う

公式の手順では、`google-antigravity` をインストールします。

ただ、私はできれば global な Python 環境を汚したくありません。

そこで今回は [uv](https://docs.astral.sh/uv/) を使って、検証用の環境を作りました。

```bash
mkdir -p ~/repos/antigravity-sdk-lab
cd ~/repos/antigravity-sdk-lab

uv init
uv add google-antigravity
```

これで、このディレクトリ専用の Python 環境ができます。

以降は `python` ではなく、基本的に `uv run python` で実行します。

## API Keyを用意する

私は、「Google AI Pro(2026/06/27現在2,900円/月)」に加入しています。
Google ドライブが5TB、[YouTube Premium Liteの特典](https://support.google.com/googleone/answer/17101453)もついています。

API Key は [Google AI Studio](https://aistudio.google.com/) から作りました。Googleにログインしている状態で、 [https://aistudio.google.com/api-keys](https://aistudio.google.com/api-keys) にアクセスして作りました。

私の環境では、いつの間にか `Default Gemini Project` という無料枠のプロジェクトができていました。

そのプロジェクトに API Key を追加し、環境変数に設定しました。

```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```

## hello_world.py を動かす

まずは公式リポジトリの [getting started](https://github.com/google-antigravity/antigravity-sdk-python/tree/main/examples/getting_started) にある [hello_world.py](https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/getting_started/hello_world.py) を動かしました。

https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/getting_started/hello_world.py

実行します。

```bash
uv run python hello_world.py
```

結果です。

```text
  User: Say 'Hello World!'
  Agent: Hello World!
```

動きました。

しかし、この時点ではまだピンと来ません。

これは確かに Agent を作って、メッセージを送って、返事を受け取っています。
しかし、挨拶だけなら普通のチャットAPIでもできます。
まだ、Antigravity SDK らしさは見えてきません。

## Quick Start を動かす

次に、公式ドキュメントの SDK overview にある Quick Start を動かしました。

https://antigravity.google/docs/sdk/overview

コードはこのようなものです。

```python
import asyncio
from google.antigravity import Agent, LocalAgentConfig

async def main():
    config = LocalAgentConfig()
    async with Agent(config) as agent:
        response = await agent.chat("What files are in the current directory?")
        print(await response.text())

if __name__ == "__main__":
    asyncio.run(main())
```

`quick_start.py` として保存して、実行します。

```bash
uv run python quick_start.py
```

結果です。

```text
The current directory `/Users/yamauchi/repos/antigravity-sdk-lab` contains the following files and directories:

### Directories
* [.git](file:///Users/yamauchi/repos/antigravity-sdk-lab/.git) - Git repository metadata
* [.venv](file:///Users/yamauchi/repos/antigravity-sdk-lab/.venv) - Python virtual environment

### Files
* [.gitignore](file:///Users/yamauchi/repos/antigravity-sdk-lab/.gitignore) (109 B) - Git ignore rules
* [.python-version](file:///Users/yamauchi/repos/antigravity-sdk-lab/.python-version) (5 B) - Python environment version config
* [README.md](file:///Users/yamauchi/repos/antigravity-sdk-lab/README.md) - Project documentation
* [hello_world.py](file:///Users/yamauchi/repos/antigravity-sdk-lab/hello_world.py) (1.7 KB) - Python script
* [main.py](file:///Users/yamauchi/repos/antigravity-sdk-lab/main.py) (97 B) - Python script
* [pyproject.toml](file:///Users/yamauchi/repos/antigravity-sdk-lab/pyproject.toml) (273 B) - Project dependencies and settings configuration
* [quick_start.py](file:///Users/yamauchi/repos/antigravity-sdk-lab/quick_start.py) (329 B) - Quick start example script
* [uv.lock](file:///Users/yamauchi/repos/antigravity-sdk-lab/uv.lock) (100 KB) - uv lockfile for Python dependencies

#### Summary of work:
I scanned the repository directory using the directory listing tool and structured the results into directories and files with direct links for easy access.
```

ここで少し見えました。

これは、単なるテキスト生成ではありません。

`What files are in the current directory?` と聞くと、Agent が実際にカレントディレクトリを見に行きます。
そして、ディレクトリとファイルを整理して返してくれます。

つまり、Antigravity SDK は、単に Gemini にプロンプトを送るためのライブラリではなさそうです。
ローカル環境とつながった Agent を、自分の Python プログラムから扱うための SDK に見えます。

## これは何を作るための部品なのか

ここでようやく、少し見えてきました。

Antigravity SDK は、極端に言えば、自分用 Antigravity を作るための部品なのだと思います。

たとえば、GUIでチャットウィンドウを作る。  
その裏側で `Agent` を起動する。  
ユーザーの入力を `agent.chat()` に渡す。  
返ってきた内容を画面に表示する。

それだけで、小さな Antigravity 風ツールになります。

もちろん、実用的なものにするには、もっと多くの設計が必要です。

- ファイル操作の権限
- 実行できるコマンドの制限
- ログ
- 承認フロー
- 安全柵
- UI
- ワークスペース管理

考えることは山ほどあります。

しかし、少なくとも入口は見えました。
やる気さえあれば、IDEのようなもの、あるいは **Antigravity X** :rocket: を作れるわけです。

## もっと実戦的なサンプルへ進みたい

ここまでで、Antigravity SDK が何のための部品なのか、少し見えてきました。

`hello_world.py` は、Agent と会話する最小例です。  
`quick_start.py` は、Agent がローカル環境を見に行けることを示す例です。

ここでわかったのは、Antigravity SDK は単なるチャットAPIのラッパーではなさそうだということです。

ローカル環境とつながった Agent を、自分の Python プログラムから扱える。  
つまり、自分用の小さな Antigravity 的なものを作る入口になりそうです。

ただし、ファイル一覧だけでは、まだ実戦感は弱いです。

本当に知りたいのは、その先です。

Agent がローカル環境を見て、判断し、必要なファイルを読み、必要なら編集し、作業を進める。  
そこまで行くと、SDKの意味がもっとはっきりしそうです。

つまり、hello world とファイル一覧で入口は見えました。  
次は、もう少し実戦的なサンプルに踏み込みます。

## Deep Dives に希望があった

公式リポジトリを見ると、 [Deep Dives](https://github.com/google-antigravity/antigravity-sdk-python/tree/main/examples/deep_dives) があります。

飛び込んでこい、と言われている気がしました。
アントニオ猪木さんが「迷わず行けよ、行けばわかるさ！」とおっしゃられているように見えました。

その中でも気になったのが、deep dives にある [doc_maintenance_agent.py](https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/deep_dives/doc_maintenance_agent.py) です。

https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/deep_dives/doc_maintenance_agent.py

これは、ドキュメント保守のエージェント例です。

ソースコードとドキュメントを見比べ、Markdownを保守するような用途に見えます。

ファイル一覧を見るだけではなく、実際にドキュメントを読んで、必要なら直す。  
ここまで行けば、Antigravity SDKの力をもう少し体験できそうです。

次回は、この `doc_maintenance_agent.py` を試してみます。

## 次回予告

今回は、Antigravity SDK の最小例を動かしました。

最初はSDKの意味がよくわかりませんでした。

`hello_world.py` は、ただの挨拶に見えました。  
`quick_start.py` でファイル一覧を見たとき、ようやく少しだけ見えました。

これは、単なるチャットAPIではありません。

ローカル環境とつながった Agent を、自分の Python プログラムに組み込むための部品です。

次回は、`doc_maintenance_agent.py` を試します。

古くなったREADMEを、ソースコードに合わせて直せるのか。  
ドキュメント保守係として、どこまで働けるのか。

次は、その火種に闘魂を注入します。

https://qiita.com/torifukukaiou/items/658d89d4d7a08b89845c
