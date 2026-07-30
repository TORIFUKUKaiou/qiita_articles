---
title: さくらのAI Engineの音声合成で「1000モーラ制限」に当たった話──curlで発見してPythonで突破した
tags:
  - さくらのAI
  - さくらインターネット
  - 闘魂
  - 猪木
  - TTS
private: false
updated_at: '2026-07-29T12:24:00+09:00'
id: 3ccc6b50af4da3138d34
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## TL;DR

- さくらのAI Engineの`audio/speech`（ずんだもん）は **1リクエストあたり1000モーラまで**
- 仕様書には「1000文字程度」と書いてあるが、実際のエラーは **モーラ単位**で返ってくる
- curlで試行錯誤しながらこの制限を発見し、Pythonスクリプトで自動分割＋ffmpeg結合して解決した

---

## はじめに

2093文字の日本語テキストをずんだもんに読み上げてもらおうと思い立ちました。
さくらのAI EngineはOpenAI互換APIなので、`openai` Pythonクライアントをそのまま使えて便利です。

ところがいざ試してみると、長いテキストがそのままでは送れないことが分かりました。
この記事では **curlで制限を突き止めるまでの試行錯誤** と、**Pythonで自動分割して解決するまで** を書きます。

なお、curlでの検証もスクリプトの実装も、さくらのAI Engineと一緒に進めました。

---

## curlで試行錯誤──制限の正体を突き止める

最初はとにかくcurlで叩いてみました。

```bash
curl https://api.ai.sakura.ad.jp/v1/audio/speech \
  -H "Authorization: Bearer $SAKURA_AI_ENGINE_ACCOUNT_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "zundamon",
    "voice": "normal",
    "input": "（全文2093文字）",
    "response_format": "mp3"
  }' \
  --output output.mp3
```

返ってきたのは `500 Internal Server Error` でした。

そこで、inputの文字数を半分の1000文字程度に減らしてみました。
果たして、`400 Bad Request`。エラーメッセージは明確でした。

```json
{
  "error": {
    "message": "The input text exceeds the maximum of 1000 moras (current: 1089)"
  }
}
```

**「1000 moras」** ──モーラ単位での制限です。

