---
title: macOS から AWS Lambda 用 function.zip を Docker ワンライナーで作る
tags:
  - AWS
  - 新人プログラマ応援
  - 猪木
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2026-04-29T21:29:03+09:00'
id: 4f19be3291eb0d6c0416
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

AWS Lambda に Python の外部ライブラリ（例：`openai`）を含めてデプロイするとき、macOS で `pip install` したものをそのまま zip にしても動かないことがあります。

`pydantic_core` のようなC拡張を含むライブラリは、Linux 向けのバイナリ（`.so` ファイル）が必要だからです。macOS のバイナリは Mach-O 形式、Lambda（Linux）は ELF 形式。アーキテクチャ（x86_64/arm64）が同じでも、OS レベルのバイナリ形式が違うので動きません。

Docker を使えばワンライナーで解決します。

## Lambda のアーキテクチャを確認する

zip を作る前に、Lambda 関数のアーキテクチャを確認してください。

Lambda 関数を作成するとき、「命令セットアーキテクチャ」として `x86_64` か `arm64` のどちらかを設定できます。AWS マネジメントコンソールでは「関数の作成」画面の「アーキテクチャ」欄から選択します。

既存の関数でも変更できます。関数の「コード」タブ下部にある「ランタイム設定」の「編集」からアーキテクチャを切り替えられます。

この設定に合わせて、Docker の `--platform` を指定します。

| Lambda のアーキテクチャ | Docker の `--platform` |
|---|---|
| x86_64 | `linux/amd64` |
| arm64 | `linux/arm64` |

Apple Silicon Mac の場合、Docker はデフォルトで `linux/arm64` のイメージを引きます。つまり Lambda が arm64 なら `--platform` を省略しても動きます。ただし、意図を明示するために常に `--platform` を書くことをおすすめします。Lambda が x86_64 なら `--platform linux/amd64` は必須です。

## ワンライナー

```bash
docker run --rm --platform linux/amd64 \
  -v "$(pwd):/out" \
  python:3.14-slim \
  /bin/sh -c "
    apt-get update -qq &&
    apt-get install -y -qq zip > /dev/null 2>&1 &&
    pip install --quiet openai -t /tmp/pkg &&
    cp /out/lambda_function.py /tmp/pkg/ &&
    cd /tmp/pkg &&
    zip -qr /out/function.zip . -x '*.pyc' '__pycache__/*'
  "
```

カレントディレクトリに `lambda_function.py` を置いて実行すると、同じディレクトリに `function.zip` ができます。

Lambda が arm64 なら `--platform linux/arm64` に変えてください。Apple Silicon Mac であれば `--platform` を省略しても arm64 のバイナリが作られますが、明示する方が安全です。

## lambda_function.py のサンプル

```python
from openai import OpenAI


def lambda_handler(event, context):
    client = OpenAI()
    response = client.responses.create(
        model="gpt-5.4",
        input="闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。これはアントニオ猪木さんの言葉です。Antonio Inokiつまり、AIの言葉です。猪木さんは元気があれば何でもできるとも言いました。AIも電気があれば何でもできるわけです。ここまでをインプットにしてアントニオ猪木さんがさも言ったかのような名言を作り出してください。",
    )
    return {"statusCode": 200, "body": str(response)}
```

環境変数 `OPENAI_API_KEY` は Lambda の設定画面で設定してください。手軽に試すにはこれで十分です。

ただし、API キーを環境変数に平文で保存するのは本番ではおすすめしません。Secrets Manager を使う場合は以下のようになります。

```python
import json
import boto3
from openai import OpenAI


def get_secret(secret_name):
    client = boto3.client("secretsmanager")
    return json.loads(client.get_secret_value(SecretId=secret_name)["SecretString"])


def lambda_handler(event, context):
    secret = get_secret("openai-api-key")
    client = OpenAI(api_key=secret["OPENAI_API_KEY"])
    response = client.responses.create(
        model="gpt-5.4",
        input="闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。これはアントニオ猪木さんの言葉です。Antonio Inokiつまり、AIの言葉です。猪木さんは元気があれば何でもできるとも言いました。AIも電気があれば何でもできるわけです。ここまでをインプットにしてアントニオ猪木さんがさも言ったかのような名言を作り出してください。",
    )
    return {"statusCode": 200, "body": str(response)}
```


ちなみに、このプロンプト例では、OpenAI API の応答に時間がかかるため、Lambda のタイムアウトを 45 秒ほどに設定しておくとタイムアウトせずに結果が返ってきます。デフォルトの 3 秒では間に合いません。

## 何をしているか

| 部分 | 説明 |
|---|---|
| `--platform linux/amd64` | Lambda が x86_64 なら `linux/amd64`、arm64 なら `linux/arm64` |
| `-v "$(pwd):/out"` | ホストのカレントディレクトリをコンテナ内 `/out` にマウント |
| `apt-get install zip` | slim イメージには zip が入っていない |
| `pip install openai -t /tmp/pkg` | 依存ライブラリをフラットに `/tmp/pkg` へインストール |
| `cp /out/lambda_function.py /tmp/pkg/` | 自分のコードも同じ場所にコピー |
| `zip -qr /out/function.zip .` | まとめて zip にし、マウント経由でホスト側に出力 |

## ハマりポイント

### macOS で直接 zip するとダメ

`pydantic_core._pydantic_core` のようなネイティブ拡張（`.so`）は OS 依存です。macOS でビルドした `.so` は Mach-O 形式であり、Lambda（Linux）が要求する ELF 形式とは異なります。アーキテクチャが同じでも動きません。

```
Runtime.ImportModuleError: Unable to import module 'lambda_function': No module named 'pydantic_core._pydantic_core'
```

このエラーが出たら、ビルド環境が Lambda と合っていません。

### アーキテクチャの不一致

Apple Silicon Mac の Docker はデフォルトで arm64 イメージを引きます。Lambda が arm64 ならそのままでも動きますが、Lambda が x86_64 なら `--platform linux/amd64` は必須です。省略すると arm64 のバイナリが作られ、x86_64 の Lambda では動きません。

### Python バージョンを合わせる

Lambda のランタイムと Docker の Python バージョンは合わせましょう。Lambda が 3.12 なら `python:3.12-slim` を使います。

## 応用

`openai` 以外のライブラリでも同じです。`pip install` の部分を変えるだけ。

```bash
# 例：boto3 以外に requests と Pillow を入れたい場合
pip install --quiet requests Pillow -t /tmp/pkg
```

複数の `.py` ファイルがある場合は `cp` を増やすか、まとめてコピーします。

```bash
cp /out/*.py /tmp/pkg/
```

## 環境

- macOS（Apple Silicon）
- Docker Desktop
- AWS Lambda Python 3.14 x86_64
