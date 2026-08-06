---
title: >-
  語るも涙、聞くも涙。GitHub ActionsのAWS OIDC認証が新規リポジトリだけ失敗した2026年7月の思い出 (Not authorized
  to perform sts:AssumeRoleWithWebIdentity)
tags:
  - AWS
  - 闘魂
  - 猪木
  - GitHub
  - GitHubActions
private: false
updated_at: '2026-08-06T07:53:54+09:00'
id: 6818ebfc026eada9e2dd
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4893edab-37df-4637-934f-3821337717d0.png)


## TL;DR

- `aws-actions/configure-aws-credentials@v6` を使ったOIDC認証が、**古いリポジトリでは通るのに新しいリポジトリでは通らない**という謎に遭遇した
- 原因は2026年7月15日にGitHubへ入った変更で、それ以降に作られたリポジトリは `sub` クレームの形式が変わっていた
- 具体的には `repo:OWNER/REPO:ref:refs/heads/main` だった形式が `repo:OWNER@OWNER_ID/REPO@REPO_ID:ref:refs/heads/main` に変わっていた
- IAMロールの信頼ポリシーをこの新形式に合わせて書き直したら、あっさり解決した

---

## はじめに

だいぶ前に作ったリポジトリでは、IAMロールの信頼ポリシーをこう書けば何の問題もなくGitHub ActionsからAWSの認証が通っていました。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo:<octo-org>/<octo-repo>:ref:refs/heads/<branch>",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

`< >` で囲った部分はすべてプレースホルダーです。実際にはご自身の値に読み替えてください。`<branch>` も`main`固定ではなく、対象にしたい任意のブランチ名(あるいはタグなど)に置き換えてもらって構いません。

長年これでやってきて、なんの疑いも持っていませんでした。`repo:<octo-org>/<octo-repo>:ref:refs/heads/<branch>` という文字列さえ`sub`の条件に書いておけば、OIDCは通る。そう信じて疑わなかったのです。

ところが2026年7月30日、新しく作ったリポジトリで同じようにGitHub Actionsのデプロイワークフローを組み、いつも通り信頼ポリシーに新しいリポジトリ名を追記しました。

**認証されませんでした。**

`uses: aws-actions/configure-aws-credentials@v6` のステップが `Could not assume role with OIDC: Not authorized to perform sts:AssumeRoleWithWebIdentity` の一言を残して止まってしまいました。何年も同じやり方で通ってきたのに、なぜ今回だけ。最初は信頼ポリシーのタイプミスを疑い、リポジトリ名の大文字小文字を疑い、OIDCプロバイダーのARNを疑いました。原因はどれでもありませんでした。

語るも涙、聞くも涙の物語です。

## 原因:知らないうちに`sub`クレームの仕様が変わっていた

正体は、2026年7月15日にGitHub側にひっそりと入っていた変更でした。

GitHubのOIDCリファレンスには、この日以降に作成されたリポジトリでは、`sub`クレームのデフォルト形式がオーナーIDとリポジトリIDを含む恒久的な形式に切り替わったと記載されています。

- 旧形式(mutable): `repo:<octo-org>/<octo-repo>:ref:refs/heads/<branch>`
- 新形式(immutable): `repo:<octo-org>@<OWNER_ID>/<octo-repo>@<REPO_ID>:ref:refs/heads/<branch>`

`configure-aws-credentials`のREADMEにも同様の記述があり、2026年7月15日以降に作られたリポジトリ(および opt-in 済みの旧リポジトリ)は、組織とリポジトリそれぞれの永続的な数値IDを名前の後ろに`@`区切りで付与した`sub`クレームを発行するようになった、と説明されています。これは、リポジトリ名やOrg名が削除・再利用された際に、古い信頼ポリシーが新しい(しかし同名の)リポジトリに誤ってマッチしてしまう事故を防ぐための変更とのことです。

