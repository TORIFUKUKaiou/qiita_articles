---
title: Active Record(Ruby)とEcto(Elixir)でmigrateした内容を一致させる
tags:
  - Elixir
  - ecto
private: false
updated_at: '2022-09-27T22:23:23+09:00'
id: e03120b0cadd8f5b3af8
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- Active Record(Ruby)でmigrateした内容とぴったり同じものをEcto(Elixir)でマイグレーションファイルを書きたいということがありました
- データベースは[PostgreSQL](https://www.postgresql.org/)を使いました
- ググってみてもなかなか答えは見つかりませんでした
    - この記事を書く途中で、ようやく公式にも記述があるにはあることを発見しました
    - https://hexdocs.pm/ecto_sql/Ecto.Migration.html#module-field-types
    - ただなかなかここにたどり着けませんでした
- 特定のActive Record(Ruby)のマイグレーションファイルを正解(期待)として、なんとなくカンでEcto(Elixir)のマイグレーションファイルを書いてみたら一致したのでそのことを記事に残しておきます
- 使用したライブラリなどのバージョンは以下の通りです

|  | バージョン | バージョン確認コマンド |
|:-:|:-:|:-:|
| PostgreSQL | 13.2  | psql --version   |
| Ruby  | 2.6.2  |  ruby -v |
| Active Record |5.2.4.1 | cat Gemfile.lock|
| Elixir  | 1.9.4  | elixir -v  |
| Ecto | 3.3.4 | cat mix.lock |

# Active Record(Ruby)のマイグレーションファイル

```ruby
# frozen_string_literal: true

class DeviseCreateAdminUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.inet     :current_sign_in_ip
      # t.inet     :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :admin_users, :email,                unique: true
    add_index :admin_users, :reset_password_token, unique: true
    # add_index :admin_users, :confirmation_token,   unique: true
    # add_index :admin_users, :unlock_token,         unique: true
  end
end
```

- [Devise](https://github.com/heartcombo/devise)です
- https://github.com/heartcombo/devise/graphs/contributors
- のページをみると[Elixir](https://elixir-lang.org/)の作者[José Valim](https://github.com/josevalim)さんのお名前がみえます
- このマイグレーションファイルを`bin/rails db:migrate`でマイグレートしてみると、以下のテーブルがつくられます


```
$ psql -U postgres

postgres=# \c workflows_repo

workflows_repo=# \d admin_users
                                              Table "public.admin_users"
         Column         |            Type             | Collation | Nullable |                 Default                 
------------------------+-----------------------------+-----------+----------+-----------------------------------------
 id                     | bigint                      |           | not null | nextval('admin_users_id_seq'::regclass)
 email                  | character varying           |           | not null | ''::character varying
 encrypted_password     | character varying           |           | not null | ''::character varying
 reset_password_token   | character varying           |           |          | 
 reset_password_sent_at | timestamp without time zone |           |          | 
 remember_created_at    | timestamp without time zone |           |          | 
 created_at             | timestamp without time zone |           | not null | 
 updated_at             | timestamp without time zone |           | not null | 
Indexes:
    "admin_users_pkey" PRIMARY KEY, btree (id)
    "index_admin_users_on_email" UNIQUE, btree (email)
    "index_admin_users_on_reset_password_token" UNIQUE, btree (reset_password_token) 
```


# Ecto(Elixir)マイグレーションファイル
- ぴったり一致するEctoのマイグレーションファイルは以下のようになります

```elixir
defmodule Workflows.Repo.Migrations.CreateAdminUsers do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :email, :"character varying", default: "", null: false
      add :encrypted_password, :"character varying", default: "", null: false
      add :reset_password_token, :"character varying", size: nil
      add :reset_password_sent_at, :"timestamp without time zone"
      add :remember_created_at, :"timestamp without time zone"

      add :created_at, :"timestamp without time zone", null: false
      add :updated_at, :"timestamp without time zone", null: false
    end

    create unique_index(:admin_users, [:email], name: :index_admin_users_on_email)
    create unique_index(:admin_users, [:reset_password_token], name: :index_admin_users_on_reset_password_token)
  end
end
```

- Typeを指定するところに、`psql`で確認した`:"character varying"`、`:"timestamp without time zone"`とカンで書いてみるとぴったり一致しました
- インデックスの名前は、`:name`で指定しました


## 一致しないマイグレーションファイル

```elixir
defmodule Workflows.Repo.Migrations.CreateAdminUsers do
  use Ecto.Migration

  def change do
    create table(:admin_users) do
      add :email, :string, default: "", null: false
      add :encrypted_password, :string, default: "", null: false
      add :reset_password_token, :string, size: nil
      add :reset_password_sent_at, :utc_datetime
      add :remember_created_at, :utc_datetime

      add :created_at, :utc_datetime, null: false
      add :updated_at, :utc_datetime, null: false
    end

    create unique_index(:admin_users, [:email])
    create unique_index(:admin_users, [:reset_password_token])
  end
end
```

- Typeを`:string`、`:utc_datetime`にして`mix ecto.migrate`すると以下のように少し異なったものがつくられます
- インデックスの名前は、`:name`オプションを指定しない場合、少し異なっています


```
                                                Table "public.admin_users"
         Column         |              Type              | Collation | Nullable |                 Default                 
------------------------+--------------------------------+-----------+----------+-----------------------------------------
 id                     | bigint                         |           | not null | nextval('admin_users_id_seq'::regclass)
 email                  | character varying(255)         |           | not null | ''::character varying
 encrypted_password     | character varying(255)         |           | not null | ''::character varying
 reset_password_token   | character varying(255)         |           |          | 
 reset_password_sent_at | timestamp(0) without time zone |           |          | 
 remember_created_at    | timestamp(0) without time zone |           |          | 
 created_at             | timestamp(0) without time zone |           | not null | 
 updated_at             | timestamp(0) without time zone |           | not null | 
Indexes:
    "admin_users_pkey" PRIMARY KEY, btree (id)
    "admin_users_email_index" UNIQUE, btree (email)
    "admin_users_reset_password_token_index" UNIQUE, btree (reset_password_token)
```

- https://hexdocs.pm/ecto_sql/Ecto.Migration.html#module-field-types
- によると、`:string`は255文字を上限とすると書いてありまして、そのとおりになっています
    - `:size`オプションで指定することができます

# Wrapping up :lgtm::lgtm::lgtm::lgtm:
- この記事を書く前は、どこにも書いてなかったので記事にしました〜　というつもりで書いていました
- https://hexdocs.pm/ecto_sql/Ecto.Migration.html#module-field-types をよく見ると、この記事で紹介したようなTypeの指定方法が書いてありました :sweat_smile: 
- どなたかのお役に立てることがあるかもしれませんので記事を残しておきます
    - `character varying no limit postgres ecto`とかで検索しましたがなかなかヒットしなかったので:sweat_smile:
- まとめとしては、以下の手順でやればよいです
    - 正解(期待)スキーマを確認する
    - EctoのマイグレーションファイルでTypeはスキーマに書いてある型を[Atom](https://hexdocs.pm/elixir/1.12/Atom.html)で指定する 
- Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
- この記事は、2021/07/17(土) 00:00 〜 2021/07/19(月) 23:59開催の[autoracex #37](https://autoracex.connpass.com/event/219198/)という純粋なもくもく会での成果です