[公式の仕様書](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api#operation/createSpeech)には「1000文字程度」と書いてありますが、実際のカウントはモーラ単位です。日本語の場合、漢字1文字が複数モーラになることがあるため、「文字数」と「モーラ数」は一致しません。

たとえば「東京」は2文字ですが「とうきょう」で4モーラです。2093文字のテキストでも、読み仮名にすると1000モーラをはるかに超えます。

短いテキスト（数百文字）で試すと問題なく通ることも確認できました。制限は文字数ではなくモーラ数だと確信しました。

---

## 解決方針：モーラ数で分割してffmpegで結合

方針はシンプルです。

1. テキストを1000モーラ以下のチャンクに分割する
2. 各チャンクをAPIに送って音声を得る
3. ffmpegで結合する

モーラ数の概算には [pykakasi](https://github.com/miurahr/pykakasi) を使います。漢字をかなに変換し、仮名文字数をモーラとして数えます（促音・拗音の厳密な扱いは省略）。
音声ファイルの結合には [ffmpeg](https://ffmpeg.org/) を使います。音声・動画の変換・結合ができるOSSのツールで、macOSなら `brew install ffmpeg` で入ります。

### 依存関係（pyproject.toml）

```toml
[project]
name = "sakura-tts"
version = "0.1.0"
requires-python = ">=3.11"
dependencies = [
    "openai>=2.0",
    "pykakasi>=2.3",
]
```

ffmpegはPythonパッケージではないため `pyproject.toml` には入りません。別途インストールが必要です。

```bash
brew install ffmpeg
```

### スクリプト全文（tts.py）

```python
#!/usr/bin/env python3
"""input.txt を Sakura AI Engine の音声合成 API で読み上げるスクリプト。

Sakura AI Engine の audio/speech エンドポイントは 1000 モーラを超える入力を
受け付けないため、モーラ数で区切って複数リクエストに分割し、最後に ffmpeg で
結合します。
"""

from __future__ import annotations

import os
import re
import subprocess
import sys
import tempfile
from pathlib import Path

import pykakasi
from openai import OpenAI

INPUT_PATH = Path("input.txt")
OUTPUT_PATH = Path("output.mp3")
API_URL = "https://api.ai.sakura.ad.jp/v1"
MODEL = "zundamon"
VOICE = "normal"
# Sakura AI Engine の仕様（「現在は指定できますが常にwavを返します」）に基づき "wav" で統一する。
RESPONSE_FORMAT = "wav"
MAX_MORAS = 1000


def count_moras(text: str) -> int:
    """日本語テキストのモーラ数を概算する。"""
    kks = pykakasi.kakasi()
    result = kks.convert(text)
    kana = "".join(item["kana"] for item in result)
    # 促音・拗音を考慮せず、仮名 1 文字を 1 モーラとしてカウント
    return sum(1 for ch in kana if ch >= "぀" and ch <= "ゟ" or ch >= "゠" and ch <= "ヿ")


def split_text(text: str, max_moras: int) -> list[str]:
    """テキストを max_moras 以下になるように段落単位で分割する。"""
    # 段落に分ける（空行で区切る）
    paragraphs = re.split(r"\n\s*\n", text.strip())
    chunks: list[str] = []
    current = ""

    for paragraph in paragraphs:
        paragraph = paragraph.strip()
        if not paragraph:
            continue

        paragraph_moras = count_moras(paragraph)
        current_moras = count_moras(current)

        if paragraph_moras > max_moras:
            # 1 段落だけで制限を超える場合は、文単位でさらに分割
            if current:
                chunks.append(current.strip())
                current = ""
            sentences = re.split(r"(?<=[。．！？\n])", paragraph)
            for sentence in sentences:
                sentence = sentence.strip()
                if not sentence:
                    continue
                sentence_moras = count_moras(sentence)
                current_moras = count_moras(current)
                if current_moras + sentence_moras > max_moras and current:
                    chunks.append(current.strip())
                    current = sentence
                else:
                    current = f"{current}\n\n{sentence}" if current else sentence
        elif current_moras + paragraph_moras > max_moras and current:
            chunks.append(current.strip())
            current = paragraph
        else:
            current = f"{current}\n\n{paragraph}" if current else paragraph

    if current:
        chunks.append(current.strip())

    return chunks


def synthesize(client: OpenAI, text: str) -> bytes:
    """audio/speech API を呼び出して音声データを取得する。"""
    response = client.audio.speech.create(
        model=MODEL,
        voice=VOICE,
        input=text,
        response_format=RESPONSE_FORMAT,
    )
    return response.content


def combine_audio_files(audio_files: list[Path], output: Path) -> None:
    """ffmpeg で複数の WAV ファイルを結合し、最後に MP3 に変換する。"""
    with tempfile.NamedTemporaryFile(mode="w", suffix=".txt", delete=False) as f:
        for path in audio_files:
            f.write(f"file '{path.resolve()}'\n")
        list_path = Path(f.name)

    try:
        with tempfile.NamedTemporaryFile(suffix=".wav", delete=False) as tmp_wav:
            tmp_wav_path = Path(tmp_wav.name)

        subprocess.run(
            [
                "ffmpeg",
                "-y",
                "-f", "concat",
                "-safe", "0",
                "-i", str(list_path),
                "-c", "copy",
                str(tmp_wav_path),
            ],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )

        subprocess.run(
            [
                "ffmpeg",
                "-y",
                "-i", str(tmp_wav_path),
                "-c:a", "libmp3lame",
                "-q:a", "2",
                str(output),
            ],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
        )
    finally:
        list_path.unlink(missing_ok=True)
        tmp_wav_path.unlink(missing_ok=True)


def main() -> int:
    if not INPUT_PATH.exists():
        print(f"エラー: {INPUT_PATH} が見つかりません。", file=sys.stderr)
        return 1

    token = os.environ.get("SAKURA_AI_ENGINE_ACCOUNT_TOKEN")
    if not token:
        print("エラー: 環境変数 SAKURA_AI_ENGINE_ACCOUNT_TOKEN が設定されていません。", file=sys.stderr)
        return 1

    text = INPUT_PATH.read_text(encoding="utf-8")
    total_chars = len(text)
    print(f"入力文字数: {total_chars} 文字")
    if total_chars == 0:
        print("エラー: 入力テキストが空です。", file=sys.stderr)
        return 1

    chunks = split_text(text, MAX_MORAS)
    print(f"分割数: {len(chunks)} チャンク")
    for i, chunk in enumerate(chunks, 1):
        print(f"  チャンク {i}: {count_moras(chunk)} モーラ / {len(chunk)} 文字")

    client = OpenAI(
        api_key=token,
        base_url=API_URL,
    )

    audio_files: list[Path] = []
    with tempfile.TemporaryDirectory() as tmpdir:
        tmp_path = Path(tmpdir)
        for i, chunk in enumerate(chunks, 1):
            print(f"チャンク {i}/{len(chunks)} を音声合成中...")
            audio = synthesize(client, chunk)
            chunk_path = tmp_path / f"chunk_{i:03d}.{RESPONSE_FORMAT}"
            chunk_path.write_bytes(audio)
            audio_files.append(chunk_path)

        print(f"{len(audio_files)} 個の音声ファイルを ffmpeg で結合します。")
        combine_audio_files(audio_files, OUTPUT_PATH)

    print(f"音声ファイルを保存しました: {OUTPUT_PATH.resolve()}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
```

### 実行結果

2093文字のテキストは3つのチャンクに分割されました。

```text
$ source .envrc && uv run python tts.py
入力文字数: 2093 文字
分割数: 3 チャンク
  チャンク 1: 997 モーラ / 845 文字
  チャンク 2: 977 モーラ / 840 文字
  チャンク 3: 464 モーラ / 403 文字
チャンク 1/3 を音声合成中...
チャンク 2/3 を音声合成中...
チャンク 3/3 を音声合成中...
3 個の音声ファイルを ffmpeg で結合します。
音声ファイルを保存しました: /Users/.../output.mp3
```

文字数とモーラ数の比率がチャンクによって異なるのが分かります。
チャンク1は845文字で997モーラ（文字あたり約1.18モーラ）、チャンク3は403文字で464モーラ（約1.15モーラ）。漢字の多さによって比率が変わります。

---

## ポイントと注意事項

### モーラ数 vs 文字数

| 項目 | 詳細 |
|------|------|
| 仕様書の記載 | 「1000文字程度」 |
| 実際の制限 | 1000モーラ（エラーメッセージより） |
| エラーメッセージ | `The input text exceeds the maximum of 1000 moras` |

仕様書の「1000文字程度」という記載は、一般的な日本語テキストの目安として分かりやすく書かれたものと思われます。実際のAPI判定はエラーメッセージの通りモーラ数（拍）で行われるため、長文を分割処理する際はモーラ数でカウントして制御するのが確実です。

### pykakasi のモーラ概算の精度

pykakasiは内部でMeCabなしに変換を行うため、固有名詞や新語の変換精度は完璧ではありません。本スクリプトでは安全マージンを取らず `MAX_MORAS = 1000` そのままにしていますが、ギリギリになる文章の場合は `MAX_MORAS = 950` 程度に下げると安全です。

### response_format の挙動

[公式仕様書](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api#operation/createSpeech)に「※現在は指定できますが常にwavを返します」と明記されている通り、`response_format` に何を渡しても常に WAV が返ってきます。そのため本スクリプトでは最初から WAV で受け取り、最後に ffmpeg で MP3 に変換しています。

https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api#operation/createSpeech

### 無料枠のリクエスト数

さくらのAI Engineの音声合成は**月50回まで**無料です。本スクリプトは分割した数だけリクエストを消費します（今回は3回）。3000リクエストの無料枠はテキスト生成系のAPIに使うとして、音声合成は別枠で管理されています。

---

## まとめ

- さくらのAI Engineの音声合成は **1000モーラ制限** がある
- 仕様書の「1000文字程度」という記述はあくまで目安で、実際はモーラ単位
- curlでエラーメッセージを確認して制限の正体を特定
- pykakasiでモーラ数を概算し、段落・文単位でテキストを分割
- 各チャンクをAPIに送り、ffmpegで結合して1つのMP3に

OpenAI互換APIなので `openai` クライアントがそのまま使える点は非常に便利でした。
制限さえ把握してしまえば、長文の音声合成も問題なく動きます。

---

## さくらのAI Engine x Claude Code

Claude CodeをさくらのAI Engineと組み合わせると、APIの呼び出しコードそのものをさくらのAI Engineに書いてもらうことができます。
[公式コラム](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)が分かりやすいので、ぜひ参照してください。

https://ai.sakura.ad.jp/column/claude-code-messages-api-2/

---

2026/07/28現在、`preview/Kimi-K2.7-Code` も提供されています。使うしかありませんッ！

https://x.com/sakura_AI_pr/status/2081960948127203748

```bash
claude --model preview/Kimi-K2.7-Code
```

この記事を書くにあたり、専用のアクセストークンを払い出しました。リクエスト数の実績は84回でした。

![スクリーンショット 2026-07-29 12.18.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8918086d-05b8-4fd9-b9e0-8d84ced316ab.png)

だいたいのおおよそのざっくりですが、トークン(闘魂)数で円に換算すると、約200円分使用させていただきました‼️

---

## おわりに──token消化ではなく、**闘魂昇華**

![ai-back.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b84b2736-c4a6-4c31-8fa5-ae55387eba08.png)

:::note
**TokenをTokonへ**

AIが扱うのは、Token。

```math
\mathrm{Token}
-
\mathrm{見\ (Ken)}
+
\mathrm{魂\ (Kon)}
=
\mathrm{Tokon\ (闘魂)}
```

現段階の生成AIは、突き詰めればベクトルの数理遊びである。

どのモデルが賢い、速い、勝つ。
外から眺め、比べ、論評するだけでは、まだTokenだ。

だから「見（Ken）」を引く。

見る側から、使う側へ。
そこに目的と意味を与え、執念を持ち込み、魂を込めるのは人間である。

token消化ではなく、**$\huge{闘魂昇華}$** :fire:
Don't just consume Tokens. Forge them into Tokon.
:::

無料枠を、闘って、磨いて、使い切りますッ！！！

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d648527b-6c59-4c85-9681-bf5d01b0b6f4.png)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0f8edf8-7ba0-4f97-8667-31f00ad9348f.png)

---

## 参考

- [さくらのAI Engine 音声合成 API仕様](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api#operation/createSpeech)
- [pykakasi](https://github.com/miurahr/pykakasi)
- [OpenAI Python SDK](https://github.com/openai/openai-python)
