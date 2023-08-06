これは、Qiita記事の原稿を置いているリポジトリです。  

https://qiita.com/torifukukaiou

[Qiita CLI](https://github.com/increments/qiita-cli) を利用させていただいております。  
記事を書く際には手元のマシンで、[Developing inside a Container（devcontainer）](https://code.visualstudio.com/docs/devcontainers/containers)を使っています。  

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

## 参考

[闘魂Qiita CLI ── Qiita記事をGitHubで管理することにしました (use Qiita CLI)](https://qiita.com/torifukukaiou/items/75854acfcb0460d08237)
