---
title: ElixirでS3を操る - EC2のIAMロールで画像アップロード実装
tags:
  - AWS
  - Elixir
  - 猪木
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-19T20:50:23+09:00'
id: 769b889e6561a87bf2a8
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

ElixirからAWS S3に画像をアップロードします。
EC2のIAMロールを使うので、アクセスキー不要です。

## 環境

- EC2（Ubuntu 24.04）
- IAMロール（S3アクセス権）
- mise（Elixir/Erlangインストール）

## 1. EC2起動とIAMロール設定

EC2インスタンスに以下のIAMロールを割り当てます。

**必要なマネージドポリシー:**
- `AmazonS3FullAccess` - S3操作用
- `AmazonSSMManagedInstanceCore` - SSM接続用

## 2. miseでElixirインストール

セッションマネージャーで接続します。  

```bash
sudo su - ubuntu

# miseインストール
curl https://mise.run | sh
echo 'eval "$(~/.local/bin/mise activate bash)"' >> ~/.bashrc
source ~/.bashrc

# Elixir/Erlangインストール
mise use -g erlang@28
mise use -g elixir@1.19

# 確認
elixir --version
```

## 3. プロジェクト作成

```bash
mix new s3_uploader
cd s3_uploader
```

## 4. 依存関係追加

`mix.exs`:

```elixir
defp deps do
  [
    {:ex_aws, "~> 2.6"},
    {:ex_aws_s3, "~> 2.5"},
    {:hackney, "~> 1.25"},
    {:sweet_xml, "~> 0.7"},
    {:req, "~> 0.5"}
  ]
end
```

```bash
mix deps.get
```

## 5. Lorem Picsumについて

https://picsum.photos/

ランダムなプレースホルダー画像を提供する無料サービスです。

- `https://picsum.photos/200/300` = 200×300pxのランダム画像
- アクセスするたびに違う画像
- テスト用途に最適

## 6. S3バケット作成

```elixir
iex -S mix

# バケット作成
ExAws.S3.put_bucket("my-elixir-bucket-20251119", "us-east-1")
|> ExAws.request()
```

## 7. Elixirコード実装

`lib/s3_uploader.ex`:

```elixir
defmodule S3Uploader do
  def upload(body, bucket, key) do
    ExAws.S3.put_object(bucket, key, body)
    |> ExAws.request()
  end
end
```

## 8. 実行

```elixir
iex -S mix

# 画像をダウンロード
url = "https://picsum.photos/200/300"
{:ok, response} = Req.get(url)

# S3にアップロード（パイプラインで）
bucket = "my-elixir-bucket-20251119"
key = "sample.jpg"

response.body
|> S3Uploader.upload(bucket, key)
```

## 9. 確認

```elixir
# バケット内のオブジェクト一覧
ExAws.S3.list_objects("my-elixir-bucket-20251119")
|> ExAws.request()
```

## IAMロール認証の仕組み

ExAwsは自動でEC2メタデータから一時認証情報を取得します。
アクセスキー不要！

## まとめ

- EC2のIAMロールでキー不要
- Reqで画像取得
- ExAwsでS3アップロード

## 参考

- ExAws: https://github.com/ex-aws/ex_aws
- Req: https://github.com/wojtekmach/req
