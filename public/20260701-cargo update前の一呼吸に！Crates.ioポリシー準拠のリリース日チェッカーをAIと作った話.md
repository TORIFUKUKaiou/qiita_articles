---
title: cargo update前の一呼吸に！Crates.ioポリシー準拠のリリース日チェッカーをAIと作った話
tags:
  - Python
  - Rust
  - codex
  - Tauri
  - Antigravity
private: false
updated_at: '2026-07-02T15:42:11+09:00'
id: b3c676f56146287b2034
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 9d632f51614ebd7b333c
agreed_posting_campaign_term: true
---
こんにちは。[Rust](https://rust-lang.org/ja/)はそこまで詳しくないものの、デスクトップアプリ開発で[Tauri](https://v2.tauri.app/ja/)を愛用している開発者です。

最近、オープンソース界隈でよく耳にするのが **「ソフトウェアサプライチェーン攻撃」** です。悪意のあるコードが紛れ込んだライブラリがリリースされ、それを知らずにアップデートして取り込んでしまうリスクが身近に存在します。

もちろん「ライブラリのリリースから数日〜数週間経っていること（エイジング）」を確認しただけでサプライチェーン攻撃を100%防げるわけではありません。しかし、 **「リリース直後の怪しいアップデートを無防備に踏まない」** ための一応の防御策、一歩としては十分に意味があると考えています。

とはいえ、毎回 `cargo update --dry-run` を実行し、更新される大量のCrate名とバージョンを見て、いちいちブラウザで crates.io を開いてリリース日時を調べるのは……**あまりにも面倒すぎます。**

「じゃあ、コマンドをラップして Cargo の更新レポートを読み取り、自動でリリース日時を追記して表示しちゃえばいいんじゃないか？」

そう思い立ち、次世代AIアシスタント **Antigravity 2.0** と、コードレビューに **OpenAI Codex (ChatGPT)** を迎えた「AI三位一体体制」で、サクッとマナーの良いラッパーツールを作り上げました。

---

## 作ったもの：`cargo-update-age`

実行すると、以下のように `cargo update` の出力の横に、自動で `crates.io` から取得したリリース日時（実行環境のローカルタイムゾーンに変換済み）が追記されます。

```text
$ cargo-update-age -p tauri --dry-run
    Updating crates.io index
     Locking 1 package to latest compatible version
    Updating tauri v2.11.3 -> v2.11.4 (released: 2026-07-01 00:14:25)
note: pass `--verbose` to see 43 unchanged dependencies behind latest
```

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a1568eba-467f-43e9-a399-876f8b240e0d.gif)


`v2.11.4 (released: 2026-07-01 00:14:25)` のように、リリースされてどれくらい経っているか（Age）が一目瞭然になります。

このラッパーは確認専用です。引数に `--dry-run` が含まれていない場合でも自動で付与し、`Cargo.lock` を変更しないようにしています。

申し遅れました！
`cargo-update-age` は以下のようなエイリアスを書いております。

```
alias cargo-update-age="uv run --no-project /path/to/tools/cargo-update-date.py"
```

### スクリプトコード (Python 3)
外部依存ライブラリを一切使わず、Pythonの標準ライブラリ（`urllib.request`, `json`, `datetime`）のみで完結させたため、`uv run` 等でカレントを汚さずに即実行可能です。

```python
#!/usr/bin/env python3
# /// script
# requires-python = ">=3.11"
# dependencies = []
# ///

import json
import re
import subprocess
import sys
import time
from datetime import datetime
import urllib.request

# crates.io API requires a specific User-Agent header
USER_AGENT = "cargo-update-date/1.0 (contact: github.com/TORIFUKUKaiou)"

# Track the timestamp of the last API request for rate limiting (max 1 req/sec)
last_request_time = 0.0


def format_date(iso_str: str) -> str:
    try:
        # ISO string format like "2026-06-30T15:14:25.757956Z"
        # Convert Z to +00:00 for python fromisoformat
        clean_str = iso_str.replace("Z", "+00:00")
        dt = datetime.fromisoformat(clean_str)
        # Convert UTC to local timezone
        local_dt = dt.astimezone()
        return local_dt.strftime("%Y-%m-%d %H:%M:%S")
    except Exception:
        return iso_str


def get_release_date(crate_name: str, version: str) -> str:
    global last_request_time

    # Enforce policy rate limit: max 1 request per second
    now = time.time()
    elapsed = now - last_request_time
    if elapsed < 1.0:
        time.sleep(1.0 - elapsed)

    url = f"https://crates.io/api/v1/crates/{crate_name}"
    req = urllib.request.Request(url, headers={"User-Agent": USER_AGENT})
    try:
        last_request_time = time.time()
        with urllib.request.urlopen(req, timeout=5) as res:
            data = json.loads(res.read().decode("utf-8"))
            versions = data.get("versions", [])
            for v in versions:
                if v.get("num") == version:
                    created_at = v.get("created_at")
                    if created_at:
                        return format_date(created_at)
            return "unknown date"
    except Exception:
        return "api error"


def main() -> None:
    # This wrapper is for inspecting updates, so never modify Cargo.lock.
    cargo_args = sys.argv[1:]
    if "--dry-run" not in cargo_args:
        cargo_args.append("--dry-run")
    args = ["cargo", "update", *cargo_args]

    # Cargo writes its update report to stderr. Let stdout pass through directly
    # so the child cannot block on an unread stdout pipe.
    process = subprocess.Popen(
        args,
        stderr=subprocess.PIPE,
        text=True,
    )
    assert process.stderr is not None

    # Pattern to match: Updating <crate> v<old> -> v<new>
    pattern = re.compile(r"Updating\s+([\w-]+)\s+v(\S+)\s+->\s+v(\S+)")

    # Read stderr line-by-line in real time
    while True:
        line = process.stderr.readline()
        if not line and process.poll() is not None:
            break
        if line:
            stripped = line.strip()
            match = pattern.search(stripped)
            if match:
                crate_name = match.group(1)
                new_version = match.group(3)

                if sys.stderr.isatty():
                    sys.stderr.write(
                        line.rstrip("\n") + " (fetching release date...)\r"
                    )
                    sys.stderr.flush()

                # Get the release date
                date_str = get_release_date(crate_name, new_version)

                clear_line = "\033[K" if sys.stderr.isatty() else ""
                sys.stderr.write(
                    clear_line
                    + line.rstrip("\n")
                    + f" (released: {date_str})\n"
                )
                sys.stderr.flush()
            else:
                sys.stderr.write(line)
                sys.stderr.flush()

    raise SystemExit(process.wait())


if __name__ == "__main__":
    main()
```

