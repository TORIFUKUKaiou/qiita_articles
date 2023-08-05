---
title: '[Elixir]SlackのAPIを例にuseするものを自分で作って使ってみる'
tags:
  - Elixir
  - Slack
private: false
updated_at: '2020-06-14T07:35:22+09:00'
id: c1d6fd54117197ea9991
organization_url_name: fukuokaex
slide: false
---
# はじめに
- たとえば[Phoenix](https://www.phoenixframework.org/)で[Controllers](https://hexdocs.pm/phoenix/controllers.html#content)を書く時に、`use HelloWeb, :controller`みたいなことを書きますが、`use`しているものを自分で書くにはどうしたらいいのでしょうか
- [use](https://hexdocs.pm/elixir/Kernel.html#use/2)しているものを自分で書きたいという思いは、単なる憧れのようなものでした
    - [quote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2)とかみたらそっと閉じていました
- SlackのAPIをコールすることを通じてこの体験ができましたので書いておきます
- [sapporo.beam #326](https://sapporo-beam.connpass.com/event/179261/)という**ほぼ毎週水曜日**に「**思い思いの場所**」で行われる勉強会での成果であります
- `Elixir 1.10.3`

# 初期バージョン
- [users.list](https://api.slack.com/methods/users.list)と[conversations.list](https://api.slack.com/methods/conversations.list)をコールするプログラムを書いてみました
- [Hex](https://hex.pm/)は、[HTTPoison](https://github.com/edgurgel/httpoison)と[Jason](https://github.com/michalmuskala/jason)を使っています

## [users.list](https://api.slack.com/methods/users.list)

```elixir:lib/awesome_app/slack/api/users/list.ex
defmodule AwesomeApp.Slack.Api.Users.List do
  @token Application.get_env(:awesome_app, :slack_token)

  def run do
    get(url(), [])
  end

  def get(url, got_members) do
    url
    |> HTTPoison.get()
    |> handle_response()
    |> Jason.decode!()
    |> next_action(got_members)
  end

  defp handle_response({:ok, %{body: body, status_code: 200}}), do: body

  defp handle_response(_), do: ~s/{"members":[], "response_metadata":{"next_cursor":""}}/

  defp next_action(
         %{"members" => members, "response_metadata" => %{"next_cursor" => ""}},
         got_members
       ) do
    got_members ++ members
  end

  defp next_action(
         %{"members" => members, "response_metadata" => %{"next_cursor" => next_cursor}},
         got_members
       ) do
    url(next_cursor)
    |> get(got_members ++ members)
  end

  defp url do
    "https://slack.com/api/users.list?token=#{@token}"
  end

  defp url(next_cursor) do
    "#{url()}&cursor=#{next_cursor}"
  end
end
```

## [conversations.list](https://api.slack.com/methods/conversations.list)

```elixir:lib/awesome_app/slack/api/conversations/list.ex
defmodule AwesomeApp.Slack.Api.Conversations.List do
  @token Application.get_env(:awesome_app, :slack_token)

  def run do
    get(url(), [])
  end

  def get(url, got_channels) do
    url
    |> HTTPoison.get()
    |> handle_response()
    |> Jason.decode!()
    |> next_action(got_channels)
  end

  defp handle_response({:ok, %{body: body, status_code: 200}}), do: body

  defp handle_response(_), do: ~s/{"channels":[], "response_metadata":{"next_cursor":""}}/

  defp next_action(
         %{"channels" => channels, "response_metadata" => %{"next_cursor" => ""}},
         got_channels
       ) do
    got_channels ++ channels
  end

  defp next_action(
         %{"channels" => channels, "response_metadata" => %{"next_cursor" => next_cursor}},
         got_channels
       ) do
    url(next_cursor)
    |> get(got_channels ++ channels)
  end

  defp url do
    "https://slack.com/api/conversations.list?token=#{@token}"
  end

  defp url(next_cursor) do
    "#{url()}&cursor=#{next_cursor}"
  end
end
```

- 構造は全く同じです
- `members`という字面と`channels`という字面の違いとAPIのパスが違うくらいです

# 改善
- [defmacro](https://hexdocs.pm/elixir/Kernel.html#defmacro/2)で共通部分を書きます
    - ざっくりいうと[quote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2)の中に共通部分を押し込みます
        - ほぼ大部分は初期バージョンのコピペでいけます
    - オプションで受け取った違いの部分は、[unquote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#unquote/1)で押し込みます
- [use](https://hexdocs.pm/elixir/Kernel.html#use/2) するときに違う部分をオプションで渡します

```elixir:lib/awesome_app/slack/api.ex
defmodule AwesomeApp.Slack.Api do
  defmacro __using__(opts) do
    key = Keyword.get(opts, :key)
    method = Keyword.get(opts, :method)

    quote do
      @token Application.get_env(:awesome_app, :slack_token)

      def run do
        get(url(), [])
      end

      def get(url, got_values) do
        url
        |> HTTPoison.get()
        |> handle_response()
        |> Jason.decode!()
        |> next_action(got_values)
      end

      defp handle_response({:ok, %{body: body, status_code: 200}}), do: body

      defp handle_response(_),
        do: ~s/{"#{unquote(key)}":[], "response_metadata":{"next_cursor":""}}/

      defp next_action(
             %{unquote(key) => values, "response_metadata" => %{"next_cursor" => ""}},
             got_values
           ) do
        got_values ++ values
      end

      defp next_action(
             %{unquote(key) => values, "response_metadata" => %{"next_cursor" => next_cursor}},
             got_values
           ) do
        url(next_cursor)
        |> get(got_values ++ values)
      end

      defp url do
        "https://slack.com/api/#{unquote(method)}?token=#{@token}"
      end

      defp url(next_cursor) do
        "#{url()}&cursor=#{next_cursor}"
      end
    end
  end
end
```

```elixir:lib/awesome_app/slack/api/users/list.ex
defmodule AwesomeApp.Slack.Api.Users.List do
  use AwesomeApp.Slack.Api, key: "members", method: "users.list"
end
```

```elixir:lib/awesome_app/slack/api/conversations/list.ex
defmodule AwesomeApp.Slack.Api.Conversations.List do
  use AwesomeApp.Slack.Api, key: "channels", method: "conversations.list"
end
```

# Wrapping Up
- [defmacro](https://hexdocs.pm/elixir/Kernel.html#defmacro/2)
    - [quote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#quote/2)
        - [unquote](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#unquote/1)
- [use](https://hexdocs.pm/elixir/Kernel.html#use/2)
- 共通部分をくくりだすには↑↑↑を使えばよいのであります
- We are the Alchemists, my friends!
- Enjoy!

