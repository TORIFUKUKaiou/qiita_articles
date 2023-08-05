---
title: >-
  bin/rails sしたら「`require': Could not load the 'ecto' Active Record adapter.
  Ensure that the adapter is spelled correctly in config/database.yml and that
  you've added the necessary adapter gem to your
  Gemfile.」と言われなんのことだかわからず発狂しそうになったが解決できた話
tags:
  - Rails
  - Elixir
  - Phoenix
private: false
updated_at: '2020-03-20T08:23:50+09:00'
id: 11c4e88cbeb5ecd622ca
organization_url_name: fukuokaex
slide: false
---
# はじめに
- **昨日まで動いていた**Railsのプロジェクトが動かなくなりました
- なにもしていないことはなくて、**バッチリなにかをしていました**
- が、まさかそんなところに影響がでるとはおもわず、右往左往した話です

```
`require': Could not load the 'ecto' Active Record adapter. 
Ensure that the adapter is spelled correctly in config/database.yml and 
that you've added the necessary adapter gem to your Gemfile.
```

- こんなエラーがでました
  - 指示通り、`config/database.yml`をみても不審な点は見当たりません
  - `ecto`です
  - [ecto](https://hex.pm/packages/ecto) です
  - `ecto` で[Phoenix](https://www.phoenixframework.org/)でのなにかが影響しているのだろうなあとはおもいましたが、なかなかわかりませんでした
- 私は、[Ruby on Rails](https://rubyonrails.org/)と[Elixir](https://elixir-lang.org/)のWebアプリケーションフレームワーク[Phoenix](https://www.phoenixframework.org/)をよく使っています


# 結論
- [Rubyの変数DATABASE_URLでハマった話](https://note.gosyujin.com/2016/08/31/ruby-database-url/)
- ↑こちらの記事に詳しいです
- こちらと同じく、[Phoenix](https://www.phoenixframework.org/)の作業で、環境変数`DATABASE_URL`を追加していました
- どうやらRailsが`DATABASE_URL`を読み込むようです

# なぜ追加したの？
- [Phoenix](https://www.phoenixframework.org/)のガイドの中にある[Introduction to Deployment](https://hexdocs.pm/phoenix/deployment.html#content) ここの記事の内容を写しているときに追加しました

```
export DATABASE_URL=ecto://USER:PASS@HOST/database
```
- Yay!

- `~/.zshenv` や `~/.bashrc`、`~/.bash_profile`等に追加している場合は、環境変数`DATABASE_URL`を消してターミナルを立ち上げ直してください
    - `DATABASE_URL`を消したあとに、`source ~/.zshenv`なんてやっても、**しぶとく`DATABASE_URL`は残っていますから！**
    - いわれてみればその通りなのですが、`DATABASE_URL`が怪しいと気づいたあとでも老い先短い人生の時間を浪費してしまいました
- `Could not load the 'ecto' Active Record adapter. ` は私がググった限りはでてこなかったので、ここに記しておきます
