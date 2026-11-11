---
title: Secrets Managerの削除予約後は歯車から再表示、RDSのSG変更はメンテナンスを待たずに反映される
tags:
  - AWS
  - 闘魂連鎖
  - tips
private: false
updated_at: '2026-11-11T12:22:18+09:00'
id: 84c8794cbfc954aa70d8
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
## はじめに

AWSコンソールで作業していて、迷った操作を2つ紹介します。

:::note info
- Secrets Managerで削除予約したシークレットが一覧から消えたら、歯車から「削除予定のシークレットを表示」を有効にします。
- RDSに関連付けるVPCセキュリティグループの変更は、「次回の定期メンテナンス期間中に適用」を選んでも、非同期で速やかに反映されます。
:::

以下は2026年11月に確認した内容です。

## Secrets Manager：削除予約したシークレットを再表示する

不要になったシークレットに、7日間の復旧猶予を付けて削除予約しました。

すると、シークレットが一覧から見えなくなりました。

完全に削除されるまで猶予があることは理解していましたが、その間の確認場所が分かりません。CLIで確認する必要があるのかと思いましたが、コンソールにも表示設定がありました。

### 一覧の歯車から表示を切り替える

1. Secrets Managerのシークレット一覧を開きます。
2. 歯車アイコンから設定を開きます。
3. 「削除予定のシークレットを表示」を有効にして保存します。

![スクリーンショット 2026-11-11 12.15.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f6e6cdf6-9ccb-4509-97e3-8c0a44d02119.png)


これで、削除予約したシークレットが一覧に表示されます。対象を開けば、削除をキャンセルすることもできます。

AWS公式ドキュメントにも、歯車の「Preferences」から「Show secrets scheduled for deletion」を選択する手順があります。

[公式：削除予約したシークレットの表示方法](https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_delete-secret.html)

### 復旧猶予中は値を取得できない

これは表示設定とは別の話ですが、削除予約した時点でシークレットの値は取得できなくなります。

復旧猶予は「引き続き利用できる期間」ではなく、「削除を取り消して利用可能な状態へ戻せる期間」です。

値を再取得する必要がある場合は、先に削除をキャンセルします。

[公式：シークレットの復元](https://docs.aws.amazon.com/secretsmanager/latest/userguide/manage_restore-secret.html)

---

## RDS：SG変更はメンテナンス期間を待たずに反映される

RDSのDBインスタンスへ、新しいVPCセキュリティグループを追加しました。

変更画面では、適用タイミングとして次の選択肢が表示されます。

- 次回の定期メンテナンス期間中に適用
- すぐに適用

![スクリーンショット 2026-11-08 11.40.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f44ddac5-e9dc-4db4-ac90-8414a05a8454.png)


この画面を見ると、前者を選んだ場合はSGの追加もメンテナンス期間まで待つように見えます。

しかし、SG変更は例外です。

AWS公式ドキュメントの「Security group」には、次の仕様が記載されています。

- 変更は、非同期でできるだけ早く適用される
- 「すぐに適用」の設定には左右されない
- この変更自体によるダウンタイムは発生しない

今回も「次回の定期メンテナンス期間中に適用」を選んで変更し、その後の画面で新しいSGの追加を確認できました。

[公式：DBインスタンスの設定項目別の適用タイミング](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ModifyInstance.Settings.html)

### SGだけのために「すぐに適用」を選ぶ必要はない

:::note warn
「すぐに適用」を選ぶと、今回の変更だけでなく、既に保留されている変更も適用対象になります。
:::

保留中の変更に停止を伴うものがあれば、予期しないダウンタイムにつながる可能性があります。

SG変更だけを早く反映したいのであれば、そのために「すぐに適用」を選ぶ必要はありません。

[公式：変更の適用タイミングと保留中の変更](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_ModifyInstance.ApplyImmediately.html)

## 操作前に確認すること

| 操作 | 覚えておくこと |
| --- | --- |
| Secrets Managerの削除予約 | 一覧から消えたら、歯車で削除予定のシークレットを表示する |
| 削除予約したSecretの値を取得 | 復旧猶予中でも、そのままでは取得不可。先に削除をキャンセルする |
| RDSのVPC SG変更 | メンテナンス期間を待たず、非同期で反映される |
| RDSの「すぐに適用」 | 他の保留中変更も適用対象になる |
