---
title: >-
  Liker likes any tweets with "#大晦日ハッカソン" hash tag on 12/31, 2021 -- Enjoy
  Elixir !!!
tags:
  - Elixir
  - 大晦日ハッカソン
private: false
updated_at: '2021-12-31T21:36:20+09:00'
id: 487dd22c388a8e991900
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# Introduction

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

Today[^1] I take part in an event.
Its event is "Omisoka hackathon".
Omisoka means December 31th in Japananese.
December 31th is called Omisoka in Japananese.

[^1]: 12/31, 2021

https://omisoka-hackathon.connpass.com/event/233973/

This event rules to tweet with ["#大晦日ハッカソン"](https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hashtag_click&f=live) hash tag.

I made an app.
Its app is called **Liker**.
**Liker** likes any tweets with ["#大晦日ハッカソン"](https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hashtag_click&f=live) hash tag.

# Write -- aka Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

```
$ mix new liker --sup
```

## mix.exs

```elixir:mix.exs
  defp deps do
    [
      {:oauther, "~> 1.3"},
      {:jason, "~> 1.3"},
      {:extwitter, "~> 0.13.0"},
      {:quantum, "~> 3.4"},
      {:timex, "~> 3.7"}
    ]
  end
```

- [oauther](https://hex.pm/packages/oauther)
    - A library to authenticate using the OAuth 1.0 protocol.
- [jason](https://hex.pm/packages/jason)
    - A blazing fast JSON parser and generator in pure Elixir.
- [extwitter](https://hex.pm/packages/extwitter)
    - Twitter client library for Elixir.
- [quantum](https://hex.pm/packages/quantum)
    - Cron-like job scheduler for Elixir.
- [timex](https://hex.pm/packages/timex)
    - Timex is a rich, comprehensive Date/Time library for Elixir projects, with full timezone support via the :tzdata package. If you need to manipulate dates, times, datetimes, timestamps, etc., then Timex is for you!

# lib/liker/twitter/api.ex

```elixir:lib/liker/twitter/api.ex
defmodule Liker.Twitter.Api do
  @query "#大晦日ハッカソン -RT"
  @ignores []

  def search(last_created_at \\ 0) do
    response =
      ExTwitter.search(
        @query,
        count: 100,
        search_metadata: true
      )

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, [])
  end

  def create_favorite(id) do
    try do
      ExTwitter.create_favorite(id, [])
    rescue
      [ExTwitter.Error] -> IO.puts("You have already favorited this status.")
    end
  end

  defp do_search_next_page([], _metadata, _last_created_at, result_list), do: result_list

  defp do_search_next_page(prev_page_list, metadata, last_created_at, result_list) do
    response = ExTwitter.search_next_page(metadata)

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, result_list ++ prev_page_list)
  end

  defp statuses(statuses, last_created_at) do
    statuses
    |> Enum.map(fn %{
                     id: id,
                     id_str: id_str,
                     text: text,
                     created_at: created_at,
                     user: %{
                       profile_image_url_https: profile_image_url_https,
                       screen_name: screen_name
                     },
                     favorited: favorited
                   } ->
      %{
        id: id,
        id_str: id_str,
        text: text,
        created_at:
          Timex.parse!(created_at, "{WDshort} {Mshort} {D} {h24}:{m}:{s} +0000 {YYYY}")
          |> Timex.to_unix(),
        profile_image_url_https: profile_image_url_https,
        screen_name: screen_name,
        url: "https://twitter.com/#{screen_name}/status/#{id_str}",
        favorited: favorited
      }
    end)
    |> Enum.reject(fn %{screen_name: screen_name} -> screen_name in @ignores end)
    |> Enum.reject(fn %{favorited: favorited} -> favorited end)
    |> Enum.filter(fn %{created_at: created_at} -> created_at > last_created_at end)
  end
end
```

## lib/liker/created_at_agent.ex

```elixir:lib/liker/created_at_agent.ex
defmodule Liker.CreatedAtAgent do
  use Agent

  def start_link(_initial_value) do
    created_at = Timex.now() |> Timex.to_unix() |> Kernel.-(20000)
    Agent.start_link(fn -> %{created_at: created_at} end, name: __MODULE__)
  end

  def get, do: Agent.get(__MODULE__, & &1)

  def update(created_at) do
    Agent.update(__MODULE__, fn _ ->
      %{created_at: created_at}
    end)
  end
end
```

## lib/liker/scheduler.ex

```elixir:lib/liker/scheduler.ex
defmodule Liker.Scheduler do
  use Quantum, otp_app: :liker
end
```

## lib/liker/application.ex

```elixir:lib/liker/application.ex
  def start(_type, _args) do
    children = [
      Liker.CreatedAtAgent, # add
      Liker.Scheduler # add
    ]
```

## lib/liker.ex

```elixir:lib/liker.ex
defmodule Liker do
  def run do
    statuses =
      last_created_at()
      |> Liker.Twitter.Api.search()

    statuses
    |> Enum.map(fn %{id: id} ->
      Liker.Twitter.Api.create_favorite(id)
    end)

    update_created_at(statuses)
  end

  defp last_created_at do
    %{created_at: created_at} = Liker.CreatedAtAgent.get()

    created_at
  end

  defp update_created_at([]), do: nil

  defp update_created_at(statuses) do
    statuses
    |> Enum.map(fn %{created_at: created_at} -> created_at end)
    |> Enum.max()
    |> Liker.CreatedAtAgent.update()
  end
end

```

## config/config.exs

```elixir:config/config.exs
import Config

config :extwitter, :oauth,
  consumer_key: System.get_env("STSP_TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("STSP_TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("STSP_TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("STSP_TWITTER_ACCESS_TOKEN_SECRET")

config :liker, Liker.Scheduler,
  jobs: [
    # Every 20 minutes
    {"*/20 * * * *", {Liker, :run, []}}
  ]
```

# Run

```
$ mix deps.get
$ iex -S mix
```

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

https://github.com/TORIFUKUKaiou/hello_nerves_poncho/tree/main/liker

See all you next year.
 
