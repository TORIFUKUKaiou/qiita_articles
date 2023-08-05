---
title: GitHubでログインをPhoenixで楽しむ
tags:
  - GitHub
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-19T19:51:47+09:00'
id: c6ecfb8fa396ac55285d
organization_url_name: fukuokaex
slide: false
---
# はじめに

[GitHubでログイン](https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow)を[Phoenix](https://www.phoenixframework.org/)アプリの上に実装してみます。

今回は、OAuth2クライアントライブラリを使わずに、

https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow

の仕様書に沿って、実装してみたいとおもいます。
HTTPクライアントライブラリは使います。
[fly-apps/live_beats](https://github.com/fly-apps/live_beats)を参考にします。

OAuth2クライアントライブラリを使うなら、[ueberauth/oauth2](https://github.com/ueberauth/oauth2)を使うのがよいとおもいます。

# 実装すべきこと

実装すべきことは以下の3点です。

1. Users are redirected to request their GitHub identity
1. Users are redirected back to your site by GitHub
1. Your app accesses the API with the user's access token

詳しくは、

https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow

に書いてあります。

# What is [fly-apps/live_beats](https://github.com/fly-apps/live_beats)?

> Play music together with Phoenix LiveView!

[Phoenix](https://www.phoenixframework.org/)の作者[Chris McCord](https://twitter.com/chris_mccord)さんが作成されたサンプル[Phoenix](https://www.phoenixframework.org/)アプリです。

以前、動かしてみましたー　記事を書きました。

https://qiita.com/torifukukaiou/items/bc4210986fc6d4880245

## OAuth2

[fly-apps/live_beats](https://github.com/fly-apps/live_beats)プロジェクトでは、HTTPクライアントライブラリ[Mint](https://hexdocs.pm/mint/Mint.HTTP.html)を使って、OAuth2クライアントの処理を実装しています。

https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow

の仕様書に書いてある通りの処理をしています。
特にポイントとなるソースコードは以下の3ファイルです。

### live_beats/github.ex

https://github.com/fly-apps/live_beats/blob/6b02cfc614aaf1f7a5ebc595c435bf62a65f5bcb/lib/live_beats/github.ex

### lib/live_beats_web/controllers/oauth_callback_controller.ex

https://github.com/fly-apps/live_beats/blob/6b02cfc614aaf1f7a5ebc595c435bf62a65f5bcb/lib/live_beats_web/controllers/oauth_callback_controller.ex

### lib/live_beats_web/controllers/user_auth.ex

https://github.com/fly-apps/live_beats/blob/6b02cfc614aaf1f7a5ebc595c435bf62a65f5bcb/lib/live_beats_web/controllers/user_auth.ex

ここでだいたいこの記事はおわりです。
以下、コピペして動くものを作ってみました。

# 自分でも作ってみました

[fly-apps/live_beats](https://github.com/fly-apps/live_beats)からのコピペです。

![](https://media.giphy.com/media/5MMV0sAwD6etwM1yWZ/giphy.gif)

ログインに成功すると、
<font color="red">$\huge{元気ですかーーーーッ！}$</font>
というメッセージを確認できます。

## 使用したバージョン

```
mix phx.new -v
Phoenix installer v1.6.13

asdf current
elixir          1.14.0-otp-25
erlang          25.0.3
```

## PostgreSQL

Dockerで動かしました。

```
docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:13
```

## プロジェクト作成

```
mix phx.new hello_github
cd hello_github
```

## ソースコードを作る

あとはだらだら変更点を書いておきます。

### lib/hello_github/github.ex

ポイントとなるソースコードその１です。

https://docs.github.com/en/developers/apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow

通りの処理がされています。



```elixir:lib/hello_github/github.ex
defmodule HelloGithub.Github do
  def authorize_url() do
    state = random_string()

    "https://github.com/login/oauth/authorize?client_id=#{client_id()}&state=#{state}&scope=user:email"
  end

  def exchange_access_token(opts) do
    code = Keyword.fetch!(opts, :code)
    state = Keyword.fetch!(opts, :state)

    state
    |> fetch_exchange_response(code)
    |> fetch_user_info()
    |> fetch_emails()
  end

  defp fetch_exchange_response(state, code) do
    resp =
      http(
        "github.com",
        "POST",
        "/login/oauth/access_token",
        [state: state, code: code, client_secret: secret()],
        [{"accept", "application/json"}]
      )

    with {:ok, resp} <- resp,
         %{"access_token" => token} <- Jason.decode!(resp) do
      {:ok, token}
    else
      {:error, _reason} = err -> err
      %{} = resp -> {:error, {:bad_response, resp}}
    end
  end

  defp fetch_user_info({:error, _reason} = error), do: error

  defp fetch_user_info({:ok, token}) do
    resp =
      http(
        "api.github.com",
        "GET",
        "/user",
        [],
        [{"accept", "application/vnd.github.v3+json"}, {"Authorization", "token #{token}"}]
      )

    case resp do
      {:ok, info} -> {:ok, %{info: Jason.decode!(info), token: token}}
      {:error, _reason} = err -> err
    end
  end

  defp fetch_emails({:error, _} = err), do: err

  defp fetch_emails({:ok, user}) do
    resp =
      http(
        "api.github.com",
        "GET",
        "/user/emails",
        [],
        [{"accept", "application/vnd.github.v3+json"}, {"Authorization", "token #{user.token}"}]
      )

    case resp do
      {:ok, info} ->
        emails = Jason.decode!(info)
        {:ok, Map.merge(user, %{primary_email: primary_email(emails), emails: emails})}

      {:error, _reason} = err ->
        err
    end
  end

  def random_string do
    binary = <<
      System.system_time(:nanosecond)::64,
      :erlang.phash2({node(), self()})::16,
      :erlang.unique_integer()::16
    >>

    binary
    |> Base.url_encode64()
    |> String.replace(["/", "+"], "-")
  end

  defp client_id, do: HelloGithub.config([:github, :client_id])
  defp secret, do: HelloGithub.config([:github, :client_secret])

  defp http(host, method, path, query, headers, body \\ "") do
    {:ok, conn} = Mint.HTTP.connect(:https, host, 443)

    path = path <> "?" <> URI.encode_query([{:client_id, client_id()} | query])

    {:ok, conn, ref} =
      Mint.HTTP.request(
        conn,
        method,
        path,
        headers,
        body
      )

    receive_resp(conn, ref, nil, nil, false)
  end

  defp receive_resp(conn, ref, status, data, done?) do
    receive do
      message ->
        {:ok, conn, responses} = Mint.HTTP.stream(conn, message)

        {new_status, new_data, done?} =
          Enum.reduce(responses, {status, data, done?}, fn
            {:status, ^ref, new_status}, {_old_status, data, done?} -> {new_status, data, done?}
            {:headers, ^ref, _headers}, acc -> acc
            {:data, ^ref, binary}, {status, nil, done?} -> {status, binary, done?}
            {:data, ^ref, binary}, {status, data, done?} -> {status, data <> binary, done?}
            {:done, ^ref}, {status, data, _done?} -> {status, data, true}
          end)

        cond do
          done? and new_status == 200 -> {:ok, new_data}
          done? -> {:error, {new_status, new_data}}
          !done? -> receive_resp(conn, ref, new_status, new_data, done?)
        end
    end
  end

  defp primary_email(emails) do
    Enum.find(emails, fn email -> email["primary"] end)["email"] || Enum.at(emails, 0)
  end
end

```

### lib/hello_github_web/controllers/oauth_callback_controller.ex

ポイントとなるソースコードその２です。
GitHubからのコールバックのエントリーポイントです。


```elixir:lib/hello_github_web/controllers/oauth_callback_controller.ex
defmodule HelloGithubWeb.OAuthCallbackController do
  use HelloGithubWeb, :controller
  require Logger

  alias HelloGithub.Accounts

  def new(conn, %{"provider" => "github", "code" => code, "state" => state}) do
    client = github_client(conn)

    with {:ok, info} <- client.exchange_access_token(code: code, state: state),
         %{info: info, primary_email: primary, emails: emails, token: token} = info,
         {:ok, user} <- Accounts.register_github_user(primary, info, emails, token) do
      conn
      |> put_flash(:info, "Welcome #{user.email}")
      |> HelloGithubWeb.UserAuth.log_in_user(user)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        Logger.debug("failed GitHub insert #{inspect(changeset.errors)}")

        conn
        |> put_flash(
          :error,
          "We were unable to fetch the necessary information from your GithHub account"
        )
        |> redirect(to: "/")

      {:error, reason} ->
        Logger.debug("failed GitHub exchange #{inspect(reason)}")

        conn
        |> put_flash(:error, "We were unable to contact GitHub. Please try again later")
        |> redirect(to: "/")
    end
  end

  def new(conn, %{"provider" => "github", "error" => "access_denied"}) do
    redirect(conn, to: "/")
  end

  def sign_out(conn, _) do
    HelloGithubWeb.UserAuth.log_out_user(conn)
  end

  defp github_client(conn) do
    conn.assigns[:github_client] || HelloGithub.Github
  end
end

```

### lib/hello_github_web/controllers/user_auth.ex

ポイントとなるソースコードその３です。
前述の`OAuthCallbackController`や`routes.ex`から呼び出されています。

```elixir:lib/hello_github_web/controllers/user_auth.ex
defmodule HelloGithubWeb.UserAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Phoenix.LiveView
  alias HelloGithub.Accounts
  alias HelloGithubWeb.Router.Helpers, as: Routes

  def on_mount(:current_user, _params, session, socket) do
    case session do
      %{"user_id" => user_id} ->
        {:cont, LiveView.assign_new(socket, :current_user, fn -> Accounts.get_user(user_id) end)}

      %{} ->
        {:cont, LiveView.assign(socket, :current_user, nil)}
    end
  end

  def on_mount(:ensure_authenticated, _params, session, socket) do
    case session do
      %{"user_id" => user_id} ->
        new_socket =
          LiveView.assign_new(socket, :current_user, fn -> Accounts.get_user!(user_id) end)

        %Accounts.User{} = new_socket.assigns.current_user
        {:cont, new_socket}

      %{} ->
        {:halt, redirect_require_login(socket)}
    end
  rescue
    Ecto.NoResultsError -> {:halt, redirect_require_login(socket)}
  end

  defp redirect_require_login(socket) do
    socket
    |> LiveView.put_flash(:error, "Please sign in")
    |> LiveView.redirect(to: Routes.sign_in_path(socket, :index))
  end

  @doc """
  Logs the user in.
  It renews the session ID and clears the whole session
  to avoid fixation attacks. See the renew_session
  function to customize this behaviour.
  It also sets a `:live_socket_id` key in the session,
  so LiveView sessions are identified and automatically
  disconnected on log out. The line can be safely removed
  if you are not using LiveView.
  """
  def log_in_user(conn, user) do
    user_return_to = get_session(conn, :user_return_to)
    conn = assign(conn, :current_user, user)

    conn
    |> renew_session()
    |> put_session(:user_id, user.id)
    |> put_session(:live_socket_id, "users_sessions:#{user.id}")
    |> redirect(to: user_return_to || signed_in_path(conn))
  end

  defp renew_session(conn) do
    conn
    |> configure_session(renew: true)
    |> clear_session()
  end

  @doc """
  Logs the user out.
  It clears all session data for safety. See renew_session.
  """
  def log_out_user(conn) do
    if live_socket_id = get_session(conn, :live_socket_id) do
      HelloGithubWeb.Endpoint.broadcast(live_socket_id, "disconnect", %{})
    end

    conn
    |> renew_session()
    |> redirect(to: Routes.sign_in_path(conn, :index))
  end

  @doc """
  Authenticates the user by looking into the session.
  """
  def fetch_current_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Accounts.get_user(user_id)
    assign(conn, :current_user, user)
  end

  @doc """
  Used for routes that require the user to not be authenticated.
  """
  def redirect_if_user_is_authenticated(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
      |> redirect(to: signed_in_path(conn))
      |> halt()
    else
      conn
    end
  end

  @doc """
  Used for routes that require the user to be authenticated.
  If you want to enforce the user email is confirmed before
  they use the application at all, here would be a good place.
  """
  def require_authenticated_user(conn, _opts) do
    if conn.assigns[:current_user] do
      conn
    else
      conn
      |> put_flash(:error, "You must log in to access this page.")
      |> maybe_store_return_to()
      |> redirect(to: Routes.sign_in_path(conn, :index))
      |> halt()
    end
  end

  defp maybe_store_return_to(%{method: "GET"} = conn) do
    %{request_path: request_path, query_string: query_string} = conn
    return_to = if query_string == "", do: request_path, else: request_path <> "?" <> query_string
    put_session(conn, :user_return_to, return_to)
  end

  defp maybe_store_return_to(conn), do: conn

  def signed_in_path(conn) do
    Routes.awesome_path(conn, :index)
  end
end

```

### config/dev.exs

```elixir:config/dev.exs
config :hello_github, :github,
  client_id: System.fetch_env!("HELLO_GITHUB_GITHUB_CLIENT_ID"),
  client_secret: System.fetch_env!("HELLO_GITHUB_GITHUB_CLIENT_SECRET")

```

### lib/hello_github.ex

```elixir:lib/hello_github.ex
  def config([main_key | rest] = keyspace) when is_list(keyspace) do
    main = Application.fetch_env!(:hello_github, main_key)

    Enum.reduce(rest, main, fn next_key, current ->
      case Keyword.fetch(current, next_key) do
        {:ok, val} -> val
        :error -> raise ArgumentError, "no config found under #{inspect(keyspace)}"
      end
    end)
  end
```

### lib/hello_github/accounts.ex

```elixir:lib/hello_github/accounts.ex
defmodule HelloGithub.Accounts do
  import Ecto.Query
  import Ecto.Changeset

  alias HelloGithub.Repo
  alias HelloGithub.Accounts.{User, Identity}

  ## Database getters

  @doc """
  Gets a single user.
  Raises `Ecto.NoResultsError` if the User does not exist.
  ## Examples
      iex> get_user!(123)
      %User{}
      iex> get_user!(456)
      ** (Ecto.NoResultsError)
  """
  def get_user!(id), do: Repo.get!(User, id)

  def get_user(id), do: Repo.get(User, id)

  ## User registration

  @doc """
  Registers a user from their GithHub information.
  """
  def register_github_user(primary_email, info, emails, token) do
    if user = get_user_by_provider(:github, primary_email) do
      update_github_token(user, token)
    else
      info
      |> User.github_registration_changeset(primary_email, emails, token)
      |> Repo.insert()
    end
  end

  def get_user_by_provider(provider, email) when provider in [:github] do
    query =
      from(u in User,
        join: i in assoc(u, :identities),
        where:
          i.provider == ^to_string(provider) and
            fragment("lower(?)", u.email) == ^String.downcase(email)
      )

    Repo.one(query)
  end

  defp update_github_token(%User{} = user, new_token) do
    identity =
      Repo.one!(from(i in Identity, where: i.user_id == ^user.id and i.provider == "github"))

    {:ok, _} =
      identity
      |> change()
      |> put_change(:provider_token, new_token)
      |> Repo.update()

    {:ok, Repo.preload(user, :identities, force: true)}
  end
end

```

### lib/hello_github/accounts/identity.ex

```elixir:lib/hello_github/accounts/identity.ex
defmodule HelloGithub.Accounts.Identity do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloGithub.Accounts.{Identity, User}

  # providers
  @github "github"

  @derive {Inspect, except: [:provider_token, :provider_meta]}
  schema "identities" do
    field :provider, :string
    field :provider_token, :string
    field :provider_email, :string
    field :provider_login, :string
    field :provider_name, :string, virtual: true
    field :provider_id, :string
    field :provider_meta, :map

    belongs_to :user, User

    timestamps()
  end

  @doc """
  A user changeset for github registration.
  """
  def github_registration_changeset(info, primary_email, emails, token) do
    params = %{
      "provider_token" => token,
      "provider_id" => to_string(info["id"]),
      "provider_login" => info["login"],
      "provider_name" => info["name"] || info["login"],
      "provider_email" => primary_email
    }

    %Identity{provider: @github, provider_meta: %{"user" => info, "emails" => emails}}
    |> cast(params, [
      :provider_token,
      :provider_email,
      :provider_login,
      :provider_name,
      :provider_id
    ])
    |> validate_required([:provider_token, :provider_email, :provider_name, :provider_id])
    |> validate_length(:provider_meta, max: 10_000)
  end
end

```

### lib/hello_github/accounts/user.ex

```elixir:lib/hello_github/accounts/user.ex
defmodule HelloGithub.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias HelloGithub.Accounts.{User, Identity}

  schema "users" do
    field :email, :string
    field :name, :string
    field :username, :string
    field :confirmed_at, :naive_datetime
    field :role, :string, default: "subscriber"
    field :profile_tagline, :string
    field :active_profile_user_id, :id

    has_many :identities, Identity

    timestamps()
  end

  @doc """
  A user changeset for github registration.
  """
  def github_registration_changeset(info, primary_email, emails, token) do
    %{"login" => username, "avatar_url" => avatar_url, "html_url" => external_homepage_url} = info

    identity_changeset =
      Identity.github_registration_changeset(info, primary_email, emails, token)

    if identity_changeset.valid? do
      params = %{
        "username" => username,
        "email" => primary_email,
        "name" => get_change(identity_changeset, :provider_name),
        "avatar_url" => avatar_url,
        "external_homepage_url" => external_homepage_url
      }

      %User{}
      |> cast(params, [:email, :name, :username])
      |> validate_required([:email, :name, :username])
      |> validate_username()
      |> validate_email()
      |> put_assoc(:identities, [identity_changeset])
    else
      %User{}
      |> change()
      |> Map.put(:valid?, false)
      |> put_assoc(:identities, [identity_changeset])
    end
  end

  defp validate_email(changeset) do
    changeset
    |> validate_required([:email])
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, HelloGithub.Repo)
    |> unique_constraint(:email)
  end

  defp validate_username(changeset) do
    changeset
    |> validate_format(:username, ~r/^[a-zA-Z0-9_-]{2,32}$/)
    |> unsafe_validate_unique(:username, HelloGithub.Repo)
    |> unique_constraint(:username)
    |> prepare_changes(fn changeset ->
      case fetch_change(changeset, :profile_tagline) do
        {:ok, _} ->
          changeset

        :error ->
          username = get_field(changeset, :username)
          put_change(changeset, :profile_tagline, "#{username}'s beats")
      end
    end)
  end
end

```

### lib/hello_github_web/live/awesome_live.ex

ログイン後にアクセスできる画面です。

```elixir:lib/hello_github_web/live/awesome_live.ex
defmodule HelloGithubWeb.AwesomeLive do
  use HelloGithubWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    IO.inspect(assigns)

    ~H"""
    元気ですかーーーーッ！
    Welcome
    <p>Hello, <%= @current_user.email %>!</p>
    """
  end
end

```

### lib/hello_github_web/live/sign_in_live.ex

ログイン画面です。

```elixir:lib/hello_github_web/live/sign_in_live.ex
defmodule HelloGithubWeb.SignInLive do
  use HelloGithubWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gray-50 flex flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
        <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <div class="space-y-6">
            <a
              href={HelloGithub.Github.authorize_url()}
              class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
            >
              Sign in with GitHub
            </a>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    {:ok, socket}
  end
end

```

### lib/hello_github_web/router.ex

```elixir:lib/hello_github_web/router.ex
  import HelloGithubWeb.UserAuth,
    only: [redirect_if_user_is_authenticated: 2]

  scope "/", HelloGithubWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    get "/oauth/callbacks/:provider", OAuthCallbackController, :new
  end

  scope "/", HelloGithubWeb do
    pipe_through :browser

    get "/", PageController, :index
    delete "/signout", OAuthCallbackController, :sign_out

    live_session :default, on_mount: [{HelloGithubWeb.UserAuth, :current_user}] do
      live "/signin", SignInLive, :index
    end

    live_session :authenticated,
      on_mount: [{HelloGithubWeb.UserAuth, :ensure_authenticated}] do
      live "/awesome", AwesomeLive, :index
    end
  end
```

### lib/hello_github_web/templates/layout/_user_menu.html.heex

```elixir:lib/hello_github_web/templates/layout/_user_menu.html.heex
<%= if @current_user do %>
  <li><p><%= @current_user.email %></p></li>
  <li><%= link "Log out", to: Routes.o_auth_callback_path(@conn, :sign_out), method: :delete %></li>
<% end %>
```

### lib/hello_github_web/templates/layout/root.html.heex

```diff:lib/hello_github_web/templates/layout/root.html.heex
             <%= if function_exported?(Routes, :live_dashboard_path, 2) do %>
               <li><%= link "LiveDashboard", to: Routes.live_dashboard_path(@conn, :home) %></li>
             <% end %>
+            <%= render "_user_menu.html", assigns %>
           </ul>
         </nav>
         <a href="https://phoenixframework.org/" class="phx-logo">
```

### mix.exs

```diff:mix.exs
@@ -48,7 +48,8 @@ defmodule HelloGithub.MixProject do
       {:telemetry_poller, "~> 1.0"},
       {:gettext, "~> 0.18"},
       {:jason, "~> 1.2"},
-      {:plug_cowboy, "~> 2.5"}
+      {:plug_cowboy, "~> 2.5"},
+      {:mint, "~> 1.0"}
     ]
   end
```

### priv/repo/migrations/20210905021010_create_user_auth.exs

GitHubにログインしたあとにGitHubからもらった情報を自データベースに保存します。

```elixir:priv/repo/migrations/20210905021010_create_user_auth.exs
defmodule LiveBeats.Repo.Migrations.CreateUserAuth do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add :email, :citext, null: false
      add :username, :string, null: false
      add :name, :string
      add :role, :string, null: false
      add :confirmed_at, :naive_datetime
      add :profile_tagline, :string
      add :active_profile_user_id, references(:users, on_delete: :nilify_all)

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:username])

    create table(:identities) do
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :provider, :string, null: false
      add :provider_token, :string, null: false
      add :provider_login, :string, null: false
      add :provider_email, :string, null: false
      add :provider_id, :string, null: false
      add :provider_meta, :map, default: "{}", null: false

      timestamps()
    end

    create index(:identities, [:user_id])
    create index(:identities, [:provider])
    create unique_index(:identities, [:user_id, :provider])
  end
end

```

## GitHubにアプリ登録をする

https://github.com/settings/applications/new
ここから作れます。

Application name: 適当な名前をつけてください
Homepage URL: http://localhost:4000
Authorization callback URL: http://localhost:4000/oauth/callbacks/github

を登録します。


## 動かす

迷わず動かしてみます。

```
export HELLO_GITHUB_GITHUB_CLIENT_ID="..."
export HELLO_GITHUB_GITHUB_CLIENT_SECRET="..."

mix setup
mix phx.server
```

`HELLO_GITHUB_GITHUB_CLIENT_ID`と`HELLO_GITHUB_GITHUB_CLIENT_SECRET`は、GitHubアプリの設定画面で確認できます。




# おわりに

GitHubでログインをPhoenixで楽しみました。

[fly-apps/live_beats](https://github.com/fly-apps/live_beats)プロジェクトから必要な処理を抜き書きしました。
データベースに保存する処理を省けばもっと量は少なくなるとおもいます。


