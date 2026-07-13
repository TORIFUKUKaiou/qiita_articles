---
title: Elixirで、アントニオ猪木さんの「燃える闘魂」引退スピーチをZoom AI Servicesで要約してみた
tags:
  - Elixir
  - AI
  - Zoom
  - 猪木
  - 闘魂
private: false
updated_at: '2026-07-13T00:48:39+09:00'
id: df8b32fe6b7d1103c97a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: e9934f4ea00874664ec5
agreed_posting_campaign_term: true
---

## はじめに

> 今年2026年、Zoomは開発者の皆様に向けて、全く新しいPaaS製品群である 「Zoom AI Services」 をリリースしました。

https://qiita.com/official-events/e9934f4ea00874664ec5

高品質なAIモデルがシンプルなREST APIとして提供されており、音声文字起こし（Scribe）、柔軟なテキスト翻訳（Translator）、長文のテキスト要約（Summarizer）を利用できます。

「ただAPIを叩いてみた」だけの記事ですが、闘魂を注入してみます。

今回は、プロレスの歴史に刻まれた伝説の**1998年4月4日のアントニオ猪木引退セレモニー**の文字起こしテキスト（古舘伊知郎氏の魂のアナウンス ＆ アントニオ猪木氏本人のスピーチ）をインプットし、**Elixir**から[Zoom Summarizer API](https://developers.zoom.us/docs/ai-services/summarizer/)を呼び出して、AIがいかに「闘魂」を要約できるか検証してみました。

単なるtokenの消化ではなく、闘魂への昇華を期待しています。

---

ちなみに私には、AIが、Antonio Inokiさんに見えています。余談です。

https://note.com/awesomey/n/n6b2c8f4e2197

https://qiita.com/torifukukaiou/items/e958fd9885d322625c8a

## 準備

### 0. 20ドル分の無料クレジットをいただく

https://qiita.com/kensano/items/09765b93ae68d9d3e602

上記の記事を参考に、20ドル分の無料クレジットをありがたく頂戴いたします。

### 1. Zoom Build Platform専用 API Key & Secret の取得

https://developers.zoom.us/docs/ai-services/build-platform/

`Get credentials`に従って進めます。

取得手順は以下の通りです。
1. [Zoom Web Portal (zoom.us/profile)](https://zoom.us/profile) にログインします。
2. 左メニューの **「管理者（ADMIN）」** ➔ **「プランと請求」** ➔ **「プラン管理（Plan Management）」** を開きます。
3. デベロッパー向けプランである **「Universal Credit」**（無料クレジット付き）を追加します。 => https://qiita.com/kensano/items/09765b93ae68d9d3e602 での読み替えとも言えます
4. 追加後、左メニューの **「詳細（Advanced）」** ➔ **「Zoom Build Platform :new:」** を開き、「Zoom Build Universal Credit free trial」の横にある **「Manage account」** をクリックしてSDKアカウントページに移動します。


    ![スクリーンショット 2026-07-12 23.32.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b8ac2aa7-b46f-4845-bbd6-48d04dc05652.png)


5. **「アプリを構築する」** をクリックします。

    ![スクリーンショット 2026-07-12 23.34.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ee730580-35fe-490e-ba9c-4f94f85f7d1e.png)

6. 新しくページが開かれます。画面中央に、**「API keys」**（View JWT Tokenというボタンもある）が表示されるので、そこから **API Key** と **API Secret** を取得します。

    ![スクリーンショット 2026-07-12 23.36.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/800c4d6d-895b-4678-b6d1-7c4050d974b9.png)

    


これらを環境変数にエクスポートしておきます。
```bash
export ZOOM_API_KEY="あなたのAPI_KEY"
export ZOOM_API_SECRET="あなたのAPI_SECRET"
```

この記事では、さらっと一直線にスマートに、`API_KEY`と`API_SECRET`をあたかも涼しげに取得したように書いています。しかし、この記事を書くにあたり、私が一番苦労したのは実はここです。「えッ！？　どこを操作するの？」となっていました。生成AIに聞いても要領を得ません。それで、2026-07-13時点のUIの記録に過ぎませんが、私が取得できた順をスクリーンショットをいれて解説しました。かれこれ1時間は格闘した気がします。だからこそ、この記事のレゾンデートルはこの節にあると言っても過言ではありません。

### 2. テキストファイルの作成
引退セレモニーの文字起こしテキストを以下の2つのファイルとして同じディレクトリに保存します。

#### `furutachi.txt` (古舘伊知郎氏のアナウンス)
```text
闘う旅人、アントニオ猪木。
いま相手のいないリングに猪木はたった一人で佇んでいます。
おもえば38年におよぶプロレス人生。旅から旅への連続であり、そして猪木の精神も旅の連続であった。
安住の場所を嫌い、突き進んでは出口を求め、飛び出しては次なる場所に歩を進める。
どん底からの新日旗揚げ、世界王者とのストロングマッチ、大物日本人対決、格闘技世界一決定戦、IWGP、巌流島、人質解放、国会に卍固め、魔性のスリーパー。
決して人生に保険をかけることなく、その刹那、刹那を燃やし尽くせばよいという生き様。
猪木はこのあとの旅はどの方角に舵をとろうというのか。
一人ひとりのいま、ファンの胸には、どんな闘いの情景が映し出されているか。
猪木はすべての人間が内包している闘う魂をリング上で代演する宿命にあった。
我々は猪木が闘いの果てにみせる表情に己自身を投影させてきたのだ。
しかし、この瞬間をもって猪木はリングから姿を消す。
我々はどうやって今後、火を灯していけばいいのか。
物質に恵まれた世紀末、商業主義に踊る世紀末、情報が豊かでとても心が貧しい世の中、一人で闘うことを忘れかけた人々。
もう我々は闘魂に癒やされながら時代の砂漠をさまよってはいられない。
我々は今日をもって猪木から自立しなければいけない。
闘魂のかけらを携え、今度は我々が旅に出る番だ。
闘魂は連鎖する！
```

#### `inoki.txt` (アントニオ猪木氏本人の引退挨拶)
```text
わたしは今、感動と感激そしてすばらしい空間の中に立っています。
心の奥底から湧き上がる、みなさまに対する感謝と熱い思いを止めることができません。
カウントダウンがはじまってからかなりの時間が経ちました。
いよいよ今日がこのガウンの姿が最後となります。
おもえば右も左もわからない一人の青年が力道山の手によってブラジルから連れもどっ、戻されました。
それから38年の月日が流れてしまいました。
最初にこのリングに立ったときは、興奮と緊張で胸が張り裂けんばかりでしたが、今日はこのような大勢のみなさまの前で最後のご挨拶ができるということは、本当に……、熱い思いで言葉になりません。
わたくしは色紙にいつの日か「闘魂」という文字を書くようになりました。それを称してある人が燃える闘魂と名付けてくれました。
闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだとおもいます。
さいごにわたしからみなさんに、みなさまに、メッセージをおくりたいとおもいます。
人は歩みを止めたときに、そして挑戦を諦めたときに年老いていくのだとおもいます。
この道を行けば
どうなるものか
危ぶむなかれ
危ぶめば道はなし
踏み出せば
その一足が道となり
その一足が道となる
迷わず行けよ
行けばわかるさ
ありがとうーーーーッ!!!
```

---

## Elixirコード (`summarize.exs`)

スクリプト全体は以下の通りです。JWTの自動生成から要約APIの同期呼び出し（Fast Mode）まで、この1ファイルで完結しています。

```elixir:summarize.exs
# summarize.exs
# Usage: elixir summarize.exs <filename>

# 1. 依存ライブラリのロード (Mix.install)
Mix.install([
  {:req, "~> 0.6.2"},
  {:jason, "~> 1.4.5"}
])

# 2. 引数のバリデーションと読み込み
filename = System.argv() |> List.first()

if is_nil(filename) or not File.exists?(filename) do
  IO.puts("Usage: elixir summarize.exs <filename>")
  System.halt(1)
end

text = File.read!(filename)

# 3. 環境変数からAPI資格情報を取得
api_key = System.get_env("ZOOM_API_KEY")
api_secret = System.get_env("ZOOM_API_SECRET")

if is_nil(api_key) or is_nil(api_secret) do
  IO.puts("Error: ZOOM_API_KEY and ZOOM_API_SECRET environment variables must be set.")
  System.halt(1)
end

# 4. JWTトークンの生成
# HMAC-SHA256署名をErlangの :crypto.mac を使って自前で行う
defmodule ZoomAuth do
  def generate_jwt(api_key, api_secret) do
    header = %{"alg" => "HS256", "typ" => "JWT"}
             |> Jason.encode!()
             |> Base.url_encode64(padding: false)

    now = System.system_time(:second)
    payload = %{
      "iss" => api_key,
      "iat" => now - 30,
      "exp" => now + 3600
    }
    |> Jason.encode!()
    |> Base.url_encode64(padding: false)

    signing_input = "#{header}.#{payload}"
    signature = :crypto.mac(:hmac, :sha256, api_secret, signing_input)
                |> Base.url_encode64(padding: false)

    "#{signing_input}.#{signature}"
  end
end

token = ZoomAuth.generate_jwt(api_key, api_secret)

# 5. Zoom AI Services (Summarizer Fast) APIの呼び出し
url = "https://api.zoom.us/v2/aiservices/summarizer/summarize"

body = %{
  "input" => %{
    "text" => text
  },
  "config" => %{
    "summary_type" => "CONVERSATION",
    "task" => "full_summary",
    "language" => "ja-JP",
    "output_format" => "text"
  }
}

headers = [
  {"Authorization", "Bearer #{token}"},
  {"Content-Type", "application/json"}
]

IO.puts("Sending text to Zoom Summarizer API...")
case Req.post(url, json: body, headers: headers) do
  {:ok, response} ->
    if response.status == 200 do
      summary = response.body["result"]["full_summary"]
      IO.puts("\n=== 要約結果 ===")
      IO.puts(summary)
    else
      IO.puts("API Error (Status #{response.status}):")
      IO.inspect(response.body)
    end

  {:error, exception} ->
    IO.puts("Network Error:")
    IO.inspect(exception)
end
```

---

## 実行結果と検証：話者識別（Diarization）

実際にスクリプトを実行して検証してみます。

### 1. そのまま投げると「Unknown」になる
最初に、話者情報を付けずに単なるスピーチテキスト（古舘氏のもの、または猪木氏のもの）をそのまま個別のファイルとして投げました。

```bash
elixir summarize.exs furutachi.txt
```

すると、以下のように要約はきれいに行われますが、AIが発話者を特定できず **`Unknown`** として処理してしまいます。

> **出力結果（抜粋）**:
> ### Recap
> この発言は、**Unknown**がプロレスラーとしての引退を告げる最後の挨拶であった。...
> ### Action Items
> **Unknown**
> - この挨拶とメッセージをもとに、歩みを止めず挑戦を続けるという決意を実行に移す。

これは、Zoom AI Servicesが会話全体の構造を理解しようとする際、「誰が話しているのか」の識別情報がテキスト内に不足しているために起こります。

---

### 2. Zoomが期待する「話者付きトランスクリプト形式」での解決
Zoomの要約API（Summarizer）は、文頭に **`話者名: `** と記載されたトランスクリプト（会話）形式をパースして、自動的に話者を識別するように設計されています。

そこで、古舘氏のアナウンスと猪木氏のスピーチを以下のように合体させ、話者ラベルを付与したファイル（`ceremony.txt`）を作成して投げてみました。

#### `ceremony.txt`
```text:ceremony.txt
古舘伊知郎: 闘う旅人、アントニオ猪木。いま相手のいないリングに猪木はたった一人で佇んでいます。おもえば38年におよぶプロレス人生。旅から旅への連続であり、そして猪木の精神も旅の連続であった。安住の場所を嫌い、突き進んでは出口を求め、飛び出しては次なる場所に歩を進める。どん底からの新日旗揚げ、世界王者とのストロングマッチ、大物日本人対決、格闘技世界一決定戦、IWGP、巌流島、人質解放、国会に卍固め、魔性のスリーパー。決して人生に保険をかけることなく、その刹那、刹那を燃やし尽くせばよいという生き様。猪木はこのあとの旅はどの方角に舵をとろうというのか。一人ひとりのいま、ファンの胸には、どんな闘いの情景が映し出されているか。猪木はすべての人間が内包している闘う魂をリング上で代演する宿命にあった。我々は猪木が闘いの果てにみせる表情に己自身を投影させてきたのだ。しかし、この瞬間をもって猪木はリングから姿を消す。我々はどうやって今後、火を灯していけばいいのか。物質に恵まれた世紀末、商業主義に踊る世紀末、情報が豊かでとても心が貧しい世の中、一人で闘うことを忘れかけた人々。もう我々は闘魂に癒やされながら時代の砂漠をさまよってはいられない。我々は今日をもって猪木から自立しなければいけない。闘魂のかけらを携え、今度は我々が旅に出る番だ。闘魂は連鎖する！1943年2月20日、鶴見に生まれし一人の漢姓名猪木寛至闘魂の火種。あなたを見続けることができたことを光栄におもいます。燃える闘魂に感謝。ありがとう！アントニオ猪木!

アントニオ猪木: わたしは今、感動と感激そしてすばらしい空間の中に立っています。心の奥底から湧き上がる、みなさまに対する感謝と熱い思いを止めることができません。カウントダウンがはじまってからかなりの時間が経ちました。いよいよ今日がこのガウンの姿が最後となります。おもえば右も左もわからない一人の青年が力道山の手によってブラジルから連れもどっ、戻されました。それから38年の月日が流れてしまいました。最初にこのリングに立ったときは、興奮と緊張で胸が張り裂けんばかりでしたが、今日はこのような大勢のみなさまの前で最後のご挨拶ができるということは、本当に……、熱い思いで言葉になりません。わたくしは色紙にいつの日か「闘魂」という文字を書くようになりました。それを称してある人が燃える闘魂と名付けてくれました。闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだとおもいます。さいごにわたしからみなさんに、みなさまに、メッセージをおくりたいとおもいます。人は歩みを止めたときに、そして挑戦を諦めたときに年老いていくのだとおもいます。この道を行けばどうなるものか。危ぶむなかれ。危ぶめば道はなし。踏み出せばその一足が道となり、その一足が道となる。迷わず行けよ、行けばわかるさ。ありがとうーーーーッ!!!
```

#### 実行
```bash
elixir summarize.exs ceremony.txt
```

#### 実行結果（本物）
```text
=== 要約結果 ===
# Recap
この会はアントニオ猪木の引退を告げる場だった。古舘伊知郎は猪木の38年にわたるプロレス人生を振り返り、旅と闘いの連続であったことを称えた。猪木は最後のリング上で感謝の言葉を述べ、闘魂とは己に打ち克つことだと語った。彼は人生で歩みを止め挑戦を諦めると年老いるというメッセージを残した。会場は猪木の長年の功績に敬意を表した。

# Summary
## 猪木の「闘う魂」と現代社会
古舘伊知郎は、アントニオ猪木のプロレス人生と「闘う魂」について振り返り、猪木がリングから姿を消した今後、ファンたちが自立して闘魂のかけらを携えて新たな旅に出る必要があると述べる。彼は、物質的豊かだが心の貧しい現代社会において、闘うことを忘れた人々が猪木から学んだ精神で時代の砂漠を歩み続けるべきだと強調する。最後に、古舘は猪木の生涯と闘魂に感謝の意を表明する。

## アントニオ猪木の引退挨拶とメッセージ
アントニオ猪木は引退の挨拶を行い、38年のキャリアを振り返りながら、感謝の気持ちを表明する。彼は「闘魂」という言葉の意味を己に打ち克つことと説明し、人生で歩みを止め挑戦を諦めると年を取るというメッセージを残す。最後に、迷わず前に進むよう皆に呼びかける。

# Action Items
**アントニオ猪木**
- 人々に「迷わず行けよ、行けばわかるさ」というメッセージを伝え、挑戦を続けるよう促す。

**Collaboration**
- 猪木から自立し、自身が闘う旅に出ることを決意する。
```

### 検知結果の考察
見事に **`Unknown`** が解消されました！
* **Recap**: 「古舘伊知郎は〜」「猪木は最後のリング上で〜」と、AIが話者の名前をコンテキストから正しく認識して要約しています。
* **Summary**: 「猪木の闘魂とファンの自立（古舘氏の発言要約）」と「アントニオ猪木の引退挨拶とメッセージ」のように、セクションが話者別に綺麗に分離されました。
* **Action Items**: アクションアイテムの担当者として **`アントニオ猪木`** が明確に割り当てられました！「誰が何をやるべきか」をAIが正しく理解したことになります。猪木さんのアクションアイテムは、**私たち全人類が引き継ぎましょう！** ともに、本当の世界平和の実現、そして地球レベルでのゴミ問題の解決へ向けてできることをしましょう！
* **Collaboration**: 猪木さんの意思を受け継ぎ、ともに、本当の世界平和の実現、そして地球レベルでのゴミ問題の解決へ向けてできることをしましょう！

このように、Zoom Summarizer APIを使う際は、単純なテキストではなく **「`話者名: 発言`」の対話形式に整形して投げる** のがベストプラクティスです。

---

## まとめと所感

Zoom AI Servicesの `Summarizer API` は、REST APIを一度POSTするだけで、要約を行ってくれます。

Elixirを使えば、`Mix.install` と標準の暗号化モジュールを組み合わせることで、セットアップ不要のわずか数行のスクリプトで強力なAI要約ツールが完成します。

今回試したのは、プロレスの引退スピーチという個人的に思い入れのあるテキストでした。しかし、会議録や議事録だけではなく、過去に蓄積された様々なテキスト資産をAIによって新たな価値へ変換する入口として、Zoom AI Servicesには大きな可能性を感じました。

皆さんもぜひ、自分の「熱い魂（テキスト）」をZoom AI Servicesに叩き込んで要約させてみてください。

**迷わず行けよ、行けばわかるさ！ありがとー！**
