---
title: 実録 Nervesアプリで定期実行ができない！ cronの書き方を間違えているだけでした
tags:
  - Elixir
  - Nerves
  - 猪木
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-12-04T20:38:42+09:00'
id: eab541b850e17593deea
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
## はじめに
タイトルの通りです。

「[Raspberry Pi 2 + Nerves、5年間の連続運転で不調に → microSDカード交換で復活](https://qiita.com/torifukukaiou/items/90118093a1b9d319313e)」記事の「○日間連続でうまく動いています。」の○を自動で更新させているつもりでした。しかしうまく動いていませんでした。

内情を包み隠さず申しますと、
**実は自分でSSHにて接続し、IEx経由でたまに手動実行して更新をしていました。**

見事、解決をいたしました:tada::tada::tada:
その愛と感動の物語を余すところなくみなさまにお伝えいたしたいと思っています。

## 定期実行
定期的な実行には[Quantum](https://hexdocs.pm/quantum/readme.html)を使っています。cron式で繰り返し日時を指定できます。

## diff
変更前後。

```diff:config/config.exs
-    {"0 30 * * *", {Qiita.Qiita90118093a1b9d319313e, :run, []}},
+    {"30 0 * * *", {Qiita.Qiita90118093a1b9d319313e, :run, []}},
```

一体、30時とはいつのことでしょうか。永遠にやってくるはずのない時間を指定していました。
NervesアプリにSSHで接続をして、IExで「`Qiita.Qiita90118093a1b9d319313e.run`とやると動いているのだけどなあ」、「`config/config.exs`を変更する前のファームウェアを焼き込んでいるのかなあ」とか、あらぬ方向ばかりを向いていました。30時は永遠にやってくるはずはありません。永遠に答えにはたどり着きそうにありませんでした。


## 原因
自分でコードを書いたから。これに尽きるかもしれません。

開発業務という名の藝術活動では、専ら[Kiro CLI](https://kiro.dev/cli/)と[Codex CLI](https://developers.openai.com/codex/cli/)とチャットしているばかりです。私の国語力の高さ、指示の仕方がいいのだろうと自画自賛しておきます。

趣味のプログラムくらい自分で書こうとして、ドツボにハマってしまいました。

## どうやって気づいたのか
他にもたくさん、よくわからない定期実行の設定をたくさん書いていてそれらを眺めていると、なんだか妙なことに気づきました。あれ？　この2番目のフィールドはhourだよなあ、と。

## プロジェクト
恥をさらしておきます。全文公開しておきます。全世界に公開しています。

https://github.com/TORIFUKUKaiou/hello_nerves

何が動いているのかさっぱりわからなくなっています。専ら、このアプリが動いているRaspberry Pi 2は、Qiita記事を自動更新しつづけているマシンと化しています。

## さいごに
30時、それは永遠にやってこない時間帯です。私は人類のルールを無視してしまっていました。

完全に[Nerves](https://nerves-project.org/)に関係のある話題でしたので、「[#NervesJP Advent Calendar 2025](https://qiita.com/advent-calendar/2025/nervesjp)」に投稿（闘魂）しました。
