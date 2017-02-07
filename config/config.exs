# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :unafrik,
  ecto_repos: [Unafrik.Repo]

# Configures the endpoint
config :unafrik, Unafrik.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TAOyDmx/3Nxry+MxA8q0vwkHcybWI1fCLIGcuVKz8JFoGagaie8TnRu/fkFrIE3D",
  render_errors: [view: Unafrik.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Unafrik.PubSub,
           adapter: Phoenix.PubSub.PG2]


config :guardian, Guardian,
  allowed_algos: ["HS512"],   # optional
  verify_module: Guardian.JWT, # optional
  issuer: "Unafrik.#{Mix.env}",
  ttl: {30, :days},
  allowed_drift: 2000,
  verify_issuer: true,
  serializer: Unafrik.GuardianSerializer,
  secret_key: to_string(Mix.env) <> "SuPerseCret_aBraCadabrA"


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :comeonin, :bcrypt_log_rounds, 4

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
