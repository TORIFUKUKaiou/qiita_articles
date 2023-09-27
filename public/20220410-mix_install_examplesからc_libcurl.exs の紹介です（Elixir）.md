---
title: mix_install_examplesからc_libcurl.exs の紹介です（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-10T20:18:29+09:00'
id: 03e87957e995528e5753
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**ちぎりきなかたみに袖をしぼりつつ末の松山波越さじとは**

Advent Calendar 2022 93日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)のサンプル集である[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)から[wojtekmach/c](https://github.com/wojtekmach/c)を紹介します。



# What's [Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2) ?

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)は、[Elixir](https://elixir-lang.org/) 1.12から追加されました。
[Elixir](https://elixir-lang.org/)でライブラリ(Hex)を追加するのは、1.11までは`mix new`でプロジェクトを作らないといけないなど、ひと手間必要でした。
[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)を使うことで、ちょっとした1ファイルで収まるようなスクリプトを書く際に`.exs`のみで完結できるようになりました。

## 具体例

具体例です。
私がよく使ういつものサンプルです。

[Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています

```elixir
Mix.install [:req]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

Qiitaさん、いつもありがとうございます!!!

---

# [c_libcurl.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/c_libcurl.exs)

おもしろそうなサンプルってことで、今日は[wojtekmach/c](https://github.com/wojtekmach/c)を楽しんでみます。



## What's [wojtekmach/c](https://github.com/wojtekmach/c) ?

> Easily use C code in your Elixir projects.

https://hex.pm

には登録されていないようです。


## Run

それでは、[c_libcurl.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/c_libcurl.exs)を動かしてみます。

https://github.com/wojtekmach/mix_install_examples/blob/main/c_libcurl.exs

以下、そのまま掲載します。

```elixir:c_libcurl.exs
Mix.install([
  {:c, github: "wojtekmach/c"}
])

defmodule Curl.MixProject do
  use Mix.Project

  def project do
    [
      app: :curl,
      version: "1.0.0"
    ]
  end
end

defmodule Main do
  def main do
    Curl.test()
  end
end

defmodule Curl do
  use C, compile: "-lcurl"

  # Based on https://curl.se/libcurl/c/simple.html

  defc(:test, 0, ~S"""
  #include <curl/curl.h>
  static ERL_NIF_TERM test(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
  {
    CURL *curl;
    CURLcode res;
    curl = curl_easy_init();
    if (!curl) {
      enif_raise_exception(env, enif_make_string(env, "could not init curl", ERL_NIF_LATIN1));
      return -1;
    }
    curl_easy_setopt(curl, CURLOPT_URL, "https://httpbin.org/json");
    /* Perform the request, res will get the return code */
    res = curl_easy_perform(curl);
    /* Check for errors */
    if (res != CURLE_OK) {
      fprintf(stderr, "curl_easy_perform() failed: %s\n", curl_easy_strerror(res));
    }
    /* always cleanup */
    curl_easy_cleanup(curl);
    return enif_make_atom(env, "ok");
  }
  """)
end

Main.main()
```

`defc`の第2引数に文字列でCのコードを埋め込んでいるところが特徴です。


## 実行

```shell
git clone https://github.com/wojtekmach/mix_install_examples.git
cd mix_install_examples
elixir c_libcurl.exs
```

## 結果

JSONが表示されました。
C言語の`curl_easy_perform`の実行のところで表示されていました。
前後に`printf("a")`を入れて確かめました。


```json
{
  "slideshow": {
    "author": "Yours Truly", 
    "date": "date of publication", 
    "slides": [
      {
        "title": "Wake up to WonderWidgets!", 
        "type": "all"
      }, 
      {
        "items": [
          "Why <em>WonderWidgets</em> are great", 
          "Who <em>buys</em> WonderWidgets"
        ], 
        "title": "Overview", 
        "type": "all"
      }
    ], 
    "title": "Sample Slide Show"
  }
}
```

https://httpbin.org/json
にブラウザでアクセスするなり、それこそ`curl https://httpbin.org/json`したときに得られる結果と同じものが表示されました。

もしかしたら環境によってはCのコンパイラや`curl/curl.h`を見れるようにするためにsomethingのインストールが必要になるかもしれません。
私はmacOSを使っていまして、Command line tools for Xcodeをインストールしています。
このへんで事足りたのだとおもいます。


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は、[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)の中から、[c_libcurl.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/c_libcurl.exs)をご紹介をしました。


今後も他のサンプルをご紹介していきます。
また、シンプルでいい例をおもいついたら、プルリクを送ってみるのはいいかもしれません。
私は、おもいついた場合には、プルリクを送ってみる気でいます :rocket::rocket::rocket: 


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





