---
title: 'とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 解決編 (Elixir)'
tags:
  - Elixir
private: false
updated_at: '2021-09-04T09:58:02+09:00'
id: fd7971bb5dd7788c55d5
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- 以前、「[とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 (Elixir)](https://qiita.com/torifukukaiou/items/100afafe1920eb72b339)」という記事を書きました
- ようやくHTTP Getに成功できましたので記事にしておきます
    - あくまでも私がHTTP Getしたかったとあるサイトでの実装例です
    - サイトごとにパラメータ調整が必要になるとおもいますが、その際には私がやったことを参考にすればきっと正解にたどり着けるとおもいます
- この記事は2021/09/04(土) 00:00〜2021/09/06(月) 23:59開催の純粋なもくもく会「[autoracex #44](https://autoracex.connpass.com/event/224102/)」の成果物です

# とあるサイトでHTTP Getに成功したコード

```elixir
HTTPoison.get "https://to-aru-site.jp", [], [ssl: [{:ciphers, ['AES256-SHA256']}]]
```

- `to-aru-site.jp`は架空のドメインです
- `to-aru-site.jp`サイトは他人様のもので、私がどうのこうのすること(**接続暗号スイート**を更新するなど)はできません

# この問題に出くわしたときにやるべきこと
- 今回の例を踏まえて、また同じような問題に出くわしたときの対処方法を示しておきます
- 他のサイトではどうか => 問題がない場合、次へ
    - さらにもう一つくらいみんながよくつかっている有名なサイトで試してみて、それでもやっぱり駄目なら自分を疑ったほうがいいでしょう
    - エラーがでるのが本当ならそこそこ界隈では大騒ぎになっているはずだから自分の実装を疑ったほうがいいでしょう
- 問題がないほかのサイトとくらべて通信内容に差異がないかを調べる
    - 例: `curl -v https://to-aru-site.jp --head`
        - 残念ながら私はcurlコマンドの結果ではなにがなにやらさっぱりわかりませんでした
    - [CMAN 株式会社シーマン](https://www.cman.co.jp/)様が提供されている[SSLチェック【証明書・プロトコル・暗号スイート確認】](https://www.cman.jp/network/support/ssl.html)でチェックしてみる
        - こちらにより、**接続暗号スイート**なるものに差異があることがわかりました
        - その上で、curlの結果をみると確かに`SSL connection using TLSv1.2 / XXXX`に差異がありました
- ここまでわかればあとはなんとかなります
    - でてきた単語でググったり、[httpc](https://erlang.org/doc/man/httpc.html)や[ssl](https://erlang.org/doc/man/ssl_app.html)を読んだり、先人のブログを読んだり
    - カンでプログラムを書いてとりあえず試してみたり
- https://erlang.org/doc/apps/ssl/using_ssl.html#customizing-cipher-suites に以下の記述がありましてこのへんが関係しているようです

> In OTP 20 it is desirable to remove all cipher suites that uses rsa kexchange (removed from default in 21)

- OTP 20でrsa keyexchangeを使うすべてのcipher suitesを取り除くことが強くもとめられた
- それでOTP 21ではデフォルトで取り除いた
- **そうそう、たしかにこのとあるサイトにおいても、OTP 20では通信ができていました**
    - [Docker](https://www.docker.com/)便利〜:relaxed:

```sh
$ docker run -it --rm erlang:20.3.8.26
```

```erlang
Erlang/OTP 20 [erts-9.3.3.15] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:10] [hipe] [kernel-poll:false]

Eshell V9.3.3.15  (abort with ^G)
1> inets:start(),
1> ssl:start(),
1> httpc:request("https://to-aru-site.jp/")   .
{ok,{{"HTTP/1.1",200,"OK"},
     [{"cache-control","max-age=30"},
      {"connection","Keep-Alive"},
      {"date","Sat, 04 Sep 2021 00:51:05 GMT"},
      {"server","Apache"},
      {"vary","Accept-Encoding"},
      {"content-length","58989"},
      {"content-type","text/html; charset=UTF-8"},
      {"expires","Sat, 04 Sep 2021 00:51:35 GMT"},
      {"x-frame-options","SAMEORIGIN"},
      {"keep-alive","timeout=1, max=100"}],
     [60,33,68,79,67,84,89,80,69,32,104,116,109,108,62,10,60,104,
      116,109,108,32,108,97|...]}}
```



## 但し書き
- https をちゃ〜んと理解していることが一番いいのだとおもいます
- ちゃんとした理解があれば、「[とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 (Elixir)](https://qiita.com/torifukukaiou/items/100afafe1920eb72b339)」という記事を書いたあと10ヶ月くらい放置せずに済んだでしょう
- 私みたいに、<font color="green">緑</font>のあれね[^1]くらいのノリで雰囲気httpsを使っている人にはヒントになるかもしれません
    - これで良いと言っているわけではなくて、やっぱりちゃんとhttps をちゃ〜んと理解していることが一番いいのだとおもいます
    - 繰り返しておきます


[^1]: 最近は、<font color="green">緑</font>じゃないかもしれません


# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
- ようやく[Elixir](https://elixir-lang.org/)でとあるサイトと会話できるようになってうれしいです :rocket::rocket::rocket: 
- [autoracex #44](https://autoracex.connpass.com/event/224102/)開催中 :tada::tada::tada: 

 
