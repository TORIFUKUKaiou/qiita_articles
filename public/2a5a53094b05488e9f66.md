---
title: Qiita 15周年の隠しメッセージを、Elixir で取りに行った
tags:
  - Elixir
  - Python
  - Playwright
  - ChromeDevTools
  - みんなのQiita15周年
private: false
updated_at: '2026-10-03T17:08:24+09:00'
id: 2a5a53094b05488e9f66
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
## はじめに

Qiita が15周年を迎えました。公式ブログの [15周年のお知らせ](https://blog.qiita.com/qiita15th/) に、「Qiita のどこかにささやかなメッセージを用意した」という趣旨の「お祝い隠しメッセージ」の話があります。

おそらくこれのことだろう、と思って調べてみました。

## 見つけ方

開発者コンソール（F12）を開くだけです。

終わりです。

## でも Elixir から取得したくなった

Elixir の本を書いたこともあり、F12 を押す代わりに、プログラムで取りに行きたくなりました。

https://gihyo.jp/book/2024/978-4-297-14014-4

ただ、単純に HTML を取得するだけでは出てきません。このメッセージはクライアント側の JavaScript が実行されたときに `console.log` で出力されるためです。サーバーから返ってくる HTML には含まれていません。

そこで、実際にブラウザを動かして、コンソール出力を捕まえる方針にしました。

## まず Python で動かした

先に動くことを確認したくて、Python と Playwright で試しました。`uv` を使っているので、PEP 723 のインラインスクリプトメタデータで依存関係を書いています。

```python:qiita_console.py
# /// script
# requires-python = ">=3.10"
# dependencies = [
#     "playwright>=1.48",
# ]
# ///
"""Qiita を開いてブラウザの console 出力を端末に表示する。

PCにインストール済みの Google Chrome を使うため、ブラウザの追加取得は不要。
実行:
    uv run qiita_console.py
"""
import sys

from playwright.sync_api import sync_playwright

URL = "https://qiita.com/"
IDLE_MS = 4000  # ロード後、遅延出力を待つ時間

with sync_playwright() as p:
    browser = p.chromium.launch(channel="chrome")
    page = browser.new_page()
    page.on("console", lambda msg: print(msg.text.replace("%c", ""), flush=True))
    page.on("pageerror", lambda err: print(f"[pageerror] {err}", file=sys.stderr))
    page.goto(URL, wait_until="load")
    page.wait_for_timeout(IDLE_MS)
    browser.close()
```

```bash
uv run qiita_console.py
```

実行すると、メッセージが表示されました。出力内容はネタバレになるので、ここには載せません。気になる方は、実際に動かして（あるいは F12 を押して）、ご自身の目で確かめてください。

`console` イベントを購読するだけなので、Playwright なら 10 行ほどで済みました。

出力の先頭に `%c` が付いていたので、`replace` で消しています。理由は後述します。

## その実績をもとに Elixir で書いた

Python で「ヘッドレス Chrome で開けばメッセージは出る」と分かったので、同じことを Elixir で書きました。Elixir には Playwright 相当の定番ライブラリがないため、Chrome DevTools Protocol（CDP）を WebSocket で直接叩く方針です。

動作確認は macOS、Elixir 1.20.1、Google Chrome です。

```elixir:qiita_console_cdp.exs
#!/usr/bin/env elixir
# Qiita のコンソールメッセージを、ヘッドレス Chrome + CDP (Chrome DevTools Protocol) で取得する。
#
#   elixir qiita_console_cdp.exs
#
# 環境変数: CHROME_BIN=/path/to/chrome  IDLE_MS=4000  TIMEOUT_MS=30000  CHROME_NO_SANDBOX=1

Mix.install([
  {:req, "~> 0.5"},
  {:jason, "~> 1.4"},
  {:mint_web_socket, "~> 1.0"}
])

defmodule QiitaConsole do
  @url "https://qiita.com/"

  def main do
    case find_chrome() do
      nil -> abort("Chrome が見つかりません。CHROME_BIN にパスを指定してください。")
      chrome -> chrome |> capture() |> report()
    end
  end

  defp report({:ok, []}), do: abort("コンソール出力を捕捉できませんでした。IDLE_MS / TIMEOUT_MS を延ばしてください。")
  defp report({:ok, logs}), do: Enum.each(logs, &IO.puts/1)
  defp report({:error, reason}), do: abort(reason)

  # --- Chrome の起動と後始末 ---------------------------------------------

  defp find_chrome do
    mac = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
    env = System.get_env("CHROME_BIN")

    cond do
      env && File.exists?(env) ->
        env

      true ->
        Enum.find_value(
          ~w(google-chrome google-chrome-stable chromium chromium-browser chrome),
          &System.find_executable/1
        ) || if(File.exists?(mac), do: mac)
    end
  end

  defp capture(chrome) do
    debug_port = Enum.random(9300..9999)
    profile = Path.join(System.tmp_dir!(), "qiita-cdp-#{System.unique_integer([:positive])}")

    args =
      [
        "--headless=new",
        "--disable-gpu",
        "--no-first-run",
        "--remote-debugging-port=#{debug_port}",
        "--remote-allow-origins=*",
        # 新しい Chrome は既定プロファイルでのリモートデバッグを拒否するため、専用ディレクトリを使う
        "--user-data-dir=#{profile}",
        "about:blank"
      ] ++ if(System.get_env("CHROME_NO_SANDBOX"), do: ["--no-sandbox"], else: [])

    port = Port.open({:spawn_executable, chrome}, [:binary, :exit_status, :stderr_to_stdout, args: args])

    try do
      with {:ok, ws_url} <- wait_for_page(debug_port, 50),
           {:ok, st} <- connect(ws_url) do
        # Navigate より先に Runtime.enable を送り、読み込み中のログを取りこぼさない
        st =
          st
          |> send_cmd(1, "Runtime.enable")
          |> send_cmd(2, "Page.enable")
          |> send_cmd(3, "Page.navigate", %{url: @url})

        now = now_ms()

        collect(
          Map.merge(st, %{
            logs: [],
            loaded?: false,
            last: now,
            deadline: now + env_int("TIMEOUT_MS", 30_000),
            idle: env_int("IDLE_MS", 4_000)
          })
        )
      end
    after
      kill(port)
      File.rm_rf(profile)
    end
  end

  # /json/list をポーリングして page ターゲットの WebSocket URL を得る
  defp wait_for_page(_port, 0), do: {:error, "Chrome のデバッグポートに接続できませんでした"}

  defp wait_for_page(port, tries) do
    with {:ok, %{status: 200, body: body}} <- Req.get("http://127.0.0.1:#{port}/json/list", retry: false),
         list when is_list(list) <- if(is_binary(body), do: Jason.decode!(body), else: body),
         %{"webSocketDebuggerUrl" => ws} <- Enum.find(list, &(&1["type"] == "page")) do
      {:ok, ws}
    else
      _ ->
        Process.sleep(200)
        wait_for_page(port, tries - 1)
    end
  end

  # --- WebSocket (Mint.WebSocket) ---------------------------------------

  defp connect(ws_url) do
    uri = URI.parse(ws_url)

    with {:ok, conn} <- Mint.HTTP.connect(:http, uri.host, uri.port),
         {:ok, conn, ref} <- Mint.WebSocket.upgrade(:ws, conn, uri.path, []) do
      await_upgrade(conn, ref, %{status: nil, headers: [], done?: false})
    else
      {:error, reason} -> {:error, "接続失敗: #{inspect(reason)}"}
      {:error, _conn, reason} -> {:error, "アップグレード失敗: #{inspect(reason)}"}
    end
  end

  # HTTP → WebSocket のアップグレード応答（status / headers / done）が揃うまで待つ
  defp await_upgrade(conn, ref, acc) do
    receive do
      message ->
        case Mint.WebSocket.stream(conn, message) do
          {:ok, conn, responses} ->
            acc = Enum.reduce(responses, acc, &upgrade_response(&1, &2, ref))

            if acc.done? do
              case Mint.WebSocket.new(conn, ref, acc.status, acc.headers) do
                {:ok, conn, ws} -> {:ok, %{conn: conn, ref: ref, ws: ws}}
                {:error, _conn, reason} -> {:error, "WebSocket 確立失敗: #{inspect(reason)}"}
              end
            else
              await_upgrade(conn, ref, acc)
            end

          {:error, _conn, reason, _responses} ->
            {:error, "アップグレード中のエラー: #{inspect(reason)}"}

          :unknown ->
            await_upgrade(conn, ref, acc)
        end
    after
      5_000 -> {:error, "WebSocket のアップグレードがタイムアウトしました"}
    end
  end

  defp upgrade_response({:status, ref, status}, acc, ref), do: %{acc | status: status}
  defp upgrade_response({:headers, ref, headers}, acc, ref), do: %{acc | headers: headers}
  defp upgrade_response({:done, ref}, acc, ref), do: %{acc | done?: true}
  defp upgrade_response(_other, acc, _ref), do: acc

  defp send_cmd(st, id, method, params \\ %{}) do
    json = Jason.encode!(%{id: id, method: method, params: params})
    {:ok, ws, data} = Mint.WebSocket.encode(st.ws, {:text, json})
    {:ok, conn} = Mint.WebSocket.stream_request_body(st.conn, st.ref, data)
    %{st | ws: ws, conn: conn}
  end

  # --- イベント収集: 「ロード後、IDLE_MS の間ログが途絶えた」か「全体タイムアウト」で終了 ----

  defp collect(st) do
    now = now_ms()

    cond do
      now >= st.deadline -> {:ok, Enum.reverse(st.logs)}
      st.loaded? and now - st.last >= st.idle -> {:ok, Enum.reverse(st.logs)}
      true -> receive_event(st)
    end
  end

  defp receive_event(st) do
    receive do
      {p, {:exit_status, code}} when is_port(p) ->
        {:error, "Chrome が異常終了しました (exit #{code})"}

      {p, {:data, _chrome_stderr}} when is_port(p) ->
        collect(st)

      message ->
        case Mint.WebSocket.stream(st.conn, message) do
          {:ok, conn, responses} ->
            %{st | conn: conn} |> handle_responses(responses) |> collect()

          {:error, _conn, reason, _responses} ->
            {:error, "WebSocket エラー: #{inspect(reason)}"}

          :unknown ->
            collect(st)
        end
    after
      300 -> collect(st)
    end
  end

  defp handle_responses(st, responses) do
    Enum.reduce(responses, st, fn
      {:data, ref, data}, %{ref: ref} = st -> handle_data(st, data)
      _other, st -> st
    end)
  end

  defp handle_data(st, data) do
    {:ok, ws, frames} = Mint.WebSocket.decode(st.ws, data)

    Enum.reduce(frames, %{st | ws: ws}, fn
      {:text, json}, st -> handle_event(st, Jason.decode!(json))
      _other, st -> st
    end)
  end

  defp handle_event(st, %{"method" => "Page.loadEventFired"}),
    do: %{st | loaded?: true, last: now_ms()}

  defp handle_event(st, %{"method" => "Runtime.consoleAPICalled", "params" => %{"args" => args}}),
    do: %{st | logs: [format(args) | st.logs], last: now_ms()}

  defp handle_event(st, _other), do: st

  # console.log("%c...", "css") では、最初の引数に %c、2つ目以降にCSS文字列が入る。
  # %c の個数だけ後続の引数（CSS）を捨て、%c 自体も取り除く。
  defp format([]), do: ""

  defp format(args) do
    [first | rest] = Enum.map(args, &to_text/1)
    n = length(String.split(first, "%c")) - 1
    {_css, rest} = Enum.split(rest, n)
    Enum.join([String.replace(first, "%c", "") | rest], " ")
  end

  defp to_text(%{"value" => v}) when is_binary(v), do: v
  defp to_text(%{"value" => v}), do: inspect(v)
  defp to_text(%{"description" => d}), do: d
  defp to_text(_), do: ""

  # --- 雑多なヘルパー ---------------------------------------------------

  defp kill(port) do
    with {:os_pid, pid} <- Port.info(port, :os_pid) do
      System.cmd("kill", [to_string(pid)], stderr_to_stdout: true)
    end
  rescue
    _ -> :ok
  end

  defp now_ms, do: System.monotonic_time(:millisecond)

  defp env_int(key, default) do
    case Integer.parse(System.get_env(key) || "") do
      {v, _} -> v
      :error -> default
    end
  end

  defp abort(msg) do
    IO.puts(:stderr, "エラー: #{msg}")
    System.halt(1)
  end
end

QiitaConsole.main()

```

```bash
elixir qiita_console_cdp.exs
```

## 軽い解説

### 全体の流れ

1. ヘッドレス Chrome を `--remote-debugging-port` 付きで起動する
2. `http://127.0.0.1:<port>/json/list` から、ページの WebSocket URL を得る
3. WebSocket で接続する
4. `Runtime.enable` を送り、`Page.navigate` で Qiita を開く
5. `Runtime.consoleAPICalled` イベントを受け取り、ログを集める
6. 整形して標準出力に出す

CDP は「JSON を送ると JSON が返ってくる」だけのプロトコルなので、WebSocket さえ使えれば Elixir でも素直に書けます。

### `Runtime.enable` を `Page.navigate` より先に送る

先にページを開いてしまうと、読み込み中に出たログを取りこぼす可能性があります。そのため、ログの購読を先に有効にしています。

### 待ち時間の扱い

コンソール出力がいつ終わるかは分からないので、「ロード完了後、`IDLE_MS` の間ログが出なければ終了」「全体は `TIMEOUT_MS` で打ち切り」という 2 段構えにしています。

### `%c` の処理

Qiita は `console.log("%c...", "css")` の形式で出力しています。1 つ目の引数が本文（先頭に `%c`）、2 つ目がスタイル用の CSS 文字列です。

Playwright の `msg.text` は CSS を落としてくれますが、先頭の `%c` は残るので `replace` で消しました。CDP を直接受ける Elixir 版では、`%c` の個数だけ後続の引数を捨て、`%c` 自体も取り除く処理を自前で書いています。

### Chrome の起動まわり

- 新しい Chrome は、既定のプロファイルではリモートデバッグを拒否することがあります。そのため `--user-data-dir` に一時ディレクトリを指定しています。
- 終了時は、OS の PID を取って Chrome を `kill` します。

## まとめ

**F12 を押そう。**

---

それだけで、メッセージは目の前に現れる。

私は何をしていたのだろう。Chrome を起動し、WebSocket を繋ぎ、JSON を投げ、返事を待った。`IDLE_MS` という名の静けさの中で、ログが途絶えるのをただ眺めていた。

メッセージは、最初からそこにあった。キーを一つ押せば開く扉の前で、私は壁を掘っていたのだ。

掘り終えた穴の底にも、同じ扉があった。

コードは動いた。動いた、というだけだった。ターミナルには、F12 を押せば見えたはずのものが、ただ静かに映っている。

---

まあ、とにかく
**15周年、おめでとうございます!**

![スクリーンショット 2026-10-03 17.04.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/967ea617-d06e-4e53-96ed-231ef0f7f2b4.png)
