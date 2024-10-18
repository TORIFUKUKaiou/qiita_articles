これは、Qiita記事の原稿を置いているリポジトリです。  

https://qiita.com/torifukukaiou

[Qiita CLI](https://github.com/increments/qiita-cli) を利用させていただいております。  
[Developing inside a Container（devcontainer）](https://code.visualstudio.com/docs/devcontainers/containers)を使えるように、リポジトリを構成しています。  

私はRapberry Pi 2の上でイゴかしているNervesアプリケーションで一部の記事を自動更新しています。  
記事の変更は、 `.github/workflows/pull.yml` で一日一回取り込むことにしています。  

# このリポジトリはいつ動かすのか

Qiitaに記事を投稿（闘魂）する際は、 `npx qiita preview` にてQiita Previewから書くこともできますが、Qiita上で直接書くことにしています。  
以下の２つの場面で動かしています。  

- Qiita CLIのアップデート
- 記事ファイル(.md)のリネーム


# Codespacesで (こちらのほうが私は楽)

Code > Codespaces > create a codespace on main  
`.devcontainer/credentials.json` が存在しないので、ビルドが失敗しリカバリーモードで立ち上がります。  
`.devcontainer/credentials.json` を配置して、もちろん中身は適切な値を設定したうえで、リビルドするとよいです。  

自動で `npx qiita preview` するはずです。もし立ち上がらなければターミナルで手動でコマンドを実行すればよいです。  

最新の `main` からCodespaceを起動した場合は不要ですが、前述のように `main` ブランチには「闘魂注入」という名のコミットメッセージで、危ぶむことなく歩を進めて、どんどん道を進んでいるので、停止したCodespaceを再度立ち上げて作業する場合には、 `git fetch origin; git rebase origin/main` とでもやって最新に追いつくとよいでしょう。  

## .mdファイルのリネーム

```
QIITA_TOKEN="your token" elixir bin/normalize-filenames.exs
```

# ローカルPCで

使い方は`.devcontainer/credentials.json`を配置した状態で「Reopen in Container」です。  
（credentials.jsonはそもそもどうやってつくったかというと、ホストで`npx qiita login`をして、ホストの`~/.config/qiita-cli/credentials.json`からコピーしています）  

`credentials.json`はこんな感じです。  

```json:credentials.json
{
  "default": "qiita",
  "credentials": [
    {
      "name": "qiita",
      "accessToken": "your access token"
    }
  ]
}
```

[Dev Container CLI](https://github.com/devcontainers/cli)を使うとよいでしょう。  
[Dev Container CLI](https://github.com/devcontainers/cli)の使用例。  

```bash
devcontainer build
devcontainer open
devcontainer exec npx qiita preview
```

## .mdファイルのリネーム

`bin` 配下を参照  


# Qiita CLIのアップデート

まず公式で案内されているようにやる。  
コンテナの中に入るなりしてやる。Codespaceで動かしている場合はLinuxで操作している感覚で作業を進められる。  

```
npm install @qiita/qiita-cli@latest
```

改めて `npx qiita init` をしてみる。セットアップファイルが増えたり、内容が変わっているかもしれないので。上書きはしないようなので、 `Already exists.` と言われたファイルも一応消してから `npx qiita init` を実行して差異を見ることにしている。



# 参考

[闘魂Qiita CLI ── Qiita記事をGitHubで管理することにしました (use Qiita CLI)](https://qiita.com/torifukukaiou/items/75854acfcb0460d08237)
