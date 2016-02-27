use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :phoenix_ecommerce, PhoenixEcommerce.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :phoenix_ecommerce, PhoenixEcommerce.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_ecommerce_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :hound,
  driver: "phantomjs",
  app_host: "http://localhost",
  app_port: 4001
