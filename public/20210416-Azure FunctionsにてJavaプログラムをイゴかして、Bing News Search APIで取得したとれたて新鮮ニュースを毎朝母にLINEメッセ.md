---
title: >-
  Azure FunctionsにてJavaプログラムをイゴかして、Bing News Search
  APIで取得したとれたて新鮮ニュースを毎朝母にLINEメッセージでおくりつける
tags:
  - Java
  - Azure
  - Elixir
  - QiitaAzure
private: false
updated_at: '2021-05-09T20:10:55+09:00'
id: 982aded76cf1f9bb5a99
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/22637c675c61a797a24f

# はじめに
- Java楽しんでいますか:bangbang::bangbang::bangbang:
- この記事は[Java開発者のためのAzure入門](https://qiita.com/official-events/22637c675c61a797a24f)というキャンペーンへの投稿記事です
- この記事では、[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)を使って、朝06:30にJavaのプログラムを動かして以下のことを行います
    - [Bing News Search API](https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/search-the-web)にて新鮮とれたてニュースを取得します
    - LINEの[Messaging API](https://developers.line.biz/ja/docs/messaging-api/overview/)を使って、[Bing News Search API](https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/search-the-web)で取得した新鮮とれたてニュースと「おはようございます」というあいさつを母が属するグループへ送りつけます

## 制作背景
- 最近、seventyになんなんとする母がスマートフォンを買いました
    - 買い替えた理由は、「FOMAが終わると聞いたから早めに慣れておきたい」というものです
    - 表向きもっともらしいことをいっていますが、本当はまわりの人がシュッとやっているのをみて母自身がやってみたくなった**だけ**なのだとおもいます
    - スマートフォンはファッションなのです
    - パカパカの携帯電話はいやだ、あたいもスマホがいい
    - いくつになっても女心は枯れてはいないとでも申しましょうか
- ショップに行ったら、本人は買いたいと言っているのに店員からは止められる始末
    - 値段の高い端末しかショップにはおいてなくてお値打ち価格のものは入荷まで1ヶ月かかると言われて、「もう一度検討する」と言って帰りました
    - 母のスマホを買いたい気持ちは止められるはずもなく、[docomo Online Shop](https://onlineshop.smt.docomo.ne.jp/)を利用したら2日後に届いて初期設定をやってあげました
- [はじめてスマホプラン](https://www.nttdocomo.co.jp/charge/hajimete_plan/)です
    - 1GB/月で全然いいんです
    - 余ります
        - 4/16現在、残りは0.98GBありました
    - 実家にインターネットは引いてありまして、Wi-Fiルーターはありますし、ほとんど家からでることはありませんし、外にでかけるときもスマホは**忘れておいていく**ので1GBでギガは十分足ります
    - そもそも母には意味がわかりませんし、いいんです
    - 外で動画みたりするわけないし、そもそも動画アプリの起動ができるかあやしいし
- <font color="purple">$\huge{5G}$</font>
    - 対応機種です
    - 実家はど田舎なので、5Gとか来ていませんが4G圏内でよかったよかった
- そんな母が、「LINEは難しい」と言います
- LINEと接する機会を増やしたほうがいいだろうということではじめは私が手打ちでメッセージを送っていました
- ただ、だんだん
- 面倒くさくなってきました
- <font color="purple">$\huge{面倒くさくなってきました}$</font>
- そこでボット :robot: に代行してもらうことにしました
    - ちなみに母にボットと言っても通じないので「ロボット」が送っていると説明しています
- こういう用途に、[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)はうってつけだとおもいます
- [Nerves](https://www.nerves-project.org/)ならできるもん！　ということで、[Elixir](https://elixir-lang.org/)というプログラミング言語をつかって、Raspberry Piで動かすのがいま一番私が得意とすることですが、それだとイベントに参加できないし、たまには違うことやってみるのが「**そこがいいんじゃない！[^1]**」ということでAzure FunctionsでJavaのプログラムをイゴかしたいとおもいます
- まだ読んだことはありませんが、[みうらじゅん](http://miurajun.net/)さんの[親孝行プレイ](https://www.amazon.co.jp/dp/4043434065/)に通じるものがあるのではないかと勝手におもっています

[^1]: [2021年本屋大賞 『発掘部門』 「超発掘本！」](https://www.hontai.or.jp/find/vote2021.html)の『「ない仕事」の作り方』 より

# 準備
- [Azure Functions(Java)を利用するための準備運動](https://qiita.com/torifukukaiou/items/b6557ce35e18e1502e23)
- にまとめました
- もうひとつ準備が必要です
    - [ローカルでの Azure Storage の開発に Azurite エミュレーターを使用する](https://docs.microsoft.com/ja-jp/azure/storage/common/storage-use-azurite)を参考に、Azurite オープンソース エミュレーターをインストールしておいてください
        - [Azurite Visual Studio Code の拡張機能をインストールして実行する](https://docs.microsoft.com/ja-jp/azure/storage/common/storage-use-azurite#install-and-run-the-azurite-visual-studio-code-extension)でインストールしました
            - VSCodeの右下のほうに [Azurite Blob Service] と表示されているものがあるはずでそれを迷わず押しておくとよいです

![スクリーンショット 2021-04-16 1.30.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d06ad6fe-a98f-88bc-31f4-dd028efe2964.png)



- 以下、:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: の記事に書いていることは**スミ**[^2]の前提で書いていきます

[^2]: 昔、[銀牙 -流れ星 銀-](https://ja.wikipedia.org/wiki/%E9%8A%80%E7%89%99_-%E6%B5%81%E3%82%8C%E6%98%9F_%E9%8A%80-)という犬の漫画がありました。駄菓子屋でカードを売っていて、その中に当り🎯のカードがあるわけです。当りを引くと何をもらえたのかは忘れましたが、きなこ餅だかもう一枚だかをもらえました。その店の婆さんは景品と交換済みであることをわかるように油性マジックで**スミ**と書いてくださっていたことをおもいだしました。ああいうカードで子供のときはたくさん集めていたわけですがどこに行ってしまったのでしょうね。

# つくる
- 前置きが四の五の多かったですが、ここから先はあっさり楽勝です
- [クイックスタート: コマンド ラインから Azure に Java 関数を作成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-cli-java?tabs=bash%2Cazure-cli%2Cbrowser) という公式の手順を適宜読み替えてすすめていきます

## ① プロジェクトをつくる
- [ローカル関数プロジェクトを作成する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-cli-java?tabs=bash%2Cazure-cli%2Cbrowser#create-a-local-function-project)

```
mvn archetype:generate -DarchetypeGroupId=com.microsoft.azure \
-DarchetypeArtifactId=azure-functions-archetype \
-DjavaVersion=11 \
-DgroupId=tokyo.torifuku \
-DartifactId=torifuku-functions \
-Dtrigger=TimerTrigger
```

- `TimerTrigger`の指定は、こちらの記事にて教えてもらいました
    - [Azure Functions（Java）のTimerTriggerをローカルで動かしてみる](https://kazuhira-r.hatenablog.com/entry/2021/03/26/200101)
    - ありがとうございます！

## ② プログラム書く、書く、書く

```xml:pom.xml
        <dependency>
            <groupId>com.linecorp.bot</groupId>
            <artifactId>line-bot-api-client</artifactId>
            <version>4.3.0</version>
        </dependency>

        <dependency>
            <groupId>com.linecorp.bot</groupId>
            <artifactId>line-bot-model</artifactId>
            <version>4.3.0</version>
        </dependency>

        <dependency>
            <groupId>com.google.code.gson</groupId>
            <artifactId>gson</artifactId>
            <version>2.8.5</version>
        </dependency>
    </dependencies>
```

```diff:pom.xml
                     <!-- function app name -->
                     <appName>${functionAppName}</appName>
                     <!-- function app resource group -->
-                    <resourceGroup>java-functions-group</resourceGroup>
+                    <resourceGroup>java-torifuku-functions-20210411122137476</resourceGroup>
                     <!-- function app service plan name -->
                     <appServicePlanName>java-functions-app-service-plan</appServicePlanName>
                     <!-- function app region-->
                     <!-- refers https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Functions:-Configuration-De
tails#supported-regions for all valid values -->
-                    <region>westus</region>
+                    <region>japaneast</region>
                     <!-- function pricingTier, default to be consumption if not specified -->
                     <!-- refers https://github.com/microsoft/azure-maven-plugins/wiki/Azure-Functions:-Configuration-Details#supported-pricing-tiers for all valid values -->
                     <!-- <pricingTier></pricingTier> -->
@@ -76,7 +94,7 @@
                     <!-- <disableAppInsights></disableAppInsights> -->
                     <runtime>
                         <!-- runtime os, could be windows, linux or docker-->
-                        <os>windows</os>
+                        <os>linux</os>
                         <javaVersion>11</javaVersion>
                         <!-- for docker function, please set the following parameters -->
                         <!-- <image>[hub-user/]repo-name[:tag]</image> -->
```
- `windows`だと、[Bing News Search API](https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/search-the-web)で取得したデータが文字化けしていたので`linux`にしました
- 他のもっといい解決方法があるかもしれません
- とりあえず母親に送りつけることができればいいのでOSは問いません

### [クイック スタート:Java と Bing News Search REST API を使用してニュース検索を実行する](https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/java)
- リンク先を参考にしてつくりました
- ほぼ同じです
- こちらもMicrosoft様のサービスです
- ありがとうございます！

```java:src/main/java/tokyo/torifuku/BingNewsSearch.java
package tokyo.torifuku;

import java.io.InputStream;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

import javax.net.ssl.HttpsURLConnection;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class BingNewsSearch {
    // Add your Bing Search V7 subscription key to your environment variables.
    static String subscriptionKey = System.getenv("BING_SEARCH_V7_SUBSCRIPTION_KEY");

    // Add your Bing Search V7 endpoint to your environment variables.
    static String endpoint = "https://api.bing.microsoft.com/v7.0/news/search";

    public static SearchResults searchNews(String searchQuery) throws Exception {
        // Construct URL of search request (endpoint + query string)
        URL url = new URL(endpoint + "?q=" +  URLEncoder.encode(searchQuery, "UTF-8") + "&setLang=ja-JP" + "&mkt=ja-JP");
        HttpsURLConnection connection = (HttpsURLConnection)url.openConnection();
        connection.setRequestProperty("Ocp-Apim-Subscription-Key", subscriptionKey);

        // Receive JSON body
        InputStream stream = connection.getInputStream();
        Scanner scanner = new Scanner(stream);
        String response  = scanner.useDelimiter("\\A").next();
        JsonObject jsonResponse = new JsonParser().parse(response).getAsJsonObject();

        // Construct result object for return
        SearchResults results = new SearchResults(new HashMap<String, String>(), jsonResponse);

        // Extract Bing-related HTTP headers
        Map<String, List<String>> headers = connection.getHeaderFields();
        for (String header : headers.keySet()) {
            if (header == null) continue;      // may have null key
            if (header.startsWith("BingAPIs-") || header.startsWith("X-MSEdge-")) {
                results.relevantHeaders.put(header, headers.get(header).get(0));
            }
        }

        scanner.close();
        stream.close();

        return results;
    }

    // Pretty-printer for JSON; uses GSON parser to parse and re-serialize
    public static String prettify(JsonObject json) {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        return gson.toJson(json);
    }
}
```

```java:src/main/java/tokyo/torifuku/SearchResults.java
package tokyo.torifuku;

import java.util.HashMap;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class SearchResults {
    HashMap<String, String> relevantHeaders;
    JsonObject jsonResponse;
    SearchResults(HashMap<String, String> headers, JsonObject json) {
        relevantHeaders = headers;
        jsonResponse = json;
    }

    public String topNews() {
        JsonArray array = jsonResponse.getAsJsonArray("value");
        JsonObject first = array.get(0).getAsJsonObject();
        String name = first.get("name").getAsString();
        String url = first.get("url").getAsString();

        return name + "\n\n" + url;
    }
}
```

### LINEのメッセージをおくる
- [プッシュメッセージを送る](https://developers.line.biz/ja/reference/messaging-api/#send-push-message)のJavaのコードを参考に書きます

```java:src/main/java/tokyo/torifuku/Postman.java
package tokyo.torifuku;

import com.linecorp.bot.model.PushMessage;
import com.linecorp.bot.model.message.TextMessage;
import com.linecorp.bot.client.LineMessagingClient;
import java.util.concurrent.ExecutionException;

public class Postman {
    public void post(String message) {
        final LineMessagingClient client = LineMessagingClient
        .builder(System.getenv("LINE_CHANNEL_ACCESS_TOKEN"))
        .build();

        final TextMessage textMessage = new TextMessage(message);
        final PushMessage pushMessage = new PushMessage(
            System.getenv("LINE_TO"),
            textMessage);

        try {
            client.pushMessage(pushMessage).get();
        } catch (InterruptedException | ExecutionException e) {
            e.printStackTrace();
            return;
        }
    }
}
```

### 定期的に実行する`run`メソッド

```java:src/main/java/tokyo/torifuku/Function.java
package tokyo.torifuku;

import java.time.*;
import com.microsoft.azure.functions.annotation.*;
import com.microsoft.azure.functions.*;

/**
 * Azure Functions with Timer trigger.
 */
public class Function {
    /**
     * This function will be invoked periodically according to the specified schedule.
     */
    @FunctionName("Function")
    public void run(
        @TimerTrigger(name = "timerInfo", schedule = "0 30 21 * * *") String timerInfo,
        final ExecutionContext context
    ) {
        context.getLogger().info("Java Timer trigger function executed at: " + LocalDateTime.now());

        Postman kevin = new Postman();
        kevin.post("おはようございます");

        SearchResults result;
        try {
            result = BingNewsSearch.searchNews("");

            context.getLogger().info(BingNewsSearch.prettify(result.jsonResponse));

            String topNews = result.topNews();
            context.getLogger().info(topNews);
            kevin.post(topNews);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
```

- `schedule`は`run`メソッドをRunさせる時間をUTCで指定しています
- 上の例ですと日本時間の06:30に送りつけることになります
- 朝は05:00くらいから母は起きだしてごそごそしているので問題ないです
- `Postman`のインスタンス名はもちろん`kevin`にしました[^3]
    - 城戸利成(元オートレース選手)と迷ったのですが、わかる人が少ないかなあとおもいまして世界的スターのほうを採用しました[^4]


### 設定値
- `BING_SEARCH_V7_SUBSCRIPTION_KEY`
- `LINE_CHANNEL_ACCESS_TOKEN`
- `LINE_TO`

```json:local.settings.json
{
  "IsEncrypted": false,
  "Values": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true",
    "FUNCTIONS_WORKER_RUNTIME": "java",
    "BING_SEARCH_V7_SUBSCRIPTION_KEY": "secret",
    "LINE_CHANNEL_ACCESS_TOKEN": "secret",
    "LINE_TO": "secret"
  }
}
```

[^3]: [ポストマン](https://ja.wikipedia.org/wiki/%E3%83%9D%E3%82%B9%E3%83%88%E3%83%9E%E3%83%B3_(1997%E5%B9%B4%E3%81%AE%E6%98%A0%E7%94%BB))の主演[ケビン・コスナー](https://ja.wikipedia.org/wiki/%E3%82%B1%E3%83%93%E3%83%B3%E3%83%BB%E3%82%B3%E3%82%B9%E3%83%8A%E3%83%BC)さん

[^4]: 城戸利成選手のことです。競争車名に「ポストマン」を使われていたことがありました。第20回日本選手権オートレースにおいて優出を果たしているすごい選手です。


## ③ ローカルでイゴかす
- [関数をローカルで実行する](https://docs.microsoft.com/ja-jp/azure/azure-functions/create-first-function-cli-java?tabs=bash%2Cazure-cli%2Cbrowser#run-the-function-locally)
- 待ちきれない場合は、`schedule`の値を調整してください

```
mvn clean package
mvn azure-functions:run
```

## ④ デプロイする
- [Azure 関数をデプロイする](https://docs.microsoft.com/ja-jp/learn/modules/develop-azure-functions-app-with-maven-plugin/7-exercise-deploy-function-azure)

```
mvn clean package azure-functions:deploy
```

- 設定値を設定しておいてください
    - `BING_SEARCH_V7_SUBSCRIPTION_KEY`
    - `LINE_CHANNEL_ACCESS_TOKEN`
    - `LINE_TO`

![スクリーンショット 2021-04-16 2.05.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4edc02e8-3dea-301b-dec7-6b14fdfee47a.png)

- 以上で、毎朝06:30にBing News Search APIで取得したとれたて新鮮ニュースがLINEメッセージとして配信されるはずです :robot::rocket::rocket::rocket: 
![Screenshot_20210416_021014_jp.naver.line.android.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/091b1d50-9453-6465-cf56-86d6207688fa.jpeg)

# 2021/05/01 追記
- 次は文字入力の練習だとおもい、ボットが返事するようにしてみました
- あんまり自信はないのですが[Node.js](https://nodejs.org/ja/)をなんとなく見様見真似で書いてみました
    - [express](https://www.npmjs.com/package/express)
    - [@line/bot-sdk](https://www.npmjs.com/package/@line/bot-sdk)
    - [axios](https://www.npmjs.com/package/axios)
- [Azure VM](https://azure.microsoft.com/ja-jp/services/virtual-machines/)でイゴかしています
    - 素朴に `node index.js`
- [Talk API](https://a3rt.recruit-tech.co.jp/product/talkAPI/)を利用させていただいています

```javascript:index.js 
const express = require('express');
const line = require('@line/bot-sdk');
const axios = require('axios');
const { response } = require('express');

const config = {
  channelAccessToken: 'ひみつ',
  channelSecret: 'ひみつ'
};

const app = express();
app.post('/webhook', line.middleware(config), (req, res) => {
  Promise
    .all(req.body.events.map(handleEvent))
    .then((result) => res.json(result));
});

const client = new line.Client(config);
function handleEvent(event) {
  console.log(event);
  if (event.type !== 'message' || event.message.type !== 'text') {
    return Promise.resolve(null);
  }

  if (['カード', '家計簿', 'かけいぼ'].filter((element) => { return event.message.text.match(element); }).length > 0) {
    return client.replyMessage(event.replyToken, {
      type: 'text',
      text: 'カード明細のまとめです。ご確認ください。https://docs.google.com/spreadsheets/d/ひみつ/preview'
    });
  }

  runBot(event);
}

async function runBot(event) {
  const params = new URLSearchParams();
  params.append('apikey', 'ひみつ');
  params.append('query', event.message.text);
  const response = await axios.post('https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk', params)

  if (response.data.status === 0) {
    const replyText = response.data.results[0].reply;

    return client.replyMessage(event.replyToken, {
      type: 'text',
      text: replyText
    });
  } else {
    return Promise.resolve(null);
  }
}

app.listen(3000);
```

## ボットとの会話を楽しんでいる様子
- 楽しんでくれているようです

![Screenshot_20210501_153952_jp.naver.line.android.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b94e9c6a-dbb0-18bf-1b9a-798d739f0e05.jpeg)

![Screenshot_20210501_150955_jp.naver.line.android (1).jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3dcb6260-cb66-8060-65eb-28284f213651.jpeg)



# Wrapping up :lgtm::lgtm::lgtm::lgtm:
- とても簡単に**親孝行**ができるようになりました
- Azureの利用料はほとんどかかっていません
    - [リソース グループ](https://docs.microsoft.com/ja-jp/azure/azure-resource-manager/management/manage-resource-groups-portal#what-is-a-resource-group)をわけているのですが0円な気がします
    - まだ使いはじめて1年以内のアカウントなので無料枠の適用があるのかもしれません
- みなさんも[Azure Functions](https://azure.microsoft.com/ja-jp/services/functions/)を使って、お手軽になにかの定期実行をしてみてはいかがでしょうか
- Happy coding!!!

# 最後に
- 私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです 
- ここからは同じことを[Elixir](https://elixir-lang.org/)でやってみます

## プロジェクトをつくる

```
$ mix new good_son --sup
$ cd good_son
```

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:quantum, "~> 3.0"}
    ]
  end
```

```
$ cd good_son
$ mix deps.get
```

## プログラムを書く
- 詳しい解説はしますまい
- 感じてください

```elixir:lib/good_son/scheduler.ex
defmodule GoodSon.Scheduler do
  use Quantum, otp_app: :good_son
end
```

```elixir:lib/good_son/application.ex
defmodule GoodSon.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: GoodSon.Worker.start_link(arg)
      # {GoodSon.Worker, arg}
      GoodSon.Scheduler # add
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoodSon.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

### Bing News Search

```elixir:lib/good_son/bing_news_search.ex
defmodule GoodSon.BingNewsSearch do
  @subscription_key "secret"

  def top_news do
    search()
    |> Map.get("value")
    |> Enum.at(0)
  end

  def search do
    "https://api.bing.microsoft.com/v7.0/news/search?q=&setLang=ja-JP&mkt=ja-JP"
    |> HTTPoison.get!("Ocp-Apim-Subscription-Key": @subscription_key)
    |> Map.get(:body)
    |> Jason.decode!()
  end
end
```

### LINE

```elixir:lib/good_son/line.ex
defmodule GoodSon.Line do
  @to "secret"
  @channel_access_token "secret"

  def push(msg \\ "Hello") do
    body =
      %{
        to: @to,
        messages: [
          %{
            type: "text",
            text: msg
          }
        ]
      }
      |> Jason.encode!()

    HTTPoison.post!(
      "https://api.line.me/v2/bot/message/push",
      body,
      "Content-Type": "application/json",
      Authorization: "Bearer #{@channel_access_token}"
    )
  end
end
```

### 06:30に実行する関数

```elixir:lib/good_son.ex
defmodule GoodSon do
  def run do
    GoodSon.Line.push("おはようございます")

    %{"name" => name, "url" => url} = GoodSon.BingNewsSearch.top_news()

    "#{name}\n\n#{url}"
    |> GoodSon.Line.push()
  end
end
```

```elixir:config/config.exs
import Config

config :good_son, GoodSon.Scheduler,
  jobs: [
    {"30 21 * * *", {GoodSon, :run, []}}
  ]
```

### 実行
```
$ iex -S mix
```

- とりあえずローカル(macOS)でイゴくところまででこの記事は終わります
- ぜひ次は、@erinさんの[Azure FunctionsをElixirで](https://qiita.com/erin/items/e76fa2aa5fd9f4644579) みたいなことをしたいです
- [Nerves](https://www.nerves-project.org/)は得意としておりますし楽しいのですが、いつか自分の手元のハードウェア(Raspberry Pi 2)は壊れることがあるでしょうし、そういうことはクラウドサービスにまかせチャオ[^5] というのはすごく便利です
- ありがとうございます！

[^5]: https://www.honda.co.jp/ciao/

# もう一度最後の最後に
## [Elixir](https://elixir-lang.org/)って何よ:interrobang:　という方へ
- 最後はがっつり[Elixir](https://elixir-lang.org/)でしめました

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

