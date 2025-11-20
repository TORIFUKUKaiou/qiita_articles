---
title: 私のKiro CLI(旧Amazon Q Developer CLI)の起動方法を大公開
tags:
  - AWS
  - AmazonQ
  - AmazonQCLI
  - Kiro
  - KiroCLI
private: false
updated_at: '2025-11-19T08:26:13+09:00'
id: b23538894e706a000410
organization_url_name: null
slide: false
ignorePublish: false
---
:::note info
**Qiita Advent Calendar 2025**
今年もこの季節がいよいよ始まりました :tada::tada::tada:
誰よりもこの日を待ちわびていたと自負しております。

2024年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

## はじめに
私のKiro CLI(旧Amazon Q Developer CLI)の起動方法を大公開します。

![スクリーンショット 2025-11-18 20.38.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/05f73688-0ddd-415f-ba7c-a5f0d145901a.png)


## 設定ファイル
設定ファイルを大公開します。

「[Welcome to AWS MCP Servers](https://awslabs.github.io/mcp/)」を読んで設定しました。AWSの最新ドキュメントを見てくれるようになるので、生成AIモデルのカットオフ日によって知識が古い問題を解消できます。

設定ファイルは、`~/.kiro/settings/mcp.json`に書きます。

```json:~/.kiro/settings/mcp.json
{
  "mcpServers": {
    "aws-knowledge-mcp-server": {
      "args": [
        "fastmcp",
        "run",
        "https://knowledge-mcp.global.api.aws"
      ],
      "command": "uvx"
    },
    "awslabs.aws-documentation-mcp-server": {
      "args": [
        "awslabs.aws-documentation-mcp-server@latest"
      ],
      "autoApprove": [],
      "command": "uvx",
      "disabled": false,
      "env": {
        "AWS_DOCUMENTATION_PARTITION": "aws",
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    },
    "awslabs.cdk-mcp-server": {
      "args": [
        "awslabs.cdk-mcp-server@latest"
      ],
      "autoApprove": [],
      "command": "uvx",
      "disabled": false,
      "env": {
        "FASTMCP_LOG_LEVEL": "ERROR"
      }
    }
  }
}
```

## Kiro CLI(旧Amazon Q Developer CLI)の起動方法
Kiro CLI(旧Amazon Q Developer CLI)の起動方法を大公開します。
AWS MCP Serversはがんがん使って欲しいので、trust(信頼)しておきます。

```bash
kiro-cli chat --resume --trust-tools=@aws-knowledge-mcp-server/aws___read_documentation,@aws-knowledge-mcp-server/aws___recommend,@aws-knowledge-mcp-server/aws___search_documentation,@aws-knowledge-mcp-server/aws___list_regions,@aws-knowledge-mcp-server/aws___get_regional_availability,@awslabs.aws-documentation-mcp-server/read_documentation,@awslabs.aws-documentation-mcp-server/recommend,@awslabs.aws-documentation-mcp-server/search_documentation
```


:::note warn
単なる思い出ですが、`q`で起動していたのがもはや懐かしいです。
:::

## Kiro CLI(旧Amazon Q Developer CLI)とは?
説明が前後しますが、Kiro CLIの説明をします。

その前に、旧Amazon Q Developer CLIから語らせてください。
Amazon Q Developerは、ソフトウェア開発のための、生成 AI を活用した極めて有能なアシスタントです。VS Codeなどに拡張機能をインストールして利用するIDE統合版とCLI版があります。私はCLI版の方を愛用しています。IDE統合版の方はあまり利用していません。他には、旧称で[Fig](https://fig.io/)と呼ばれていた賢いターミナルで使えるコマンド補完機能がもれなくついてきます。

Amazon Q Developer CLIは、Codex CLIに似ています。私は利用したことがありませんが、Claude Codeとも似ているのではないかと思います。

**Amazon Q Developer CLIは、Kiro CLIになりました。**

### 最大の魅力は月額の安さでほぼ体感使い放題 => 過去の話です => 10,000回です
$19/月です。

昔話をします。あくまでも昔話です。
体感ほぼ使い放題です。
いきなりタイトルと矛盾しますが、使い放題かというと残念ながら上限はあります。私はひっかかったことがあります。それでも月末のわずかな日数だったのでなんとか乗り切りました。どうでもいいチャットでもなんでもかんでもAmazon Q Developer CLIに放り込んでいました。さすがに使い放題ではありませんでした。

最新情報は、「Included (with limits)」で、その回数は下記ドキュメントによると、月あたりの上限は10,000回のようです。

https://docs.aws.amazon.com/general/latest/gr/amazonqdev.html#amazonqdev_quotas_pro

![スクリーンショット 2025-11-18 21.17.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6b1e9d5d-72a3-4723-8ca5-b073b2646b1d.png)


### 料金ページは流動的
https://aws.amazon.com/q/developer/pricing/?p=qdev&z=subnav&loc=7
このページの「Included agentic requests (Q&A chat, agentic coding)」が、Amazon Q Developer CLIの料金体系のことを指していると思われます。

- Included (with limits): 2025/11/18現在
- Additional usage included till November, 2025: つい先日までの記述。現在は特別期間で、12月以降は別料金となりそうな言い方でこの言い方が8月ころから常に期限が延期されています。現在は一周まわっている気がします
- Included: 2025/7くらい

この話は、どうでもよくなりました。みるべきところが変わるかもしれません。今日現在は$19/月のProプランで私は使用できています。

### Kiroとの違いは？
Amazonさんと言えば[Kiro](https://kiro.dev/)もありますよね。そちらとの違いは何でしょうか。昨日時点の私のでは全然別物であるというのが私の理解でした。しかし、Amazonさんの中では両者は統合される方向であることであることで、間違いなさそうです。というのも次の2つを観測しています。と、さも最新情報を語っている風ですが、だいぶ時代遅れでした。

> The Q CLI has become the Kiro CLI.

![スクリーンショット 2025-11-18 20.34.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ae8dfe5a-5d18-422c-aa99-8e0e0ccd8633.png)

> Amazon Q Developer CLI は廃止され、Kiro CLI に統合されました！
https://dev.classmethod.jp/articles/kiro-ga-announcement-kiro-cli/

せっかくなので書こうとしていたことをそのまま書きます。


#### AWSコンソール上では、Kiroというメニューにぶら下がっている

![スクリーンショット 2025-11-18 20.05.09.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b4dbbeac-7a51-4934-87ba-355e518a1cf8.png)

気づいたら、「Kiro > Amazon Q Developer」という構成にいつの間にかなっていました。本当にいつの間にかこうなっていました。

#### Kiro CLI
Kiro CLIがでました！

- [Kiro CLI の紹介：Kiro エージェントをあなたのターミナルへ](https://aws.amazon.com/jp/blogs/news/introducing-kiro-cli/)
- [【アップデート】 Kiro一般提供開始！ Amazon Q Developer CLI は Kiro CLI へ統合されました](https://dev.classmethod.jp/articles/kiro-ga-announcement-kiro-cli/)

## さいごに
Amazon Q Developer CLIは、Kiro CLIになりました。
私の起動方法を大公開しました。
