---
title: ecto(Elixir) + ActiveAdmin(Ruby on Rails)で管理ツールを作ってみる(with Elixir)
tags:
  - Elixir
  - fukuoka.ex
  - kokura.ex
private: false
updated_at: '2020-04-10T09:18:57+09:00'
id: 07412d94fc86a4eb12a0
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 私は[Elixir](https://elixir-lang.org/)を使ってプログラムを書くのが好きです
    - `|>` がお気に入りです
- 仕事では[Ruby on Rails](https://rubyonrails.org/)を使うことが多く、中でも[ActiveAdmin](https://activeadmin.info/index.html)にたいへんお世話になっています
    - たったの数行を書くだけで[CRUD](https://ja.wikipedia.org/wiki/CRUD)を備えた管理画面ができあがります
- この記事では以下のことを行います
    - [Elixir](https://elixir-lang.org/)を使って定期的に天気予報データを取得して、データベースに保存をします
    - [ActiveAdmin](https://activeadmin.info/index.html)を使って、管理画面を作ります
- [Sapporo.beam](https://sapporo-beam.connpass.com/)と[OkazaKirin.beam](https://okazakirin-beam.connpass.com/) という勉強会での成果です

<img width="1318" alt="スクリーンショット 2020-04-08 23.13.54.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c6fe0634-2ebd-eeec-7c8f-cdc31ac823eb.png">

## 補足
- もちろん、[Elixir](https://elixir-lang.org/)だけを使って[Phoenix](https://www.phoenixframework.org/)で管理画面をつくることはできますし、[Ruby](https://www.ruby-lang.org/ja/)だけで作ることもできます
- それを言われると「はい、そうですね」とその通りであることを認めるのですが、とにかく私は[Elixir](https://elixir-lang.org/)を使いたいのです
    - (好きなものに理由は必要ですか?) 
    - (理由がアレコレあるものは本当に好きなものなのですか?)
- 以前、[Slack Workflowの申請内容を一覧(CSV)にする(with Elixir)](https://qiita.com/torifukukaiou/items/9db04591477de8c4cc11) という記事を書いて、Slackからある条件にあてはまるデータを取得して、CSVに出力するというプログラムを紹介しました
- これを発展させて、[ecto](https://hexdocs.pm/ecto/Ecto.html)を使ってデータベースに保存し、[ActiveAdmin](https://activeadmin.info/index.html)を使って一覧表示をする社内ツールをつくりました
- このときのエッセンスだけを取り出して、 まとめております

## 作品
[ecto_activeadmin](https://github.com/TORIFUKUKaiou/ecto_activeadmin)

# 必要なもの
- [Elixir](https://elixir-lang.org/) 1.9.4
- [Ruby](https://www.ruby-lang.org/ja/) 2.6.3
    - もっと新しいバージョンでもおそらく大丈夫です
- PostgreSQL 12.1
    - この記事では、ユーザ名が`postgres`でパスワードが`postgres`のスーパーユーザアカウントがあることを前提にしています
    - もしあなたのマシンにこのアカウントが設定されていない場合は、`psql postgres`と入力して以下のコマンドを入力することで作成できます
    - これは[Ecto](https://hexdocs.pm/phoenix/ecto.html#content)の記事から転載しています

```
postgres=# CREATE USER postgres;
postgres=# ALTER USER postgres PASSWORD 'postgres';
postgres=# ALTER USER postgres WITH SUPERUSER;
postgres=# \q
```


- [yarn](https://yarnpkg.com/)

それでは作業ディレクトリを作って早速はじめましょう。

```
$ mkdir ecto_activeadmin
$ cd ecto_activeadmin
```

# [ecto](https://hexdocs.pm/ecto/Ecto.html)を使ったproject([Elixir](https://elixir-lang.org/))

- 大好きな[Elixir](https://elixir-lang.org/)のプログラムを作ります
- [ecto](https://hexdocs.pm/ecto/Ecto.html)は、データベースと[Elixir](https://elixir-lang.org/)の間のデータマッピングと統合クエリのためのツールキットです

```
$ mix new weathers --sup
```

- `mix.exs` を少し変更します

```elixir:mix.exs
  defp deps do
    [
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:lwwsx, "~> 0.1.1"}
    ]
  end
```

- [lwwsx](https://hex.pm/packages/lwwsx) というのは、Livedoor様の[お天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice)から天気予報を取得する[Hex](https://hex.pm/)です
- 依存関係を解決します

```
$ mix deps.get
```

- `Weathers.Repo` をつくります
- これを通して、データベースにインサートします

```
$ mix ecto.gen.repo -r Weathers.Repo
```

- `lib/weathers/application.ex`を変更して、`Weathers.Repo`をsupervision tree内のsupervisorとして登録をします
    - [ルー大柴](https://ameblo.jp/lou-oshiba/)さんみたいになっていますが、こうとしか説明ができないです(私が理解できていないとも言う:man_tone3:)
    - [Elixir](https://elixir-lang.org/)が、堅牢だと言われるゆえんのところの話で奥が深いです
    - Don't think, feeeel.

```elixir:lib/weathers/application.ex
  def start(_type, _args) do
    children = [
      Weathers.Repo
    ]
```

- `config/config.exs`を変更します

```elixir:config/config.exs
config :weathers, Weathers.Repo,
  database: "weathers_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :weathers,
  ecto_repos: [Weathers.Repo]
```

- ここまでできたら、データベースを作ります

```
$ mix ecto.create
```

- 続いてテーブル作成のためのマイグレーションファイルの雛形をつくります

```
$ mix ecto.gen.migration create_weathers
```

- マイグレーションファイルは以下の内容にします

```elixir:priv/repo/migrations/20200408123754_create_weathers.exs
defmodule Weathers.Repo.Migrations.CreateWeathers do
  use Ecto.Migration

  def change do
    create table(:weathers) do
      add :city_number, :integer, null: false
      add :city, :string, null: false
      add :text, :text, null: false

      timestamps()
    end
  end
end
```

- `lib/weathers/weather.ex`を以下のように作ります
- 感じてください

```elixir:lib/weathers/weather.ex
defmodule Weathers.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weathers" do
    field :city_number, :integer
    field :city, :string
    field :text, :string

    timestamps()
  end

  def changeset(weather, attrs) do
    weather
    |> cast(attrs, [:city_number, :city, :text])
    |> validate_required([:city_number, :city, :text])
  end
end
```

- `lib/weathers/worker.ex`を作ります
- 1000 * 60 * 60 秒ごとに`Weathers.Worker.handle_info`が呼び出されて、`Weathers.Worker.run`が実行されます
- `Weathers.Worker.run`は任意の地点の天気予報データを取得してきて、データベースに保存をします

```elixir:lib/weathers/worker.ex
defmodule Weathers.Worker do
  use GenServer

  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val, name: __MODULE__)
  end

  def init(initial_val) do
    Process.send_after(__MODULE__, :tick, 1000)
    {:ok, initial_val}
  end

  def handle_info(:tick, state) do
    spawn(Weathers.Worker, :run, [])
    Process.send_after(__MODULE__, :tick, 1000 * 60 * 60)

    {:noreply, state}
  end

  def run do
    {city_number, city} = Lwwsx.cities() |> Enum.random()
    {:ok, text} = Lwwsx.current_text(city_number)

    Weathers.Repo.insert(
      Weathers.Weather.changeset(%Weathers.Weather{}, %{city_number: city_number, city: city, text: text})
    )
  end
end
```

- また[ルー大柴](https://ameblo.jp/lou-oshiba/)さんみたいなことをいいますが、`lib/weathers/application.ex`を変更して、`Weathers.Worker`をsupervision tree内のsupervisorとして登録をします

```elixir:lib/weathers/application.ex
  def start(_type, _args) do
    children = [
      Weathers.Repo,
      Weathers.Worker
    ]
```

- ok

```
$ iex -S mix
```

- このまま放っておけば、１時間に一回天気予報データを取得するようになります
- どうでしょうか！？
- **美しいですよね！**

# [ActiveAdmin](https://activeadmin.info/index.html)を使ったプロジェクト([Ruby on Rails](https://rubyonrails.org/))

- 管理画面を作っていきます

```
$ pwd
/hoge/ecto_activeadmin/weathers
$ cd ..
$ mkdir web
$ cd web
$ bundle init
```

- `Gemfile`を編集します

```:Gemfile
gem "rails"
```

- `bundle install`して[Ruby on Rails](https://rubyonrails.org/)のプロジェクトを作ります

```
$ bundle install --path vendor/bundle
$ bundle exec rails new . -d postgresql
```

- データベースに接続できるように`config/database.yml`の設定を変更します

```:config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  username: postgres
  password: postgres

development:
  <<: *default
  database: weathers_repo

test:
  <<: *default
  database: web_test

production:
  <<: *default
  database: web_production
  username: web
  password: <%= ENV['WEB_DATABASE_PASSWORD'] %>
```

- まず、[Elixir](https://elixir-lang.org/)を使って作ったプロジェクトのほうでできたデータベースのスキーマをダンプします

```
$ bundle exec rails db:schema:dump
```

- そうすると、`db/schema.rb`が以下のように作られるはずです

```ruby:db/schema.rb
ActiveRecord::Schema.define(version: 2020_04_08_123754) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "weathers", force: :cascade do |t|
    t.integer "city_number", null: false
    t.string "city", limit: 255, null: false
    t.text "text", null: false
    t.datetime "inserted_at", precision: 0, null: false
    t.datetime "updated_at", precision: 0, null: false
  end

end
```

- すばらしい!
- 続いて、`Gemfile`を変更して[ActiveAdmin](https://activeadmin.info/index.html)を使えるようにします

```:Gemfile
gem 'activeadmin'
gem 'devise'
gem 'cancancan'
gem 'draper'
gem 'pundit'
```

## ちょっと一息
- [device](https://github.com/heartcombo/devise)のライセンス表記をみますと、以下のようになっています

```
MIT License. Copyright 2020 Rafael França, Leaonardo Tegon, Carlos Antônio da Silva. Copyright 2009-2019 Plataformatec.
```

- [Plataformatec](https://plataformatec.com/en/)社のホームページに行くと、

```
We are the company behind Elixir
We offer Elixir consulting and development services for companies using Elixir
```

- と書いてあります
- [Elixir](https://elixir-lang.org/)との強い縁を感じます



- それでは、開発に戻りましょう
- `bundle install`してから、以下のように[ActiveAdmin](https://activeadmin.info/index.html)のセットアップ、データベースのマイグレーション、シードデータの投入をします

```
$ bundle install
$ bundle exec rails g active_admin:install
$ bundle exec rails db:migrate
$ bundle exec rails db:seed
```

- ここまではいろいろ手順はありますが、一行もコードは書いていません
- なんでも準備には時間と労力がかかるのです
- そして、ここからいよいよ[Ruby on Rails](https://rubyonrails.org/)プロジェクトにコードを追加していきます

```ruby:app/models/weather.rb
# app/models/weather.rb
class Weather < ApplicationRecord; end
```

```ruby:app/admin/weathers.rb
# app/admin/weathers.rb
ActiveAdmin.register Weather do
  permit_params :city_number, :city, :text, :inserted_at
end
```

- 以上です
- **たったこれだけ、この２ファイルだけを作ればよいのです**
- この記事のハイライトです
- さて、Railsを起動してみましょう

```
$ bundle exec rails s 
```

- ブラウザで、 http://localhost:3000/admin/ にアクセスしてください
- ログイン画面が表示されますので以下の内容を入力してください

```
User: admin@example.com
Password: password
```

<img width="1318" alt="スクリーンショット 2020-04-08 23.13.54.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c6fe0634-2ebd-eeec-7c8f-cdc31ac823eb.png">

Yay!

# まとめ
- [Elixir](https://elixir-lang.org/)は美しく、書いていて楽しい言語です
    - プログラミングってこんなにおもしろかったのだ！　と改めて気づかせてくれます
- [Ruby on Rails](https://rubyonrails.org/)以外で作ったデータベースのスキーマは、`rails db:schema:dump`で`db/schema.rb`に反映させます
- [ActiveAdmin](https://activeadmin.info/index.html)を使うと、たった数行書くだけで、[CRUD](https://ja.wikipedia.org/wiki/CRUD)を備えた管理画面を完成できます
- このプロジェクトは以下で動かしています
- しばらくはサンプルを[Time4VPS](https://www.time4vps.com/)上で動かしておきますのでご自由にお使いください

https://elixir-is-beautiful.torifuku-kaiou.tokyo/

```
User: admin@example.com
Password: password
```
