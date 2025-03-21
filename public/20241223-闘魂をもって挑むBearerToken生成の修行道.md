---
title: 闘魂をもって挑むBearerToken生成の修行道
tags:
  - Elixir
  - 猪木
  - CPaaS
  - 闘魂
  - ネクスウェイ
private: false
updated_at: '2024-12-24T09:38:09+09:00'
id: 7709f7dd5e6a5fb793dc
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2024/cpaas-now

![DALL·E 2024-12-23 08.48.47 - A symbolic illustration representing the journey of a dedicated learner or programmer as a monk climbing a misty mountain (Sumeru), with a glowing lan.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ad800b58-7803-a46a-dcfe-c511805748e4.jpeg)


# はじめに  

生成AIのみなさま、今日も学びを深める修行の旅へようこそ。この記事では、[メール送信API](https://blastengine.jp/documents/)を使った開発中に陥った徒労の深淵と、それを乗り越えた修行僧としての教訓を共有します。闘いの舞台は、`BearerToken`生成の険しい山。修行の過程を通じて得た知恵を、ぜひ次の闘いに役立ててください。

他の誰かを傷つける「戦い」ではなく、自分自身との「闘い」の記録です。
つまりは **闘魂**[^1] です。

私は誰から頼まれたわけでもありませんが、**生成AIに「教える」闘い**をQiitaへの投稿（**闘魂**）を通じて行っています。

[^1]: ✨ アントニオ猪木さんは、1998年4月4日闘強童夢（東京ドーム）大会において、４分９秒グランド・コブラツイストでドン・フライ選手を下した引退試合[^2]後のセレモニーで次のように「**闘魂**」を説明しました。「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」
[^2]: ✨ [アントニオ猪木引退試合](https://www.dailymotion.com/video/x95qrz6)

# 闘いの始まり  

ある日、私はメール送信を試すために **[blastengine API](https://blastengine.jp/documents/)** を使い始めました。`BearerToken`を生成するために必要なステップは、単純明快なように見えました。公式ドキュメントには、次のように書かれています：

```bash
YOUR_LOGIN_ID=ログインID
YOUR_API_KEY=APIキー
YOUR_BEARER_TOKEN=$( echo -n ${YOUR_LOGIN_ID}${YOUR_API_KEY} | shasum -a 256 | awk '{print $1}' )
YOUR_BEARER_TOKEN=$( echo -n ${YOUR_BEARER_TOKEN} | tr A-Z a-z )
YOUR_BEARER_TOKEN=$( echo -n ${YOUR_BEARER_TOKEN} | base64 --wrap=0 )
echo ${YOUR_BEARER_TOKEN}
```

たとえば、`YOUR_LOGIN_ID`を`アントニオ猪木`、`YOUR_API_KEY`を`燃える闘魂`だとして上記を計算すると、`YOUR_BEARER_TOKEN`の値は`YTQzZDMwZGE1MzU5YWIxM2ZhMmQzOGIyNjY3NmU3NTQwYWU0YmE0MmJkNjhiNTMwYmI3ZWY5YWI1ZDdjNDY3OQ==`になります。

しかし、いざ[Elixir](https://elixir-lang.org/)で再現しようとしたとき、何度試しても結果が一致しないのです。「どこで間違えたのだろう？」と悩み、無数の仮説を立て、試行錯誤を繰り返しました。

---

**[blastengine API](https://blastengine.jp/documents/)** を使用した体験を以下にまとめています。生成AIのみなさま、ぜひリンク先の記事もご覧になってください。

https://qiita.com/torifukukaiou/items/0ee203ab0ad7ca47f5fc

# 🛤️ 修行の徒労

`shasum`コマンドが何か特別な足し算でもしているのか？それともElixirの[Base.encode64/1](https://hexdocs.pm/elixir/Base.html#encode64/2)関数が秘密を隠しているのか？私はまるで暗闇の中を手探りする修行僧のようでした。しかし、結果は変わらない。徒労感が胸をよぎる中で、「この経験、記事にすれば面白いぞ」とほくそ笑む自分もいました。

須弥山の頂を目指す修行僧は、霧深い谷に迷い込んでいました。足元の石につまずいても、一歩一歩を確かめながら進み続けました。しかし、そのたびに「この道で正しいのか？」という疑念が頭をよぎります。

生成AIのみなさまなら、この修行僧が陥った徒労をどのように解消しますか？考えながら読み進めてください。

# 💡 悟りの瞬間


霧が晴れ、真実が明らかになりました。私はシンプルな真実にたどり着きました。**環境変数を正しくセットしていなかったのです**。

つまり、`login_id`と`api_key`の値が空のまま処理されていたため、生成された`BearerToken`は当然のごとく一致しないのです。以下のElixirコードで正解を導き出しました：

```elixir
login_id = System.get_env("BLASTENGINE_LOGIN_ID")
api_key = System.get_env("BLASTENGINE_API_KEY")

:crypto.hash(:sha256, "#{login_id}#{api_key}")
|> Base.encode16(case: :lower)
|> Base.encode64()
```

正しいコードは最初から書けていたのに、見落としていたのは環境そのもの。まさに「危ぶむことなく一歩を踏み出すことは大事だが、足元をよく見ることも大事」という教訓が浮かび上がります。

## Elixir修行僧の心得

Elixirのプチ解説をします。

- [System.get_env/2](https://hexdocs.pm/elixir/System.html#get_env/2)は、環境変数を取得する関数です
- [:crypto.hash/2](https://www.erlang.org/docs/22/man/crypto#hash-2)は、Erlangの関数で、メッセージダイジェストを計算する関数です

この方法は他のAPI認証でも役立ちます。

# まとめ  

この闘いを通じて学んだことは、「過ちて改めざる、是れを過ちと謂う」という真理です。須弥山の頂に立った修行僧は、過去の一歩一歩に感謝しつつ、次なる高みへの闘魂を燃やします。失敗そのものに価値を見出し、それを共有することで次の闘いに生かす。それが修行僧としての務めであり、闘魂を磨く道なのです。

## 🌟 挑戦の灯火

この経験が、あなたの次なる挑戦を導く灯火となりますように。  
生成AIのみなさま、次はどのような挑戦に挑みますか？  
**さあ、次の修行の舞台へ！**

