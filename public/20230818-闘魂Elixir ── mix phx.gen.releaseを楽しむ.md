---
title: 闘魂Elixir ── mix phx.gen.releaseを楽しむ
tags:
  - Elixir
  - Phoenix
  - AdventCalendar2023
  - optionparser
  - 闘魂
private: false
updated_at: '2023-08-18T22:44:41+09:00'
id: 1c006187440d50af89ca
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>
# はじめに

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があります。  
[Elixir](https://elixir-lang.org/)には、[Phoenix](https://www.phoenixframework.org/)というWebアプリケーションフレームワークがあります。  

この記事は、[Phoenix](https://www.phoenixframework.org/)の[mix phx.gen.release](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html)タスクについて書きます。  

# What is [mix phx.gen.release](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html) ???

[Phoenix](https://www.phoenixframework.org/) 1.6.3からあります。  
私がついて行けていませんでした。てっきり1.7からのものだとおもいこんでいました。

これらのファイルを作成してくれます。  

- lib/app_name/release.ex (※)
- rel/overlays/bin/migrate
- rel/overlays/bin/server

特に(※)が素敵です。  
以前は、[Deploying with Releases](https://hexdocs.pm/phoenix/releases.html)を見ながら、写経のようなことをしていました。  

```elixir:lib/app_name/release.ex
defmodule MyApp.Release do
  @app :my_app

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end
```

以前は、まずコピペして自分のアプリケーション名にあうように`MyApp`や`:my_app`を書き直していました。
[mix phx.gen.release](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html)タスクを使うことで、自分のプロジェクト名にあわせていい感じのファイルを作ってくれます。

---


また`--docker`オプションを使えます。`--docker`オプションを付けて実行すると、次のファイルを作成してくれます。

- Dockerfile
- .dockerignore

これまた以前は、[Deploying with Releases](https://hexdocs.pm/phoenix/releases.html)を見ながら、写経のようなことをしていました。 

```docker:Dockerfile
# Find eligible builder and runner images on Docker Hub. We use Ubuntu/Debian instead of
# Alpine to avoid DNS resolution issues in production.
#
# https://hub.docker.com/r/hexpm/elixir/tags?page=1&name=ubuntu
# https://hub.docker.com/_/ubuntu?tab=tags
#
#
# This file is based on these images:
#
#   - https://hub.docker.com/r/hexpm/elixir/tags - for the build image
#   - https://hub.docker.com/_/debian?tab=tags&page=1&name=bullseye-20210902-slim - for the release image
#   - https://pkgs.org/ - resource for finding needed packages
#   - Ex: hexpm/elixir:1.14.0-erlang-24.3.4-debian-bullseye-20210902-slim
#
ARG ELIXIR_VERSION=1.14.0
ARG OTP_VERSION=24.3.4
ARG DEBIAN_VERSION=bullseye-20210902-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git \
    && apt-get clean && rm -f /var/lib/apt/lists/*_*

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV="prod"

# install mix dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV
RUN mkdir config

# copy compile-time config files before we compile dependencies
# to ensure any relevant config change will trigger the dependencies
# to be re-compiled.
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

COPY priv priv

# note: if your project uses a tool like https://purgecss.com/,
# which customizes asset compilation based on what it finds in
# your Elixir templates, you will need to move the asset compilation
# step down so that `lib` is available.
COPY assets assets

# compile assets
RUN mix assets.deploy

# Compile the release
COPY lib lib

RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

COPY rel rel
RUN mix release

# start a new build stage so that the final image will only contain
# the compiled release and other runtime necessities
FROM ${RUNNER_IMAGE}

RUN apt-get update -y && apt-get install -y libstdc++6 openssl libncurses5 locales \
  && apt-get clean && rm -f /var/lib/apt/lists/*_*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

WORKDIR "/app"
RUN chown nobody /app

# set runner ENV
ENV MIX_ENV="prod"

# Only copy the final release from the build stage
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/my_app ./

USER nobody

CMD /app/bin/server
```

これまた以前は`:my_app`を書き換えていました。  
`mix phx.gen.release --docker`タスクをつかうことでいい感じ、猪木寛至、猪木さんのファイルを作ってくれます。  


# さいごに

この記事は、[mix phx.gen.release](https://hexdocs.pm/phoenix/Mix.Tasks.Phx.Gen.Release.html)タスクを説明しました。  

ご存知の方にとってはふ〜んでしょう。その一方で、私のようにえっ！！！ 1.6.3というタイミングでそんなのが追加されていたんだ〜　という方もいらっしゃるとおもいますので記事をしたためておきました。  

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
