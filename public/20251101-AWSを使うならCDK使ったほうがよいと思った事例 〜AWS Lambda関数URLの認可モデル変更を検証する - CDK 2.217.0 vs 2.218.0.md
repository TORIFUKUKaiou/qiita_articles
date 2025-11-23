---
title: >-
  AWSを使うならCDK使ったほうがよいと思った事例 〜AWS Lambda関数URLの認可モデル変更を検証する - CDK 2.217.0 vs
  2.218.0+ 〜
tags:
  - AWS
  - lambda
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-22T12:04:24+09:00'
id: 48eb35c7d826bd49abc2
organization_url_name: haw
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

https://qiita.com/advent-calendar/2025

## はじめに

2025年10月、AWSからLambda関数URLの認可モデル変更に関する重要な通知が届きました。この記事では、CDKのバージョンによる挙動の違いを実際に検証します。

- Lambda security notification: 2025年10月27日 午後 4:50:00 UTC+9
- [Control access to Lambda function URLs](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html)

[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)の全面協力により、作成をしております。

## 変更内容のサマリー

### 従来の認可モデル（2025年10月以前）
- `lambda:InvokeFunctionUrl` のみで関数URL経由の呼び出しが可能

### 新しい認可モデル（2025年10月以降）
- `lambda:InvokeFunctionUrl` **AND** `lambda:InvokeFunction` の両方が必要
- 2026年11月1日までに対応が必要

### CDKでの対応
- **CDK 2.217.0以前**: 旧モデル（`lambda:InvokeFunctionUrl`のみ）
- **CDK 2.218.0以降**: 新モデル（両方のパーミッション）

## 検証の目的

1. CDK 2.217.0でデプロイした際のリソースポリシーを確認
2. CDK 2.218.0+にアップグレード後のリソースポリシーの変化を確認
3. 新旧モデルの違いを可視化

## 検証環境

- AWS CDK: 2.217.0 → 2.218.0+
- Node.js: 22.x
- Lambda Runtime: Python 3.13
- 関数URL AuthType: NONE（パブリックアクセス）

## 検証用CDKプロジェクトの構成

プロジェクト構造：

```
lambda-furl-auth-verification/
├── bin/
│   └── app.ts
├── lib/
│   └── lambda-furl-stack.ts
├── lambda/
│   └── handler.py
├── package.json
├── cdk.json
└── tsconfig.json
```

### 1. Lambda関数のコード

シンプルなHello World関数：

```python:lambda/handler.py
import json

def handler(event, context):
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
        'body': json.dumps({
            'message': 'Hello from Lambda Function URL!',
            'requestId': context.request_id
        })
    }
```

### 2. CDK Stack定義

```typescript:lib/lambda-furl-stack.ts
import * as cdk from 'aws-cdk-lib';
import * as lambda from 'aws-cdk-lib/aws-lambda';
import { Construct } from 'constructs';
import * as path from 'path';

export class LambdaFurlStack extends cdk.Stack {
  constructor(scope: Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // Lambda関数の作成
    const fn = new lambda.Function(this, 'FunctionUrlTestFunction', {
      runtime: lambda.Runtime.PYTHON_3_13,
      handler: 'handler.handler',
      code: lambda.Code.fromAsset(path.join(__dirname, '../lambda')),
      timeout: cdk.Duration.seconds(30),
      memorySize: 128,
    });

    // 関数URLの作成（AuthType: NONE）
    const fnUrl = fn.addFunctionUrl({
      authType: lambda.FunctionUrlAuthType.NONE,
    });

    // 関数URLを出力
    new cdk.CfnOutput(this, 'FunctionUrl', {
      value: fnUrl.url,
      description: 'Lambda Function URL',
    });

    // 関数ARNを出力
    new cdk.CfnOutput(this, 'FunctionArn', {
      value: fn.functionArn,
      description: 'Lambda Function ARN',
    });
  }
}
```

### 3. アプリケーションエントリーポイント

```typescript:bin/app.ts
#!/usr/bin/env node
import 'source-map-support/register';
import * as cdk from 'aws-cdk-lib';
import { LambdaFurlStack } from '../lib/lambda-furl-stack';

const app = new cdk.App();
new LambdaFurlStack(app, 'LambdaFurlStack', {
  env: {
    account: process.env.CDK_DEFAULT_ACCOUNT,
    region: process.env.CDK_DEFAULT_REGION,
  },
});
```

