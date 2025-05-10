---
title: Elixirで画像生成！OpenAIのCreate Image APIを叩いてみた
tags:
  - Elixir
  - OpenAI
  - 画像生成
  - 猪木
  - 闘魂
private: false
updated_at: '2025-05-10T07:29:32+09:00'
id: 7e900cd3c9e4277cf2db
organization_url_name: null
slide: false
ignorePublish: false
---
# はじめに

OpenAIの[Create image](https://platform.openai.com/docs/api-reference/images/create) APIを[Elixir](https://elixir-lang.org/)でコールしてみます。

ElixirではHTTPクライアントとして [Req](https://hexdocs.pm/req/Req.html) がモダンで扱いやすいです。今回のようなAPI連携にも最適です。特にシンプルなJSONベースのやり取りには圧倒的な手軽さがあります。
Elixir使い（アルケミスト=錬金術師)でOpenAI APIを叩きたい人向けに、Reqで完結する最小実装を紹介します。
(つまりは、_[Req](https://hexdocs.pm/req/Req.html)でHTTP Postしているだけの記事です。_)

# 参考実装

参考となる実装を紹介します。
公式ドキュメントに書いてあります。

## Python

`pip install openai` でライブラリを利用する例です。

https://platform.openai.com/docs/guides/image-generation?image-generation-model=gpt-image-1&lang=python#generate-images に書いてあるサンプルのモデルを`dall-e-3`に変更しただけです。

```python:image.py
from openai import OpenAI
import base64
client = OpenAI()

prompt = """
A children's book drawing of a veterinarian using a stethoscope to 
listen to the heartbeat of a baby otter.
"""

result = client.images.generate(
    model="dall-e-3",
    prompt=prompt,
    response_format="b64_json"
)

image_base64 = result.data[0].b64_json
image_bytes = base64.b64decode(image_base64)

# Save the image to a file
with open("otter.png", "wb") as f:
    f.write(image_bytes)
```

## curl

https://platform.openai.com/docs/guides/image-generation?image-generation-model=gpt-image-1&lang=curl
に書いてあるサンプルのモデルを`dall-e-3`に変更しただけです。


```bash
curl -X POST "https://api.openai.com/v1/images/generations" \
    -H "Authorization: Bearer $OPENAI_API_KEY" \
    -H "Content-type: application/json" \
    -d '{
        "model": "dall-e-3",
        "prompt": "A childrens book drawing of a veterinarian using a stethoscope to listen to the heartbeat of a baby otter."
    }' | jq -r '.data[0].b64_json' | base64 --decode > otter.png
```

# Elixirで実装する

curlの実装例が参考になります。

```elixir:image.exs
Mix.install([
  {:req, "~> 0.5.0"}
])

openai_api_key = System.get_env("OPENAI_API_KEY")

headers = [
  "Content-Type": "application/json",
  Authorization: "Bearer #{openai_api_key}"
]

prompt = """
A children's book drawing of a veterinarian using a stethoscope to
listen to the heartbeat of a baby otter.
"""

url = "https://api.openai.com/v1/images/generations"

body = %{
  prompt: prompt,
  model: "dall-e-3",
  response_format: "b64_json",
  n: 1
}

{:ok, %{body: %{"data" => [%{"b64_json" => b64_json}]}}} =
  Req.post(url,
    headers: headers,
    json: body,
    connect_options: [timeout: 60_000],
    receive_timeout: 60_000
  )

Base.decode64!(b64_json)
|> then(fn content -> File.write("otter-elixir.png", content) end)
```

特筆すべき点としては、`receive_timeout: 60_000`を指定しないと`{:error, %Req.TransportError{reason: :timeout}}`が頻発していました。

[Req.post/2](https://hexdocs.pm/req/Req.html#post/2)の第2引数`options`にいろいろなオプションを指定している**恒例の好例**です。
`:headers`や`:json`(つまりはボディにMap渡す)などを指定しています。

# 結果

結果です。

## dall-e-3

`dall-e-3`モデルで描いたものはうまいです。

![otter.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/75526ae1-f2e4-4d26-b46e-9fd301bc09bf.png)

![otter-elixir.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a5f3243d-4557-4fd1-acd5-56f0b77bb5ef.png)




## dall-e-2

`dall-e-2`モデルで描いたものはなんだか気持ち悪いです。怖いです。
折りたたんでおきます。
怖いものを見たい方はどうぞ。

<details><summary>dall-e-2で描いた絵</summary>

![otter.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ccea35c1-abe5-4966-9629-f947b1f736a9.png)

![otter-elixir.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/aa2b515d-975e-4f49-bfd8-c08589950b7c.png)

</details>


# おわりに

OpenAIの[Create image](https://platform.openai.com/docs/api-reference/images/create) APIを[Elixir](https://elixir-lang.org/)でコールしてみました。

_APIのその先には、誰かの「描きたい未来」がある。_
_Elixirはその想いを、静かに、そして確かに形にする──。_
_そう、闘魂とは「描くこと」なのだ。_


# 2025/05/10 追記

いくつかHexが作られていました。リポジトリを紹介しているのみです。私は使っていません。

- https://github.com/mgallo/openai.ex
- https://github.com/cyberchitta/openai_ex
- https://github.com/dvcrn/ex_openai
