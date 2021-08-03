# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :simple_auth_phoenix,
  ecto_repos: [SimpleAuthPhoenix.Repo]

# Configures the endpoint
config :simple_auth_phoenix, SimpleAuthPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GSd6Hsdc7yygERPejRpKF1IeLog/gHRvkTCh9oAe41CILUdVReVgDlqLlCZOVyKO",
  render_errors: [view: SimpleAuthPhoenixWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: SimpleAuthPhoenix.PubSub,
  live_view: [signing_salt: "ujfzFWsX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config all databases tables to use UUID
config :simple_auth_phoenix, SimpleAuthPhoenix.Repo, migration_primary_key: [type: :uuid]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
