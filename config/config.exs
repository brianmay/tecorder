# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tecorder,
  ecto_repos: [Tecorder.Repo]

# Configures the endpoint
config :tecorder, TecorderWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1QzaMrJBDcE3uE3z2iUvqUCM575Krzl01USHnYkpJxnmILlGzaHtHNLz3xOOneqc",
  render_errors: [view: TecorderWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tecorder.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