### 4. package.json（CDK 2.217.0固定）

```json:package.json
{
  "name": "lambda-furl-auth-verification",
  "version": "1.0.0",
  "description": "Lambda Function URL Authorization Model Change Verification",
  "devDependencies": {
    "@types/node": "^22.0.0",
    "typescript": "^5.0.0",
    "aws-cdk": "^2.160.0"
  },
  "dependencies": {
    "aws-cdk-lib": "2.217.0",
    "constructs": "^10.0.0",
    "source-map-support": "^0.5.21"
  }
}
```

### 5. その他の設定ファイル

```json:cdk.json
{
  "app": "npx ts-node --prefer-ts-exts bin/app.ts",
  "context": {
    "@aws-cdk/aws-lambda:recognizeLayerVersion": true,
    "@aws-cdk/core:checkSecretUsage": true,
    "@aws-cdk/core:target-partitions": ["aws", "aws-cn"]
  }
}
```

```json:tsconfig.json
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["es2020"],
    "declaration": true,
    "strict": true,
    "noImplicitAny": true,
    "strictNullChecks": true,
    "noImplicitThis": true,
    "alwaysStrict": true,
    "noUnusedLocals": false,
    "noUnusedParameters": false,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": false,
    "inlineSourceMap": true,
    "inlineSources": true,
    "experimentalDecorators": true,
    "strictPropertyInitialization": false,
    "typeRoots": ["./node_modules/@types"]
  },
  "exclude": ["node_modules", "cdk.out"]
}
```

## 検証手順

### Phase 1: CDK 2.217.0でのCloudFormationテンプレート生成

```bash
# プロジェクトのセットアップ
cd lambda-furl-auth-verification
npm install

# TypeScriptコンパイル確認
npx tsc

# CloudFormationテンプレート生成
npx cdk synth
```

### Phase 2: Permissionリソースの確認（CDK 2.217.0）

```bash
# 生成されたテンプレートからPermissionリソースを抽出
cat cdk.out/LambdaFurlStack.template.json | jq '.Resources | to_entries | .[] | select(.value.Type == "AWS::Lambda::Permission")'
```

**期待される結果（CDK 2.217.0）**:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "FunctionURLAllowPublicAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "lambda:InvokeFunctionUrl",
      "Resource": "arn:aws:lambda:ap-northeast-1:123456789012:function:LambdaFurlStack-FunctionUrlTestFunction-XXXXX",
      "Condition": {
        "StringEquals": {
          "lambda:FunctionUrlAuthType": "NONE"
        }
      }
    }
  ]
}
```

**重要ポイント**: `lambda:InvokeFunctionUrl` **のみ**が付与されている

### Phase 3: CDK 2.218.0+へのアップグレード

```bash
# package.jsonを編集
# "aws-cdk-lib": "2.217.0" → "aws-cdk-lib": "^2.218.0" (2.218.0以上)
# 注意: aws-cdk (CLI) はそのままでOK

rm -rf node_modules

# 依存関係の更新
npm install

# CloudFormationテンプレート再生成
npx cdk synth
```

### Phase 4: Permissionリソースの再確認（CDK 2.218.0+）

```bash
# 生成されたテンプレートを確認（Permissionが2つになっているはず）
cat cdk.out/LambdaFurlStack.template.json | jq '.Resources | to_entries | .[] | select(.value.Type == "AWS::Lambda::Permission")'
```

**期待される結果（CDK 2.218.0+）**:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "FunctionURLAllowPublicAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "lambda:InvokeFunctionUrl",
      "Resource": "arn:aws:lambda:ap-northeast-1:123456789012:function:LambdaFurlStack-FunctionUrlTestFunction-XXXXX",
      "Condition": {
        "StringEquals": {
          "lambda:FunctionUrlAuthType": "NONE"
        }
      }
    },
    {
      "Sid": "FunctionURLInvokeAllowPublicAccess",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "lambda:InvokeFunction",
      "Resource": "arn:aws:lambda:ap-northeast-1:123456789012:function:LambdaFurlStack-FunctionUrlTestFunction-XXXXX",
      "Condition": {
        "Bool": {
          "lambda:InvokedViaFunctionUrl": "true"
        }
      }
    }
  ]
}
```

