---
title: Text to Speech REST API(Azure)を使ってみる(Elixir)
tags:
  - Azure
  - Elixir
  - Nerves
  - autoracex
private: false
updated_at: '2021-03-20T09:45:47+09:00'
id: a253a5afaa30d765a886
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- 長い間お世話になりました[docomo Developer support](https://dev.smt.docomo.ne.jp/)さんが3/31をもって[サービス終了](https://dev.smt.docomo.ne.jp/?p=notice.detail&news_id=306)とのことです
- 私は[音声合成【Powered by NTTテクノクロス】](https://dev.smt.docomo.ne.jp/?p=docs.api.page&api_name=text_to_speech&p_name=api_reference#tag01)を[Nerves](https://www.nerves-project.org/)アプリで利用させていただいておりました
    - ありがとうございました
    - @takasehideki先生と、[Interface 2021年1月号](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)にてこのAPIの使い方を記載させていただきました
- 残念ながら終了とのことで他のものにのせ替えを検討していました
- 「[Raspberry PIを喋らせよう　クラウドいろいろ](https://qiita.com/hiratarich/items/9035ef916cf471477ea9)」を拝見して、Azureの[Text to Speech](https://azure.microsoft.com/ja-jp/services/cognitive-services/text-to-speech/)サービスを使うことにしました
- なにせ私は「[日本マイクロソフト賞④](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)」受賞者ですから
- もう一回いいます
- <font color="purple">$\huge{日本マイクロソフト賞④}$</font>
- 受賞していますから
    - ありがとうございます！
- 本記事は2021/3/15(金)開催の[autoracex #16](https://autoracex.connpass.com/event/207338/)という純粋なもくもく会での成果です


## 2021/03/20 追記
- [ElixirでText to Speech REST API(Azure, ニューラル音声)を使ってみる](https://qiita.com/torifukukaiou/items/4ce31ea7f6041aae68be) の記事の内容のほうがソースコードが洗練されていますし、フレンドリーなボイスを聞くことができます

https://qiita.com/torifukukaiou/items/4ce31ea7f6041aae68be


# ドキュメント
- [Text to Speech REST API](https://docs.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech)

# 依存関係

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"}
    ]
  end
```

```
$ mix deps.get
```

# ソースコード
```elixir:lib/azure/text_to_speech.ex
defmodule Azure.TextToSpeech do
  @subscription_key "ひみつ"

  def run!(text) do
    access_token()
    |> voice(text)
  end

  def access_token do
    headers = [
      "Ocp-Apim-Subscription-Key": @subscription_key,
      "Content-type": "application/x-www-form-urlencoded"
    ]

    "https://japaneast.api.cognitive.microsoft.com/sts/v1.0/issuetoken"
    |> HTTPoison.post!("", headers)
    |> Map.get(:body)
  end

  def voices_list(token) do
    "https://japaneast.tts.speech.microsoft.com/cognitiveservices/voices/list"
    |> HTTPoison.get!(authorization_header(token))
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def voice(token, text) do
    headers =
      authorization_header(token)
      |> Keyword.merge(
        "Content-Type": "application/ssml+xml",
        "X-Microsoft-OutputFormat": "riff-24khz-16bit-mono-pcm",
        "User-Agent": "awesome"
      )

    locale = "ja-JP"
    gender = "Female"

    %{"Name" => name} =
      voices_list(token)
      |> Enum.filter(fn %{"Locale" => l} -> l == locale end)
      |> Enum.filter(fn %{"Gender" => g} -> g == gender end)
      |> Enum.random()

    body = """
    <speak version='1.0' xml:lang='#{locale}'>
      <voice xml:lang='#{locale}' xml:gender='#{gender}' name='#{name}'>
        <prosody volume="100.0">
          #{text}
        </prosody>
      </voice>
    </speak>
    """

    "https://japaneast.tts.speech.microsoft.com/cognitiveservices/v1"
    |> HTTPoison.post!(body, headers)
    |> Map.get(:body)
  end

  defp authorization_header(token) do
    [Authorization: "Bearer #{token}"]
  end
end
```

- `User-Agent`は必須って書いてあるけど、サンプルにはないし、実際なくても動いたしどうなんだろう？
- という件は[Issue](https://github.com/MicrosoftDocs/azure-docs/issues/72084)を書いてみました
- どうなるでしょう:interrobang::interrobang::interrobang:


## サブスクリプションキーの取得方法
- Azureにサインアップしましょう
- [Text to Speech](https://azure.microsoft.com/ja-jp/services/cognitive-services/text-to-speech/)のページにて「[Azure のご利用者なら、このサービスを今すぐ無料でお試しください](https://portal.azure.com/#create/Microsoft.CognitiveServicesSpeechServices)」のリンクから飛ぶのがわかりやすいです
    - 逆にコンソールから順にたどっていくやりかたではMarketplace? だかなんだかでてきて私にはよくわからなかったです

![スクリーンショット 2021-03-12 21.48.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cecce59b-ea00-2a07-ec88-d6b8653ec2b1.png)

- 飛んだ先のフォームでは、価格レベルは、**Free F0**を選びました
- [Cognitive Services の価格—Speech Services](https://azure.microsoft.com/ja-jp/pricing/details/cognitive-services/speech-services/)にあるように、standardの使い方なら、**1 か月あたり 5 million 文字まで無料**とのことらしいです
- (5 million 文字とか言われてもピンときていません)
- 毎朝ちょっとした天気予報をしゃべらせるくらいならきっと範囲内でしょう

# Run

```elixir
$ iex -S mix

iex> Azure.TextToSpeech.run!("こんにちは Azure awesome") |> (&(File.write("output.wav", &1))).()
```
- `output.wav`というファイルに書き出しています
- `(&(File.write("output.wav", &1))).()`はカッコばかり書いて
- <font color="purple">$\huge{カッコつけているだけです}$</font>

macOSなら

```
$ afplay output.wav
```

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

# 最後の最後に
## [Elixir](https://elixir-lang.org/)ってなによ:interrobang:という方へ

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

