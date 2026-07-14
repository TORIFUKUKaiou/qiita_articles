---
title: Elixir製NotebookLMクローン「Notex」をDocker (Ubuntu 24.04) で動かす＆ai& Inference検証
tags:
  - Elixir
  - AI
  - 猪木
  - 闘魂
  - ai&
private: false
updated_at: '2026-07-13T11:26:28+09:00'
id: 78314be5a6db95b13286
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: 750d1f37b7217167b1ad
agreed_posting_campaign_term: true
---
## はじめに

こんにちは！
@piacerex さんが制作された噂のNotebookLMクローンプロジェクト **「[notex](https://github.com/piacerex/notex)」** を、Docker（Ubuntu 24.04 LTSベース）環境で動かしてみました。

https://x.com/piacere_ex/status/2074144458229305685

ローカルで動かすための準備から、起動中に遭遇したちょっとしたバグ（Elixir PhoenixのLiveView関連など）の修正、そして実際にRAGや各種メディア生成（マインドマップ、スライド、動画）を試した結果まで、体験記事としてまとめます。

---

## 1. 動作環境とベースイメージの選定

READMEによると、ナレーション付き動画生成のために `open-jtalk` や `ffmpeg` などのパッケージが必要になります。
`apt-get`の例が書いてあったので、Ubuntu Noble（24.04 LTS）ベースのイメージを選択しました。

* **ベースイメージ**: [hexpm/elixir:1.20.2-erlang-29.0.3-ubuntu-noble-20260610](https://hub.docker.com/layers/hexpm/elixir/1.20.2-erlang-29.0.3-ubuntu-noble-20260610/images/sha256-b0c22256342c6d69958f1c30ba01832c7d3e72079f1e59868c4893143764b3cd)
* **対象リビジョン (Git HEAD)**: [78c18c4e21b93f6960bd10d49883c6515ffe825a](https://github.com/piacerex/notex/commit/78c18c4e21b93f6960bd10d49883c6515ffe825a) (Refine web search relevance)

---

## 2. Dockerfile の作成

必要な各種メディアライブラリ（動画用の `ffmpeg`、日本語音声合成用の `open-jtalk`、日本語フォントなど）とElixirビルドツールをDockerfile内でまとめてインストールします。

プロジェクトルートに以下の `Dockerfile` を作成しました。

```dockerfile
FROM hexpm/elixir:1.20.2-erlang-29.0.3-ubuntu-noble-20260610

# 回避：パッケージインストール時の対話プロンプト
ENV DEBIAN_FRONTEND=noninteractive

# READMEで指定されているメディア系パッケージおよびビルドツールのインストール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    ffmpeg \
    open-jtalk \
    open-jtalk-mecab-naist-jdic \
    hts-voice-nitech-jp-atr503-m001 \
    fonts-noto-cjk \
    espeak-ng \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリの設定
WORKDIR /app

# Hex と Rebar のインストール
RUN mix local.hex --force && \
    mix local.rebar --force

# ソースコードをコピーして依存関係の取得・ビルドを実行
COPY . .

RUN mix deps.get && \
    mix setup

# Phoenix のデフォルトポート
EXPOSE 4000

# サーバーの起動コマンド
CMD ["mix", "phx.server"]
```

---

## 3. 遭遇した2つのトラブルとパッチ（修正方法）

リポジトリを as-is でそのままコンテナ化して起動したところ、動かすために以下の2つのパッチ修正が必要になりました。

### ① ホストからアクセスできない問題（0.0.0.0 バインド）
* **現象**: コンテナは正常に立ち上がっているように見えるが、ホストマシンのブラウザから `http://localhost:4000` にアクセスすると `Connection reset by peer` で接続が拒否される。
* **原因**: 開発環境設定（`config/dev.exs`）でバインドアドレスがループバック（`127.0.0.1`）に固定されていたため、コンテナ外からの通信が遮断されていました。
* **修正方法**: `config/dev.exs` の12行目付近を `0.0.0.0` に変更して、どこからでもアクセスできるようにします。

```diff
-  http: [ip: {127, 0, 0, 1}],
+  http: [ip: {0, 0, 0, 0}],
```

### ② ソース追加時にLiveViewがクラッシュする問題（as: :source の指定漏れ）
* **現象**: UI上の「Add Source」からテキストソースを入力して送信すると、LiveViewプロセスがクラッシュ（`FunctionClauseError`）する。
* **原因**: 
  HTMLフォーム側は `source[title]` / `source[body]` というネストされたパラメータ名で送信する設計になっており、サーバー側も `%{"source" => source_params}` というパターンマッチで待ち受けていました。
  しかし、LiveViewのバックエンド（`lib/notex_web/live/notebook_live.ex`）でフォームデータを初期化・構築する `to_form` 呼び出し時に、パラメータをネストさせるためのオプション `:as` の指定が漏れていました。その結果、フラットなパラメータが送信されてマッチできずに落ちていました。
* **修正方法**: 
  `notebook_live.ex` 内の該当する `to_form` の呼び出し箇所（計4箇所）に、`as: :source` を明示的に指定するように修正しました。

```diff
# 例 (notebook_live.ex 32行目付近)
-      |> assign(:source_form, to_form(Notebooks.change_source()))
+      |> assign(:source_form, to_form(Notebooks.change_source(), as: :source))
```

:::note warn
この修正が正しいのかどうかは確信がありませんが、私の手元ではこれで、ソース追加ができるようになりました。
:::



---

## 4. コンテナのビルドと起動

パッチを当てた後、以下のコマンドでDockerイメージをビルドし、環境変数を指定してコンテナを起動します。

```bash
# 1. ビルド
docker build -t notex .

# 2-A. OpenAI公式 APIを使用して起動
docker run -p 4000:4000 \
  -e NOTEX_LLM_PROVIDER="openai" \
  -e OPENAI_API_KEY="your-open-ai-api-key" \
  -e NOTEX_LLM_MODEL="gpt-5.6-luna" \
  -e NOTEX_LLM_BASE_URL="https://api.openai.com/v1" \
  -e NOTEX_OPEN_JTALK_RATE="1.0" \
  -e NOTEX_VIDEO_FONTFILE="/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc" \
  -e NOTEX_LLM_REASONING_EFFORT="low" \
  notex
```

OpenAIのAPI Keyは、 https://platform.openai.com/api-keys から取得します。

---

## 5. 実際に使ってみた結果

ブラウザで `http://localhost:4000` にアクセスすると、無事にNotebookLMそっくりのモダンなUIが立ち上がりました！

### ① ソースの追加

選んだのは以下のリソースです。

https://qiita.com/torifukukaiou/items/df8b32fe6b7d1103c97a

https://note.com/awesomey/n/n6b2c8f4e2197

![スクリーンショット 2026-07-13 10.00.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/32e2a656-d3bc-4820-95b7-eb497dd16b9a.png)

![スクリーンショット 2026-07-13 10.01.03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e36f0254-ea5a-4b0c-86d5-551e0bcc4789.png)



### ② RAG（ソースに基づく回答）と引用機能
ノートに「ElixirやAIについてのテキスト」をソースとして貼り付け、「AIとは何ですか？」と質問してみました。
すると、登録したソースから正確に情報を読み込み、回答の語尾に `[1]` などの引用リンクを付けて答えてくれました。私好みの回答が得られています。

![スクリーンショット 2026-07-13 10.10.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f91e7fe9-a70a-4d31-a4b3-6d6e3cccdf2e.png)


### ③ 各種メディア（成果物）の生成
右側の「Media」パネルから、ワンクリックで多様なインフォグラフィックやレポートが作成できます。今回は以下を試しました。

* **マインドマップ**: ノートの要約構造を円と線で繋いだ図として出力してくれます。
* **スライド**: 内容を要約した説明スライドが自動作成されます。
* **動画**: 
  OpenAIには台本（テキスト）を作らせ、**コンテナ内の `open-jtalk` で日本語ナレーションを生成し、`ffmpeg` で字幕（`fonts-noto-cjk`）と合成してスライド解説動画（MP4）をローカルで完全生成**してくれます。

![スクリーンショット 2026-07-13 10.11.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8ea91f2e-ae31-464b-9715-c26839813abd.png)


![スクリーンショット 2026-07-13 10.11.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a7b781f2-1a7c-4917-8859-87aac1748c42.png)

![スクリーンショット 2026-07-13 10.13.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7742ba4e-ad3f-4bc5-9e76-76406bd46e28.png)


### ④ ai& Inference (`deepseek-ai/deepseek-v4-flash`) での動作検証

国内のAIモデル推論プラットフォームである **ai& Inference** 経由でも動作を確認しました。

* **動作ステータス**: RAG（チャット）機能の生成は動作しました。一方、今回のコンテナ環境およびAPI仕様の違いからか、動画（Video）の生成処理はエラーとなり動きませんでした（今回は深追いしていません）。
* **もっと性能のよいモデルでの検証**: 『[GPT5.5 相当の GLM5.2 (ai& Inference提供) を GitHub Copilot で動かしてみた $50=8000円分使えますよ！](https://qiita.com/baku2san/items/97212e7b525ae448f54e)』を参考に、8,000円分のクレジットをいただいています。GPTと相性がよいような気がなんとなくするので、「openai/gpt-oss-120b」を試してみたいと思っています。あくまでも思っています。

以下、ai& Inference のAPIを使用する場合の起動例です。

```
docker run -p 4000:4000 \
  -e NOTEX_LLM_PROVIDER="openai" \
  -e OPENAI_API_KEY="your-ai&-api-key" \
  -e NOTEX_LLM_MODEL="deepseek-ai/deepseek-v4-flash" \
  -e NOTEX_LLM_BASE_URL="https://api.aiand.com/v1" \
  -e NOTEX_OPEN_JTALK_RATE="1.0" \
  -e NOTEX_VIDEO_FONTFILE="/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc" \
  -e NOTEX_LLM_REASONING_EFFORT="low" \
  notex
```

:::note info
NOTEX_LLM_PROVIDER の指定について

Notexの内部実装では、環境変数 NOTEX_LLM_PROVIDER に指定された文字列（"openai" / "codex_app_server"）によって、どの通信モジュールをロードするかを分岐しています。

ai& InferenceなどのOpenAI互換APIサービスを利用する場合、内部でHTTP通信用のクライアント（Notex.LLM.OpenAI）をロードさせる必要があるため、プロバイダー名には "openai" を指定する必要があります。
:::

---

## まとめ

ローカルで動作する、Elixir Phoenix製NotebookLMクローン「Notex」の体験レポートでした。

Elixir（Phoenix LiveView）で書かれているためUIのレスポンスが非常に高速で、コンテナ内のローカルツール（ffmpeg / open-jtalk）をフル活用した動画生成のアーキテクチャなどは、非常に開発の参考になります。

動かす際は一部のバグ（！？）修正や、環境によっては `0.0.0.0` バインドの設定が必要になるため、この記事のパッチを参考に試してみてください！

ai& Inference については、『[OpenAI APIからai& InferenceのOpenAI互換APIへ載せ替えたら、ほぼbaseURL変更だけで動いた話](https://qiita.com/torifukukaiou/items/4041ef2b82f096398ce5)』の記事でも書いた通り、baseURL変更だけで動きます！

---

## 編集後記

`NewPJ` (新プロジェクト) ということだと思いますが、私には、New Japanつまり、新日本にしか見えませんでした。
