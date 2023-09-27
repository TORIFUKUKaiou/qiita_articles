---
title: >-
  @im_miolabさんの「GitHooksをElixir開発環境へ導入して、コミットやプッシュの際にコード検査やテストが走るようにする」にすこ〜し補足をします。git
  commit時にmix formatを自動的に行ってくれるですよ！！！
tags:
  - Elixir
  - 40代駆け出しエンジニア
private: false
updated_at: '2021-03-03T23:52:37+09:00'
id: 619a26f59639dae20e1d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか :bangbang::bangbang::bangbang:
- @piacerex さんの小粒でピリリと辛いユーティリティ群[piacerex/smallex](https://github.com/piacerex/smallex)の更新をお手伝いしています
- そのなかで`mix format`していきましょうとみんなへ呼びかけたところ、自動化できるよという話を @koyo-miyamura さんから聞きました
- そして[qgadrian/elixir_git_hooks](https://github.com/qgadrian/elixir_git_hooks)という[Hex](https://hex.pm/)が便利だよということを @zacky1972 先生に教わりました
    - [zeam-vm/pelemay_fp](https://github.com/zeam-vm/pelemay_fp/)に導入されています
- [Qiita](https://qiita.com/)に導入記事がなければ書くつもりでおりました
- <font color="purple">$\huge{すでにありました}$</font>
- じゃあ書かなくても良いわけですが、まあちょっと調べたことがあるのでそれをそのまま書いておきます
- この記事は、2021/3/15に開催予定の[autoracex #N](https://autoracex.connpass.com/event/206023/)の成果といたします

# [qgadrian/elixir_git_hooks](https://github.com/qgadrian/elixir_git_hooks)を紹介した先輩記事
- [kokura.ex](https://fukuokaex.connpass.com/)の@im_miolabさん作
- 「[GitHooksをElixir開発環境へ導入して、コミットやプッシュの際にコード検査やテストが走るようにする](https://qiita.com/im_miolab/items/7ffb1e1aeebd78477079)」
- [qgadrian/elixir_git_hooks](https://github.com/qgadrian/elixir_git_hooks)のREADMEと@im_miolabさんの[記事](https://qiita.com/im_miolab/items/7ffb1e1aeebd78477079)を見ていればほぼほぼ事足ります
- ここから先は:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:をご覧になっている前提で書きます

# 私の補足
- そもそも[Git のカスタマイズ - Git フック](https://git-scm.com/book/ja/v2/Git-%E3%81%AE%E3%82%AB%E3%82%B9%E3%82%BF%E3%83%9E%E3%82%A4%E3%82%BA-Git-%E3%83%95%E3%83%83%E3%82%AF)というものがあります
    - 私は今日知りました
    - `.git/hooks`配下にあるスクリプトがアレしてナニしてくれるわけです
    - 最初は`.sample`というファイルが置いてあります
    - 詳細はリンク先をご参照ください
- `config/config.exs`に`:git_hooks`の設定を書いておいて、`mix git_hooks.install`をすると以下のファイルができます
    - `.git/hooks/pre-commit`
    - `.git/hooks/pre-push`
- 中身は以下のようになっています

```:.git/hooks/pre-commit
#!/bin/sh

mix git_hooks.run pre_commit "$@"
[ $? -ne 0 ] && exit 1
exit 0
fi
```

```:.git/hooks/pre-push
#!/bin/sh

mix git_hooks.run pre_push "$@"
[ $? -ne 0 ] && exit 1
exit 0
fi
```

- これらが`git commit`や`git push`コマンドの際にフックされてmixタスクが実行されるという仕組みです

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm: 
- `mix format`とかちょっとしたことではあるけれども必ずやることにするならこういう仕組みを導入して自動化するのはいいですね
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:

# (最後の最後に)[Elixir](https://elixir-lang.org/)ってなによ？ という方へ

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/601aeb87-9d1d-6a9d-b30b-338507dc593e.png)

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 2020/12/26時点くらいのスクリーンショット
- [Elixir](https://elixir-lang.org/)についてもっと知りたい方は下記の本:books:をオススメします
    - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
    - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
- [elixir.jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)の`#autoracex`というところに私は入り浸っておりますのでお気軽にお声がけください

 
