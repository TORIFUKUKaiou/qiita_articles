---
title: ちょっと古めのElixirバージョンでmix testしたい
tags:
  - Elixir
private: false
updated_at: '2021-05-24T00:13:22+09:00'
id: ce959056e34e9a2a33e3
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- [Hex](https://hex.pm/)の開発をしているとちょっと古めのElixirバージョンで`mix test`したくなるときがあるかもしれません
- 私の場合は @piacerex さん作の[smallex](https://github.com/piacerex/smallex)という[Elixir](https://elixir-lang.org/)の標準にはないけれどあると便利な小粒でピリリと辛い小粋で気の利いた[Hex](https://hex.pm/)の開発でそういうことをしたくなっちゃったりしました
- `mix.exs`に`elixir: "~> 1.6"`という記述があって、あれこれって本当に`1.6`でイゴくのだっけ？　というのを確かめたくて、Elixir 1.6を[asdf](https://asdf-vm.com/#/)でインストールしようとしました
- `OTP 21`が必要で、macOS CatalinaとUbuntu 20.04でインストールしようとしましたがエラーがでました
    - けっこう時間がたったあとに無理でしたと言われる感じでますます萎えます
- 古いもののビルドを通す努力を続ける気にもならずどうしようかとしばし逡巡したのち、「あ、[Docker Hub](https://hub.docker.com/)にあるんじゃないの？」とおもってやってみたらうまくいったので書いておきます

# こげな感じでやりました

## コンテナを立ち上げる
```
$ docker pull elixir:1.6.6

$ docker run -it --rm elixir:1.6.6 
```

- `elixir:1.6.6`のところは、 https://hub.docker.com/_/elixir?tab=tags&page=1&ordering=last_updated から必要とするものを探してください

## [Dockerコンテナのシェルの中に入る](https://qiita.com/__cooper/items/4740c24666299c366044)
- リンク先の記事の通りです
    - ありがとうございます！

```
$ docker ps                                                        
CONTAINER ID   IMAGE          COMMAND   CREATED         STATUS         PORTS     NAMES
15bdc05bae6c   elixir:1.6.6   "iex"     9 seconds ago   Up 6 seconds             dreamy_sutherland

$ docker exec -it dreamy_sutherland bash
```

## 中に入れたらあとはもうこちらのものですね
- 以下、`mix test`する操作の一例です

```
root@15bdc05bae6c:/#

root@cbf7ce2b75e8:/# cd /root/

root@15bdc05bae6c:~# git clone https://github.com/piacerex/smallex.git

root@15bdc05bae6c:~# cd smallex/

root@15bdc05bae6c:~/smallex# git checkout -b b-afbb723449c82f9bde16bf58ba8e787d39fc6334 afbb723449c82f9bde16bf58ba8e787d39fc6334

root@15bdc05bae6c:~/smallex# HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get

root@15bdc05bae6c:~/smallex# mix test
```

- `HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get`は、私の家のインターネットが夜だと遅くなっていてですね、そんなときにこれをつけるとうまくいきます
    - 手前味噌の記事: [HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get (Elixir)](https://qiita.com/torifukukaiou/items/3890d4ea8220f44c7e0a)
    - `mix deps.get`失敗したときのメッセージに書いてあるのでそのまま試している感じです
    - これに出くわしたことがない人はいいネット環境なのでしょう
    - うらやましいです


# Wrapping Up :lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