**重要ポイント**: `lambda:InvokeFunction` が**追加**されている

## AWS Consoleでの確認方法

実際にデプロイした場合、AWS Consoleでも確認できます：

**Lambda関数 > Configuration > Permissions > Resource-based policy statements**

![スクリーンショット 2025-11-01 16.48.42.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1d967a52-6525-44c8-b641-3035416d0440.png)


ここに表示されるポリシーが、CloudFormationの`AWS::Lambda::Permission`リソースに対応します。

- **CDK 2.217.0**: Statement が **1つ**（`lambda:InvokeFunctionUrl`のみ）
- **CDK 2.218.0+**: Statement が **2つ**（`lambda:InvokeFunctionUrl` + `lambda:InvokeFunction`）

## 検証結果の比較表

| 項目 | CDK 2.217.0 | CDK 2.218.0+ |
|------|-------------|--------------|
| `lambda:InvokeFunctionUrl` | ✅ 付与 | ✅ 付与 |
| `lambda:InvokeFunction` | ❌ なし | ✅ 付与 |
| `lambda:InvokedViaFunctionUrl` 条件 | ❌ なし | ✅ あり |
| Permissionリソース数 | 1個 | 2個 |
| 2026年11月以降の動作 | ⚠️ 非推奨 | ✅ 推奨 |

## 重要な考察

### 1. `lambda:InvokedViaFunctionUrl` 条件の意味

新しいモデルでは、`lambda:InvokeFunction` に `lambda:InvokedViaFunctionUrl: true` という条件が付与されます。これにより：

- ✅ 関数URL経由の呼び出しは許可
- ❌ AWS SDK/CLI経由の直接呼び出しは拒否

つまり、**関数URLのみに限定したアクセス制御**が実現されます。

### 2. セキュリティ上の改善点

旧モデルでは `lambda:InvokeFunctionUrl` のみで呼び出し可能でしたが、新モデルでは：

- より明示的な権限管理
- 呼び出し経路の制限が可能
- 意図しない呼び出し方法の防止

### 3. 移行期間と猶予措置

- **2025年10月**: 新モデル開始
- **2026年11月1日**: 移行期限
- 既存の関数URLには一時的な例外措置が適用されている

## まとめ

### この記事で確認できたこと

1. ✅ CDK 2.217.0では`lambda:InvokeFunctionUrl`のみ生成される
2. ✅ CDK 2.218.0+では`lambda:InvokeFunction`も追加される
3. ✅ `npx cdk synth`だけで検証可能（AWSデプロイ不要）

### やるべきこと

1. ✅ CDK 2.218.0以上にアップグレード
2. ✅ `npx cdk synth`でCloudFormationテンプレート確認
3. ✅ 既存の関数URLをデプロイし直す

### やってはいけないこと

- ❌ CDK 2.217.0以前のまま放置
- ❌ 2026年11月1日を過ぎてから対応

### 参考リンク

- [AWS Lambda Function URLs - Control access](https://docs.aws.amazon.com/lambda/latest/dg/urls-auth.html)
- [AWS Lambda AddPermission API](https://docs.aws.amazon.com/lambda/latest/api/API_AddPermission.html)
- [AWS CDK Release Notes](https://github.com/aws/aws-cdk/releases)

## おわりに

Lambda関数URLの認可モデル変更は、セキュリティ強化のための重要なアップデートです。CDK 2.218.0以降を使用することで、自動的に新しいモデルに対応できます。

2026年11月1日までに対応を完了させましょう！🔥
来年の話をすると、鬼に笑われますが、動かなくなるまで放置すると、上司に鬼のように怒られますので、早めの対策を！

さいごにタイトル「AWSを使うならCDK使ったほうがよいと思った事例」の回収です。CDKを使うとベストプラクティスやセキュリティアップデートがライブラリに組み込まれています。ですから、AWSを使うならCDK使ったほうがよいと思いました。
