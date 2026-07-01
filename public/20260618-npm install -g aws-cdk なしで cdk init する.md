---
title: npm install -g aws-cdk なしで cdk init する
tags:
  - AWS
  - TypeScript
  - CDK
  - 猪木
  - 闘魂
private: false
updated_at: '2026-07-01T08:08:16+09:00'
id: 09a7816a08fec5b50ba1
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

AWS CDK の公式の案内では、AWS CDK の TypeScript プロジェクトを作るとき、 `npm install -g aws-cdk` をするように書いてあります。

https://docs.aws.amazon.com/cdk/v2/guide/getting-started.html

私は、 `npm install -g aws-cdk` はしたくありませんでした。

グローバル環境に何が入ったのかわからなくなるのを避けたかったためです。

今回は [Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) 内で、`npm install -g aws-cdk` なしに CDK TypeScript プロジェクトを作りました。

この記事で書きたいことは次の2つです。

- `npm install -g aws-cdk` なしでも `npx aws-cdk init app --language typescript` で始められる
- `cdk init` は実行ディレクトリ名をもとに名前を付ける

## Dev Container

`Dockerfile` は次のようにしました。

```Dockerfile
FROM mcr.microsoft.com/devcontainers/typescript-node:24-bookworm

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libasound2 \
        libatk-bridge2.0-0 \
        libatk1.0-0 \
        libcups2 \
        libdbus-1-3 \
        libdrm2 \
        libgbm1 \
        libgtk-3-0 \
        libnss3 \
        libx11-xcb1 \
        libxcomposite1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxrandr2 \
        libxss1 \
        libxtst6 \
        xdg-utils \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://github.com/AikidoSec/safe-chain/releases/latest/download/install-safe-chain.sh \
        | sh -s -- --ci --install-dir /usr/local/.safe-chain \
    && chown -R node:node /usr/local/.safe-chain \
    && chmod -R u+rwX,go+rX /usr/local/.safe-chain

ENV PATH="/usr/local/.safe-chain/shims:/usr/local/.safe-chain/bin:${PATH}"
```

[AikidoSec/safe-chain](https://github.com/AikidoSec/safe-chain/) を利用しています。

`devcontainer.json` は次のようにしました。

```json
{
  "name": "Awesome Project",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "workspaceFolder": "/workspace",
  "workspaceMount": "source=${localWorkspaceFolder},target=/workspace,type=bind,consistency=cached",
  "forwardPorts": [
    5173
  ],
  "customizations": {
    "vscode": {
      "extensions": [
        "dbaeumer.vscode-eslint",
        "esbenp.prettier-vscode"
      ]
    }
  },
  "remoteUser": "node",
  "postCreateCommand": "npm config list"
}
```

`.npmrc` は次のようにしました。

```ini
engine-strict=true
ignore-scripts=true
audit=true
min-release-age=7
registry=https://npm.flatt.tech
```

[Takumi Guard](https://flatt.tech/takumi/features/guard) も使っています。

## npm install -g aws-cdk はしない

空のディレクトリを作って、その中で `cdk init` を実行します。

```bash
npx aws-cdk init app --language typescript
```

これで、`aws-cdk` をグローバルインストールせずに CDK TypeScript プロジェクトを作れました。

## ディレクトリ名が使われる

ここで知ったことがあります。

`cdk init` は、実行したディレクトリ名をもとに名前を付けます。

今回、Dev Container 内で実行しました。

`"workspaceFolder": "/workspace"` を指定していたため、`cdk init` は `/workspace` というディレクトリ名をもとに生成名を付けました。

すると、生成されるファイル名やクラス名にも、そのディレクトリ名をもとにした名前が使われます。

実は、`cdk init --help` を確認すると、任意のプロジェクト名を指定するための `--project-name` (`-n`) オプションが定義されています。

```bash
  --project-name, -n                The name of the new project         [string]
```

しかし、手元のバージョンでは --project-name が表示されるものの、期待どおりには反映されませんでした。ソースを見ると `projectName: args.name` となっており、 `args.projectName` を参照していないように見えます。

そのため、初期化時にプロジェクト名を指定する手段は実質的に機能しておらず、やはり最初のディレクトリ名は意外と大事です。

## まとめ

- `npm install -g aws-cdk` なしでも `npx aws-cdk init app --language typescript` で始められる
- `cdk init` は実行ディレクトリ名をもとに名前を付ける
- 初期化時にプロジェクト名を指定する `--project-name` オプションはあるが、動作しないようにみえる（？）

地味ですが、CDK プロジェクトを作り始める前に知っておくとよさそうです。

## 追記

その後、`cdk init --project-name` が期待どおり反映されない件について、AWS CDK CLI に Pull Request を送り、マージされました。

`aws-cdk@2.1128.1` 以降では、次のように実行ディレクトリ名とは別のプロジェクト名を指定できます。

```bash
npx aws-cdk@latest init app --language typescript --project-name awesome-cdk
```

詳しくは次の記事に書きました。

- [`cdk init --project-name` で実行ディレクトリ名以外のプロジェクト名を指定できるようにした話](https://qiita.com/torifukukaiou/items/d01fca30d48a777e6a3d)