---

## 🛠️ こだわりと工夫した点

### 1. Crates.io の APIポリシーを厳格に順守する
ここが一番大事です。[crates.io Data Access Policy](https://crates.io/data-access#api) には以下のルールが明記されています。

*   **ユーザーエージェント (User-Agent) の明記**: どこの誰がリクエストしているか（あるいは連絡先リポジトリ）を示すヘッダーを付与すること。
*   **レートリミット**: **「1秒あたり最大1リクエスト」** に抑えること。

今回のスクリプトでは、グローバル変数で直前のリクエスト時刻を管理し、1秒以内に連続してリクエストが飛ばないよう、必要な待ち時間を `time.sleep` で挟む仕組みを実装しました。マナーを守って優しくAPIを使います。

### 2. プレリリースや複雑な出力に対応する正規表現の最適化
Rustのバージョン表記には `2.0.0-alpha.1` のようなプレリリースが存在します。また、Cargoの出力には以下のように次のバージョン案内が括弧書きで付与されるケースもあります。
`Updating time v0.3.47 -> v0.3.51 (available: v0.3.52)`

当初は単純なドットと数値だけのマッチや、力業の `split()` で括弧を除去していましたが、レビューを経て正規表現を以下のように最適化しました。
```python
pattern = re.compile(r"Updating\s+([\w-]+)\s+v(\S+)\s+->\s+v(\S+)")
```
`\S+`（空白以外の連続文字）を採用することで、プレリリース文字（`-` やアルファベット）も扱いやすくなり、さらに後ろの `(available: ...)` などの余剰な情報もスペースの手前で自然にカットされ、APIに正確なバージョン番号だけを渡せるようになりました。

### 3. `uv run` によるポータビリティ
スクリプトには PEP 723 に準拠したインラインメタデータを定義しています。
これにより、環境を一切汚さずに `uv` を使って一発で実行できます。

`.zshrc` などに以下のようにエイリアスを設定しておけば、どのRustプロジェクトディレクトリからでも `cargo-update-age` としてシームレスに使えます。

```bash
alias cargo-update-age="uv run --no-project /path/to/tools/cargo-update-date.py"
```

---

## 🤖 AIとのペアプログラミング体験

今回のツールは、自分で手を動かしてコードを書いたというより、AIアシスタントである **Antigravity 2.0** にやりたいことを伝え、レビュー担当の **Codex (ChatGPT)** と連携させながら対話的にコードを洗練させていきました。

*   「こういう出力をパースしたい」と伝えると、標準ライブラリだけで動くきれいなPythonコードの土台が瞬時に出力される。
*   「crates.ioの規約を守りたい」と言うと、すぐにミリ秒計算つきの正確なレートリミッターが追加される。
*   「プレリリースや、available表記がある場合に対応したい」と伝えると、正規表現の落とし穴をクリアした美しい `\S+` を使ったパターンへ修正が施される。

このように、アイディアの言語化から実装、そしてエッジケースのバグ修正までが、AIとの心地よい往復ビンタ（対話）だけで一瞬で完成しました。まさに開発における「闘魂」の熱量そのままに、小さく速く試して動くものを作る体験ができました。

## まとめ

`cargo update` は開発を進める上で非常に便利なコマンドですが、依存関係の海に飛び込む前に「このアップデートはいつリリースされたものか？」をワンクッション挟んで確認できるだけで、精神的な衛生面は大きく変わります。

もし「なんでも自動アップデートするのがちょっと怖いな」と感じている方は、こうしたシンプルなラッパーをシェルに忍ばせてみてはいかがでしょうか。

（※crates.io API の詳細は公式の [Data Accessポリシー](https://crates.io/data-access#api) をご参照ください）
