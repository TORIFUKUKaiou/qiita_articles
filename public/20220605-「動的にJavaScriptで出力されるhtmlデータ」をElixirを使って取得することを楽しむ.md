---
title: 「動的にJavaScriptで出力されるhtmlデータ」をElixirを使って取得することを楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
  - QiitaEngineerFesta2022
private: false
updated_at: '2022-06-15T19:20:26+09:00'
id: 9ee8276ede477e22c52e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---

**夜をこめてとりのそらねははかるともよに逢坂の関は許さじ**

Advent Calendar 2022 114日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/) を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、「動的にJavaScriptで出力されるhtmlデータ」を取得することをやってみます。
Pythonの記事が多いです。
とても参考にさせてもらいました。

私はもちろん、[Elixir](https://elixir-lang.org/)を使います。

# 準備

まず準備を進めます。
私はmacOSを使っています。

## スクレイピングする対象

ヨソサマにご迷惑をかけぬようにしたいとおもいます。
おもうだけでは駄目なので、簡易なものを手元に用意します。

スクレイピングする対象を用意するというわけです。
以下、一例を示します。

```html:index.html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="utf-8">
  <title>Vue.js App</title>
</head>
<body>
  <div id="list-rendering">
    <ol>
      <li v-for="todo in todos">
        {{ todo.text }}
      </li>
    </ol>
  </div>
  <script
    src="https://unpkg.com/vue@next"></script>
  <script src="main.js"></script>
</body>
</html>
```

```js:main.js
const ListRendering = {
  data() {
    return {
      todos: [
        { text: 'Learn JavaScript' },
        { text: 'Learn Vue' },
        { text: 'Build something awesome' }
      ]
    }
  }
}

Vue.createApp(ListRendering).mount('#list-rendering')
```

上記の2ファイルを同じディレクトリに置いておきます。
たとえばDockerをお使いの場合は以下のようにするとよいでしょう。

```bash
docker run --rm -v $(pwd):/usr/share/nginx/html:ro -p 8080:80 -d nginx
```

http://localhost:8080
に訪れると以下のようなページが表示されます。

![スクリーンショット 2022-06-05 17.18.42.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0ee2c155-48f8-db33-3e1b-d1d972ca2982.png)

## [Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザと[ChromeDriver](https://chromedriver.chromium.org/home)のインストール

雑な説明で恐縮ですが、今回は静的なページではなく、**動的にJavaScriptで内容がかわるhtml**を解析したいので、スクレイピングプログラムの実行で、あたかもブラウザでアクセスしたかのようにアクセスをする必要があります。
それで、[Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザと[ChromeDriver](https://chromedriver.chromium.org/home)のインストールが必要となります。

[Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザはリンク先のインストーラでインストールしました。

[ChromeDriver](https://chromedriver.chromium.org/home)は、[Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザのバージョンと近いものをインストールしておくことが吉のようです。
[Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザのバージョンは、右上の三点リーダ（︙）から確認できます。

![スクリーンショット 2022-06-05 17.28.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b6cf41d3-3105-f129-c72a-62c99b86d694.png)




私の場合は、[ChromeDriver](https://chromedriver.chromium.org/home)のページにある**Latest stable release**が[Chrome](https://www.google.com/intl/ja_jp/chrome/)ブラウザとバージョンが近かったので、その`.zip`をダウンロードし、解凍して、下記のコマンドで`/usr/local/bin/`に配置しました。

```
sudo mv chromedriver /usr/local/bin/
```

あとで、スクレイピングを実行したときに、 「**"chromedriver"は開発元を検証できないため開けません。**」 と言われるかもしれません。
そのときはこちらの記事を参考にするとよいです。
この場をお借りして記事を書いてくださった方に感謝を申し上げます。

https://qiita.com/apukasukabian/items/77832dd42e85ab7aa568

準備は以上です。

# [Elixir](https://elixir-lang.org/)で楽しむ

[wallaby](https://github.com/elixir-wallaby/wallaby)を使います。
他に候補は、[Hound](https://github.com/HashNuke/hound)があります。

これらのライブラリの共通点は、テストのためというのを主眼に置いていることです。
つまりは自分のつくったアプリケーションのテストをしようね、と言うことを暗に言っているのだとおもいます。
テストの中にはふつうに[Elixir](https://elixir-lang.org/)のプログラムが書けますので、テストの中でスクレイピングすることにします。

以下、[wallaby](https://github.com/elixir-wallaby/wallaby)のドキュメントに書いてある通りの手順です。



## プロジェクトの作成

まずはプロジェクトを作っておきましょう。

```
mix new sample
```

## [wallaby](https://github.com/elixir-wallaby/wallaby)の追加

`mix.exs`に、[wallaby](https://github.com/elixir-wallaby/wallaby) Hexを追加します。

```elixir:mix.exs
  defp deps do
    [
      {:wallaby, "~> 0.29.0", runtime: false, only: :test}
    ]
  end
```

ファイルを変更後、`mix deps.get`で依存関係を解決します。

```bash
mix deps.get
```

## test_helper.exs の変更

```elixir:test/test_helper.exs
ExUnit.start()
{:ok, _} = Application.ensure_all_started(:wallaby) # add
Application.put_env(:wallaby, :base_url, "http://localhost:8080") # add
```

## テストファイルを書く

```elixir:test/scraping_test.exs
defmodule ScrapingTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  feature "visit /index.html", %{session: session} do
    page_source =
      session
      |> visit("/index.html")
      |> page_source()

    IO.puts(page_source)
  end
end
```

## Run

実行してみます。

```bash
mix test
```

結果:tada::tada::tada:

```elixir
<html lang="ja"><head>
  <meta charset="utf-8">
  <title>Vue.js App</title>
</head>
<body>
  <div id="list-rendering" data-v-app=""><ol><li>Learn JavaScript</li><li>Learn Vue</li><li>Build something awesome</li></ol></div>
  <script src="https://unpkg.com/vue@next"></script>
  <script src="main.js"></script>


</body></html>
```

JavaScriptで動的に埋め込まれたデータが得られています！！！
`main.js`の

```javascript
      todos: [
        { text: 'Learn JavaScript' },
        { text: 'Learn Vue' },
        { text: 'Build something awesome' }
      ]
```

この部分です。

- Learn JavaScript
- Learn Vue
- Build something awesome

# (おまけ) テキストだけ取り出す ーー [Floki](https://github.com/philss/floki)を簡単に紹介します

Pythonの[Beautiful Soup](https://pypi.org/project/beautifulsoup4/)に相当するもとして、[Elixir](https://elixir-lang.org/)は[Floki](https://github.com/philss/floki)があります。
[Floki](https://github.com/philss/floki)を利用して、動的に埋め込まれたテキストを取り出してみます。

`mix.exs`に[Floki](https://github.com/philss/floki)を追加します。

```elixir:mix.exs
  defp deps do
    [
      {:wallaby, "~> 0.29.0", runtime: false, only: :test},
      {:floki, "~> 0.32.0"}
    ]
  end
```


`mix.exs`を変更したら、依存関係を解決します。

```bash
mix deps.get
```

`test/scraping_test.exs`を修正します。
[Floki](https://github.com/philss/floki)の使い方はドキュメントをご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
以下、使い方の一例を示します。 

```elixir:test/scraping_test.exs
defmodule ScrapingTest do
  use ExUnit.Case, async: true
  use Wallaby.Feature

  feature "visit /index.html", %{session: session} do
    page_source =
      session
      |> visit("/index.html")
      |> page_source()

    IO.puts(page_source)

    # add ここから
    {:ok, document} = Floki.parse_document(page_source)

    Floki.find(document, "li")
    |> Enum.map(&Floki.text/1)
    |> IO.inspect()
    # add ここまで
  end
end
```

実行してみます。

```bash
mix test
```

結果は、以下の通りテキストの値がしっかり取得できています！ :tada::tada::tada: 

```elixir
["Learn JavaScript", "Learn Vue", "Build something awesome"]
```

# 本当にこんな面倒くさいことをしないといけないの？

ふつうにindex.htmlをHTTP GETしただけでは、ブラウザでのアクセスのようにJavaScriptが実行されず、本当に`index.html`のみしか取得できません。
以下、実行例です。


```elixir
iex

iex> Mix.install [:req]
:ok

iex> Req.get!("http://localhost:8080/index.html") |> Map.get(:body) |> IO.puts
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="utf-8">
  <title>Vue.js App</title>
</head>
<body>
  <div id="list-rendering">
    <ol>
      <li v-for="todo in todos">
        {{ todo.text }}
      </li>
    </ol>
  </div>
  <script
    src="https://unpkg.com/vue@next"></script>
  <script src="main.js"></script>
</body>
</html>
```

もちろん静的なページであれば、単純なHTTP GETでよいです。

今回のように、「動的にJavaScriptで出力されるデータ」がある場合には、[ChromeDriver](https://chromedriver.chromium.org/home)の力を借りると、あたかもブラウザでアクセスしている体となり、所望のhtmlが得られるわけです。


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

「動的にJavaScriptで出力されるhtmlデータ」をElixirを使って取得することを楽しんでみました。

久々に、[AdventCalendar2022](https://qiita.com/tags/adventcalendar2022)を書きました。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



---

# 参考記事

以下、参考にした記事です。
各記事の作者の方には、この場をお借りして御礼申し上げます。

## Python

Pythonの記事です。
参考になるところがたくさんありました。

- [Pythonスクレイピング：JavaScriptによる動的ページ、静的ページ、キャプチャ取得のそれぞれの手法をサンプルコード付きで解説](https://www.handsonplus.com/programming/python-scraping/)
- [Python Webスクレイピング テクニック集「取得できない値は無い」JavaScript対応@追記あり6/12](https://qiita.com/Azunyan1111/items/b161b998790b1db2ff7a)
    - [**注意事項**](https://qiita.com/Azunyan1111/items/b161b998790b1db2ff7a#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)はよく読みましょう
- [seleniumを使用しようとしたら、「"chromedriver"は開発元を検証できないため開けません。」と言われた](https://qiita.com/apukasukabian/items/77832dd42e85ab7aa568)
- [【Python】ChromeDriverのエラーまとめ【selenium】](https://sushiringblog.com/chromedriver-error)
- [Ubuntu + Python3 + Selenium + GoogleChrome でスクレイピング](https://www.mt-megami.com/article/ubuntu-python3-selenium-googlechrome-scraping)


## [Elixir](https://elixir-lang.org/)

Elixirの記事です。

- [Scraping Js heavy website](https://elixirforum.com/t/scraping-js-heavy-website/15188)
- [Selenium driver for elixir, with javascript support](https://elixirforum.com/t/selenium-driver-for-elixir-with-javascript-support/5494)








---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)




