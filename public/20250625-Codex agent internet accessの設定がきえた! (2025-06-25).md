---
title: Codex agent internet accessの設定がきえた!? (2025-06-25)
tags:
  - ポエム
  - OpenAI
  - codex
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-29T12:24:02+09:00'
id: c319a3f520c035d60037
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/official-events/43ff3363e32f43d7507c

:::note info
2025/06/29 12:23現在
設定メニューがまた表示されるようになりました！！！
:::

# はじめに

[Codex](https://platform.openai.com/docs/codex/overview)をびくびくしながら使っています。  
**A**ntonio **I**nokiさんではない方のArtificial Intelligenceの方のGenerative AIになんでも見せてよいのか、と。  
同僚に相談したところ、**迷わず行けよ 行けば分かるさ**と背中を押していただいたので、使うことにしました。  

[Codex](https://platform.openai.com/docs/codex/overview)は、ざっくり言うと、GitHubのリポジトリと連携して、Agent(代理人)に自然言語でタスクを振っておけばプルリク候補を作ってくれる凄腕エージェントです。  

# Agent internet access

Agent(代理人)は作業を進めるにあたり、必要最低限のインターネットアクセスしか許可されていません。  
`git clone`や環境のセットアップです。  

だけど、コードを修正したあとに`npm test`とかするときに`jest`ですか？　なんだかのダウンロードが必要な場合があります。そういうときにインターネットアクセスが必要なわけです。インターネットアクセスには危険が伴うよ、ということで公式ドキュメントにも、設定画面にも注意喚起が書いてあります（ありました）。  

[Codex agent internet access](https://platform.openai.com/docs/codex/agent-network)

# Agent internet accessの設定がない

つい先日までは設定メニューがありました。たしかにありまして、X(旧Twitter)あたりでも大きな話題になっていました。  
しかし今日私のCodexにはその設定が見当たりません。  

![スクリーンショット 2025-06-25 22.16.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c33272d9-3e03-443b-aa25-262ed41f1caa.png)


特段大騒ぎになっているわけではないようですが、私と同じ状況の方がいらっしゃいました。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/OpenAI?ref_src=twsrc%5Etfw">@OpenAI</a> why can&#39;t I find where to enable internet access to codex in environments? i&#39;m struggling to find documentation that explains how to do this...is there a catch here?</p>&mdash; Calimanu Loredan (@CalimanuLoredan) <a href="https://twitter.com/CalimanuLoredan/status/1937811512598380824?ref_src=twsrc%5Etfw">June 25, 2025</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ChatGPTに訳してもらったところ、「なぜCodexでインターネットアクセスを有効にする設定項目が「環境（environments）」に見つからないのでしょうか？ それを説明しているドキュメントもなかなか見つけられずに困っています……。 何か見落としている“カラクリ”でもあるのでしょうか？」とのことでした。

ちなみに、私はPlusプランを使っています。

インターネットアクセスをONにしているプロジェクト環境ではあいかわらずインターネットアクセスはできるようです。  

![スクリーンショット 2025-06-25 22.19.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a8a868f1-32db-4898-be0f-70b0ace9df17.png)



# さいごに

危険は承知のうえで、Agent internet accessは結構便利なものです。  
一時的に設定が見えなくなっているのか、Proプランにあげないと使わせてもらえないのかはわかりません。

設定の場所が変わった等、なにか勘違いしていましたごめんなさい、お騒がせしました、ごめんなさいとかで、また設定をON/OFFできるようになるといいなあと思っています。

https://qiita.com/tech-festa/2025