なぜこの変更が入ったかという「意図」自体はセキュリティ上まっとうです。ただ問題は、**この変更が入ったことを知らずに、いつも通りのテンプレートで信頼ポリシーを書いてしまったこと**にあります。旧リポジトリの`sub`は`repo:<octo-org>/<octo-repo>:ref:refs/heads/<branch>`のままなので今まで通り動く一方、2026/7/15以降に新規作成したリポジトリの実際の`sub`は`repo:<octo-org>@<OWNER_ID>/<octo-repo>@<REPO_ID>:ref:refs/heads/<branch>`になっていて、両者はまったく別の文字列として扱われます。信頼ポリシー側は旧形式のままなので、当然マッチしません。

つまり、**同じ書き方をしているつもりで、実は「別のフォーマットのIDカード」を求められていた**というのが今回のオチでした。

## 対処:`sub`クレームを新形式に書き換える

対処自体はシンプルです。信頼ポリシーの`sub`を新形式に合わせて書き直すだけです。

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::<AWS_ACCOUNT_ID>:oidc-provider/token.actions.githubusercontent.com"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "token.actions.githubusercontent.com:sub": "repo:<octo-org>@<OWNER_ID>/<octo-repo>@<REPO_ID>:ref:refs/heads/<branch>",
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
            }
        }
    ]
}
```

ここでも`< >`部分はプレースホルダーです。`<OWNER_ID>`と`<REPO_ID>`だけ新たに埋める必要があり、それ以外(`<AWS_ACCOUNT_ID>`、`<octo-org>`、`<octo-repo>`、`<branch>`)は「はじめに」で使ったものと同じ考え方で読み替えてください。

ポイントは、**旧リポジトリと新リポジトリで`sub`のフォーマットが違うまま共存する**ということです。7/15より前に作ったリポジトリは、こちらから明示的にオプトイン(=この場合、旧リポジトリ側で新形式を有効にする設定をオンにすること)しない限り旧形式のままなので、慌てて全部書き換える必要はありません。新規作成分だけ新形式で追記すればOKです。ただしセキュリティの観点では、余裕があれば旧リポジトリ側もオプトインして新形式に揃えておいた方が望ましいです。

### OWNER_IDとREPO_IDの調べ方

肝心の`<OWNER_ID>`と`<REPO_ID>`は、対象リポジトリの **Settings → Actions → OIDC** ページをたどれば確認できます。そのリポジトリが実際に発行する`sub`クレームの形式(オーナーIDとリポジトリIDを含んだ文字列)がそのまま表示されています。ここに出ている値をコピーして、信頼ポリシーの`sub`条件にそのまま貼り付ければ間違いがありません。

![スクリーンショット 2026-08-03 15.05.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/81deeceb-a203-4d0c-9397-68f57daee964.png)

:::note
2026/7/15以降に作ったリポジトリは、デフォルトで、「Use immutable subject claim」に✅️があります。
2026/7/15より前に作ったリポジトリで、オプトインしたい場合は、この設定に✅️を入れます。
:::

## まとめ

- 2026年7月15日を境に、新規作成されたGitHubリポジトリのOIDC `sub`クレームは`repo:<octo-org>@<OWNER_ID>/<octo-repo>@<REPO_ID>:ref:refs/heads/<branch>`という恒久的な形式に変わった
- 旧リポジトリはそのままなので、**同じ組織の中で新旧フォーマットが混在する**ことがある
- 信頼ポリシーの`sub`条件は、リポジトリの作成日に応じてどちらの形式で書くべきか確認が必要
- リポジトリの`Settings → Actions → General`ページを見れば、`OWNER_ID`/`REPO_ID`を含む実際の`sub`クレームがそのまま確認できる
- 「いつも通りのコピペ」がある日突然通らなくなったら、GitHub側の仕様変更を疑うべし

知らないところで足元の仕様が変わっていた、地味だけどハマると小一時間溶かされる話でした。同じ轍を踏む人が一人でも減れば幸いです。

## 参考

- [OpenID Connect reference - GitHub Docs (Immutable subject claims)](https://docs.github.com/en/actions/reference/security/oidc#immutable-subject-claims)
- [Security hardening your deployments - OIDC in AWS](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws)
- [aws-actions/configure-aws-credentials README (Immutable subject claims)](https://github.com/aws-actions/configure-aws-credentials/blob/main/README.md)
