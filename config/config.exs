# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :phoenix_ecommerce, PhoenixEcommerce.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "o4TinWqfhzsvjhS3la5XHbNDjvPq0MbwTIiM+kjIGmGdkH+ebJzlbnUz5d90SZ50",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: PhoenixEcommerce.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :arc,
  bucket: "phoenix-ecommerce"

config :ex_aws,
  access_key_id: System.get_env("AWS_ACCESS_ID"),
  secret_access_key: System.get_env("AWS_SECRET_KEY")
