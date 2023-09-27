---
title: daisyUIを組み込んだPhoenixアプリをDockerで本番展開しようとしたらデコった内容が反映されないときに確認すること
tags:
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - AdventCalendar2022
  - daisyui
private: false
updated_at: '2022-09-05T17:29:08+09:00'
id: 9a4b9add065219db339c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---



Advent Calendar 2022 140日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/) を楽しんでいますか:bangbang::bangbang::bangbang:

[Elixir](https://elixir-lang.org/)のWebアプリケーションフレームワーク[Phoenix](https://www.phoenixframework.org/)で作成したアプリをDockerを使って本番展開しようとしたときに、[daisyUI](https://daisyui.com/)でデコった内容がうまく反映されないことがありました。
この記事は、私はこうしたら解決したよ！　という内容を書いておきます。

# 結論

`COPY lib lib` => `RUN mix assets.deploy` の順となるように`Dockerfile`を書くのが吉です。

# What's [daisyUI](https://daisyui.com/) ?

[daisyUI](https://daisyui.com/) is "The most popular, free and open-source Tailwind CSS component library".

見た目をキレイにデコれます。
見た目は大事です。

# [daisyUI](https://daisyui.com/)の導入

話の前提として、[Phoenix](https://www.phoenixframework.org/)アプリの準備が必要ですが、そこは省略します。

[Phoenix](https://www.phoenixframework.org/)アプリに、[daisyUI](https://daisyui.com/)を導入する手順は紹介しておきます。

以下の通り、進めるとよいです。

[Install Tailwind CSS with Phoenix](https://tailwindcss.com/docs/guides/phoenix)

https://tailwindcss.com/docs/guides/phoenix

続いて、`assets`フォルダにて、

[Install daisyUI as a Tailwind CSS plugin](https://daisyui.com/docs/install/)

https://daisyui.com/docs/install/

を行います。

日本語の記事は、

https://qiita.com/nako_sleep_9h/items/9cd2343d19abee7a59e9

が詳しいです。

# Dockerfile

参考となるDockerfileは、

https://hexdocs.pm/phoenix/releases.html

に書いてあります。


これをもとにいくつか書き換えています。
書き換えポイントは次の通りです。

- `COPY lib lib` => `RUN mix assets.deploy` の順になるようにする
- Build imageに`OTP-25`を使う
    - https://elixirforum.com/t/github-ci-down-is-it-working-for-you/49661/3
- npmのインストール
- node_modulesのインストール
    - `RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error`

```Dockerfile:Dockerfile
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
#   - Ex: hexpm/elixir:1.12.0-erlang-24.0.1-debian-bullseye-20210902-slim
#
ARG ELIXIR_VERSION=1.13.4
ARG OTP_VERSION=25.0.4
ARG DEBIAN_VERSION=bullseye-20220801-slim

ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# install build dependencies
RUN apt-get update -y && apt-get install -y build-essential git npm \
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

COPY lib lib

# compile assets
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error
RUN mix assets.deploy

# Compile the release
RUN mix compile

# Changes to config/runtime.exs don't require recompiling the code
COPY config/runtime.exs config/

# relがないプロジェクトは消しましょう
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


きちんと理解できていないのですが、サンプルのDockerfileに書いてあるコメントに以下の記述があります。

```
# note: if your project uses a tool like https://purgecss.com/,
# which customizes asset compilation based on what it finds in
# your Elixir templates, you will need to move the asset compilation
# step down so that `lib` is available.
```

このコメントと

https://elixirforum.com/t/how-to-get-daisyui-and-phoenix-to-work/46612/9

の記事には、
`RUN mix assets.deploy`より前に、`COPY lib lib`をしなさいと明記されています。

確かにこの通りにやるとうまくいきました :tada::tada::tada: 




# まとめ

`COPY lib lib` => `RUN mix assets.deploy` の順となるように`Dockerfile`を書くのが吉です。

私はこれで解決しました。
他にもハマるポイントはあるかもしれません。
お便りお待ちしております。


2022/12/25が待ち遠しいです :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 


---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)




