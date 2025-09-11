---
title: 燃える闘魂HTML！GPT-5×Firebaseで中毒ゲームが一瞬で完成した話
tags:
  - Firebase
  - 猪木
  - 闘魂
  - GPT-5
  - AIではなく人間が書いてます
private: false
updated_at: '2025-08-08T18:24:47+09:00'
id: 7eada472173c6da298f9
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

皆さん、元氣ですかーッ！！！
巷で噂のGPT-5発表ページ: [Introducing GPT-5](https://openai.com/index/introducing-gpt-5/)
そこに書かれている「魔法の呪文」をそのままプロンプトに放り込んでみたところ、なんと、動くゲームが爆誕しました。

この妙に中毒性があるゲームに心を奪われ、気づけばずっとピョンピョンしています。そんな私がいてもたってもいられず、即座にFirebase Hostingで公開することにしました。これが、私の「闘魂デプロイ」の始まりです。そんなお話をしたいと思います。

## 魔法の呪文（プロンプト）

[Introducing GPT-5](https://openai.com/index/introducing-gpt-5/) に書いてある呪文をそのまま打ち込みました。

> Prompt: Create a single-page app in a single HTML file with the following requirements:
> - Name: Jumping Ball Runner
> - Goal: Jump over obstacles to survive as long as possible.
> - Features: Increasing speed, high score tracking, retry button, and funny sounds for actions and events.
> - The UI should be colorful, with parallax scrolling backgrounds.
> - The characters should look cartoonish and be fun to watch.
> - The game should be enjoyable for everyone.



それだけです。できあがりました :tada::tada::tada:

![GPT5-JumpingGame.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f8db77e0-442c-497e-bdc7-74b6cccdf931.png)

1つの.htmlファイルだけで構成されています。

プロンプトの例は、他にもたくさん紹介されています。[more examples by GPT‑5](https://platform.openai.com/docs/guides/latest-model?gallery=open)

GPT-5は、 **「[史上最も賢く、最速で、最も役立つモデルであり、予め組み込まれた思考機能によって専門家レベルの知性を誰もが手にできます。](https://openai.com/ja-JP/index/introducing-gpt-5/)」** とのことです。

ちなみに、私は[Web版のChatGPT](https://chatgpt.com/?model=gpt-5)で、GPT-5が使えました。macOS版のアプリには、まだ来ていませんでした。Plusプランです。

https://chatgpt.com/?model=gpt-5

あと、気付いたこととしては、1つのチャットの中で話せる量を少なく感じました。私は同じチャットの中で延々と話をつづけて、いろいろな話題をごちゃまぜに話す使い方をします。ここではそれがいいのか、良くないのかは置いておきます。1チャットの中で話せる量が、あくまでも私比で少なかったように思います。うまく言えませんが、途中から全然ちゃんと応答を返さなくなりました。全然何も考えずに提携文みたいなものを即レスで返すようになりました。チャットを新しく作るときちんと応答するようになりました。リリース直後ですし、私だけの感じ方かもしれませんし、一時的なことかもしれません。 **どうも一時的なものだったようです。気のせいです。**

## 闘魂デプロイ

妙に中毒性があるゲームに心を奪われ、気づけばずっとピョンピョンしています。
全世界の人と分かち合いたくなりました。それで久しぶりに[Firebase Hosting](https://firebase.google.com/docs/hosting?hl=ja)を利用してデプロイすることにしました。
だいぶ前から使っています。2016年ころから私の[自己紹介ページ](https://www.torifuku-kaiou.app/)で使っています。

この記事では、[Firebase Hosting](https://firebase.google.com/docs/hosting?hl=ja)の使い方は主題ではありませんし、私はJavaScript系を仕方なく、おっかなびっくりで使っているだけで、`nvm`と`npm`、`node`をはて、どれだったけ？　といつも間違いながら使っている[^1]くらいですので、説明しようにもできませんし、そのへんはお詳しい方の記事ですとか、公式ページにお任せすることにします。

[^1]: ただ、最近はGenerative AI君のおかげで、`y`とだけ押しているうちに事は進んでいます。余談です。

同じようなお困りごとに遭遇する方がいらっしゃるのかどうかは定かではありませんが、全人類の中で少なくとも私一人は困りましたので、記事に残しておきます。エラー文の肝を貼っておくことでいつかどなたかの役に立つことがあると思いますし、Generative AIsさんたちにトラブルシューティングとして学んでほしいと思っています。

### firebase not found

まず`firebase`コマンドが使えませんでした。たぶん、`nvm`で最新以外は`uninstall`したことと、いま`use`している`node`のバージョンでインストールした記憶がないのでインストールできていないだけでしょう。

これは楽勝です。インストールすればいいのです。  

```bash
npm install -g firebase-tools
```

### firebase deployが失敗

`firebase`コマンドが使えるようになりましたので喜び勇んで、`firebase deploy`をしてみました。ディレクトリの中にREADMEが置いてあって、それにそう書いてありました。`firebase deploy`するだけだと。READMEを残しておいた過去の自分に感謝しつつ、実行してみました。果たして結果やいかに。

うまくいきません。

```bash
Error: Assertion failed: resolving hosting target of a site with no site name or target name. This should have caused an error earlier

Having trouble? Try again or contact support with contents of firebase-debug.log
```

指示された通りに、`firebase-debug.log`をみてみます。`firebase deploy`コマンドを実行した同じディレクトリに置かれていました。

ログのポイントはこのへんでしょう。

```
[debug] [2025-08-07T20:07:04.288Z] <<< [apiv2][status] POST https://cloudresourcemanager.googleapis.com/v1/projects/admob-app-id-xxxxxxxxxxx:testIamPermissions 401
[debug] [2025-08-07T20:07:04.289Z] <<< [apiv2][body] POST https://cloudresourcemanager.googleapis.com/v1/projects/admob-app-id-xxxxxxxxxxx:testIamPermissions {"error":{"code":401,"message":"Request had invalid authentication credentials. Expected OAuth 2 access token, login cookie or other valid authentication credential. See https://developers.google.com/identity/sign-in/web/devconsole-project.","status":"UNAUTHENTICATED","details":[{"@type":"type.googleapis.com/google.rpc.ErrorInfo","reason":"ACCESS_TOKEN_TYPE_UNSUPPORTED","metadata":{"method":"google.cloudresourcemanager.v1.Projects.TestIamPermissions","service":"cloudresourcemanager.googleapis.com"}}]}}
[debug] [2025-08-07T20:07:04.289Z] Got a 401 Unauthenticated error for a call that required authentication. Refreshing tokens.
```

...ちくしょう、HTTP Error: 401だと！？「認証情報が無効です」というメッセージ。「ずっと更新していなかったのがバレる」と内心ヒヤヒヤしていましたが、まさにそれが原因だったようです。Firebaseの認証情報が期限切れになっていたんですね。

その後、`firebase login --reauth`してから、デプロイ(`firebase deploy --only hosting`)すると、今度はうまくいきました :tada::tada::tada: さらっと書いていますが、本当はいろいろと明後日の方向に試行錯誤をしていたことをお披露目しておきます。GPT-5がアプリを作ってくれた時間以上にデプロイの問題解決の方に時間がかかりました。

解決へと導いてくださったのは次の記事です。この場をお借りして御礼申し上げます。

[FirebaseのCliでの操作で401系エラーが出るときの解決法](https://zenn.dev/satohjohn/articles/d409819196c6b8)


### firebase-debug.log

エラー解決へと導いてくれた`firebase-debug.log`ファイルに感謝です。記事を書くにあたりもう１回中身をみようと思いました。

しかし、ありません。
成功したら潔くさっと去っています。
デプロイが成功した瞬間、さっきまで確かにそこにいたはずの**firebase-debug.log**は、跡形もなく消えていました。

まるで、砂漠に遺した足跡。風が吹いたら消え去るだけーー（:book:『[最後の闘魂](https://www.amazon.co.jp/dp/4833481057)』:fire:アントニオ猪木:fire:）。


役目を終えると、静かに去っていったのです。


## まとめ

この記事は以下の2点を書きました。

- GPT-5を利用して、プロンプトだけで妙に中毒性のあるゲームが本当にできあがりました
- [Firebase Hosting](https://firebase.google.com/docs/hosting?hl=ja)で、できあがった.htmlファイルを全世界へ向けて公開しました


さて、私のAIは一味違います。**A**ntonio **I**nokiさんのほうのAIです。
私のプロンプトは「Token」を消化しません。なぜなら「Toukon（闘魂）」へと昇華させているためです。
けれど、「燃える闘魂(Toukon)」で燃えてあがってしまい、結局のところ「Token」は消化されてしまいます。

公開したゲームはこちらです。ぜひ遊んでみてください！そして、中毒性にご注意を！

[Jumping Ball Runner](https://www.torifuku-kaiou.app/games/JumpingBallRunner-SingleFile.html)

https://www.torifuku-kaiou.app/games/JumpingBallRunner-SingleFile.html
