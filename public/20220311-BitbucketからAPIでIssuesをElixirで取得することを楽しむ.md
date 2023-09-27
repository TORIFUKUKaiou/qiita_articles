---
title: BitbucketからAPIでIssuesをElixirで取得することを楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-12T15:23:58+09:00'
id: 6558d211a80f7174f85a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**立ち別れいなばの山の峰に生ふるまつとし聞かばいざ帰り来む**


---

Advent Calendar 2022 65日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今日は[Bitbucket](https://bitbucket.org/)からAPIでIssuesを取得してみます。

# What's [Bitbucket](https://bitbucket.org/)?

> Bitbucket は、単なる Git コード管理ツールではありません。Bitbucket を使用すれば、プロジェクトの計画、コラボレーションによるコード開発、テスト、デプロイをすべて 1 つの場所で行うことができます。

https://www.atlassian.com/ja/software/bitbucket

コンペティターは、[GitHub](https://github.com/)、[GitLab](https://gitlab.com/explore)です。

# API仕様書

https://developer.atlassian.com/cloud/bitbucket/rest/intro/

上記に書いてあります。

まず`access_token`を得ます。

```
curl -X POST -u "client_id:secret" \
  https://bitbucket.org/site/oauth2/access_token \
  -d grant_type=client_credentials
```

得た`access_token`を指定して下記の具合です。

```
curl --request GET \
  --url 'https://api.bitbucket.org/2.0/repositories/{workspace}/{repo_slug}/issues' \
  --header 'Authorization: Bearer <access_token>' \
  --header 'Accept: application/json'
```

# `client_id:secret` って何だ？

`https://bitbucket.org/<username>/workspace/settings/api`
に、「コンシューマーキーを追加」という青のボタンがあるのでそこから設定します。

以下のように設定してください。

![スクリーンショット 2022-03-10 9.42.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a4823002-74b7-1f4b-43d4-c65adafa7be9.png)

## 設定のポイント

設定のポイントを説明します。

- `Name`は適当に決めてください
- コールバックURLは今回は使用しませんが、適当に `http://localhost:9999` とでも入力しておいてください
- `This is a private consumer`にチェックを入れてください
- 権限で、`課題`の`読み取り`をチェックしています
    - 権限はご所望の権限を要求してください

## `client_id:secret`

設定をしたあと、 `https://bitbucket.org/<username>/workspace/settings/api` に`OAuthコンシューマ`の一覧があります。
`>`で開いたあと、表示される値を使います。

- 鍵が`client_id`です
- シークレットが`secret`です

![スクリーンショット 2018-05-26 20.19.4523.png](https://qiita-image-store.s3.amazonaws.com/0/69645/2c914fab-5560-22fe-6a8c-49da4166f86f.png)


https://qiita.com/ukiuki-satoshi/items/90e7ee2e33ca8b530bd6

の記事がとても参考になります。
ありがとうございます！

---

# 実行

`client_id:secret`が何のことかさえわかればあとは簡単です。
`curl`と[Elixir](https://elixir-lang.org/)で課題の一覧を取得してみます。

## curl

curlは既出の通りです。

```
curl -X POST -u "client_id:secret" \
  https://bitbucket.org/site/oauth2/access_token \
  -d grant_type=client_credentials
```

得た`access_token`を指定して下記の具合です。

```
curl --request GET \
  --url 'https://api.bitbucket.org/2.0/repositories/{workspace}/{repo_slug}/issues' \
  --header 'Authorization: Bearer <access_token>' \
  --header 'Accept: application/json'
```


## [Elixir](https://elixir-lang.org/)

次に、[Elixir](https://elixir-lang.org/)で課題の一覧取得を楽しみます。
以下3つのパートに分けて書いていますが、実際は`issues.exs`という1ファイルに書いています。
区切りのいいところで区切って、解説を加えます。

まず、[Mix.install/2](https://hexdocs.pm/mix/Mix.html#install/2)で必要なライブラリ（Hexと呼ばれます）をインストールしています。
ここでは4つのライブラリをインストールしています。

- [HTTPoison](https://hex.pm/packages/httpoison)
- [Jason](https://hex.pm/packages/jason)
- [Req](https://hex.pm/packages/req)
- [NimbleCSV](https://hex.pm/packages/nimble_csv)

### アクセストークンの取得

まずはアクセストークンを取得します。
公式ドキュメントは、「[3. Client Credentials Grant (4.4)](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#3--client-credentials-grant--4-4-)」が該当します。

```elixir:issues.exs
Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.3"},
  {:req, "~> 0.2.1"},
  {:nimble_csv, "~> 1.2"}
])

client_id = "鍵"
secret = "シークレット"
workspace = "<workspace>"
repo_slug = "<repo_slug>"

{:ok, %{body: body, status_code: 200}} =
  HTTPoison.post(
    "https://bitbucket.org/site/oauth2/access_token",
    {:form, [grant_type: "client_credentials"]},
    [],
    hackney: [basic_auth: {client_id, secret}]
  )
  |> IO.inspect()

access_token = Jason.decode!(body) |> Map.get("access_token")
```

どうして、[HTTPoison](https://hex.pm/packages/httpoison)と[Req](https://hex.pm/packages/req)と2つの異なるHTTP Clientをインストールしているの？　とおもったあなたは鋭いです。
本来ひとつでいいはずです。
私は、[Req](https://hex.pm/packages/req)を推したいです。
ただ、[Req](https://hex.pm/packages/req)の場合、ベーシック認証の書き方がわかりませんでした。
ググり力が足りませんでした。
[HTTPoison](https://hex.pm/packages/httpoison)の場合は、上記の感じでできたので、まあいいかということにしました。
[Req](https://hex.pm/packages/req)での書き方がわかれば更新したいとおもいますし、読者の方でご存知の方はぜひコメントなり編集リクエストなりをいただけるとありがたいです。

#### 2022-03-12 追記

[Req](https://hex.pm/packages/req)でのベーシック認証の書き方がわかりました。

```elixir:issues.exs
%{body: body, status: 200} =
  Req.post!(
    "https://bitbucket.org/site/oauth2/access_token",
    {:form, [grant_type: "client_credentials"]},
    auth: {client_id, secret}
  )

access_token = Map.get(body, "access_token")
```

ドキュメントは、[ココ](https://hexdocs.pm/req/Req.html#auth/2)です。

https://hexdocs.pm/req/Req.html#auth/2


### [List issues](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-issue-tracker/#api-repositories-workspace-repo-slug-issues-get) APIの呼び出し

アクセストークンが取得できたらもう勝負は決まったも同然です。
取得したアクセストークンを利用して、[List issues](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-issue-tracker/#api-repositories-workspace-repo-slug-issues-get) APIを呼び出してIssuesを取得します。
少し解説をします。
Issueが一体何ページ分あるかわからないので、[Stream.iterate/2](https://hexdocs.pm/elixir/Stream.html#iterate/2)で[Stream](https://hexdocs.pm/elixir/Stream.html#content)を作っています。

> Streams are composable, lazy enumerables

どこかで終わらせないといけないのですが、幸い返戻JSONの中に`next`というキーで次のページのURLが書いてあります。
`next`がある間は処理を続け、`next`がなくなれば処理を終えればよいのです。
さらに[List issues](https://developer.atlassian.com/cloud/bitbucket/rest/api-group-issue-tracker/#api-repositories-workspace-repo-slug-issues-get) APIコールで得た結果は溜め込んでいきたいはずです。
そんなときに便利なのが、[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)です。


```elixir:issues.exs
headers = [
  "Content-type": "application/json",
  Accept: "application/json",
  Authorization: "Bearer #{access_token}"
]

list =
  Stream.iterate(1, &(&1 + 1))
  |> Enum.reduce_while([], fn page, acc ->
    IO.puts(page)

    %{body: %{"values" => values} = body, status: 200} =
      Req.get!(
        "https://api.bitbucket.org/2.0/repositories/#{workspace}/#{repo_slug}/issues?page=#{page}",
        headers: headers,
        finch_options: [pool_timeout: 50000, receive_timeout: 50000]
      )

    {if(Map.get(body, "next"), do: :cont, else: :halt), acc ++ values}
  end)
  |> IO.inspect()
```

上記コードのポイントは、[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)です。
まずそもそも[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を知らない方は、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を理解するようにしてください。
[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールの最後の難関と言っても過言ではありません。
あせらずじっくりと理解を進めてください。
たとえば、@kuroda@github さんの「[Elixir実践ガイド](https://book.impress.co.jp/books/1120101021):book:」では、まるまる一章をつかって、[Enum.reduce/2](https://hexdocs.pm/elixir/Enum.html#reduce/2)、[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)、[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)の解説がされています。
[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を理解していれば、[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)の理解は容易です。
[Enum.reduce_while/3](https://hexdocs.pm/elixir/Enum.html#reduce_while/3)は、途中でループを脱出することができます。
第3引数の関数の結果で、タプルの先頭を `:cont` にすると処理を継続し、 `:halt` にするとそこでループを中断します。

### 整形、ソート、csv出力

あとは、個々のIssueを整形したり、並び替えたりしてcsvファイルに出力しています。
ここはいろいろと好みが分かれるところだとおもいますし、あくまでも私はこんな感じで実装しましたという程度のご紹介のみとさせてください。


```elixir:issues.exs
NimbleCSV.define(MyParser, [])

nickname = fn
  nil -> nil
  %{"nickname" => nickname} -> nickname
end

date = fn
  nil -> nil
  %{"name" => name} -> name
end

mapper = fn %{
              "state" => state,
              "title" => title,
              "assignee" => assignee,
              "milestone" => milestone,
              "priority" => priority,
              "id" => id
            } ->
  milestone = if milestone == nil, do: "3333-33-33", else: milestone
  assignee = if assignee == nil, do: "あ", else: assignee

  [milestone, priority, assignee, id, state, title]
end

list
|> Enum.map(fn %{
                 "state" => state,
                 "title" => title,
                 "assignee" => assignee,
                 "milestone" => milestone,
                 "priority" => priority,
                 "id" => id,
                 "links" => %{
                   "html" => %{
                     "href" => url
                   }
                 }
               } ->
  %{
    "state" => state,
    "title" => title,
    "assignee" => nickname.(assignee),
    "milestone" => date.(milestone),
    "priority" => priority,
    "id" => id,
    "url" => url
  }
end)
|> Enum.filter(fn %{"state" => state} ->
  state == "new" or state == "on hold" or state == "wontfix"
end)
|> Enum.sort_by(fn map -> mapper.(map) end)
|> Enum.map(fn %{
                 "state" => state,
                 "title" => title,
                 "assignee" => assignee,
                 "milestone" => milestone,
                 "priority" => priority,
                 "id" => id,
                 "url" => url
               } ->
  [
    id,
    priority,
    title,
    assignee,
    milestone,
    url
  ]
end)
|> MyParser.dump_to_iodata()
|> IO.iodata_to_binary()
|> then(
  &File.write!(
    "output-#{DateTime.utc_now() |> DateTime.to_string() |> String.replace(" ", "_") |> String.replace(":", "") |> String.replace(".", "_")}.csv",
    &1
  )
)
```

ポイントをお伝えすると、[Enum.sort_by/3](https://hexdocs.pm/elixir/Enum.html#sort_by/3)で、複数の列的な要素で並び替えを簡単に実装できることを特筆しておきます。
詳しくは下記の記事をご参照ください。

https://qiita.com/torifukukaiou/items/009fc0559c70e5e69ca7



---

# トラブル

この記事で一番有用な部分かもしれないとおもっています。
ここに書いてあるエラーメッセージで、この記事にたどり着く方が大半だとおもいます。
私の予言があたっておりましたら、ぜひコメント欄に足跡 :footprints: を残してください。
励みになりますし、私はちょっぴりハゲています。

## Your credentials lack one or more required privilege scopes.

```json
{"type": "error", "error": {"message": "Your credentials lack one or more required privilege scopes.", "detail": {"granted": ["repository"], "required": ["issue"]}}}
```

おそらくですが、`client_id:secret` にユーザIDとパスワードを指定していませんか。
そうじゃないのです。
上記のエラーがでた場合、 「コンシューマーキーを追加」を行ってください。
何のことを言っているのか？　については、この記事の[前の方](https://qiita.com/torifukukaiou/items/6558d211a80f7174f85a#client_idsecret-%E3%81%A3%E3%81%A6%E4%BD%95%E3%81%A0)を読んでください。
お願いします :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

## Calls for auto generated consumers should use urn:bitbucket:oauth2:jwt instead.

```json
{"error_description": "Cannot use client_credentials with a consumer marked as \"public\". Calls for auto generated consumers should use urn:bitbucket:oauth2:jwt instead.", "error": "invalid_grant"}
```

というエラーがでた場合、 `This is a private consumer`にチェックを入れてください。
何のことを言っているのか？　については、この記事の[前の方](https://qiita.com/torifukukaiou/items/6558d211a80f7174f85a#client_idsecret-%E3%81%A3%E3%81%A6%E4%BD%95%E3%81%A0)を読んでください。
お願いします :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

## No callback uri defined for the OAuth client.

```json
{"error_description": "No callback uri defined for the OAuth client.", "error": "invalid_request"}
```

というエラーがでた場合、 コールバックURLに `http://localhost:9999` とでも適当な値を入力しておいてください
何のことを言っているのか？　については、この記事の[前の方](https://qiita.com/torifukukaiou/items/6558d211a80f7174f85a#client_idsecret-%E3%81%A3%E3%81%A6%E4%BD%95%E3%81%A0)を読んでください。
お願いします :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

---
# 参考

とても参考になりました。
この場をお借りして御礼申し上げます。

- [REST APIs](https://developer.atlassian.com/cloud/bitbucket/rest/intro/#authentication)
- [Bitbucket Build Status Notifier - Cannot Extract Access Token](https://stackoverflow.com/questions/64584797/bitbucket-build-status-notifier-cannot-extract-access-token)
- [BitbucketのOAuthでリポジトリクローンする](https://qiita.com/ukiuki-satoshi/items/90e7ee2e33ca8b530bd6)



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

本日は[Bitbucket](https://bitbucket.org/)からAPIでIssuesを取得してみました。
みなさまのお役に立てれば幸いです。

:lgtm: やコメントは、励みになりますし、私はちょっぴりハゲています。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



以上です。





