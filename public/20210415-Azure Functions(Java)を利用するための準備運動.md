---
title: Azure Functions(Java)を利用するための準備運動
tags:
  - Java
  - Azure
  - Elixir
  - QiitaAzure
private: false
updated_at: '2021-04-16T19:16:30+09:00'
id: b6557ce35e18e1502e23
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/22637c675c61a797a24f

# はじめに
- Java楽しんでいますか:bangbang::bangbang::bangbang:
- この記事では以下のことを書いています
    - Javaおよびツールのインストール(on macOS 10.15.7)
    - 雛形プロジェクトの動かし方
    - Azure Functionsへのデプロイ
- 「[Java開発者のためのAzure入門](https://qiita.com/official-events/22637c675c61a797a24f) （2021/4/6– 2021/5/9）」というキャンペーンへの投稿記事です
- 私は[Elixir](https://elixir-lang.org/)というプログラミング言語を使って、「[【毎日自動更新】Java開発者のためのAzure入門(2021/4/6–2021/5/9) LGTMランキング！](https://qiita.com/torifukukaiou/items/9cfefb20ec347514576b)」という記事を自動更新しています
- 当初は、これと同じことをJavaでやってみようと考えていました
    - ただそれだとただキャンペーンに参加するためだけの記事になってしまう気がしました
    - 自分にとっても面白くはないので、別のことはないかと模索しました
    - 自分の役に立つことはないかと
- そこでおもいついたのが、Seventyになんなんとする母がスマートフォンに最近、買い替えまして、その操作の練習支援になるようなことをしたいとおもいました
    - みうらじゅんさんの「[親孝行プレイ](https://www.amazon.co.jp/dp/B01EMHXV5M)」に通じるものがあるかもしれません
    - ごめんなさい、まだ読んでいないです :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 
    - 「[「ない仕事」の作り方](https://www.amazon.co.jp/dp/B07HWHKXR1/)[^1]」は読んでいます
- ところが最近、Javaに触れる機会が少なかったのでさてどこから手をつけようかと逡巡してしまいました
- それで次にとった行動は、「Azure Java」で検索してたどり着いた**Azureの公式ドキュメント**をそのままやってみるということです
- 以下のドキュメントをみていくとよさそうです
    - [Azure Functions のドキュメント](https://docs.microsoft.com/ja-jp/azure/azure-functions/)[^2]
    - [Azure Functions の概要](https://docs.microsoft.com/ja-jp/azure/azure-functions/functions-overview)
    - [Azure Functions の概要 - Java](https://docs.microsoft.com/ja-jp/azure/azure-functions/functions-get-started?pivots=programming-language-java)
    - [クイックスタート: Visual Studio Code を使用して Azure に Java 関数を作成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java)
        - ここが一番、私にとってはためになりました
    - [Maven を使用して Azure で Java サーバーレス機能を開発する](https://docs.microsoft.com/ja-jp/learn/modules/develop-azure-functions-app-with-maven-plugin/)


# この記事を書いている人
- Javaは使ったことがありますが、ここ５年くらいはほとんど触っていません
    - 個人開発でリリースしているandroidアプリはメンテナンスを続けています
        - [オートレースオンデマンド再生](https://play.google.com/store/apps/details?id=jp.torifuku.ondemandplayer)
        - [読書日記](https://play.google.com/store/apps/details?id=jp.torifuku.ReadingDiary)
        - ご利用のみなさま、ありがとうございます :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 
- 最近は[Elixir](https://elixir-lang.org/)というプログラミング言語が大のお気に入りでございます

# ① 環境構築
- macOS Catalina 10.15.7
- Oracle JDK、JREを以前インストールしていた
- まずは、[環境を構成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#configure-your-environment)を丁寧にやってみませふ

## Oracle JDK、JREのアンインストール
- [macOSでのJDKのアンインストール](https://docs.oracle.com/javase/jp/10/install/installation-jdk-and-jre-macos.htm#GUID-F9183C70-2E96-40F4-9104-F3814A5A331F)
- [macOSでのJREのアンインストール](https://docs.oracle.com/javase/jp/10/install/installation-jdk-and-jre-macos.htm#GUID-577CEA7C-E51C-416D-B9C6-B1469F45AC78)
- 上記に従ってすすめました
    - なんかこわい
    - おっかなびっくりだけど公式の手順なので迷わず行けよ、行けばわかるさ、ありがとう！
- なぜアンインストールしたのかについては、[環境を構成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#configure-your-environment)というところで、[Azul Zulu for Azure - Enterprise Edition](https://www.azul.com/downloads/azure-only/zulu/) JDK buildsのインストールがすすめられていて、なんとなく同じようなものが２つあるのはよくないのかなあとおもったからです
    - 共存できたのかもしれませんし、
    - 詳しくはよくわかっていないのですが、[JDKの新しいリリース・モデ および提供ライセンスについて](https://www.oracle.com/jp/technical-resources/article/java/ja-topics/jdk-release-model.html) が関係しているようにおもいます

## Java11 のインストール
- https://www.azul.com/downloads/azure-only/zulu/?version=java-11-lts
- ここから.dmgをダウンロードしてダブルクリック
- 画面の指示通りすすめればこわくない
- インストーラーの画面はなんだか楽しそう！

![スクリーンショット 2021-04-10 1.19.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2d140f58-cc44-07e9-1b49-e85624041183.png)



```~/.zshenv
export JAVA_HOME=`/usr/libexec/java_home`
```
- と書いていました
    - いつ書いたのかはとんと思い出せないのです

```
$ source ~/.zshenv
$ echo $JAVA_HOME
/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home

$ java -version
openjdk version "11.0.10" 2021-01-19 LTS
OpenJDK Runtime Environment 21.1-(Zulu-11.45+27-macosx_x64)-Microsoft-Azure-restricted (build 11.0.10+9-LTS)
OpenJDK 64-Bit Server VM 21.1-(Zulu-11.45+27-macosx_x64)-Microsoft-Azure-restricted (build 11.0.10+9-LTS, mixed mode)
```
:tada::tada::tada: 

## [Apache Maven](https://maven.apache.org/index.html)のインストール
- 昔インストールしたような記憶がありますが、`mvn`で`command not found`と言われてしまいました
- [公式の手順](https://maven.apache.org/install.html)は面倒そうにみえたので、[Homebrew](https://brew.sh/index_ja)でインストールしました

```
$ brew install maven

$ mvn -v
Apache Maven 3.8.1 (05c21c65bdfed0f71a2f2ada8b84da59348c4c5d)
Maven home: /usr/local/Cellar/maven/3.8.1/libexec
Java version: 1.8.0_282, vendor: Azul Systems, Inc., runtime: /Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/jre
Default locale: ja_JP, platform encoding: UTF-8
OS name: "mac os x", version: "10.15.7", arch: "x86_64", family: "mac"
```

## [Visual Studio Code](https://code.visualstudio.com/)
- 私はすでにインストール済みでした
- 重宝しております
- ありがとうございます

## [Java Extension Pack](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack)
- リンク先に飛んで、`Install`ボタンを押す

## [Visual Studio Code 用 Azure Functions 拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions)
- リンク先に飛んで、`Install`ボタンを押す
- [Visual Studio Code](https://code.visualstudio.com/)が立ち上がって、そちらで`Install`ボタンを押す



# ② [ローカル プロジェクトを作成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- リンク先の通りにやればいいのですが、最初のフォルダ選択は、中身が空の`myFunction`ディレクトリを選択すると吉です
- ディレクトリ作ってくれるだろうと高を括ってすすめるとぶちまけられます
    - なんのことだかわからない方は何事も経験なので`~/Desktop`でも選んでやってみるとわかりますが後始末が面倒なのでおすすめしません
        - もしやっちまったら、`ls -la`とかして日付をみて、ぶちまけてしまったファイルやフォルダを消していくとよいでしょう
- 「provide an app name (アプリ名を指定してください) : [myFunction-12345] 」のところの`12345`という数字は、[Visual Studio Code](https://code.visualstudio.com/)が表示していた値を変更せずにそのままエンターを押しました

# ③ [関数をローカルで実行する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- `F5`を押しますと、[azure-functions-core-tools](https://www.npmjs.com/package/azure-functions-core-tools)のインストールがはじまりました
    - [Azure Functions Core Tools のインストール](https://docs.microsoft.com/ja-jp/azure/azure-functions/functions-run-local?tabs=macos%2Ccsharp%2Cbash#install-the-azure-functions-core-tools)に書いてあるようなことです
- イゴいた:tada:、イゴいた:tada:

![スクリーンショット 2021-04-10 1.34.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4f06e07f-9734-79b8-650b-6a20c639130e.png)


- ここまでポチポチやっただけで、自らはJavaのコードを一切書いていません
- デフォルトで以下のコードが生成されています
- `name`をキーとするクエリパラメータの値を、`"Hello, " + name`して返すプログラムです
- `@HttpTrigger`のところはなにやらごちゃごちゃしていますが、とりあえず**景色**だとおもって関数本体に目を通してみるとそんなに難しいことは書いてありません

```java:src/main/java/com/function/Function.java
package com.function;

import com.microsoft.azure.functions.ExecutionContext;
import com.microsoft.azure.functions.HttpMethod;
import com.microsoft.azure.functions.HttpRequestMessage;
import com.microsoft.azure.functions.HttpResponseMessage;
import com.microsoft.azure.functions.HttpStatus;
import com.microsoft.azure.functions.annotation.AuthorizationLevel;
import com.microsoft.azure.functions.annotation.FunctionName;
import com.microsoft.azure.functions.annotation.HttpTrigger;

import java.util.Optional;

/**
 * Azure Functions with HTTP Trigger.
 */
public class Function {
    /**
     * This function listens at endpoint "/api/HttpExample". Two ways to invoke it using "curl" command in bash:
     * 1. curl -d "HTTP Body" {your host}/api/HttpExample
     * 2. curl "{your host}/api/HttpExample?name=HTTP%20Query"
     */
    @FunctionName("HttpExample")
    public HttpResponseMessage run(
            @HttpTrigger(
                name = "req",
                methods = {HttpMethod.GET, HttpMethod.POST},
                authLevel = AuthorizationLevel.ANONYMOUS)
                HttpRequestMessage<Optional<String>> request,
            final ExecutionContext context) {
        context.getLogger().info("Java HTTP trigger processed a request.");

        // Parse query parameter
        final String query = request.getQueryParameters().get("name");
        final String name = request.getBody().orElse(query);

        if (name == null) {
            return request.createResponseBuilder(HttpStatus.BAD_REQUEST).body("Please pass a name on the query string or in the request body").build();
        } else {
            return request.createResponseBuilder(HttpStatus.OK).body("Hello, " + name).build();
        }
    }
}

```



# ④ [Azure へのサインイン](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- リンクの通りに進めます
- すでに[Azure](https://azure.microsoft.com/ja-jp/)のアカウントは持っていましたし、すんなりいきました
    - まだもっていないよ〜　という方は、
    - [Azure | クラウドコト始め l まずは"Azure"に登録してみよう l 初心者向け01](https://www.youtube.com/watch?v=au_Fnsfb_Xc) :video_camera: にて詳しく丁寧に解説されています!　のでご参照ください
- そうそう、なにせ私には[日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)の受賞実績がありますから、[Azure](https://azure.microsoft.com/ja-jp/)のアカウントは持っているのでありますよ
- もう一度言います
- <font color="purple">$\huge{日本マイクロソフト賞④}$</font>
- を受賞したことがあります
    - その原動力となったのは[Elixir](https://elixir-lang.org/)が好きだというただ一点です
    - その話はまた別の機会に

# ⑤ [Azure にプロジェクトを発行する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- リンクの通りに進めます
- `awesome-test-12345`と、`Enter a globally unique name for the function app`に対して今回は入力してみました

# ⑥ [Azure で関数を実行する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- リンクの通りに進めます

![スクリーンショット 2021-04-10 1.47.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8d37ad9d-888d-ef0f-221d-53bc02c2f1b2.png)

- イゴいた:tada:、イゴいた:tada:

# ⑦ [リソースをクリーンアップする](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-vs-code-java#create-your-local-project)
- 私の場合ですとリソースグループ`awesometest12345`を削除しました

# まとめ
- ポチポチしただけですが、[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)にJavaのプログラムをデプロイできました
- 次は、本題のタイマをトリガとして[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)でJavaのプログラムをイゴかす方法を書きたいとおもいます

# あわせて読みたいオススメ記事
- @statemachine さんの「[Java で Azure Functionsの関数を実装する](https://qiita.com/statemachine/items/562488d76c02203c1c65)」

# 最後の最後に

## [Elixir](https://elixir-lang.org/)って何よ:interrobang:　という方へ
- ちょいちょい[Elixir](https://elixir-lang.org/)を散りばめました

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/601aeb87-9d1d-6a9d-b30b-338507dc593e.png)

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 2020/12/26時点くらいのスクリーンショット
- [Elixir](https://elixir-lang.org/)についてもっと知りたい方は下記の本:books:をオススメします
    - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
    - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
- [elixir.jp Slack](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)の`#autoracex`というところに私は入り浸っておりますのでお気軽にお声がけください
- [勉強会が頻繁に行われています](https://twitter.com/piacere_ex/status/1364109880362115078)
    - 私がよく参加している勉強会です
    - [autoracex](https://autoracex.connpass.com/) 【毎週月曜】 主催
    - [Sapporo.beam](https://sapporo-beam.connpass.com)　　【毎週水曜】
    - [OkazaKirin.beam](https://okazakirin-beam.connpass.com)　【毎週木曜】
    - [fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com)　【毎月2～3回】
    - [NervesJP](https://nerves-jp.connpass.com/) 　【毎月1回】

![EsvA7uQU0AEoTuX.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2ad87109-2684-1605-e1dc-457b835b8c15.jpeg)

(@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)


[^1]: 「[「ない仕事」の作り方](https://www.amazon.co.jp/dp/B07HWHKXR1/)」は、[2021年本屋大賞 『発掘部門』](https://www.hontai.or.jp/find/vote2021.html)にて、「超発掘本！」に選ばれております。本屋大賞に選ばれたから読んだのではなく、その前から私は推していました。証拠は、2021/04/09にアップロードした[LT資料](https://www.slideshare.net/AwesomeYAMAUCHI/20210409-e-zukatechnight)に紹介をいれています。紹介文は「私の5分の話なんかより、[この本]((https://www.amazon.co.jp/dp/B07HWHKXR1/))を1時間〜2時間かけて読んだほうがよっぽどいい」です。

[^2]: どうして[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)にすぐ飛びつけたのかというと、[AWS](https://aws.amazon.com/jp/)の話で申し訳ありませんが、[Lambda](https://aws.amazon.com/jp/lambda/)っぽいものを探そうとしてたどり着きました。じゃあ、その前の[Lambda](https://aws.amazon.com/jp/lambda/)との馴れ初めは忘れてしまいました。
