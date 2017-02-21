use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :unafrik, Unafrik.Endpoint,
  http: [port: 4009],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    npm: ["start", cd: Path.expand("../", __DIR__)]
  ]


# Watch static and templates for browser reloading.
config :unafrik, Unafrik.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :unafrik, Unafrik.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "unafrik_dev",
  hostname: "localhost",
  pool_size: 10

# Bamboo Email
config :unafrik, Unafrik.Mailer,
  adapter: Bamboo.LocalAdapter
