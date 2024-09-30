---
title: 'Phoenixで作ったアプリをNginxを前においた構成でサーバーにデプロイしたらChannelの機能が動かなかったことを解決した話[Elixir]'
tags:
  - Elixir
  - Phoenix
  - fukuoka.ex
private: false
updated_at: '2024-09-18T08:51:35+09:00'
id: 5844fc25cab91950ba3e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Programming Phoenix >= 1.4](https://www.amazon.co.jp/dp/1680502263) という本がありまして、英語をよちよち読みながら一周しました
- ところどころまだまだ理解できていないところがありまして、もう一周してみることにしました
- この本は、コード例は省略がないので、二周目は説明のところはあまり読まないことにして、コードのところだけみて写してみることにしました
- ちょっとした機能追加もしてみました
- できあがったものをサーバーにデプロイしてみました
- 限定公開的な感じでアクセス元のIPは絞っています
- 本の通りにやると、[Channels](https://hexdocs.pm/phoenix/channels.html#content)を利用したチャット機能がつくれます
- ところがこのチャット機能が、ローカルでは動いていたはずなのに、デプロイした実行環境下では、うんともすんともいいませんでした
- こんな感じのエラーがブラウザのJavaScriptコンソールにでていました

```
WebSocket connection to to wss://hogehoge.com/socket/websocket?token=<token>&vsn=2.0.0' failed: Error during WebSocket handshake: Unexpected response code: 400
```

# 結論
- [Upgrading to Phoenix 1.4 & Cowboy 2.x breaks websockets](https://github.com/phoenixframework/phoenix/issues/3165)
- ↑ 答えはここにありました
- [nginx](https://www.nginx.com/)の設定に `proxy_http_version 1.1;`を追加しました
- [Phoenix](https://www.phoenixframework.org/)がどうのこうのというより、以下の記事の内容のほうがぴったりくるかもしれません
    - [NginxでリバースプロクシをしているサイトでWebSocket使ったら、なんか変な感じになった](https://web.archive.org/web/20210926071603/http://tolarian-academy.net/nginx%E3%81%A7%E3%83%AA%E3%83%90%E3%83%BC%E3%82%B9%E3%83%97%E3%83%AD%E3%82%AF%E3%82%B7%E3%82%92%E3%81%97%E3%81%A6%E3%81%84%E3%82%8B%E3%82%B5%E3%82%A4%E3%83%88%E3%81%A7websocket%E4%BD%BF%E3%81%A3/)
    - ありがとうございます！

# 詳細
- 以下、もう少し詳しくかいておきます
- それぞれ専門にかかれている良記事があるとおもいますが、ざっと流れを記録しておきます

## 構成
- [EC2](https://aws.amazon.com/jp/ec2/)を使いました
    - Ubuntu 18.04.3 LTS
    - PostgreSQL 10.12
    - nginx 1.14.0
    - node v12.16.1
    - Erlang 22.1.4
    - Elixir 1.9.4-otp-22
- [セキュリティグループ](https://docs.aws.amazon.com/ja_jp/vpc/latest/userguide/VPC_SecurityGroups.html)を使ってアクセス元のIPを限定しました
- [Let's Encrypt](https://letsencrypt.org/ja/)を使って証明書を取得して、httpsにします
    - アクセス元IPを絞っているので、DNS認証で取得します

## 1. UbuntuがインストールされたEC2をつくる
- 省略

## 2. 限られたIPからのインバウンドを許可したセキュリティグループをつくってEC2に関連づける
- 省略

## 3. Ubuntuにいろいろインストールする

```
% ssh -i ~/.ssh/secret.pem ubuntu@<サーバーのIP>
```
- https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/connection-prereqs.html
- サーバーに入りましょう

### 3-1. PostgreSQL

```
> sudo apt update
> sudo apt install postgresql postgresql-contrib
> sudo -u postgres psql postgres
\password postgres
```
- https://help.ubuntu.com/community/PostgreSQL

### 3-2. node

- [Ubuntuに最新のNode.jsを難なくインストールする](https://qiita.com/seibe/items/36cef7df85fe2cefa3ea)
    - こちらの記事の通りにやりました
    - ありがとうございます！

### 3-3. Erlang と Elixir
- [asdf-vm](https://asdf-vm.com/)を使ってインストールします

```
> git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.7.7
> echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
> echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
> source ~/.bashrc
> sudo apt install \
  automake autoconf libreadline-dev \
  libncurses-dev libssl-dev libyaml-dev \
  libxslt-dev libffi-dev libtool unixodbc-dev \
  unzip curl
> asdf plugin add erlang
> asdf plugin add elixir
> asdf install erlang 22.1.4
> asdf global erlang 22.1.4
> asdf install elixir 1.9.4-otp-22
> asdf global elixir 1.9.4-otp-22
```
- https://asdf-vm.com/#/core-manage-asdf-vm
- `asdf install erlang 22.1.4` はけっこう時間かかります
- 気長に待ちましょう

### 3-4. Let's Encrypt を使って証明書を取得する

```
> apt -y install certbot
> sudo certbot certonly --server https://acme-v02.api.letsencrypt.org/directory --manual --preferred-challenges dns -d hogehoge.com --email torifukukaiou@hogehoge.com
```
- 私は[Route 53](https://aws.amazon.com/jp/route53/)を使いましたが、こちらの [Let's EncryptのSSL証明書をDNS認証で発行してみた。（DNSはお名前.com）](https://qiita.com/aqr_w/items/db4eb8c7106f109819f0) にあることと同じようなことをすればよいです
    - ありがとうございます！

- 以下のようなファイルを用意します

```/etc/nginx/conf.d/hogehoge.conf
server {
  listen 80;
  server_name hogehoge.com;
  return 301 https://$host$request_uri;
}

server {
  listen       443 ssl http2 default_server;
  listen       [::]:443 ssl http2 default_server;
  server_name  hogehoge.com;
  root         /usr/share/nginx/html;

  ssl_certificate "/etc/letsencrypt/live/hogehoge.com/fullchain.pem";
  ssl_certificate_key "/etc/letsencrypt/live/hogehoge.com/privkey.pem";
  # It is *strongly* recommended to generate unique DH parameters
  # Generate them with: openssl dhparam -out /etc/pki/nginx/dhparams.pem 2048
  # ssl_dhparam "/etc/pki/nginx/dhparams.pem";
  ssl_session_cache shared:SSL:1m;
  ssl_session_timeout  10m;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers HIGH:SEED:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!RSAPSK:!aDH:!aECDH:!EDH-DSS-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA:!SRP;
  ssl_prefer_server_ciphers on;

  location / {
    proxy_set_header Host $host;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Host $host;
    proxy_set_header X-Forwarded-Server $host;
    proxy_set_header X-Forwarded-Proto https;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_redirect off;
    proxy_set_header X-Real-IP $remote_addr;
    
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_http_version 1.1;
    proxy_pass http://127.0.0.1:4000;
  }
}
```

```
> sudo nginx -t
> sudo nginx -s reload
```

# 4. Phoenixを動かす
- https://hexdocs.pm/phoenix/deployment.html#content
- ↑だいたいここに書いてある通りのことをしました

```
$ mix phx.gen.secret
REALLY_LONG_SECRET
```

```~/.bashrc
export SECRET_KEY_BASE="REALLY_LONG_SECRET"
export DATABASE_URL="ecto://postgres:postgres@localhost:5432/hello_prod"
```
- ↑こういうのを書き足します
- 公式に書いてある `ecto://USER:PASS@HOST/database` => これを上のように書き換えるわけですが、いわれてみれば確かになるほど！　なのですが悩みました
    - ectoのところをこれもあくまでも例で、MySQLだとかわったりするのだろうと変に考えてpostgresqlにしたりして余計な変更をしていたせいです:baby_tone2:
- いつものように[piacere_ex](https://twitter.com/piacere_ex)さんの記事に助けてもらいました
    - [ElixirのDB設定をURLで指定（Gigalixirでの指定も）](https://qiita.com/piacerex/items/c964a3c6b1e585335dd0)
    - ありがとうございます！

```config/prod.exs
config :hello, HelloWeb.Endpoint,
  url: [host: "hogehoge.com", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json"
```

```
$ source ~/.bashrc 
$ mix deps.get --only prod
$ MIX_ENV=prod mix compile
$ MIX_ENV=prod mix ecto.create
$ MIX_ENV=prod mix ecto.migrate
$ npm run deploy --prefix ./assets
$ mix phx.digest
$ MIX_ENV=prod nohup mix phx.server &
```

- `/etc/nginx/conf.d/hogehoge.conf` の設定が足りなくてチャット機能が動かなかったわけですが、私の実感としては、ローカルだと動いていたはずなのにー　と、最後の最後のほうで右往左往していました
    - [Phoenix Programming >= 1.4](https://www.amazon.co.jp/dp/1680502263/) という本のおかげでローカルで作るところまでは順調そのものでした！

- いろいろありましたが、無事動いてよかったです :rocket:
    - 時間にすると、4のところが一番時間はかかっていないのですが、なぜ動かないんだーと途方にくれていたので一番時間を使ったような気分になりました






