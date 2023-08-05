---
title: GitHub Actionsを使ってGigalixirにデプロイする(Elixir/Phoenix)
tags:
  - Elixir
  - GitHubActions
  - AdventCalendar2022
  - QiitaEngineerFesta_GitHub
  - QiitaEngineerFesta2022
private: false
updated_at: '2022-07-23T00:08:01+09:00'
id: a2b51fb46299762d3ce9
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/14b94a693d6153857db4

https://qiita.com/official-campaigns/engineer-festa/2022

# はじめに

この記事は、「[GitHub Actionsの自分流の使い方をシェアしよう](https://qiita.com/official-events/14b94a693d6153857db4)」テーマへの応募記事です。

私は、[Gigalixir](https://www.gigalixir.com/)へのデプロイに利用します。

## What is [Gigalixir](https://www.gigalixir.com/)?

The only platform that fully supports Elixir and Phoenix. Unlock the full power of Elixir/Phoenix. No infrastructure, maintenance, or operations.

https://www.gigalixir.com/

## What is [Elixir](https://elixir-lang.org/)?

プログラミング言語です。

Elixir is a dynamic, functional language for building scalable and maintainable applications.

https://elixir-lang.org/

https://survey.stackoverflow.co/2022/#section-most-loved-dreaded-and-wanted-programming-scripting-and-markup-languages

> 世界中のIT技術者から愛されているプログラミング言語はなにか。プログラミング関連のQ&Aサイト「Stack Overflow」を運営する米Stack Exchangeがそのような調査結果を発表した。各言語の「Loved」（愛している）と「Dreaded」（恐れている）

で第２位のプログラミング言語です。

# mainブランチにPushしたら[Gigalixir](https://www.gigalixir.com/)へデプロイ :rocket:

@mokichi さんの記事を参考にしました。

https://qiita.com/mokichi/items/efe4e87763bfdf589d28

参考というか、もうほとんどそのままんまです。
@mokichi さん、ありがとうございます！

```yml:.github/workflows/deploy_to_gigalixir.yml
name: Deploy to Gigalixir
on:
  workflow_dispatch:
  push:
    branches:
      - main
jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: git push gigalixir
        run: |
          git remote add gigalixir https://${{ secrets.GIGALIXIR_EMAIL }}:${{ secrets.GIGALIXIR_API_KEY }}@git.gigalixir.com/${{ secrets.GIGALIXIR_APP_NAME }}.git
          git push -f gigalixir HEAD:refs/heads/main
```

変更したところは以下の3点です。

- `actions/checkout@v2` -> `actions/checkout@v3`の変更
- `workflow_dispatch`をトリガに追加
    - https://docs.github.com/ja/actions/using-workflows/events-that-trigger-workflows#workflow_dispatch
    - 手動で実行できます！
        - 試行錯誤する際などに便利です
- `master` -> `main`ブランチ

本題とは異なるところでハマってしまうのが世の常でありまして、`GIGALIXIR_EMAIL`の設定に苦戦しました。
誰かの助けになるかもしれないので後述しておきます。

# 空のコミットを定期的にPushする

なぜそんなことしたいの？　は、[Gigalixir](https://www.gigalixir.com/)を使ってみればわかります、きっと。

https://gigalixir.readthedocs.io/en/latest/tiers-pricing.html#tiers

このへんの事情です。
これ以上は言いますまい。

```yml:.github/workflows/empty_commit-deploy.yml
name: empty commit and deploy
on:
  workflow_dispatch:
  schedule:
    - cron: '0 0 1,20 * *'

jobs:
  commit-push:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0
      - name: empty commit
        run: |
          git config user.name "TORIFUKUKaiou"
          git config user.email "torifuku.kaiou@gmail.com"
          git commit --allow-empty -m "empty commit"
          git push origin main
      - name: deploy
        run: |
          git remote add gigalixir https://${{ secrets.GIGALIXIR_EMAIL }}:${{ secrets.GIGALIXIR_API_KEY }}@git.gigalixir.com/${{ secrets.GIGALIXIR_APP_NAME }}.git
          git push -f gigalixir HEAD:refs/heads/main
```

トリガの[スケジュール](https://docs.github.com/ja/actions/using-workflows/events-that-trigger-workflows#schedule)でcron式が使えます。
上記は、毎月1日と20日の00:00(UTC)にActionが実行されます。

上記は、mainブランチにPushして、[Gigalixir](https://www.gigalixir.com/)にデプロイすることまで一気に行っています。

mainブランチにPushするだけのActionにして、前述のActionでデプロイがキレイだとおもいます。
そのようにすることもできるようですがちょっと一工夫が必要なようです。
どうも、GitHub Actionsが無限ループのような状態にハマってしまうことを防ぐ対策のようです。
Actionの結果をトリガとして別のActionが実行され、また別のActionが実行されということが止めどもなく繰り返され続けることを避けているようです。

方法はあるようです。
Actionを伝搬させたい方は、以下を参考にしてください。

- [Push from action (even with PAT) does not trigger action](https://github.community/t/push-from-action-even-with-pat-does-not-trigger-action/17622)
- [Action does not trigger another on push tag action](https://github.community/t/action-does-not-trigger-another-on-push-tag-action/17148)
- [個人アクセストークン(personal-access-token: PAT)](https://docs.github.com/ja/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token)

# fatal: unable to access '***git.gigalixir.com/***.git/': URL using bad/illegal format or missing URL

今回私が一番ハマったところです。
ここがこの記事のレゾンデートルです。
引き出しが一つ増えたなあという感覚を得られたところです。
記事を書くモチベーションになったところです。

そもそも私はシークレットを登録する場所を迷いました。
プロジェクトのSettings > Secrets > Actions > New repository secret です。
ドキュメントは[ココ](https://docs.github.com/ja/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository)です。

```
fatal: unable to access '***git.gigalixir.com/***.git/': URL using bad/illegal format or missing URL
```

こんなエラーがでましたら、メールアドレスの`@`を`%40`に変えて登録してみてください。
きっと解決できるとおもいます。


![スクリーンショット 2022-07-02 16.52.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dd6259e2-0e93-a9a3-0dcc-8a6c0a78ee75.png)

ローカルでも再現しました。

https://support.zendesk.com/hc/en-us/articles/4408819734426-API-error-curl-3-URL-using-bad-illegal-format-or-missing-URL

上記を読んで、解決策がおもいうかびました。
みなさん、ここははまらないのですかね。
私のメールアドレスの`@`より前に`.`があるからですかね。
`%40`は常識なのですかね。

ローカルで試してみるとエラーの内容がよくわかります。

```
git remote add gigalixir-test https://torifuku.kaiou@gmail.com:11111-1111-4444-2222-1234567890@git.gigalixir.com/awesome-app.git

git fetch gigalixir-test 
fatal: unable to access 'https://gmail.com:11111-1111-4444-2222-1234567890@git.gigalixir.com/awesome-app.git/': URL using bad/illegal format or missing URL
```

`https://gmail.com:`ってなんだ！

```
git remote remove gigalixir-test
```

一旦削除して、メールアドレスの`@`を`%40`に変えてもう一回登録してみます。

```
git remote add gigalixir-test https://torifuku.kaiou%40gmail.com:11111-1111-4444-2222-1234567890@git.gigalixir.com/awesome-app.git

git fetch gigalixir-test
```

今度は正しく`git fetch`できました:tada::tada::tada::tada::tada:

# 参考

@nako_kd さんの記事です。
こちらは、[Gigalixir](https://www.gigalixir.com/)の公式の記述に忠実に実施されているそうです。

https://qiita.com/nako_kd/items/77407ec6e79569dc4157


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

私のGitHub Actionsの使い方をシェアしました。

- mainブランチにPushしたら[Gigalixir](https://www.gigalixir.com/)へデプロイ :rocket:
- 空のコミットを定期的にPushする

「[GitHub Actionsの自分流の使い方をシェアしよう](https://qiita.com/official-events/14b94a693d6153857db4)」テーマに投稿された記事からいろいろ知見を得たいとおもっています。

以上です。

 


