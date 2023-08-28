---
title: ここがヘンだよ GET /api/v2/items |> 解決!!! (Elixir)
tags:
  - QiitaAPI
  - Elixir
  - Nerves
private: false
updated_at: '2020-12-22T12:15:30+09:00'
id: 6ea18016983cd66bdebd
organization_url_name: fukuokaex
slide: false
---
# 2020/12/22(火) 12:12 追記
- <font color="purple">$\huge{解決しました🎉🎉🎉}$</font>
    - 私はなにもソースコードは変えていません
    - とにかく解決してよかったです
- [【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd) に、「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」がでないのです」は載りました
- @piacerex さんと @tamanugi さんからの解析コメントありがとうございます！

---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang:
- $\huge{2020/12/21現在の記事です}$
- 事件: 「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」がでないのです :bangbang::bangbang::bangbang:
- えっ？　何のこと？
- 私が記事を自動更新している「[【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)」の記事に、「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」が載らないのですよ
    - 自動更新には[Nerves](https://www.nerves-project.org/)を使っています
    - 令和2年なのにいまだにRaspberry Pi 2ががんばっています!!!
- いつも[Qiita](https://qiita.com/)様にはお世話になっております
    - <font color="purple">$\huge{ありがとうございます!!!}$</font>
- [GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)でピンポイントでおかしいなあ、不思議だなあと私が思ったことを書きます
- 私のプログラムに不具合があるのじゃないの？
    - 否定はできませんが私の調査結果をお示ししたいとおもいます
- 「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」に[Elixir tag](https://qiita.com/tags/elixir)はちゃんとついているのですよね〜

![スクリーンショット 2020-12-21 21.18.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f78698d1-1504-5119-421b-741db052b126.png)


# HTTP GET https://qiita.com/api/v2/items?query=tag%3AElixir+OR+tag%3ANerves+OR+tag%3APhoenix&per_page=100&page=1
- 記事が該当する`page`番号はこれからどんどん増えていくことが考えられますが、
- $\huge{2020/12/21現在の記事です}$
- 2020/12/21時点では`page=1`です

## API仕様
- [GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)
- **記事の一覧を作成日時の降順で返します**
- 詳細はご参照ください

### [GET /api/v2/items/:item_id](https://qiita.com/api/v2/docs#get-apiv2itemsitem_id)
- を使って[GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)で取れないのだよなーという記事の詳細情報を取得しておきます

```elixir
iex> (HTTPoison.get!("https://qiita.com/api/v2/items/f6bb83ef45ea0e4ba98d")  
...> |> Map.get(:body)
...> |> Jason.decode!()
...> )
%{
  "body" => "この記事は [Elixir Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir) 17日目の記事です\n\n昨日は @koga1020 さんで[「Refactoring a Function in Elixir」のblog postを読んでみよう](https://zenn.dev/koga1020/articles/d1ac2beab15132)でした！\n\n\n------\n\n9月に参加した [Elixir Digitalization Implementors #1](https://fukuokaex.connpass.com/event/188564/) にて、Elixirで[AtCoder](https://atcoder.jp)に参加できるということを教えていただきました :sparkles: \n\n今まで会社にも競技プログラミングやっている人たちがいて、面白いらしいということを聞いてはいたのですが、新しい言語勉強するのもなーって思い、参加していませんでした。。。\n(去年に試しに一回だけコンテストやってみましたが、それっきりでした)\n\n\nただElixirで参加できるのなら、仕事でElixir書く機会もないし、やってみるかと思い改めて参加してみたところ、ドハマリし、現在 緑レート目指して精進中です :muscle: \n\nコンテストに参加していると、コードをテンプレートコードのコピペや実行などが面倒だと思ったので、mixタスクを書いてみました。\n\n## 作成したもの\n\n`ex_at_coder` という名前で公開しております :sparkles: \n\n**hex**\nhttps://hex.pm/packages/ex_at_coder\n\n**Github**\n<a href=\"https://github.com/tamanugi/ex_at_coder\"><img src=\"https://github-link-card.s3.ap-northeast-1.amazonaws.com/tamanugi/ex_at_coder.png\" width=\"460px\"></a>\n\n## 簡単な機能紹介\n\n今のところは以下の機能があります\n\n- ログイン\n- 提出用テンプレート作成\n- 提出用コードの実行テスト\n\n### インストール\n\nhexに登録してあるので、以下を`mix.exs`に記述した上で`mix deps.get`でインストールすることができます。\n\n```elixir:mix.exs\n{:ex_at_coder, \">0.0.0\"}\n``` \n\n### ログイン\n\n```\n$ mix atcoder.login [username] [password]\n```\n\n指定された`username` `password`でAtCoderにログインします。\n\n終了しているコンテストなどはログインしなくても閲覧できますが、開催中の場合はログインが必須になります。\nログインに成功した場合は、現在のディレクトリに`cookie.txt`が作成されます。\n\ncookieをまるごとテキストファイルで保存しちゃっているのがあんまりよくない気がしますが、とりあえずこうしちゃっています :innocent: \n\n\n### 提出用コードの作成\n\n```\n$ mix atcoder.new [contest]\n```\n\n上記コマンドで指定したコンテスト用の提出ファイルの雛形とテストケースの作成を行います。\n例えば AtCoder Regular Contest 109( https://atcoder.jp/contests/arc109 )でしたら\n`arc109` と指定します\n\n```\n$ mix atcoder.new arc109\nGenerated ex_at_coder app\n* creating lib/arc109\n* creating lib/arc109/a.ex\n* creating lib/arc109/test_case\n* creating lib/arc109/test_case/a.yml\n* creating lib/arc109/b.ex\n* creating lib/arc109/test_case/b.yml\n* creating lib/arc109/c.ex\n* creating lib/arc109/test_case/c.yml\n* creating lib/arc109/d.ex\n* creating lib/arc109/test_case/d.yml\n* creating lib/arc109/e.ex\n* creating lib/arc109/test_case/e.yml\n* creating lib/arc109/f.ex\n* creating lib/arc109/test_case/f.yml\n✨ Generate code for arc109\n👍 Good Luck\n```\n\nコマンドを実行すると、提出用コードと実行テスト用のテストケースのyamlファイルを出力します。\n\n\n問題は`https://atcoder.jp/contests/[contest]/tasks`のページから取得します。\n提出ファイルの雛形に用いるテンプレートのEEXは以下の形で`config.exs`で指定することができます。\n\n```elixir\nconfig :ex_at_coder,\n  template_path: \"lib/template.eex\"\n```\n\n```elixir\ndefmodule <%= @namespace %>.Main do\n    def read_single() do\n    IO.read(:line) |> String.trim() |> String.to_integer()\n  end\n\n  def read_array() do\n    IO.read(:line) |> String.trim() |> String.split(\" \") |> Enum.map(&String.to_integer/1)\n  end\n\n  def main() do\n    n = \n      IO.read(:line)\n      |> String.trim()\n      |> String.to_integer()\n   \n    IO.puts(n)\n  end\nend\n```\n\n### 提出用コードの実行テスト\n\n```\n$ mix atcoder.test [contest] [problem]\n```\n\n指定したコンテスト、問題のテストケースを実行します。\nデフォルトでは問題ページにある入出力サンプルをテストケースとして実行します\n\n![スクリーンショット 2020-12-12 16.58.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/55219/52c7e36a-a015-2a60-0761-9f15994c066b.png)\n\n\nテストケースの入出力は `lib/[contest]/test_case` 以下にある yaml で設定できます。\n\n```yml:lib/arc109/test_case/a.yml\n- name: sample1\n  in: |\n    2 1 1 5\n  out: |\n    1\n\n- name: sample2\n  in: |\n    1 2 100 1\n  out: |\n    101\n\n- name: sample3\n  in: |\n    1 100 1 100\n  out: |\n    199\n\n```\n\n\n## 実装について\n\nここからが本記事のメインになります。\n実装にあたって苦労したところは主に以下の点になります。\n\n- ログイン状態の保持\n- mixタスク上でのコードの実行\n- mixタスク上で標準入力/出力を制御する\n\n### ログイン状態の保持\n\n`ex_at_coder`は `HTTPoison` + `Floki`の組み合わせで実装しました。\nログイン部分は以下のような実装になっています\n\n```elixir\n  @base_url \"https://atcoder.jp\"\n\n  def login(username, password) do\n\n    csrf_token =\n      HttpClient.get(@base_url <> \"/login\")\n      |> Floki.parse_document!()\n      |> Floki.attribute(\"input[name=csrf_token]\", \"value\")\n      |> List.first()\n\n    params =\n      [\n        username: username,\n        password: password,\n        csrf_token: csrf_token\n      ]\n\n    HttpClient.post(@base_url <> \"/login\", params)\n    ...\n  end\n```\n\nログインフォームにアクセスし、CSRFトークンを探して、それをログインフォームのエンドポイントにPOSTリクエストし、得たcookieを使う・・・といった感じになります。\n\nただしここで少しハマったのがAtCoderのサイトは毎リクエストごとに `set" <> ...,
  "coediting" => false,
  "comments_count" => 2,
  "created_at" => "2020-12-12T18:53:37+09:00",
  "group" => nil,
  "id" => "f6bb83ef45ea0e4ba98d",
  "likes_count" => 12,
  "page_views_count" => nil,
  "private" => false,
  "reactions_count" => 0,
  "rendered_body" => "<p>この記事は <a href=\"https://qiita.com/advent-calendar/2020/elixir\">Elixir Advent Calendar 2020</a> 17日目の記事です</p>\n\n<p>昨日は <a href=\"/koga1020\" class=\"user-mention js-hovercard\" title=\"koga1020\" data-hovercard-target-type=\"user\" data-hovercard-target-name=\"koga1020\">@koga1020</a> さんで<a href=\"https://zenn.dev/koga1020/articles/d1ac2beab15132\" rel=\"nofollow noopener\" target=\"_blank\">「Refactoring a Function in Elixir」のblog postを読んでみよう</a>でした！</p>\n\n<hr>\n\n<p>9月に参加した <a href=\"https://fukuokaex.connpass.com/event/188564/\" rel=\"nofollow noopener\" target=\"_blank\">Elixir Digitalization Implementors #1</a> にて、Elixirで<a href=\"https://atcoder.jp\" rel=\"nofollow noopener\" target=\"_blank\">AtCoder</a>に参加できるということを教えていただきました <img alt=\":sparkles:\" class=\"emoji\" height=\"20\" src=\"https://cdn.qiita.com/emoji/twemoji/unicode/2728.png\" title=\":sparkles:\" width=\"20\" loading=\"lazy\"> </p>\n\n<p>今まで会社にも競技プログラミングやっている人たちがいて、面白いらしいということを聞いてはいたのですが、新しい言語勉強するのもなーって思い、参加していませんでした。。。<br>\n(去年に試しに一回だけコンテストやってみましたが、それっきりでした)</p>\n\n<p>ただElixirで参加できるのなら、仕事でElixir書く機会もないし、やってみるかと思い改めて参加してみたところ、ドハマリし、現在 緑レート目指して精進中です <img alt=\":muscle:\" class=\"emoji\" height=\"20\" src=\"https://cdn.qiita.com/emoji/twemoji/unicode/1f4aa.png\" title=\":muscle:\" width=\"20\" loading=\"lazy\"> </p>\n\n<p>コンテストに参加していると、コードをテンプレートコードのコピペや実行などが面倒だと思ったので、mixタスクを書いてみました。</p>\n\n<h2>\n<span id=\"作成したもの\" class=\"fragment\"></span><a href=\"#%E4%BD%9C%E6%88%90%E3%81%97%E3%81%9F%E3%82%82%E3%81%AE\"><i class=\"fa fa-link\"></i></a>作成したもの</h2>\n\n<p><code>ex_at_coder</code> という名前で公開しております <img alt=\":sparkles:\" class=\"emoji\" height=\"20\" src=\"https://cdn.qiita.com/emoji/twemoji/unicode/2728.png\" title=\":sparkles:\" width=\"20\" loading=\"lazy\"> </p>\n\n<p><strong>hex</strong><br>\n<a href=\"https://hex.pm/packages/ex_at_coder\" class=\"autolink\" rel=\"nofollow noopener\" target=\"_blank\">https://hex.pm/packages/ex_at_coder</a></p>\n\n<p><strong>Github</strong><br>\n<a href=\"https://github.com/tamanugi/ex_at_coder\" rel=\"nofollow noopener\" target=\"_blank\"><img src=\"https://qiita-user-contents.imgix.net/https%3A%2F%2Fgithub-link-card.s3.ap-northeast-1.amazonaws.com%2Ftamanugi%2Fex_at_coder.png?ixlib=rb-1.2.2&amp;auto=format&amp;gif-q=60&amp;q=75&amp;s=afe1b24bc052ccffa69038894111c36f\" width=\"460px\" data-canonical-src=\"https://github-link-card.s3.ap-northeast-1.amazonaws.com/tamanugi/ex_at_coder.png\" srcset=\"https://qiita-user-contents.imgix.net/https%3A%2F%2Fgithub-link-card.s3.ap-northeast-1.amazonaws.com%2Ftamanugi%2Fex_at_coder.png?ixlib=rb-1.2.2&amp;auto=format&amp;gif-q=60&amp;q=75&amp;w=1400&amp;fit=max&amp;s=d78c8a2b4597fc11c8525a1f3762d69b 1x\" loading=\"lazy\"></a></p>\n\n<h2>\n<span id=\"簡単な機能紹介\" class=\"fragment\"></span><a href=\"#%E7%B0%A1%E5%8D%98%E3%81%AA%E6%A9%9F%E8%83%BD%E7%B4%B9%E4%BB%8B\"><i class=\"fa fa-link\"></i></a>簡単な機能紹介</h2>\n\n<p>今のところは以下の機能があります</p>\n\n<ul>\n<li>ログイン</li>\n<li>提出用テンプレート作成</li>\n<li>提出用コードの実行テスト</li>\n</ul>\n\n<h3>\n<span id=\"インストール\" class=\"fragment\"></span><a href=\"#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB\"><i class=\"fa fa-link\"></i></a>インストール</h3>\n\n<p>hexに登録してあるので、以下を<code>mix.exs</code>に記述した上で<code>mix deps.get</code>でインストールすることができます。</p>\n\n<div class=\"code-frame\" data-lang=\"elixir\">\n<div class=\"code-lang\"><span class=\"bold\">mix.exs</span></div>\n<div class=\"highlight\"><pre><span class=\"p\">{</span><span class=\"ss\">:ex_at_coder</span><span class=\"p\">,</span> <span class=\"s2\">\"&gt;0.0.0\"</span><span class=\"p\">}</span>\n</pre></div>\n</div>\n\n<h3>\n<span id=\"ログイン\" class=\"fragment\"></span><a href=\"#%E3%83%AD%E3%82%B0%E3%82%A4%E3%83%B3\"><i class=\"fa fa-link\"></i></a>ログイン</h3>\n\n<div class=\"code-frame\" data-lang=\"text\"><div class=\"highlight\"><pre>$ mix atcoder.login [username] [password]\n</pre></div></div>\n\n<p>指定された<code>username</code> <code>password</code>でAtCoderにログインします。</p>\n\n<p>終了しているコンテストなどはログインしなくても閲覧できますが、開催中の場合はログインが必須になります。<br>\nログインに成功した場合は、現在のディレクトリに<code>cookie.txt</code>が作成されます。</p>\n\n<p>cookieをまるごとテキストファイルで保存しちゃっているのがあんまりよくない気がしますが、とりあえずこうしちゃっています <img alt=\":innocent:\" class=\"emoji\" height=\"20\" src=\"https://cdn.qiita.com/emoji/twemoji/unicode/1f607.png\" title=\":innocent:\" width=\"20\" loading=\"lazy\"> </p>\n\n<h" <> ...,
  "tags" => [
    %{"name" => "AtCoder", "versions" => []},
    %{"name" => "Elixir", "versions" => []}
  ],
  "title" => "AtCoder用のmixタスクを作ってみた",
  "updated_at" => "2020-12-17T07:00:52+09:00",
  "url" => "https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d",
  "user" => %{
    "description" => "",
    "facebook_id" => "",
    "followees_count" => 17,
    "followers_count" => 24,
    "github_login_name" => "tamanugi",
    "id" => "tamanugi",
    "items_count" => 90,
    "linkedin_id" => "",
    "location" => "",
    "name" => "",
    "organization" => "",
    "permanent_id" => 55219,
    "profile_image_url" => "https://qiita-image-store.s3.amazonaws.com/0/55219/profile-images/1473693620",
    "team_only" => false,
    "twitter_screen_name" => "tamanugi",
    "website_url" => ""
  }
}
```

- <font color="purple">"created_at" => "2020-12-12T18:53:37+09:00"</font>
- <font color="purple">
  "tags" => [
    %{"name" => "AtCoder", "versions" => []},
    %{"name" => "Elixir", "versions" => []}
  ]
</font>

## [GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)
- それでは[GET /api/v2/items](https://qiita.com/api/v2/docs#get-apiv2items)を使ってみましょう

```elixir
iex> IEx.configure(inspect: [limit: :infinity])
:ok

iex> (
...> HTTPoison.get!("https://qiita.com/api/v2/items?query=tag%3AElixir+OR+tag%3ANerves+OR+tag%3APhoenix&per_page=100&page=1")
...> |> Map.get(:body)
...> |> Jason.decode!()
...> |> Enum.map(& Map.take(&1, ["created_at", "id", "title", "updated_at"]))
...> )
[
  %{
    "created_at" => "2020-12-21T07:26:59+09:00",
    "id" => "8d4c7b475ce9d6e51821",
    "title" => "Hello! After World!! 2D - (第0章)",
    "updated_at" => "2020-12-21T07:26:59+09:00"
  },
  %{
    "created_at" => "2020-12-21T07:11:30+09:00",
    "id" => "da76cb5a81f9c63f3a37",
    "title" => "Hello! After World!! Serverless - (第0章)",
    "updated_at" => "2020-12-21T09:40:44+09:00"
  },
  %{
    "created_at" => "2020-12-21T03:55:51+09:00",
    "id" => "997609a17edf44d39538",
    "title" => "AndroidスマホでElixir／Phoenix起動っ！…ほいでUbuntuこそが世界最強のコンテナ（プリコンパイルドElixir導入付き）",
    "updated_at" => "2020-12-21T13:19:32+09:00"
  },
  %{
    "created_at" => "2020-12-21T03:34:39+09:00",
    "id" => "e200a6208013f38333de",
    "title" => "組込みに欠かせない Elixir でのビットの扱い方",
    "updated_at" => "2020-12-21T19:07:09+09:00"
  },
  %{
    "created_at" => "2020-12-20T19:15:50+09:00",
    "id" => "538bff41d9eac2f30312",
    "title" => " ElixirでIoT#4.4：Nervesの動作周波数を制御する",
    "updated_at" => "2020-12-20T23:39:26+09:00"
  },
  %{
    "created_at" => "2020-12-20T03:33:15+09:00",
    "id" => "ab12e0346756dc753491",
    "title" => "ElixirのWebAuthn用ライブラリ \"Wax\" の使い方",
    "updated_at" => "2020-12-20T03:33:15+09:00"
  },
  %{ 
    "created_at" => "2020-12-20T01:51:15+09:00",
    "id" => "98e1bde676263f5f9f81",
    "title" => "WindowsからElixir IoT端末を作ってみた：「Raspberry Pi OS」を入れた後、Elixir IoTフレームワーク「Nerves」へ",
    "updated_at" => "2020-12-20T12:53:16+09:00"
  },
  %{
    "created_at" => "2020-12-20T00:04:40+09:00",
    "id" => "df3c28dd6ee5cb9c526e",
    "title" => "0埋め (Elixir)",
    "updated_at" => "2020-12-20T00:04:40+09:00"
  },
  %{
    "created_at" => "2020-12-19T23:42:48+09:00",
    "id" => "7d37d43349d6efb8329e",
    "title" => "Macro.camelize/1 (Elixir)",
    "updated_at" => "2020-12-20T01:51:44+09:00"
  },
  %{
    "created_at" => "2020-12-19T14:57:30+09:00",
    "id" => "33e3471aaab6d863aecf",
    "title" => "I was born to love Elixir",
    "updated_at" => "2020-12-21T07:52:48+09:00"
  },
  %{
    "created_at" => "2020-12-19T00:02:25+09:00",
    "id" => "23381fff2ac630800bf0",
    "title" => "Elixirで竹内関数を計測してみた",
    "updated_at" => "2020-12-19T11:11:56+09:00"
  },
  %{
    "created_at" => "2020-12-18T23:01:51+09:00",
    "id" => "7c29778e19e5b281f293",
    "title" => "NeosVRに見出した可能性と未来について：「4つの世界」は「7つの世界」に",
    "updated_at" => "2020-12-19T11:44:19+09:00"
  },
  %{
    "created_at" => "2020-12-18T15:10:52+09:00",
    "id" => "5963a8bf5f2a34c67d88",
    "title" => "Elixirで速度を追い求めるときのプログラミングスタイル",
    "updated_at" => "2020-12-21T07:23:54+09:00"
  },
  %{
    "created_at" => "2020-12-18T14:17:54+09:00",
    "id" => "8955f78cfeb2e959c983",
    "title" => "Elixirのプログラムの実行方法",
    "updated_at" => "2020-12-20T13:09:27+09:00"
  },
  %{
    "created_at" => "2020-12-18T11:35:26+09:00",
    "id" => "a2b0d882e8cc0ae2a5a8",
    "title" => "AtCoder Beginners Selection with Elixir",
    "updated_at" => "2020-12-18T11:43:06+09:00"
  },
  %{
    "created_at" => "2020-12-17T22:39:51+09:00",
    "id" => "0b1faacfdaa1cf217bec",
    "title" => "GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified) 〜Nervesならできるもん！〜",
    "updated_at" => "2020-12-21T16:56:06+09:00"
  },
  %{
    "created_at" => "2020-12-17T19:45:51+09:00",
    "id" => "b7fb8409f3f6d0a60f66",
    "title" => "Nerves＋Phoenix\b 003　エムネチカ：分散型DB Mnesiaを使ってオリジナルCapeのLEDをエムネチカ",
    "updated_at" => "2020-12-21T19:29:11+09:00"
  },
  %{
    "created_at" => "2020-12-17T07:35:46+09:00",
    "id" => "f93aafcdcf284db28475",
    "title" => "[Elixir/Nerves] LCDにHello!",
    "updated_at" => "2020-12-21T10:41:49+09:00"
  },
  %{
    "created_at" => "2020-12-16T20:42:08+09:00",
    "id" => "a8f2eb1cf96e9cf385d8",
    "title" => "1260 (Elixir 1.11.2-otp-23)",
    "updated_at" => "2020-12-21T07:03:02+09:00"
  },
  %{
    "created_at" => "2020-12-16T19:14:22+09:00",
    "id" => "7b35cfc33774966d2e4e",
    "title" => "mix credoのエラー結果に対してどうすべきか調べる。", 
    "updated_at" => "2020-12-16T19:14:22+09:00"
  },
  %{
    "created_at" => "2020-12-16T17:03:25+09:00",
    "id" => "0306163bb15d9cfbe092",
    "title" => "動的計画法を使う問題をElixirで関数型っぽく解いてみる",
    "updated_at" => "2020-12-17T07:50:24+09:00"
  },
  %{
    "created_at" => "2020-12-16T14:50:36+09:00",
    "id" => "3aca05799f4bf490a991",
    "title" => "Elixirで並行処理をやってみた",
    "updated_at" => "2020-12-16T14:52:23+09:00"
  },
  %{
    "created_at" => "2020-12-16T00:25:58+09:00",
    "id" => "998d6539e4adcd1816b3",
    "title" => "Azure Container InstancesでNervesアプリを開発する",
    "updated_at" => "2020-12-16T08:46:25+09:00"
  },
  %{
    "created_at" => "2020-12-15T18:14:46+09:00",
    "id" => "f14ce06cebb71b00db20",
    "title" => "NervesでAutoconfを用いてNIFをビルドする方法",
    "updated_at" => "2020-12-17T09:12:47+09:00"
  },
  %{
    "created_at" => "2020-12-14T23:09:22+09:00",
    "id" => "d24749203b1586b5685a",
    "title" => "Raspberry Pi 4 + Grove Base HAT for Raspberry Pi  + Grove Buzzer + Grove ButtonでつくるNervesアラーム",
    "updated_at" => "2020-12-20T19:40:51+09:00"
  },
  %{
    "created_at" => "2020-12-14T20:37:49+09:00",
    "id" => "a67bb585ce0f2d48b23f",
    "title" => "Elixirでバリデーションを実装してみた",
    "updated_at" => "2020-12-15T10:36:50+09:00"
  },
  %{
    "created_at" => "2020-12-14T16:44:35+09:00",
    "id" => "79df06dad2c103aa6772",
    "title" => "ElixirでTwitterのbotを作る",
    "updated_at" => "2020-12-16T12:07:06+09:00"
  },
  %{
    "created_at" => "2020-12-14T00:27:31+09:00",
    "id" => "810f407b838bad599e2f",
    "title" => "[書評] プログラミングElixir第2版のインプレッションとアップデート",
    "updated_at" => "2020-12-19T17:52:35+09:00"
  },
  %{
    "created_at" => "2020-12-14T00:19:14+09:00",
    "id" => "477c92a57c8aaf694251",
    "title" => "ExUnitの`assert`でパターンマッチを用いて複雑なデータ構造をテストする",
    "updated_at" => "2020-12-14T00:26:26+09:00"
  },
  %{
    "created_at" => "2020-12-13T23:34:19+09:00",
    "id" => "19fecf95b9313b8a2b8a",
    "title" => "Grove - Buzzer をNervesで鳴らす",
    "updated_at" => "2020-12-20T19:39:42+09:00"
  },
  %{
    "created_at" => "2020-12-13T22:52:08+09:00",
    "id" => "ca56167faee1ceb16c00",
    "title" => "[Elixir] \"Hello\"と'Hello'",
    "updated_at" => "2020-12-14T10:28:52+09:00"
  },
  %{
    "created_at" => "2020-12-13T22:01:58+09:00",
    "id" => "3926fe3740e229594c8f",
    "title" => "グラフうねうね (動かし方 編) (Elixir/Phoenix)",
    "updated_at" => "2020-12-15T13:56:34+09:00"
  },
  %{
    "created_at" => "2020-12-13T11:29:54+09:00",
    "id" => "4d982a16c2448790cad4",
    "title" => "[Elixir] Referenceの作り方",
    "updated_at" => "2020-12-20T08:50:10+09:00"
  },
  %{
    "created_at" => "2020-12-13T09:58:28+09:00",
    "id" => "3fbf6a0e603adf64b235",
    "title" => "`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側",
    "updated_at" => "2020-12-14T11:17:00+09:00"
  },
  %{
    "created_at" => "2020-12-13T03:28:13+09:00",
    "id" => "f4668697cb371ea6bb39",
    "title" => "[Elixir] Supervisorのchild_spec",
    "updated_at" => "2020-12-20T08:43:20+09:00"
  },
  %{
    "created_at" => "2020-12-13T00:00:48+09:00",
    "id" => "b393bfbdd566ea08ff56",
    "title" => "ElixirからOpenGLを使って3D空間に描画をする",
    "updated_at" => "2020-12-15T23:47:09+09:00"
  },
  %{
    "created_at" => "2020-12-12T23:14:28+09:00",
    "id" => "81f2a75bee0f919224ad",
    "title" => "Grove Base HAT for RasPiは真っ直ぐグイっとさす",
    "updated_at" => "2020-12-20T19:39:27+09:00"
  },
  %{
    "created_at" => "2020-12-12T21:38:01+09:00",
    "id" => "a570e8baa337c73f011a",
    "title" => "GigalixirでPORTを4000以外の値にするのはだめよ (Elixir)",
    "updated_at" => "2020-12-13T22:31:11+09:00"
  },
  %{
    "created_at" => "2020-12-12T13:03:15+09:00",
    "id" => "7e03e6664900f4402d40",
    "title" => "[Elixir] プロセス使用を検討する基準",
    "updated_at" => "2020-12-18T07:33:50+09:00"
  },
  %{
    "created_at" => "2020-12-12T11:15:49+09:00",
    "id" => "c50fed098acd506d9559",
    "title" => "[Elixir] GenServer.init関数で重い処理",
    "updated_at" => "2020-12-19T07:13:45+09:00"
  }, 
  %{
    "created_at" => "2020-12-12T02:58:58+09:00",
    "id" => "71f4b80d8f7dddf87293",
    "title" => "String.replace/3 (Elixir)",
    "updated_at" => "2020-12-12T03:32:51+09:00"
  },
  %{
    "created_at" => "2020-12-12T01:18:56+09:00",
    "id" => "ed5c16c3ee1c7a102fba",
    "title" => "書評：プログラミングElixir第2版",
    "updated_at" => "2020-12-12T01:18:56+09:00"
  },
  %{
    "created_at" => "2020-12-11T23:27:41+09:00",
    "id" => "1bcef0e91a413879d79a",
    "title" => "[Elixir] GenServerのアイドルタイムアウト",
    "updated_at" => "2020-12-18T07:34:20+09:00"
  },
  %{
    "created_at" => "2020-12-11T21:58:18+09:00",
    "id" => "542ec8bcea454b00a32a",
    "title" => "[Elixir] GenServerのCallとCast",
    "updated_at" => "2020-12-15T07:49:45+09:00"
  },
  %{
    "created_at" => "2020-12-11T21:26:44+09:00",
    "id" => "dcb14dc9a4b1ad5b505d",
    "title" => "Elixir の OSS を読んでみよう ~ Plug.CSRFProtection を例に ~",
    "updated_at" => "2020-12-12T12:57:41+09:00"
  },
  %{
    "created_at" => "2020-12-11T16:00:00+09:00",
    "id" => "4d8b23d99434d5a841ca",
    "title" => "NeosVR＋Elixirで気軽にVR WebSocketプログラミング（VR |> AR投影アプリの裏側）",
    "updated_at" => "2020-12-18T17:45:15+09:00"
  },
  %{
    "created_at" => "2020-12-11T11:28:45+09:00",
    "id" => "833a6e14511f084438d1",
    "title" => "[Elixir] GenServerのプロセスをどう管理するか",
    "updated_at" => "2020-12-15T23:09:28+09:00"
  },
  %{
    "created_at" => "2020-12-11T09:03:49+09:00",
    "id" => "050da725dde4d05fed9e",
    "title" => "Elixirで並行コマンド実行サーバーを作ったら感動した話",
    "updated_at" => "2020-12-12T15:27:06+09:00"
  },
  %{
    "created_at" => "2020-12-11T02:12:34+09:00",
    "id" => "695928065568f6f37319",
    "title" => "Erlangのコマンドでobserverを開く。",
    "updated_at" => "2020-12-11T02:12:34+09:00"
  },
  %{
    "created_at" => "2020-12-11T00:02:23+09:00",
    "id" => "7b92b33ce16689db1cf7",
    "title" => "細かい話は置いといて、とりあえず触ってみたい人のための Elixir",
    "updated_at" => "2020-12-11T18:33:38+09:00"
  },
  %{
    "created_at" => "2020-12-10T23:18:56+09:00",
    "id" => "9e9e28411d6a7d134a11",
    "title" => "NimbleCSVのご紹介(Elixir)",
    "updated_at" => "2020-12-11T07:02:57+09:00"
  },
  %{
    "created_at" => "2020-12-10T19:46:12+09:00",
    "id" => "ecf9bd4a43f66b2d6273",
    "title" => "ElixirでIoT#4.1.3：[仕組み篇] Docker(とVS Code)だけ！でNerves開発環境を整備する",
    "updated_at" => "2020-12-17T11:19:53+09:00"
  },
  %{
    "created_at" => "2020-12-10T18:59:56+09:00",
    "id" => "39ba2840e1cbb4567135",
    "title" => "Phoenix LiveViewへのサービスリプレイスの際に既存コンテンツからの段階的な移行を考えてみる",
    "updated_at" => "2020-12-11T12:08:28+09:00"
  },
  %{
    "created_at" => "2020-12-10T18:26:33+09:00",
    "id" => "5c6db095f4c567c36f69",
    "title" => "クラウドの外でエッジサーバを作るためのElixir技術スタック",
    "updated_at" => "2020-12-19T17:59:16+09:00"
  },
  %{
    "created_at" => "2020-12-10T15:01:10+09:00",
    "id" => "d0d1891349ea5b97a3cc",
    "title" => "NervesとPhonenix(Gigalixir)とGCP Cloud PubSubを使ってBBG CapeのLEDをチカした話〜NervesでSub編〜（2/2）",
    "updated_at" => "2020-12-21T09:33:36+09:00"
  },
  %{
    "created_at" => "2020-12-10T14:35:56+09:00",
    "id" => "6c537342f8815728f69d",
    "title" => "NervesとPhonenix(Gigalixir)とGCP Cloud PubSubを使ってBBG CapeのLEDをチカした話〜Phoenix/GCPでPub編〜（1/2）",
    "updated_at" => "2020-12-18T10:15:08+09:00"
  },
  %{
    "created_at" => "2020-12-10T00:00:53+09:00",
    "id" => "14ad8b9673bd47ce8b8f",
    "title" => "1 = a (プログラミングElixir 第2版)",
    "updated_at" => "2020-12-14T11:38:33+09:00"
  },
  %{
    "created_at" => "2020-12-09T22:49:53+09:00",
    "id" => "69f1c754b0622d1c4d7c",
    "title" => "ROS2クライアントライブラリのCIを構築した話",
    "updated_at" => "2020-12-10T07:02:41+09:00"
  },
  %{
    "created_at" => "2020-12-09T03:43:39+09:00",
    "id" => "d362b2eab08def4ac4cd",
    "title" => "実験: レガシーなImage ProcessingをElixirのパイプで書いてみる",
    "updated_at" => "2020-12-09T09:57:32+09:00"
  },
  %{
    "created_at" => "2020-12-09T01:30:30+09:00",
    "id" => "9b8e78b8b0f3ca0f7e19",
    "title" => "Rustler で行儀の良い NIF を書く",
    "updated_at" => "2020-12-09T01:30:30+09:00"
  },
  %{
    "created_at" => "2020-12-08T20:40:45+09:00",
    "id" => "3890d4ea8220f44c7e0a",
    "title" => "HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get (Elixir)", 
    "updated_at" => "2020-12-09T07:08:20+09:00"
  },
  %{
    "created_at" => "2020-12-08T17:15:23+09:00",
    "id" => "753d2ef5d6bac48af14a",
    "title" => "Apple M1チップ搭載MacでNervesを動かす方法(2020.12.8暫定版)",
    "updated_at" => "2020-12-11T16:16:45+09:00"
  },
  %{
    "created_at" => "2020-12-08T00:02:19+09:00",
    "id" => "3b34fa4f4c3adaf192c4",
    "title" => "Phoenix LiveViewで作る web/mobile チャットアプリ リアルタイム処理編",
    "updated_at" => "2020-12-08T00:02:19+09:00"
  },
  %{
    "created_at" => "2020-12-07T20:52:05+09:00",
    "id" => "1e266c7b213cdd3fd58e",
    "title" => "CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)",
    "updated_at" => "2020-12-21T11:33:10+09:00"
  },
  %{
    "created_at" => "2020-12-07T00:00:41+09:00",
    "id" => "c814c741faa447446ce5",
    "title" => "Phoenix LiveViewで作る web/mobile チャットアプリ 下準備編",
    "updated_at" => "2020-12-07T00:00:41+09:00"
  },
  %{
    "created_at" => "2020-12-06T20:53:27+09:00",
    "id" => "34406dd5b6b386f1ef9e",
    "title" => "WindowsでIExで日本語を使う(iex --werl) (Elixir)",
    "updated_at" => "2020-12-07T07:02:49+09:00"
  },
  %{
    "created_at" => "2020-12-06T07:03:44+09:00",
    "id" => "5ad36ef83ad69a564970",
    "title" => "やがてelixirになる",
    "updated_at" => "2020-12-06T07:03:44+09:00"
  },
  %{
    "created_at" => "2020-12-06T02:01:55+09:00",
    "id" => "4bdf88acf0ab0e8e2c7e",
    "title" => "[Elixir/Nerves] パルス幅変調 (PWM) Lチカ",
    "updated_at" => "2020-12-18T12:32:02+09:00"
  },
  %{
    "created_at" => "2020-12-05T15:23:42+09:00",
    "id" => "6d6ac7b4938b9ff5e6db",
    "title" => "次の関数の第二引数なんだよなー(Elixir)",
    "updated_at" => "2020-12-06T21:07:23+09:00"
  },
  %{
    "created_at" => "2020-12-05T14:52:06+09:00",
    "id" => "db0d6cefc5ac46a73ec4",
    "title" => "[Elixir]匿名関数をパターンマッチする",
    "updated_at" => "2020-12-06T14:26:07+09:00"
  },
  %{
    "created_at" => "2020-12-05T01:58:19+09:00",
    "id" => "e326ee256451f2fc0f27", 
    "title" => "nerves_system_*から読み解くNervesの動向",
    "updated_at" => "2020-12-05T01:58:19+09:00"
  },
  %{
    "created_at" => "2020-12-04T21:27:53+09:00",
    "id" => "8d67e857cdfb8fa4657c",
    "title" => "二次元リストの操作(Elixir)",
    "updated_at" => "2020-12-05T07:02:47+09:00"
  },
  %{
    "created_at" => "2020-12-04T18:58:26+09:00",
    "id" => "27005ba9c0d9eb693ea9",
    "title" => "ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する",
    "updated_at" => "2020-12-17T11:20:24+09:00"
  },
  %{
    "created_at" => "2020-12-04T15:39:58+09:00",
    "id" => "4692e589bab7c84ef957",
    "title" => "Elixir から Swift 5.3のコードを呼び出す方法(Autotoolsを使って / Apple Silicon M1チップにも対応)",
    "updated_at" => "2020-12-11T16:15:23+09:00"
  },
  %{
    "created_at" => "2020-12-04T15:32:41+09:00",
    "id" => "f8f7734e9ab46aa74739",
    "title" => "Apple Silicon M1チップ搭載Mac (Big Sur) に Elixir / Erlang をクリーンインストールする〜Elixir/Pelemayマイクロベンチマーク結果もあるよ！(2020.12.4現在版)",
    "updated_at" => "2020-12-11T18:54:19+09:00"
  },
  %{
    "created_at" => "2020-12-04T15:16:53+09:00",
    "id" => "db0cbbe758200c69150a",
    "title" => "ElixirでFizzBuzz, 総和(再帰)をやってみた",
    "updated_at" => "2020-12-06T07:02:32+09:00"
  },
  %{
    "created_at" => "2020-12-04T09:06:58+09:00",
    "id" => "99a60dc8a4427b79ddc7",
    "title" => "なぜ僕はNervesに期待するのか",
    "updated_at" => "2020-12-12T15:29:01+09:00"
  },
  %{
    "created_at" => "2020-12-03T21:40:09+09:00",
    "id" => "f5f426985f968e686e85",
    "title" => "【Elixir 1.11】Phoenix Framework + DB開発をDockerでやる #2（CIパイプライン導入）",
    "updated_at" => "2020-12-21T08:38:30+09:00"
  },
  %{
    "created_at" => "2020-12-03T14:16:23+09:00",
    "id" => "6adf153ee3893fd1ad4d",
    "title" => "「kentaro/mix_tasks_upload_hotswap」を試してみる！　ご本人が参加していらっしゃるカレンダーにて",
    "updated_at" => "2020-12-14T14:54:25+09:00"
  },
  %{
    "created_at" => "2020-12-03T10:45:55+09:00",
    "id" => "ef3629064f930e85c20f",
    "title" => "Elixir練習帳: .npyファイルの中を覗く",
    "updated_at" => "2020-12-05T07:02:34+09:00"
  },
  %{
    "created_at" => "2020-12-03T09:31:28+09:00",
    "id" => "6777040eb9203a0d67cc",
    "title" => "最もスリムなphx.new",
    "updated_at" => "2020-12-03T09:31:28+09:00"
  },
  %{
    "created_at" => "2020-12-02T12:41:53+09:00",
    "id" => "a6664d3a3c76503affc7",
    "title" => "Elixir/NervesでPLC(多機能リレー)を作ってみた",
    "updated_at" => "2020-12-10T21:48:19+09:00"
  },
  %{
    "created_at" => "2020-12-02T09:50:29+09:00",
    "id" => "e8df79aa93b9fe9a567e",
    "title" => "ウェブチカでElixir/Nervesに入門する（2020年12月版）",
    "updated_at" => "2020-12-03T01:38:15+09:00"
  },
  %{
    "created_at" => "2020-12-01T18:29:15+09:00",
    "id" => "f8b4baa6f6ee294f6b79",
    "title" => "優しいエラーメッセージを書きたい",
    "updated_at" => "2020-12-01T18:29:15+09:00"
  },
  %{
    "created_at" => "2020-12-01T01:54:38+09:00",
    "id" => "aa6a073a81f002ebbcc5",
    "title" => "Elixir 1.11 でついに新しくなった Logger",
    "updated_at" => "2020-12-20T22:30:07+09:00"
  },
  %{
    "created_at" => "2020-11-30T23:41:40+09:00",
    "id" => "badb4725a9c17788f8b1",
    "title" => "[87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]",
    "updated_at" => "2020-12-09T23:05:21+09:00"
  },
  %{
    "created_at" => "2020-11-30T19:47:13+09:00",
    "id" => "84d9d71d109d689d267d",
    "title" => "【Elixir 1.11】Phoenix Framework + DB開発をDockerでやる #1（コンテナ開発環境構築~CRUD実装~テスト）",
    "updated_at" => "2020-12-08T07:44:16+09:00"
  },
  %{
    "created_at" => "2020-11-29T08:37:23+09:00",
    "id" => "b5ae9eac42bd304b7aa3",
    "title" => "Surfaceをつかってみる(Elixir/Phoenix)",
    "updated_at" => "2020-12-02T19:57:00+09:00"
  },
  %{
    "created_at" => "2020-11-28T18:33:59+09:00",
    "id" => "77388ff0d3e03c95897c",
    "title" => "Elixirで動的計画法（DP）を実装してみた（Goとの比較つき）",
    "updated_at" => "2020-12-07T07:00:36+09:00"
  },
  %{
    "created_at" => "2020-11-28T18:20:58+09:00",
    "id" => "81320c5e571c3124b338",
    "title" => "Elixir Circuits I2Cでアナログ入力 （Grove Base Hat for Raspberry Pi）",
    "updated_at" => "2020-12-04T09:38:53+09:00"
  },
  %{
    "created_at" => "2020-11-28T00:53:40+09:00",
    "id" => "79d4ba3f95b1463105f8",
    "title" => "ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法",
    "updated_at" => "2020-12-16T12:21:02+09:00"
  },
  %{
    "created_at" => "2020-11-26T00:31:38+09:00",
    "id" => "c468a228f9d0ba13ffb9",
    "title" => "Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。",
    "updated_at" => "2020-12-04T10:57:34+09:00"
  },
  %{
    "created_at" => "2020-11-25T09:08:30+09:00",
    "id" => "75d5db21d98fdf4459e2",
    "title" => "ElixirでAtCoderのABC123を解いてみる！",
    "updated_at" => "2020-12-04T19:04:10+09:00"
  },
  %{
    "created_at" => "2020-11-24T19:27:56+09:00",
    "id" => "ad2545fe8414bbd177a0",
    "title" => "(Intel) Big Sur でErlangをビルドする方法(kerl/asdf編)",
    "updated_at" => "2020-12-11T18:43:08+09:00"
  },
  %{
    "created_at" => "2020-11-24T02:28:28+09:00",
    "id" => "d71a7f3fed26ea0b0d96",
    "title" => "Timexで時を操る",
    "updated_at" => "2020-12-02T07:01:51+09:00"
  },
  %{
    "created_at" => "2020-11-23T17:56:48+09:00",
    "id" => "0dbf308947b878423112",
    "title" => "リアルタイムOSコントローラ e-RT3 （Elixirから制御編）",
    "updated_at" => "2020-12-20T19:10:57+09:00"
  },
  %{
    "created_at" => "2020-11-23T01:17:07+09:00",
    "id" => "a7b1b1545a93170eee62",
    "title" => "「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる",
    "updated_at" => "2020-12-05T12:34:48+09:00"
  },
  %{
    "created_at" => "2020-11-22T18:17:14+09:00",
    "id" => "a80677a0747232843957",
    "title" => "順列の全探索をするプログラム（競技プログラミング向け）",
    "updated_at" => "2020-11-22T18:17:14+09:00"
  },
  %{
    "created_at" => "2020-11-22T11:09:47+09:00",
    "id" => "97f208d14ccfab01d1d7",
    "title" => "Elixir Circuits I2Cで温度・湿度測定 (AHT20)",
    "updated_at" => "2020-11-28T18:18:58+09:00"
  },
  %{
    "created_at" => "2020-11-21T01:12:43+09:00",
    "id" => "68783f2d8d819f506061",
    "title" => "2次元リストの動きを眺めることをやってみた（Elixir）",
    "updated_at" => "2020-11-21T03:32:07+09:00"
  }
]
```

- `f6bb83ef45ea0e4ba98d`がないですよね〜

```elixir
  %{
    "created_at" => "2020-12-12T21:38:01+09:00",
    "id" => "a570e8baa337c73f011a",
    "title" => "GigalixirでPORTを4000以外の値にするのはだめよ (Elixir)",
    "updated_at" => "2020-12-13T22:31:11+09:00"
  },
  # ここの間が抜けているとおもうのだよなー
  %{
    "created_at" => "2020-12-12T13:03:15+09:00",
    "id" => "7e03e6664900f4402d40",
    "title" => "[Elixir] プロセス使用を検討する基準",
    "updated_at" => "2020-12-18T07:33:50+09:00"
  },
```

# でも、あんたこれ、[Elixir](https://elixir-lang.org/)でやっているから、[Elixir](https://elixir-lang.org/)がなんかおかしいんじゃないの？
- ごもっともです
- [Ruby](https://www.ruby-lang.org/ja/)でどうなるかやってみましょう

```ruby:items.rb
require 'open-uri'
require 'json'

body = URI.open('https://qiita.com/api/v2/items?query=tag%3AElixir+OR+tag%3ANerves+OR+tag%3APhoenix&per_page=100&page=1', &:read)

ary = JSON.parse(body)

p ary.map{ |h| h.slice("created_at", "id", "title", "updated_at") }
```

```ruby
$ ruby items.rb

[{"created_at"=>"2020-12-21T07:26:59+09:00", "id"=>"8d4c7b475ce9d6e51821", "title"=>"Hello! After World!! 2D - (第0章)", "updated_at"=>"2020-12-21T07:26:59+09:00"}, {"created_at"=>"2020-12-21T07:11:30+09:00", "id"=>"da76cb5a81f9c63f3a37", "title"=>"Hello! After World!! Serverless - (第0章)", "updated_at"=>"2020-12-21T09:40:44+09:00"}, {"created_at"=>"2020-12-21T03:55:51+09:00", "id"=>"997609a17edf44d39538", "title"=>"AndroidスマホでElixir／Phoenix起動っ！…ほいでUbuntuこそが世界最強のコンテナ（プリコンパイルドElixir導入付き）", "updated_at"=>"2020-12-21T13:19:32+09:00"}, {"created_at"=>"2020-12-21T03:34:39+09:00", "id"=>"e200a6208013f38333de", "title"=>"組込みに欠かせない Elixir でのビットの扱い方", "updated_at"=>"2020-12-21T19:07:09+09:00"}, {"created_at"=>"2020-12-20T19:15:50+09:00", "id"=>"538bff41d9eac2f30312", "title"=>" ElixirでIoT#4.4：Nervesの動作周波数を制御する", "updated_at"=>"2020-12-20T23:39:26+09:00"}, {"created_at"=>"2020-12-20T03:33:15+09:00", "id"=>"ab12e0346756dc753491", "title"=>"ElixirのWebAuthn用ライブラリ \"Wax\" の使い方", "updated_at"=>"2020-12-20T03:33:15+09:00"}, {"created_at"=>"2020-12-20T01:51:15+09:00", "id"=>"98e1bde676263f5f9f81", "title"=>"WindowsからElixir IoT端末を作ってみた：「Raspberry Pi OS」を入れた後、Elixir IoTフレームワーク「Nerves」へ", "updated_at"=>"2020-12-20T12:53:16+09:00"}, {"created_at"=>"2020-12-20T00:04:40+09:00", "id"=>"df3c28dd6ee5cb9c526e", "title"=>"0埋め (Elixir)", "updated_at"=>"2020-12-20T00:04:40+09:00"}, {"created_at"=>"2020-12-19T23:42:48+09:00", "id"=>"7d37d43349d6efb8329e", "title"=>"Macro.camelize/1 (Elixir)", "updated_at"=>"2020-12-20T01:51:44+09:00"}, {"created_at"=>"2020-12-19T14:57:30+09:00", "id"=>"33e3471aaab6d863aecf", "title"=>"I was born to love Elixir", "updated_at"=>"2020-12-21T07:52:48+09:00"}, {"created_at"=>"2020-12-19T00:02:25+09:00", "id"=>"23381fff2ac630800bf0", "title"=>"Elixirで竹内関数を計測してみた", "updated_at"=>"2020-12-19T11:11:56+09:00"}, {"created_at"=>"2020-12-18T23:01:51+09:00", "id"=>"7c29778e19e5b281f293", "title"=>"NeosVRに見出した可能性と未来について：「4つの世界」は「7つの世界」に", "updated_at"=>"2020-12-19T11:44:19+09:00"}, {"created_at"=>"2020-12-18T15:10:52+09:00", "id"=>"5963a8bf5f2a34c67d88", "title"=>"Elixirで速度を追い求めるときのプログラミングスタイル", "updated_at"=>"2020-12-21T07:23:54+09:00"}, {"created_at"=>"2020-12-18T14:17:54+09:00", "id"=>"8955f78cfeb2e959c983", "title"=>"Elixirのプログラムの実行方法", "updated_at"=>"2020-12-20T13:09:27+09:00"}, {"created_at"=>"2020-12-18T11:35:26+09:00", "id"=>"a2b0d882e8cc0ae2a5a8", "title"=>"AtCoder Beginners Selection with Elixir", "updated_at"=>"2020-12-18T11:43:06+09:00"}, {"created_at"=>"2020-12-17T22:39:51+09:00", "id"=>"0b1faacfdaa1cf217bec", "title"=>"GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified) 〜Nervesならできるもん！〜", "updated_at"=>"2020-12-21T16:56:06+09:00"}, {"created_at"=>"2020-12-17T19:45:51+09:00", "id"=>"b7fb8409f3f6d0a60f66", "title"=>"Nerves＋Phoenix\b 003　エムネチカ：分散型DB Mnesiaを使ってオリジナルCapeのLEDをエムネチカ", "updated_at"=>"2020-12-21T19:29:11+09:00"}, {"created_at"=>"2020-12-17T07:35:46+09:00", "id"=>"f93aafcdcf284db28475", "title"=>"[Elixir/Nerves] LCDにHello!", "updated_at"=>"2020-12-21T10:41:49+09:00"}, {"created_at"=>"2020-12-16T20:42:08+09:00", "id"=>"a8f2eb1cf96e9cf385d8", "title"=>"1260 (Elixir 1.11.2-otp-23)", "updated_at"=>"2020-12-21T07:03:02+09:00"}, {"created_at"=>"2020-12-16T19:14:22+09:00", "id"=>"7b35cfc33774966d2e4e", "title"=>"mix credoのエラー結果に対してどうすべきか調べる。", "updated_at"=>"2020-12-16T19:14:22+09:00"}, {"created_at"=>"2020-12-16T17:03:25+09:00", "id"=>"0306163bb15d9cfbe092", "title"=>"動的計画法を使う問題をElixirで関数型っぽく解いてみる", "updated_at"=>"2020-12-17T07:50:24+09:00"}, {"created_at"=>"2020-12-16T14:50:36+09:00", "id"=>"3aca05799f4bf490a991", "title"=>"Elixirで並行処理をやってみた", "updated_at"=>"2020-12-16T14:52:23+09:00"}, {"created_at"=>"2020-12-16T00:25:58+09:00", "id"=>"998d6539e4adcd1816b3", "title"=>"Azure Container InstancesでNervesアプリを開発する", "updated_at"=>"2020-12-16T08:46:25+09:00"}, {"created_at"=>"2020-12-15T18:14:46+09:00", "id"=>"f14ce06cebb71b00db20", "title"=>"NervesでAutoconfを用いてNIFをビルドする方法", "updated_at"=>"2020-12-17T09:12:47+09:00"}, {"created_at"=>"2020-12-14T23:09:22+09:00", "id"=>"d24749203b1586b5685a", "title"=>"Raspberry Pi 4 + Grove Base HAT for Raspberry Pi  + Grove Buzzer + Grove ButtonでつくるNervesアラーム", "updated_at"=>"2020-12-20T19:40:51+09:00"}, {"created_at"=>"2020-12-14T20:37:49+09:00", "id"=>"a67bb585ce0f2d48b23f", "title"=>"Elixirでバリデーションを実装してみた", "updated_at"=>"2020-12-15T10:36:50+09:00"}, {"created_at"=>"2020-12-14T16:44:35+09:00", "id"=>"79df06dad2c103aa6772", "title"=>"ElixirでTwitterのbotを作る", "updated_at"=>"2020-12-16T12:07:06+09:00"}, {"created_at"=>"2020-12-14T00:27:31+09:00", "id"=>"810f407b838bad599e2f", "title"=>"[書評] プログラミングElixir第2版のインプレッションとアップデート", "updated_at"=>"2020-12-19T17:52:35+09:00"}, {"created_at"=>"2020-12-14T00:19:14+09:00", "id"=>"477c92a57c8aaf694251", "title"=>"ExUnitの`assert`でパターンマッチを用いて複雑なデータ構造をテストする", "updated_at"=>"2020-12-14T00:26:26+09:00"}, {"created_at"=>"2020-12-13T23:34:19+09:00", "id"=>"19fecf95b9313b8a2b8a", "title"=>"Grove - Buzzer をNervesで鳴らす", "updated_at"=>"2020-12-20T19:39:42+09:00"}, {"created_at"=>"2020-12-13T22:52:08+09:00", "id"=>"ca56167faee1ceb16c00", "title"=>"[Elixir] \"Hello\"と'Hello'", "updated_at"=>"2020-12-14T10:28:52+09:00"}, {"created_at"=>"2020-12-13T22:01:58+09:00", "id"=>"3926fe3740e229594c8f", "title"=>"グラフうねうね (動かし方 編) (Elixir/Phoenix)", "updated_at"=>"2020-12-15T13:56:34+09:00"}, {"created_at"=>"2020-12-13T11:29:54+09:00", "id"=>"4d982a16c2448790cad4", "title"=>"[Elixir] Referenceの作り方", "updated_at"=>"2020-12-20T08:50:10+09:00"}, {"created_at"=>"2020-12-13T09:58:28+09:00", "id"=>"3fbf6a0e603adf64b235", "title"=>"`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側", "updated_at"=>"2020-12-14T11:17:00+09:00"}, {"created_at"=>"2020-12-13T03:28:13+09:00", "id"=>"f4668697cb371ea6bb39", "title"=>"[Elixir] Supervisorのchild_spec", "updated_at"=>"2020-12-20T08:43:20+09:00"}, {"created_at"=>"2020-12-13T00:00:48+09:00", "id"=>"b393bfbdd566ea08ff56", "title"=>"ElixirからOpenGLを使って3D空間に描画をする", "updated_at"=>"2020-12-15T23:47:09+09:00"}, {"created_at"=>"2020-12-12T23:14:28+09:00", "id"=>"81f2a75bee0f919224ad", "title"=>"Grove Base HAT for RasPiは真っ直ぐグイっとさす", "updated_at"=>"2020-12-20T19:39:27+09:00"}, {"created_at"=>"2020-12-12T21:38:01+09:00", "id"=>"a570e8baa337c73f011a", "title"=>"GigalixirでPORTを4000以外の値にするのはだめよ (Elixir)", "updated_at"=>"2020-12-13T22:31:11+09:00"}, {"created_at"=>"2020-12-12T13:03:15+09:00", "id"=>"7e03e6664900f4402d40", "title"=>"[Elixir] プロセス使用を検討する基準", "updated_at"=>"2020-12-18T07:33:50+09:00"}, {"created_at"=>"2020-12-12T11:15:49+09:00", "id"=>"c50fed098acd506d9559", "title"=>"[Elixir] GenServer.init関数で重い処理", "updated_at"=>"2020-12-19T07:13:45+09:00"}, {"created_at"=>"2020-12-12T02:58:58+09:00", "id"=>"71f4b80d8f7dddf87293", "title"=>"String.replace/3 (Elixir)", "updated_at"=>"2020-12-12T03:32:51+09:00"}, {"created_at"=>"2020-12-12T01:18:56+09:00", "id"=>"ed5c16c3ee1c7a102fba", "title"=>"書評：プログラミングElixir第2版", "updated_at"=>"2020-12-12T01:18:56+09:00"}, {"created_at"=>"2020-12-11T23:27:41+09:00", "id"=>"1bcef0e91a413879d79a", "title"=>"[Elixir] GenServerのアイドルタイムアウト", "updated_at"=>"2020-12-18T07:34:20+09:00"}, {"created_at"=>"2020-12-11T21:58:18+09:00", "id"=>"542ec8bcea454b00a32a", "title"=>"[Elixir] GenServerのCallとCast", "updated_at"=>"2020-12-15T07:49:45+09:00"}, {"created_at"=>"2020-12-11T21:26:44+09:00", "id"=>"dcb14dc9a4b1ad5b505d", "title"=>"Elixir の OSS を読んでみよう ~ Plug.CSRFProtection を例に ~", "updated_at"=>"2020-12-12T12:57:41+09:00"}, {"created_at"=>"2020-12-11T16:00:00+09:00", "id"=>"4d8b23d99434d5a841ca", "title"=>"NeosVR＋Elixirで気軽にVR WebSocketプログラミング（VR |> AR投影アプリの裏側）", "updated_at"=>"2020-12-18T17:45:15+09:00"}, {"created_at"=>"2020-12-11T11:28:45+09:00", "id"=>"833a6e14511f084438d1", "title"=>"[Elixir] GenServerのプロセスをどう管理するか", "updated_at"=>"2020-12-15T23:09:28+09:00"}, {"created_at"=>"2020-12-11T09:03:49+09:00", "id"=>"050da725dde4d05fed9e", "title"=>"Elixirで並行コマンド実行サーバーを作ったら感動した話", "updated_at"=>"2020-12-12T15:27:06+09:00"}, {"created_at"=>"2020-12-11T02:12:34+09:00", "id"=>"695928065568f6f37319", "title"=>"Erlangのコマンドでobserverを開く。", "updated_at"=>"2020-12-11T02:12:34+09:00"}, {"created_at"=>"2020-12-11T00:02:23+09:00", "id"=>"7b92b33ce16689db1cf7", "title"=>"細かい話は置いといて、とりあえず触ってみたい人のための Elixir", "updated_at"=>"2020-12-11T18:33:38+09:00"}, {"created_at"=>"2020-12-10T23:18:56+09:00", "id"=>"9e9e28411d6a7d134a11", "title"=>"NimbleCSVのご紹介(Elixir)", "updated_at"=>"2020-12-11T07:02:57+09:00"}, {"created_at"=>"2020-12-10T19:46:12+09:00", "id"=>"ecf9bd4a43f66b2d6273", "title"=>"ElixirでIoT#4.1.3：[仕組み篇] Docker(とVS Code)だけ！でNerves開発環境を整備する", "updated_at"=>"2020-12-17T11:19:53+09:00"}, {"created_at"=>"2020-12-10T18:59:56+09:00", "id"=>"39ba2840e1cbb4567135", "title"=>"Phoenix LiveViewへのサービスリプレイスの際に既存コンテンツからの段階的な移行を考えてみる", "updated_at"=>"2020-12-11T12:08:28+09:00"}, {"created_at"=>"2020-12-10T18:26:33+09:00", "id"=>"5c6db095f4c567c36f69", "title"=>"クラウドの外でエッジサーバを作るためのElixir技術スタック", "updated_at"=>"2020-12-19T17:59:16+09:00"}, {"created_at"=>"2020-12-10T15:01:10+09:00", "id"=>"d0d1891349ea5b97a3cc", "title"=>"NervesとPhonenix(Gigalixir)とGCP Cloud PubSubを使ってBBG CapeのLEDをチカした話〜NervesでSub編〜（2/2）", "updated_at"=>"2020-12-21T09:33:36+09:00"}, {"created_at"=>"2020-12-10T14:35:56+09:00", "id"=>"6c537342f8815728f69d", "title"=>"NervesとPhonenix(Gigalixir)とGCP Cloud PubSubを使ってBBG CapeのLEDをチカした話〜Phoenix/GCPでPub編〜（1/2）", "updated_at"=>"2020-12-18T10:15:08+09:00"}, {"created_at"=>"2020-12-10T00:00:53+09:00", "id"=>"14ad8b9673bd47ce8b8f", "title"=>"1 = a (プログラミングElixir 第2版)", "updated_at"=>"2020-12-14T11:38:33+09:00"}, {"created_at"=>"2020-12-09T22:49:53+09:00", "id"=>"69f1c754b0622d1c4d7c", "title"=>"ROS2クライアントライブラリのCIを構築した話", "updated_at"=>"2020-12-10T07:02:41+09:00"}, {"created_at"=>"2020-12-09T03:43:39+09:00", "id"=>"d362b2eab08def4ac4cd", "title"=>"実験: レガシーなImage ProcessingをElixirのパイプで書いてみる", "updated_at"=>"2020-12-09T09:57:32+09:00"}, {"created_at"=>"2020-12-09T01:30:30+09:00", "id"=>"9b8e78b8b0f3ca0f7e19", "title"=>"Rustler で行儀の良い NIF を書く", "updated_at"=>"2020-12-09T01:30:30+09:00"}, {"created_at"=>"2020-12-08T20:40:45+09:00", "id"=>"3890d4ea8220f44c7e0a", "title"=>"HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get (Elixir)", "updated_at"=>"2020-12-09T07:08:20+09:00"}, {"created_at"=>"2020-12-08T17:15:23+09:00", "id"=>"753d2ef5d6bac48af14a", "title"=>"Apple M1チップ搭載MacでNervesを動かす方法(2020.12.8暫定版)", "updated_at"=>"2020-12-11T16:16:45+09:00"}, {"created_at"=>"2020-12-08T00:02:19+09:00", "id"=>"3b34fa4f4c3adaf192c4", "title"=>"Phoenix LiveViewで作る web/mobile チャットアプリ リアルタイム処理編", "updated_at"=>"2020-12-08T00:02:19+09:00"}, {"created_at"=>"2020-12-07T20:52:05+09:00", "id"=>"1e266c7b213cdd3fd58e", "title"=>"CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)", "updated_at"=>"2020-12-21T11:33:10+09:00"}, {"created_at"=>"2020-12-07T00:00:41+09:00", "id"=>"c814c741faa447446ce5", "title"=>"Phoenix LiveViewで作る web/mobile チャットアプリ 下準備編", "updated_at"=>"2020-12-07T00:00:41+09:00"}, {"created_at"=>"2020-12-06T20:53:27+09:00", "id"=>"34406dd5b6b386f1ef9e", "title"=>"WindowsでIExで日本語を使う(iex --werl) (Elixir)", "updated_at"=>"2020-12-07T07:02:49+09:00"}, {"created_at"=>"2020-12-06T07:03:44+09:00", "id"=>"5ad36ef83ad69a564970", "title"=>"やがてelixirになる", "updated_at"=>"2020-12-06T07:03:44+09:00"}, {"created_at"=>"2020-12-06T02:01:55+09:00", "id"=>"4bdf88acf0ab0e8e2c7e", "title"=>"[Elixir/Nerves] パルス幅変調 (PWM) Lチカ", "updated_at"=>"2020-12-18T12:32:02+09:00"}, {"created_at"=>"2020-12-05T15:23:42+09:00", "id"=>"6d6ac7b4938b9ff5e6db", "title"=>"次の関数の第二引数なんだよなー(Elixir)", "updated_at"=>"2020-12-06T21:07:23+09:00"}, {"created_at"=>"2020-12-05T14:52:06+09:00", "id"=>"db0d6cefc5ac46a73ec4", "title"=>"[Elixir]匿名関数をパターンマッチする", "updated_at"=>"2020-12-06T14:26:07+09:00"}, {"created_at"=>"2020-12-05T01:58:19+09:00", "id"=>"e326ee256451f2fc0f27", "title"=>"nerves_system_*から読み解くNervesの動向", "updated_at"=>"2020-12-05T01:58:19+09:00"}, {"created_at"=>"2020-12-04T21:27:53+09:00", "id"=>"8d67e857cdfb8fa4657c", "title"=>"二次元リストの操作(Elixir)", "updated_at"=>"2020-12-05T07:02:47+09:00"}, {"created_at"=>"2020-12-04T18:58:26+09:00", "id"=>"27005ba9c0d9eb693ea9", "title"=>"ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する", "updated_at"=>"2020-12-17T11:20:24+09:00"}, {"created_at"=>"2020-12-04T15:39:58+09:00", "id"=>"4692e589bab7c84ef957", "title"=>"Elixir から Swift 5.3のコードを呼び出す方法(Autotoolsを使って / Apple Silicon M1チップにも対応)", "updated_at"=>"2020-12-11T16:15:23+09:00"}, {"created_at"=>"2020-12-04T15:32:41+09:00", "id"=>"f8f7734e9ab46aa74739", "title"=>"Apple Silicon M1チップ搭載Mac (Big Sur) に Elixir / Erlang をクリーンインストールする〜Elixir/Pelemayマイクロベンチマーク結果もあるよ！(2020.12.4現在版)", "updated_at"=>"2020-12-11T18:54:19+09:00"}, {"created_at"=>"2020-12-04T15:16:53+09:00", "id"=>"db0cbbe758200c69150a", "title"=>"ElixirでFizzBuzz, 総和(再帰)をやってみた", "updated_at"=>"2020-12-06T07:02:32+09:00"}, {"created_at"=>"2020-12-04T09:06:58+09:00", "id"=>"99a60dc8a4427b79ddc7", "title"=>"なぜ僕はNervesに期待するのか", "updated_at"=>"2020-12-12T15:29:01+09:00"}, {"created_at"=>"2020-12-03T21:40:09+09:00", "id"=>"f5f426985f968e686e85", "title"=>"【Elixir 1.11】Phoenix Framework + DB開発をDockerでやる #2（CIパイプライン導入）", "updated_at"=>"2020-12-21T08:38:30+09:00"}, {"created_at"=>"2020-12-03T14:16:23+09:00", "id"=>"6adf153ee3893fd1ad4d", "title"=>"「kentaro/mix_tasks_upload_hotswap」を試してみる！　ご本人が参加していらっしゃるカレンダーにて", "updated_at"=>"2020-12-14T14:54:25+09:00"}, {"created_at"=>"2020-12-03T10:45:55+09:00", "id"=>"ef3629064f930e85c20f", "title"=>"Elixir練習帳: .npyファイルの中を覗く", "updated_at"=>"2020-12-05T07:02:34+09:00"}, {"created_at"=>"2020-12-03T09:31:28+09:00", "id"=>"6777040eb9203a0d67cc", "title"=>"最もスリムなphx.new", "updated_at"=>"2020-12-03T09:31:28+09:00"}, {"created_at"=>"2020-12-02T12:41:53+09:00", "id"=>"a6664d3a3c76503affc7", "title"=>"Elixir/NervesでPLC(多機能リレー)を作ってみた", "updated_at"=>"2020-12-10T21:48:19+09:00"}, {"created_at"=>"2020-12-02T09:50:29+09:00", "id"=>"e8df79aa93b9fe9a567e", "title"=>"ウェブチカでElixir/Nervesに入門する（2020年12月版）", "updated_at"=>"2020-12-03T01:38:15+09:00"}, {"created_at"=>"2020-12-01T18:29:15+09:00", "id"=>"f8b4baa6f6ee294f6b79", "title"=>"優しいエラーメッセージを書きたい", "updated_at"=>"2020-12-01T18:29:15+09:00"}, {"created_at"=>"2020-12-01T01:54:38+09:00", "id"=>"aa6a073a81f002ebbcc5", "title"=>"Elixir 1.11 でついに新しくなった Logger", "updated_at"=>"2020-12-20T22:30:07+09:00"}, {"created_at"=>"2020-11-30T23:41:40+09:00", "id"=>"badb4725a9c17788f8b1", "title"=>"[87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]", "updated_at"=>"2020-12-09T23:05:21+09:00"}, {"created_at"=>"2020-11-30T19:47:13+09:00", "id"=>"84d9d71d109d689d267d", "title"=>"【Elixir 1.11】Phoenix Framework + DB開発をDockerでやる #1（コンテナ開発環境構築~CRUD実装~テスト）", "updated_at"=>"2020-12-08T07:44:16+09:00"}, {"created_at"=>"2020-11-29T08:37:23+09:00", "id"=>"b5ae9eac42bd304b7aa3", "title"=>"Surfaceをつかってみる(Elixir/Phoenix)", "updated_at"=>"2020-12-02T19:57:00+09:00"}, {"created_at"=>"2020-11-28T18:33:59+09:00", "id"=>"77388ff0d3e03c95897c", "title"=>"Elixirで動的計画法（DP）を実装してみた（Goとの比較つき）", "updated_at"=>"2020-12-07T07:00:36+09:00"}, {"created_at"=>"2020-11-28T18:20:58+09:00", "id"=>"81320c5e571c3124b338", "title"=>"Elixir Circuits I2Cでアナログ入力 （Grove Base Hat for Raspberry Pi）", "updated_at"=>"2020-12-04T09:38:53+09:00"}, {"created_at"=>"2020-11-28T00:53:40+09:00", "id"=>"79d4ba3f95b1463105f8", "title"=>"ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法", "updated_at"=>"2020-12-16T12:21:02+09:00"}, {"created_at"=>"2020-11-26T00:31:38+09:00", "id"=>"c468a228f9d0ba13ffb9", "title"=>"Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。", "updated_at"=>"2020-12-04T10:57:34+09:00"}, {"created_at"=>"2020-11-25T09:08:30+09:00", "id"=>"75d5db21d98fdf4459e2", "title"=>"ElixirでAtCoderのABC123を解いてみる！", "updated_at"=>"2020-12-04T19:04:10+09:00"}, {"created_at"=>"2020-11-24T19:27:56+09:00", "id"=>"ad2545fe8414bbd177a0", "title"=>"(Intel) Big Sur でErlangをビルドする方法(kerl/asdf編)", "updated_at"=>"2020-12-11T18:43:08+09:00"}, {"created_at"=>"2020-11-24T02:28:28+09:00", "id"=>"d71a7f3fed26ea0b0d96", "title"=>"Timexで時を操る", "updated_at"=>"2020-12-02T07:01:51+09:00"}, {"created_at"=>"2020-11-23T17:56:48+09:00", "id"=>"0dbf308947b878423112", "title"=>"リアルタイムOSコントローラ e-RT3 （Elixirから制御編）", "updated_at"=>"2020-12-20T19:10:57+09:00"}, {"created_at"=>"2020-11-23T01:17:07+09:00", "id"=>"a7b1b1545a93170eee62", "title"=>"「クラウドネイティブの ASP.NET Core マイクロサービスを作成してデプロイする」 をやってみる", "updated_at"=>"2020-12-05T12:34:48+09:00"}, {"created_at"=>"2020-11-22T18:17:14+09:00", "id"=>"a80677a0747232843957", "title"=>"順列の全探索をするプログラム（競技プログラミング向け）", "updated_at"=>"2020-11-22T18:17:14+09:00"}, {"created_at"=>"2020-11-22T11:09:47+09:00", "id"=>"97f208d14ccfab01d1d7", "title"=>"Elixir Circuits I2Cで温度・湿度測定 (AHT20)", "updated_at"=>"2020-11-28T18:18:58+09:00"}, {"created_at"=>"2020-11-21T01:12:43+09:00", "id"=>"68783f2d8d819f506061", "title"=>"2次元リストの動きを眺めることをやってみた（Elixir）", "updated_at"=>"2020-11-21T03:32:07+09:00"}]
```

- [Ruby](https://www.ruby-lang.org/ja/)でやってみても、「[AtCoder用のmixタスクを作ってみた](https://qiita.com/tamanugi/items/f6bb83ef45ea0e4ba98d)」記事は無いです :cry:
- <font color="purple">なんでしょうね？</font>
- `/api/v2/items?query=tag%3AElixir+OR+tag%3ANerves+OR+tag%3APhoenix&per_page=100&page=1`
    - `query`パラメータの指定が違う:interrobang:
    - 私は合っているとおもっているのですが、おかしいよ:bangbang: とかこうすればいいんじゃないの？　とかアドバイスありましたらよろしくお願いします :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 


# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- いつも[Qiita](https://qiita.com/)様にはお世話になっております!
    - [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)を書くのが私の趣味です
    - 楽しくて楽しくて仕方ありません
    - 書きたいことが無限に湧いてきます
    - 現時点の私の参加状況です
    - 参加状況はみなさん、ログインして https://qiita.com/advent-calendar/2020/my-calendar でみれますですよ

![スクリーンショット 2020-12-21 23.00.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6a7cb670-4328-1985-dcda-197bab180c14.png)




- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:
