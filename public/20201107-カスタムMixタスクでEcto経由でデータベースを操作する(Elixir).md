---
title: カスタムMixタスクでEcto経由でデータベースを操作する(Elixir)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2020-11-08T01:35:08+09:00'
id: 8a2d85324c9b8599d69a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- カスタムMixタスクでEcto経由でデータベースを操作したいです
    - [Mix.Task](https://hexdocs.pm/mix/Mix.Task.html#content)は独自に作れるんです
- 私は前提知識として、`lib/mix/tasks/hoge.ex`つくれば、`mix hoge`で実行できるタスクを実装できるのですよね〜 というところまでは知っていました
- 今回はそのタスクの中でEcto経由でデータベースを操作することをしてみたときに、エラーに遭遇しまして、解決策がわかりましたのでその記録を残しておきます
    - `Phoenix`タグをつけるかどうかは迷ったのですが、まあ[Phoenix](https://www.phoenixframework.org/)アプリを作っているときに遭遇したのでつけておきました


# カスタムMixタスク
```elixir:lib/mix/tasks/db_all_delete.ex
defmodule Mix.Tasks.DbAllDelete do
  use Mix.Task

  def run(_) do
    Mix.Task.run "app.start", []

    Demo.Repo.delete_all(Demo.Accounts.User)
  end
end
```

- `Mix.Task.run "app.start", []`の呼び出しが必要になります
- [Gigalixir](https://gigalixir.com/)にデプロイしている場合には、`gigalixir run mix db_all_delete`なんて感じで実行できます

## `Mix.Task.run "app.start", []`の呼び出しがない場合

```elixir
$ mix db_all_delete                                                                                                                     
Compiling 1 file (.ex)
** (RuntimeError) could not lookup Ecto repo Demo.Repo because it was not started or it does not exist
    lib/ecto/repo/registry.ex:19: Ecto.Repo.Registry.lookup/1
    lib/ecto/repo/queryable.ex:210: Ecto.Repo.Queryable.execute/4
    lib/mix/tasks/db_all_delete.ex:7: Mix.Tasks.DbAllDelete.run/1
    (mix 1.10.4) lib/mix/task.ex:330: Mix.Task.run_task/3
    (mix 1.10.4) lib/mix/cli.ex:82: Mix.CLI.run_task/2
    (elixir 1.10.4) lib/code.ex:926: Code.require_file/2

```
- Ecto repoが始まっていないだなんだ言われています

# 参考記事
- 詳しくはこれらの記事をご参照ください
- [How to get data from Ecto in a custom mix task](https://stackoverflow.com/questions/38225406/how-to-get-data-from-ecto-in-a-custom-mix-task)
- [カスタムMixタスク#アプリケーションの読み込み](https://elixirschool.com/ja/lessons/basics/mix-tasks/#%E3%82%A2%E3%83%97%E3%83%AA%E3%82%B1%E3%83%BC%E3%82%B7%E3%83%A7%E3%83%B3%E3%81%AE%E8%AA%AD%E3%81%BF%E8%BE%BC%E3%81%BF)
    - ありがとうございます！

# Wrapping Up :lgtm: :qiitan: :lgtm:
- [カスタムMixタスク](https://elixirschool.com/ja/lessons/basics/mix-tasks)については、リンク先が詳しいです
    - [Mix.Task](https://hexdocs.pm/mix/Mix.Task.html#content)
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
