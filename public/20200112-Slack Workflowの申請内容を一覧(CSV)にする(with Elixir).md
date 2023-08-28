---
title: Slack Workflowの申請内容を一覧(CSV)にする(with Elixir)
tags:
  - Elixir
  - Slack
private: false
updated_at: '2020-01-16T13:13:28+09:00'
id: 9db04591477de8c4cc11
organization_url_name: fukuokaex
slide: false
---
# はじめに
- Slackの[ワークフロービルダー](https://slack.com/intl/ja-jp/features/workflow-automation)使っていますか！
- 申請内容を一覧化してみました！
- [conversations.history](https://api.slack.com/methods/conversations.history) APIを使わせていただいて、メッセージの内容をパースして、CSVに保存します
- 使用した言語は、もちろん[Elixir](https://elixir-lang.org/)です

<img width="1055" alt="スクリーンショット 2020-01-12 1.36.59.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1c7b46ca-871d-fbeb-1a3d-1564b92ec469.png">

```
% uname -a
Darwin 20-02noMacBook-Pro.local 19.2.0 Darwin Kernel Version 19.2.0: Sat Nov  9 03:47:04 PST 2019; root:xnu-6153.61.1~20/RELEASE_X86_64 x86_64
% elixir -v
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.9.4 (compiled with Erlang/OTP 22)
```

# なぜ一覧化するの？
- そもそもなぜ一覧化が必要なのでしょうか
- 私が所属している会社では、有給休暇の申請はSlackのワークフローで行うことになっています
    - 他の各種申請(経費精算、始業時間変更等)もとにかく申請が必要だったものはあるときから、すべてSlackに移行しています
- 各人の有給休暇の取得日数を集計したりする管理部門の人は一覧で欲しかったりするのではないでしょうか
    - 他の良い方法はたくさんあるかもしれません
- あれ？　あの人、今日いないなあ、休みだっけ？　とワークフローのチャネルをスクロールするのが面倒だったりしませんか？
    - カレンダー共有するとかモダンなやりかたがあるかもしれません
- 詰まるところ、私が古臭い人間だから一覧が欲しいのです:man_tone1:
- 私は「承認」ボタンを押したあと、スプレッドシートに**手動でコピペ**していました
    - 最初のうちはそれでもよかったのですが、２ヶ月くらいそうやって続けてきてだんだん面倒になってきました
- 一覧は、[Phoenix](https://www.phoenixframework.org/)で！ とおもわないわけではなかったのですが、まだ[Phoenix](https://www.phoenixframework.org/)は修行中なので、まずは肝の部分をCSVに書き込むことをやってみました




# ソースコード
- [TORIFUKUKaiou/slack_workflow](https://github.com/TORIFUKUKaiou/slack_workflow)
- ワークフローは多種多様だとおもうので、私が所属しているワークスペースのチャネルの申請内容はギリギリ、パースできている気がしますが、みなさまのところのチャネルで同じようにうまく動くかどうかはわかりません
    - 私が所属しているワークスペースでも、まあそれなりにというところくらいなので、みなさまのところでは**そのままでは動かない可能性は大**です
- 以下、一覧化したいあなたに向けて、ポイントになりそうなところを説明します
- なにはともあれ[Elixir](https://elixir-lang.org/)をインストールしましょう！
    - [Installing Elixir](https://elixir-lang.org/install.html)
    - Windowsの方は上記ページからインストーラをダウンロードできます
    - macOSの方は[asdf-vm](https://asdf-vm.com/#/)でインストールするのがオススメですが、手軽に始めるなら[Homebrew](https://brew.sh/index_ja)でインストールするでもいいかもしれません
        - 上のページは[Homebrew](https://brew.sh/index_ja)でのインストール方法が最初に書いてありますし

# SlackWorkflow.Applications.run/3

```Elixir:lib/slack_workflow/slack_applications.ex
defmodule SlackWorkflow.Applications do
  def run(channel, oldest, latest) do
    members = fetch_members()

    channel_id = fetch_channels() |> Map.fetch!(channel)

    SlackWorkflow.SlackConversationsHistory.fetch(channel_id, oldest, latest)
    |> Enum.filter(&Map.get(&1, "blocks"))
    |> Enum.map(&{Map.get(&1, "blocks"), Map.get(&1, "ts"), Map.get(&1, "username")})
    |> Enum.map(fn {blocks, ts, name} -> {Enum.at(blocks, 0), ts, name} end)
    |> Enum.filter(fn {blocks, _, _} -> Map.get(blocks, "text") end)
    |> Enum.map(fn {blocks, ts, name} -> {Map.get(blocks, "text"), ts, name} end)
    |> Enum.filter(fn {text_map, _, _} -> Map.get(text_map, "type") == "mrkdwn" end)
    |> Enum.map(fn {text_map, ts, name} -> {Map.get(text_map, "text"), ts, name} end)
    |> Enum.map(fn {text, ts, name} -> {parse(text, members), ts, name} end)
    |> Enum.map(fn {keywords, ts, name} ->
      {Keyword.put(keywords, :created_at, date(ts)), ts, name}
    end)
    |> Enum.map(fn {keywords, ts, name} ->
      {Keyword.merge(keywords, [{"url" |> String.to_atom(), url(ts, channel_id)}]), name}
    end)
    |> Enum.reduce(%{}, fn {keywords, name}, acc_map ->
      list = acc_map |> Map.get(name, [])
      acc_map |> Map.merge(%{name => [keywords] ++ list})
    end)
  end
```
- `Applications`は申請たちの意味です
- [conversations.history](https://api.slack.com/methods/conversations.history) APIを呼び出した結果、`blocks`というキーをもつメッセージだけが、**私の所属しているワークスペースのチャネルでは申請内容を表しているようにみえました**
    - 最初にこれで絞りこんでいるので、もうこの時点でうちは違うよの場合は、書き換えが必要です
    - `iex -S mix` して `SlackWorkflow.SlackConversationsHistory.fetch(channel_id, oldest, latest)` を呼び出してください
    - きれいな形でJSONがみえるのであなたが所属しているワークスペースでの申請内容の傾向をつかんでください
- SlackへのリンクURLを作りたくて、`ts`キーの値をとってなんとなくURLをつくっていますが正しいのかどうかわかっていません

# SlackWorkflow.Applications.parse/2
```Elixir:lib/slack_workflow/slack_conversations_history.ex
  defp parse(s, members) do
    first = s |> String.split("\n") |> Enum.find_index(&(&1 =~ ~r/\*.+\*/))

    second =
      s
      |> String.split("\n")
      |> Enum.slice((first + 1)..-1)
      |> Enum.find_index(&(&1 =~ ~r/\*.+\*/))
      |> Kernel.+(first)
      |> Kernel.+(1)

    index = if second - first > 1, do: first, else: second

    s
    |> String.split("\n")
    |> Enum.slice(index..-1)
    |> Enum.reject(&(&1 == "&gt;"))
    |> Enum.reject(&(&1 == ""))
    |> Enum.chunk_every(2)
    |> Enum.filter(&(length(&1) == 2))
    |> Enum.reduce(Keyword.new(), fn [k, v], keywords ->
      keywords
      |> Keyword.merge([{k |> key(), v |> value(members)}])
    end)
  end
```
- 一番の難関はここでしょう
- **私の所属しているワークスペースのチャネルでは申請内容**では、いろいろ試行錯誤して、いまのところ実行時エラーは起きないくらいの実装内容となっております
    - 出力結果に、Slackへのリンクが含まれているから、一覧としては、まあいっかなあくらいの感じです
- `*申請内容*` のように`*`で囲まれている文字列が含まれているところがキーでその次にくるやつが値だろうという実装をしています
    - ここもみなさまのワークフローメッセージとは違いがある可能性が高いところだとおもいます
- 申請内容文字列を改行でsplitしたListのここから先が申請内容キーの始まりですよというものを`index`にいれているつもりです
    - `first`とか`second`とか書いているのは私の所属しているワークスペースでは次の２種類があったためです
    - これがみなさまに伝わるのは自分でも疑わしくおもっています
    - とにかく一筋縄ではいかないことをお伝えしておきます

```
:information_source: *申請内容*
&gt;  :neutral_face: *申請者* ← ここからキーとして解析したい
&gt; <@UC1234567>\n&gt; ← 申請者の値
&gt; :date: *日付* ← 日付キー
&gt; 2020/01/07 ← 日付の値
...
```

```
&gt; *申請者*  ← ここからキーとして解析したい
&gt; <@UC1234567>\n&gt; ← 申請者の値
&gt; *経費精算フォーム* ← 経費精算フォーム キー
&gt; <https://drive.google.com/open?id=hogehogehoge> ← 経費精算フォームの値
```

# 動かし方
- なにはともあれ動かしてみたい方向けに説明をします
- まずは[Elixir](https://elixir-lang.org/)を[インストール](https://elixir-lang.org/install.html)してください

## ソースコード取得と依存関係の解決
```
% git clone https://github.com/TORIFUKUKaiou/slack_workflow.git
% cd slack_workflow
% mix deps.get
```

## Slack APIのtokenを取得して環境変数SLACK_TOKENに設定
- `channels:history`、`channels:read`、`users:read`のScopesをもったトークンを取得してください
- Slackアプリの作成方法は下記の記事がとても参考になるとおもいます！
    - [Slack API 推奨Tokenについて](https://qiita.com/ykhirao/items/3b19ee6a1458cfb4ba21)
<img width="687" alt="スクリーンショット 2020-01-11 23.44.42.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6896ab6f-47d9-7f49-392f-60344c3badab.png">
- このトークンを環境変数`SLACK_TOKEN`に設定してください

## Team domainを環境変数SLACK_TEAM_DOMAINに設定
- たとえば、あなたが所属しているワークスペースが`elixir.slack.com`だったら、`elixir`を`SLACK_TEAM_DOMAIN`に設定してください

### iex 編

```Elixir
% iex -S mix
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.9.4) - press Ctrl+C to exit (type h() ENTER for help)
iex> channel = "workflow"
"workflow"
iex> oldest = 0
0
iex> latest = Timex.now |> Timex.local |> Timex.end_of_day  |> DateTime.to_unix
1578754799
iex> SlackWorkflow.create_csvs(channel, oldest, latest)
:ok
```
- `channel`はワークフローがながれているチャネル名
- `oldest`と`latest`はunix timeで指定します
- `oldest`が0のときは、一番最初のメッセージから取得します
- `oldest` 〜 `latest`の期間を指定して習得することができます

### escript編
- 単純に、`mix escript.build`してできたバイナリでは動きません
- [timex](https://hex.pm/packages/timex)が依存している[tzdata](https://hex.pm/packages/tzdata)に`.ets`ファイルというものの場所を設定してあげる必要があります
    - 参照: [Crash on startup #48](https://github.com/lau/tzdata/issues/48)

```Elixir
% iex
iex> Tzdata.Util.data_dir
"/Users/torifukukaiou/slack_workflow/_build/dev/lib/tzdata/priv"
```
- なんてのがでますから、これを`config/config.exs`に設定してください

```Elixir:config/config.exs
config :tzdata,
  data_dir: "/Users/torifukukaiou/slack_workflow/_build/dev/lib/tzdata/priv",
  autoupdate: :disabled
```

- この設定をしたあとに

```
% mix escript.build
```

- してください
- `slack_workflow` というバイナリができてるはずです

```
% ./slack_workflow --channel workflow --oldest 0 --latest 1578754799
```
- てな感じでコマンドで動かせるはずです

# さいごに
- この構想を同僚に話したところ、パースが面倒だから、どうせやるならSlackアプリとしてつくる(※ここの部分が私の知識不足であまりぴんときていません)とか他のことを考えたほうがいいですよと言われました
- おもいついてしまったものはなかなか止められません
- こういうのキライじゃないし、やるだけやってみようとおもいました
- たしかに面倒くさい部分はありましたが、[Elixir](https://elixir-lang.org/)を使ってパースの処理を書いているとだんだんと**楽しくなってきました**
    - 作っているときは`iex`でちょっとずつ試しながら試行錯誤を繰り返しました
- そう！ **[Elixir](https://elixir-lang.org/)は楽しいのです！**
- **Enjoy! with [Elixir](https://elixir-lang.org/).**



