# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :phoenix_trello, PhoenixTrello.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "5ffcj9jOuzVL8GdXpetvD3ODcnjY+mZzEg2Sn2jgnGa6/M8YZRKvV8IrZIY+K95V",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: PhoenixTrello.PubSub,
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

# Configure Guardian
config :guardian, Guardian,
  issuer: "PhoenixTrello",
  ttl: { 3, :days},
  verify_issuer: true,
  #generate secret key with 'mix phoenix.gen.secret'
  secret_key: "Blbt1P/pPaUehyOJvuoSlI5e0tYTjK4NGKRDJZpv4+h8ZP6PfgmWUJFfr9/FiX3O"
  serializer: PhoenixTrello.GuardianSerializer
