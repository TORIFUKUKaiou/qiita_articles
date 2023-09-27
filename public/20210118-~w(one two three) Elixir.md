---
title: ~w(one two three)    Elixir
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-01-18T23:21:53+09:00'
id: 2feae2b4d742923be060
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- これはご存知の方も多いとはおもいますがご紹介しておきます

# ~w
```elixir
iex> ~w(one two three) 
["one", "two", "three"]

iex> ~w(one two three) === ["one", "two", "three"]
true
```

なわけです。

- ドキュメントは https://hexdocs.pm/elixir/Kernel.html#sigil_w/2 です
- [~W](https://hexdocs.pm/elixir/Kernel.html#sigil_W/2) もあります
    - https://hexdocs.pm/elixir/Kernel.html#sigil_W/2
- [~w](https://hexdocs.pm/elixir/Kernel.html#sigil_w/2)のほうは、`#{変数}`ってのがあったときに展開されます
  - [~W](https://hexdocs.pm/elixir/Kernel.html#sigil_W/2)のほうは展開されないわけです


# Wrapping Up 🎍🎍🎍🎍🎍
- 今日は、[autoracex #3](https://autoracex.connpass.com/event/201887/)を開催していました
    - [たった一人のオリンピック](https://www.amazon.co.jp/dp/4040823869)状態です
    - [autoracex](https://autoracex.connpass.com/)ってなに？
        - https://autoracex.connpass.com/
        - 私がたちあげた[Elixir](https://elixir-lang.org/)のリモートもくもく会です
        - テーマ曲は[Elixir](https://elixir-lang.org/)の紫色にちなんで、もちろん[セクシャルバイオレットNo.1](https://www.youtube.com/watch?v=mCdbIwyVcuE)です
        - 第1回はなんとなんと日本マイクロソフト賞を受賞しちゃったりなんちゃったりしました:tada::tada::tada:
            - [autoracex はじめました (Elixir)](https://qiita.com/torifukukaiou/items/a519d326934a37ded9d9)
            - [#Qiitaアドカレ 日本マイクロソフト賞 5 名 (Azure x Python, Cloud Native)](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93) -- @chomado さん
- 23:00過ぎちゃったけど[Elixir](https://elixir-lang.org/)のことなんにもやっていなくてそれじゃあ開催したことにならんでしょ！　と急造で記事をこさえました
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:
