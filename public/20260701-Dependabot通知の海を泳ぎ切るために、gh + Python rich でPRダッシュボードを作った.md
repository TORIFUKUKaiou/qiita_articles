---
title: Dependabot通知の海を泳ぎ切るために、gh + Python rich でPRダッシュボードを作った
tags:
  - Python
  - GitHub
  - AI
  - dependabot
  - 闘魂
private: false
updated_at: '2026-07-01T19:45:41+09:00'
id: d50a134600ee010543e7
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 9d632f51614ebd7b333c
agreed_posting_campaign_term: true
---
## 🥊 はじめに：闘魂プログラマーの叫び

開発プロジェクトが増え、依存ライブラリの自動更新のために [Dependabot](https://docs.github.com/en/code-security/tutorials/secure-your-dependencies/dependabot-quickstart) を導入した。
ここまでは良かった。素晴らしい選択だった。

しかし、数日経ってメールボックスを開くと、そこには **Dependabotからの通知メールの山、山、山……。**
朝一のコーヒーを飲む前に、メールの海で溺れそうになる。これでは大事なメンバーのPRや、本当に緊急性の高い脆弱性修正のPRを見落としかねない。

**「メールはもう限界だ。気が向いたときに、ターミナルでサッと今追っているプロジェクト（Organization配下のリポジトリなど）のPR状況を綺麗に一覧したい！」**

この闘魂の叫びを、相棒のAI（Antigravity 2.0 / **ケンシロウ**）にぶつけた。
「CLIでいい。`gh` コマンドは使える。あらかじめ指定したリポジトリのPR件数とタイトルサマリーが一発で見えるやつ、サクッと作れるか？」

AIの返答は「Go」だった。
彼が爆速で土台を組み上げ、私がそこに「使いやすさ」と「魂（こだわり）」を注入する。そんな熱いペアプログラミングから生まれた爆速ダッシュボードツールを紹介する。

Dependabot対策として作り始めましたが、実際には人間のPRも含めた「いま見るべきPR一覧」として使えるツールに仕上がった。

![スクリーンショット 2026-07-01 19.42.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6c23508e-bc03-4422-a8ae-51063c29bee8.png)


---

## 🛠️ 技術選定：AIが提示したスマートな土台

AIが提案してきた構成は、驚くほどシンプルかつクリーンだった。

1. **GitHub CLI (`gh`) のラッパーとして動かす**
   - 認証トークンの管理や organization 配下のリポジトリへのアクセス権は、すでにローカルでログイン済みの `gh` コマンドに丸投げする。車輪の再発明はしない。
2. **Python + `uv` による「環境を汚さない」実行**
   - ターミナル描画のためにサードパーティライブラリ（`rich`）を使いたいが、プロジェクトごとに仮想環境を作ったり `pip install` するのは面倒だ。
   - そこで、Pythonの **PEP 723（Inline script metadata）** を採用。`uv run --no-project` で実行することで、カレントディレクトリを一切汚さずに依存ライブラリをキャッシュ実行させる。
3. **`ThreadPoolExecutor` による~~非同期~~並列フェッチ**
   - 監視対象のリポジトリが10個、20個と増えたとき、同期処理で1つずつ `gh pr list` を実行していては遅くて使えない。
   - Python標準のマルチスレッドを用いて、すべてのリポジトリへ並行でクエリを投げ、一瞬で情報を集約する。

---

## 💻 完成したソースコード

作成したスクリプトがこちらだ。
これを `tools/gh-pr-dashboard.py` として保存する。

```python
#!/usr/bin/env python3
# /// script
# dependencies = [
#     "rich",
# ]
# ///

import os
import sys
import json
import subprocess
import argparse
from datetime import datetime, timezone
from concurrent.futures import ThreadPoolExecutor

# Default configuration path
DEFAULT_CONFIG_PATH = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "pr-dashboard-config.json"
)

def load_config(config_path):
    """Load configuration file, create default if not exists."""
    if not os.path.exists(config_path):
        default_config = {
            "repositories": [
                "cli/cli",
                "python/cpython"
            ]
        }
        try:
            os.makedirs(os.path.dirname(config_path), exist_ok=True)
            with open(config_path, "w") as f:
                json.dump(default_config, f, indent=2)
                f.write("\n")
            return default_config
        except Exception as e:
            print(f"Error creating config file: {e}")
            return {"repositories": []}

    try:
        with open(config_path, "r") as f:
            return json.load(f)
    except Exception as e:
        print(f"Error reading config file: {e}")
        sys.exit(1)

def save_config(config_path, config):
    """Save configuration file with standard formatting (2-space indent, trailing newline)."""
    try:
        os.makedirs(os.path.dirname(config_path), exist_ok=True)
        # Remove duplicates while preserving insertion order
        if "repositories" in config:
            config["repositories"] = list(dict.fromkeys(config["repositories"]))
        with open(config_path, "w") as f:
            json.dump(config, f, indent=2)
            f.write("\n")
        return True
    except Exception as e:
        print(f"Error saving config file: {e}")
        return False

def fetch_prs(repo, limit):
    """Fetch open pull requests for a single repository using gh CLI."""
    cmd = [
        "gh", "pr", "list",
        "-R", repo,
        "--state", "open",
        "--limit", str(limit),
        "--json", "number,title,author,url,createdAt,labels"
    ]
    try:
        # Run gh command
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        return repo, json.loads(result.stdout), None
    except subprocess.CalledProcessError as e:
        return repo, None, e.stderr.strip() or f"gh command exited with code {e.returncode}"
    except Exception as e:
        return repo, None, str(e)

def format_relative_time(iso_str):
    """Format an ISO-8601 datetime string to a human-readable relative time."""
    try:
        if iso_str.endswith("Z"):
            iso_str = iso_str[:-1] + "+00:00"
        dt = datetime.fromisoformat(iso_str)
        now = datetime.now(timezone.utc)
        diff = now - dt

        seconds = int(diff.total_seconds())
        if seconds < 0:
            return "just now"

        minutes = seconds // 60
        hours = minutes // 60
        days = hours // 24
        months = days // 30
        years = days // 365

        if seconds < 60:
            return "just now"
        elif minutes < 60:
            return f"{minutes}m ago"
        elif hours < 24:
            return f"{hours}h ago"
        elif days < 30:
            return f"{days}d ago"
        elif months < 12:
            return f"{months}mo ago"
        else:
            return f"{years}y ago"
    except Exception:
        return iso_str

def get_label_style(hex_color):
    """Calculate text color (black or white) based on label background color luminance."""
    try:
        r = int(hex_color[0:2], 16)
        g = int(hex_color[2:4], 16)
        b = int(hex_color[4:6], 16)
        # Relative luminance formula
        luminance = 0.299 * r + 0.587 * g + 0.114 * b
        fg = "black" if luminance > 128 else "white"
        return f"{fg} on #{hex_color}"
    except Exception:
        return "white on grey"

def main():
    parser = argparse.ArgumentParser(description="GitHub Pull Request Dashboard")
    parser.add_argument(
        "-c", "--config",
        default=DEFAULT_CONFIG_PATH,
        help=f"Path to config JSON file (default: {DEFAULT_CONFIG_PATH})"
    )
    parser.add_argument(
        "-l", "--limit",
        type=int,
        default=20,
        help="Max number of PRs to fetch per repository (default: 20)"
    )
    parser.add_argument(
        "--no-bots",
        action="store_true",
        help="Exclude pull requests created by bots (e.g., dependabot)"
    )
    parser.add_argument(
        "--add",
        metavar="OWNER/REPO",
        help="Add a repository to the dashboard config"
    )
    args = parser.parse_args()

    # Delay rich import to ensure fast load when running other options
    from rich.console import Console
    from rich.table import Table
    from rich.panel import Panel
    from rich.text import Text

    console = Console()

    # Handle repository addition
    if args.add:
        config = load_config(args.config)
        repos = config.get("repositories", [])
        if args.add in repos:
            console.print(f"[yellow]'{args.add}' is already in the configuration.[/yellow]")
        else:
            repos.append(args.add)
            config["repositories"] = repos
            if save_config(args.config, config):
                console.print(f"[green]Successfully added '{args.add}' to configuration.[/green]")
            else:
                console.print(f"[red]Failed to save configuration.[/red]")
        sys.exit(0)

    config = load_config(args.config)
    repositories = config.get("repositories", [])

    if not repositories:
        console.print("[yellow]No repositories configured. Use --add OWNER/REPO to add one.[/yellow]")
        sys.exit(0)

    console.print(f"[bold blue]Fetching open Pull Requests for {len(repositories)} repositories...[/bold blue]\n")

    # Fetch PRs in parallel
    results = []
    with console.status("[bold green]Querying GitHub API...[/bold green]", spinner="dots") as status:
        with ThreadPoolExecutor(max_workers=min(len(repositories), 10)) as executor:
            futures = [executor.submit(fetch_prs, repo, args.limit) for repo in repositories]
            for future in futures:
                results.append(future.result())

    # Render results
    for repo, prs, error in results:
        if error:
            panel_content = Text(f"Error: {error}", style="red")
            console.print(Panel(panel_content, title=f"[bold red]✗ {repo}[/bold red]", expand=False))
            console.print()
            continue

        # Filter bots if requested
        filtered_prs = prs
        if args.no_bots:
            filtered_prs = [
                pr for pr in prs 
                if not (pr.get("author") or {}).get("is_bot") 
                and "dependabot" not in (pr.get("author") or {}).get("login", "").lower()
            ]

        pr_count = len(filtered_prs)
        title_text = f"[bold green]✓ {repo}[/bold green] ({pr_count} open PRs)"

        if pr_count == 0:
            panel_content = Text("No open PRs", style="dim italic")
            console.print(Panel(panel_content, title=title_text, expand=False))
            console.print()
            continue

        table = Table(box=None, show_header=True, header_style="bold magenta", padding=(0, 1))
        table.add_column("PR", justify="right")
        table.add_column("Title")
        table.add_column("Author", style="green")
        table.add_column("Created", style="yellow")
        table.add_column("Labels")

        for pr in filtered_prs:
            url = pr.get("url", "")
            number_style = f"cyan link {url}" if url else "cyan"
            number = Text(f"#{pr['number']}", style=number_style)
            
            title_style = f"link {url}" if url else ""
            title = Text(pr["title"], style=title_style)
            
            author_data = pr.get("author", {}) or {}
            author = author_data.get("login", "unknown")
            is_bot = author_data.get("is_bot", False) or "dependabot" in author.lower()
            
            # Format elapsed time
            created_at = format_relative_time(pr["createdAt"])
            
            # Style for bots
            row_style = "dim" if is_bot else ""
            if is_bot and url:
                number.style = f"dim cyan link {url}"
                title.style = f"dim link {url}"
            
            # Build label tags
            labels_text = Text()
            for label in pr.get("labels", []):
                style = get_label_style(label.get("color", "cccccc"))
                labels_text.append(f" {label['name']} ", style=style)
                labels_text.append(" ")

            table.add_row(
                number,
                title,
                f"🤖 {author}" if is_bot else author,
                created_at,
                labels_text,
                style=row_style
            )

        console.print(Panel(table, title=title_text, expand=False))
        console.print()

if __name__ == "__main__":
    main()
```

---

## 🔥 闘魂のこだわり：人間が注入した「魂」

AIは確かに動くコードを数秒で書いてくれる。しかし、それは「ただ動く」だけのものだ。
このツールを極上の「藝術品」に高めるために、私が注入したこだわりが以下の4点である。

### 1. ターミナルからブラウザへ直行できる「ハイパーリンク」
「サッと見たい」の次には「見たらすぐブラウザでPRを開いてレビューしたい」という欲求が必ず生まれる。
これを解決したのが `rich` のスタイル属性に仕込んだ `link` 設定（OSC 8プロトコル）だ。

VS Code統合ターミナルやiTerm2など、対応したターミナルで実行すると、**PR番号やタイトルを `Cmd + クリック`（Windowsなら `Ctrl + クリック`）するだけで、ブラウザがそのPRのURLを叩いて立ち上がる。**
CLIとWebの境界が消え去った瞬間だ。

### 2. ノイズであるBot PRの「dim化」と「フィルタ機能」
DependabotのPRは重要だが、人間が書いたPRに比べてタイトルが長く、数が多い。
そこで：
- BotによるPRは行全体を `dim`（薄暗い表示）にすることで、人間のPRが浮き上がるようにした。
- さらに `--no-bots` フラグにより、Bot PRを完全に非表示にするモードも用意。今すぐ確認すべき「人間のコード」に一瞬で焦点を当てられる。

### 3. 計算された視認性（ラベルの背景色と文字色の自動コントラスト）
GitHub APIが返すラベルのカラーコード（例: `ee2329` など）をターミナルにそのまま背景色として描画する際、文字色を常に「白」にしてしまうと、背景が黄色や明るい緑のときに文字が読めなくなる。
これを解決するため、カラーコードのRGB値から相対輝度（Luminance）を算出し、**「背景が明るければ文字色は黒、暗ければ白」を自動で判別する処理**を埋め込んだ。
これにより、どんなカラフルなラベルでも~~完璧な視認性が確保される~~おおむね読みやすい文字色を選ぶようにした。

### 4. 初回実行時にはサンプル設定ファイルを作る
初回実行時にはサンプル設定ファイルを作る。自分のOrganizationやリポジトリに書き換えて使っていただきたい。

```python
if not os.path.exists(config_path):
    default_config = {
        "repositories": [
            "cli/cli",
            "python/cpython"
        ]
    }
```

---

## 🏃 使い方

実行は驚くほど簡単だ。`uv` がインストールされていれば、以下のコマンドを叩くだけ。
仮想環境を手動で作る必要も、パッケージをグローバルに汚染する必要もない。

```bash
# 基本実行（設定したリポジトリのPR一覧を表示）
uv run --no-project tools/gh-pr-dashboard.py

# 人間のPRだけに絞る
uv run --no-project tools/gh-pr-dashboard.py --no-bots

# 監視したいリポジトリをCLIから追加
uv run --no-project tools/gh-pr-dashboard.py --add haw/daily-balance-maker
```

設定したリポジトリリストはスクリプトと同じ階層にある `pr-dashboard-config.json` に保存される。~~このファイルもソートされて決定論的に保存されるため、Git管理もしやすい。~~ このファイルは重複を除きつつ、追加した順序を保って保存されるため、Git管理もしやすい。

---

## 🥊 まとめ：AIと闘魂のタッグ

AI（Antigravity 2.0）は、私たちが「こういうアイデアがある」とボヤいた瞬間に、正確でスマートな土台を提供してくれる。
しかし、その土台に「本当に使う人間の目線」で、ハイパーリンクや輝度計算、視覚的ノイズの整理といった「魂」を吹き込むのは人間（プログラマー）の仕事だ。

AI(アントニオ猪木)さんと人間が互いの強みを活かして最短で最高のものを作り上げる。
これぞ現代の「闘魂プログラミング」である。

**「踏み出せば、その一足が道となり、その一足が道となる。迷わず行けよ、行けばわかるさ。ありがとー！」**
