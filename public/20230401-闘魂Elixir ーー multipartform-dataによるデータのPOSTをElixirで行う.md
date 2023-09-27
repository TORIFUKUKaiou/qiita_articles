---
title: 闘魂Elixir ーー multipart/form-dataによるデータのPOSTをElixirで行う
tags:
  - Elixir
  - OpenAI
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-04-01T19:42:05+09:00'
id: 52a4d32fce9b833dc567
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

この記事は、[multipart/form-data](https://e-words.jp/w/multipart-form-data.html)によるデータのPOSTを[Elixir](https://elixir-lang.org/)で行います。
題材は、[OpenAI](https://openai.com/)が提供している[Speech to text](https://platform.openai.com/docs/guides/speech-to-text) APIを使います。

# サマリ

サマリです。

- [HTTPoison](https://github.com/edgurgel/httpoison)での実装方法がわかりました
- [Openai.ex](https://github.com/mgallo/openai.ex) Hexでは、[HTTPoison](https://github.com/edgurgel/httpoison)を利用して実装されていました
- [Req](https://github.com/wojtekmach/req)での実装方法はわかっていません

```elixir
file_path = "/Users/awesome/Documents/13_Elixir/shohei/Nanami.mp3"
token = "ひみつ"
headers = [Authorization: "Bearer #{token}", "Content-Type": "multipart/form-data"]
url = "https://api.openai.com/v1/audio/transcriptions"
filename = Path.basename(file_path)
HTTPoison.post(
  url,
  {:multipart,
     [
       {:file, file_path, {"form-data", [name: "file", filename: filename]}, []},
       {"model", "whisper-1"}
     ]},
   headers
)
```

---

# 題材: [Speech to text](https://platform.openai.com/docs/guides/speech-to-text)

まず、題材にした[Speech to text](https://platform.openai.com/docs/guides/speech-to-text)を説明します。

ざっくりいうと、音声データファイル(mp3, mp4, mpeg, mpga, m4a, wav, or webm)をアップロードすると文字起こしをしてくれるAPIです。
ファイルの送信に、[multipart/form-data](https://e-words.jp/w/multipart-form-data.html)を使います。


詳細は以下をご参照ください。

- [Speech to text](https://platform.openai.com/docs/guides/speech-to-text)
- [Audio](https://platform.openai.com/docs/api-reference/audio)


---

# [HTTPoison](https://github.com/edgurgel/httpoison)を利用して、[multipart/form-data](https://e-words.jp/w/multipart-form-data.html)によるデータのPOSTを行う

[HTTPoison](https://github.com/edgurgel/httpoison)を利用して、[multipart/form-data](https://e-words.jp/w/multipart-form-data.html)によるデータのPOSTを行います。

## 準備
`.exs`やIEx、Livebookでは、[Mix.install/2](https://hexdocs.pm/mix/1.14/Mix.html#install/2)を使うか、プロジェクトでは`mix.exs`で依存関係を解決(`mix deps.get`)するかしてください。

```elixir
Mix.install([{:httpoison, "~> 2.0"}])
```

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 2.0"}
    ]
  end
```

## 使用するデータ

以前書いたこちらの記事を参考に、音声データ(.mp3)を作りました。

https://qiita.com/torifukukaiou/items/4ce31ea7f6041aae68be

Azureの[Text to Speech REST API](https://learn.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech?tabs=streaming)を利用させていただきました。
「七海さん」という話者に話してもらいました。
データは以下に公開しておきます。

https://www.torifuku-kaiou.app/Nanami.mp3


## ファイル指定

ファイルを指定して送信する方法です。

```elixir
file_path = "/Users/awesome/Documents/13_Elixir/shohei/Nanami.mp3"
token = "ひみつ"
headers = [Authorization: "Bearer #{token}", "Content-Type": "multipart/form-data"]
url = "https://api.openai.com/v1/audio/transcriptions"
filename = Path.basename(file_path)
HTTPoison.post(
  url,
  {:multipart,
     [
       {:file, file_path, {"form-data", [name: "file", filename: filename]}, []},
       {"model", "whisper-1"}
     ]},
   headers
)
```

**迷わず実行してみます。**
実行結果は以下の通りです。

```elixir
{:ok,
 %HTTPoison.Response{
   status_code: 200,
   body: "{\"text\":\"最後に私から皆さんに皆様にメッセージを送りたいと思います 人は歩みを止めた時にそして挑戦を諦めた時に年老いていくのだと思います この道を行けばどうなるものか 危ぶむなかれ 危ぶめば道はなし 踏み出せばその一足が道となり その一足が道となる 迷わず行けよ 行けばわかるさ ありがとう\"}",
   headers: [
   ...
```

「道」の詩の朗読を文字起こしできています！

## バイナリを送る

次にバイナリを送る方法です。「ファイル指定」とよく似ています。異なる点は、`:file`が`"file"`になっています。

```elixir
file_path = "/Users/awesome/Documents/13_Elixir/shohei/Nanami.mp3"
binary_file_content = File.read!(file_path)
token = "ひみつ"
headers = [Authorization: "Bearer #{token}", "Content-Type": "multipart/form-data"]
url = "https://api.openai.com/v1/audio/transcriptions"
filename = Path.basename(file_path)
HTTPoison.post(
  url,
  {:multipart,
     [
       {"file", binary_file_content, {"form-data", [name: "file", filename: filename]}, []},
       {"model", "whisper-1"}
     ]},
   headers
)
```

---

# 参考資料

参考にした資料を紹介しておきます。

- [HTTPoison](https://github.com/edgurgel/httpoison) [README.md](https://github.com/edgurgel/httpoison/blob/main/README.md)の中の[Multipart](https://github.com/edgurgel/httpoison#multipart)
- [Openai.ex](https://github.com/mgallo/openai.ex) Hexの[実装](https://github.com/mgallo/openai.ex/blob/e44385ff94a3cfaa8de6915930e827df4f1d83ea/lib/openai/client.ex#L70-L86)　（以下、抜粋）

```elixir:lib/openai/client.ex
  def multipart_api_post(url, file_path, file_param, params, request_options \\ []) do
    body_params = params |> Enum.map(fn {k, v} -> {Atom.to_string(k), v} end)

    body = {
      :multipart,
      [
        {:file, file_path,
         {"form-data", [{:name, file_param}, {:filename, Path.basename(file_path)}]}, []}
      ] ++ body_params
    }

    request_options = Keyword.merge(request_options(), request_options)

    url
    |> post(body, request_headers(), request_options)
    |> handle_response()
  end
```



---

# さいごに

[OpenAI](https://openai.com/)が提供している[Speech to text](https://platform.openai.com/docs/guides/speech-to-text) APIを題材に、[Elixir](https://elixir-lang.org/)で、[multipart/form-data](https://e-words.jp/w/multipart-form-data.html)によるデータのPOSTを行いました。

この記事では、HTTPクライアントライブラリに[HTTPoison](https://github.com/edgurgel/httpoison)を使いました。
[Req](https://github.com/wojtekmach/req)での実装方法は分かりましたら、追記なりしたいとおもっています（あくまでもおもっています）。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
