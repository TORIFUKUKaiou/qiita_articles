---
title: 'ElixirでText to Speech REST API(Azure, ニューラル音声)を使ってみて、フレンドリーなヴォイスに驚く'
tags:
  - Azure
  - Elixir
  - Nerves
  - QiitaAzure
private: false
updated_at: '2021-03-31T00:38:21+09:00'
id: 4ce31ea7f6041aae68be
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [What's new in Azure Cognitive Services](https://myignite.microsoft.com/sessions/6f88c4fd-684e-431b-a5eb-1f101a0aba51?source=sessions)をみました
- 07:50くらいから紹介されている**Neural Voice**を[Elixir](https://elixir-lang.org/)で使ってみます
- COVID-19のAssessment(Azure Health Bot)を例にその話の流れから**Neural Voice**が紹介されています
    - _You might need to hear a friendly voice, especially when you're sick and worried._
    - フレンドリーなヴォイスを聞きたいよね、特に病気のときや心配ごとがあるときには。
- 私の[Nerves](https://www.nerves-project.org/)アプリケーションに組み込んで、朝、素敵なボイスで起こしてもらいたいとおもっています
    - [Nerves](https://www.nerves-project.org/)とは、[Elixir](https://elixir-lang.org/)でIoTが楽しめる[ナウでヤングでCoolなすごいやつです](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)
    - [An Evaluation of Real-Time Performance for Nerves](https://www.verypossible.com/resources/video/real-time-performance-of-nerves)
        - 2:00あたりをご覧ください
    - [TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
        - 私のごった煮[Nerves](https://www.nerves-project.org/)プロジェクト


https://qiita.com/official-events/a50e99d62dc62d68a9c9


# 前提
- [Azure](https://azure.microsoft.com/ja-jp/)のアカウント登録済み
- [Elixir](https://elixir-lang.org/)インストール済み
    - 手前味噌ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB) などをご参照ください

# [Text to Speech](https://azure.microsoft.com/ja-jp/services/cognitive-services/text-to-speech/)

## ドキュメント
- [Text to Speech REST API](https://docs.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech)
    - ここを参考にします

## [Text to Speech](https://azure.microsoft.com/ja-jp/services/cognitive-services/text-to-speech/)が使えるようにする
- Visit: https://portal.azure.com/#create/Microsoft.CognitiveServicesSpeechServices

![スクリーンショット 2021-03-20 7.07.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9e015f1b-cc5a-60b1-1c0b-ff31da621d71.png)

- 今回は**ニューラル音声**を使いたいので、サポートしているリージョンを選んでおいてください
- https://docs.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech#standard-and-neural-voices
    - どのリージョンを選べばよいのかについては、:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:を参照してください
    - 私は「(US) 米国東部」を選びました

## 料金
- 料金は、https://azure.microsoft.com/ja-jp/pricing/details/cognitive-services/speech-services/ をご参照ください
  - 1 か月あたり 0.5 million 文字まで無料
  - 「0.5 million 文字」というのは私にはあんまりピンときていませんが、毎朝ちょっとしたテキストを話すくらいなら全然だいじょうぶなのではないかとおもっちょります
  - 今日から使い始めますので、また1ヶ月後くらいに更新したいとおもいます

## ソースコード

```elixir:mix.exs
  defp deps do
    [
      ...
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"}
    ]
  end
```

- [HTTPoison](https://github.com/edgurgel/httpoison)と[Jason](https://github.com/michalmuskala/jason)を使います

```elixir:lib/azure/text_to_speech.ex
defmodule Azure.TextToSpeech do
  @subscription_key "secret"
  @locale "ja-JP"
  @gender "Female"
  @voice_type "Neural"

  def run!(text) do
    access_token()
    |> voice(text)
  end

  def access_token do
    headers = [
      "Ocp-Apim-Subscription-Key": @subscription_key,
      "Content-type": "application/x-www-form-urlencoded"
    ]

    "https://eastus.api.cognitive.microsoft.com/sts/v1.0/issuetoken"
    |> HTTPoison.post!("", headers)
    |> Map.get(:body)
  end

  def voices_list(token) do
    "https://eastus.tts.speech.microsoft.com/cognitiveservices/voices/list"
    |> HTTPoison.get!(authorization_header(token))
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def voice(token, text) do
    %{"Name" => name} = select_voice(token)

    headers =
      authorization_header(token)
      |> Keyword.merge(
        "Content-Type": "application/ssml+xml",
        "X-Microsoft-OutputFormat": "riff-24khz-16bit-mono-pcm",
        "User-Agent": "awesome"
      )

    "https://eastus.tts.speech.microsoft.com/cognitiveservices/v1"
    |> HTTPoison.post!(ssml(text, name), headers)
    |> Map.get(:body)
  end

  defp authorization_header(token) do
    [Authorization: "Bearer #{token}"]
  end

  defp select_voice(token) do
    voices_list(token)
    |> Enum.filter(fn %{"Locale" => l} -> l == @locale end)
    |> Enum.filter(fn %{"Gender" => g} -> g == @gender end)
    |> Enum.filter(fn %{"VoiceType" => vt} -> vt == @voice_type end)
    |> Enum.random()
  end

  defp ssml(text, name) do
    """
    <speak version='1.0' xml:lang='#{@locale}'>
      <voice xml:lang='#{@locale}' xml:gender='#{@gender}' name='#{name}'>
        <prosody volume="100.0">
          #{text}
        </prosody>
      </voice>
    </speak>
    """
  end
end
```

- `@subscription_key`にはAzureのポータル画面からキーを取得して値をセットしてください
- 「同じトークンを 9 分間使用することをお勧めします」は未実装
    - たぶん[Agent](https://hexdocs.pm/elixir/Agent.html)を使えばうまく書ける気がします
    - この記事では取り扱いません(サボり)

# Run! :robot: 

```elixir
$ mix deps.get

$ iex -S mix

iex> (
Azure.TextToSpeech.run!("Azure最高です!。Microsoft Igniteに参加してイベントに関する記事を投稿しよう！ 詳しくはこちらをご参照ください。https://qiita.com/official-events/a50e99d62dc62d68a9c9")
|> (&(File.write("output", &1))).()
)

iex> :os.cmd('afplay output')
```

- 再生コマンドはmacOSの例です
- Raspberry Piの場合は、 `aplay -q /tmp/output` な感じで再生してください
    - [Nerves](https://www.nerves-project.org/)の場合は、`/tmp/output` 等に音声データを書き出してください

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- フレンドリーな**ヴォイス**が得られました！
    - みなさんもお好きなプログラミング言語で、フレンドリーな音声を楽しんでみてください
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:

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


 
