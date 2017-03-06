defmodule Unafrik.Mixfile do
  use Mix.Project

  def project do
    [app: :unafrik,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {Unafrik, []},
     applications: [:phoenix,
                    :phoenix_pubsub,
                    :phoenix_html,
                    :cowboy,
                    :logger,
                    :gettext,
                    :phoenix_ecto,
                    :postgrex,
                    :comeonin,
                    :guardian,
                    :bamboo,
                    :bamboo_smtp,
                    :slugger]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2.1"},
     {:phoenix_pubsub, "~> 1.0"},
     {:phoenix_ecto, "~> 3.2.2"},
     {:postgrex, ">= 0.0.0"},
     {:phoenix_html, "~> 2.9.3"},
     {:phoenix_live_reload, "~> 1.0.8", only: :dev},
     {:gettext, "~> 0.13.1"},
     {:cowboy, "~> 1.0"},
     {:comeonin, "~> 3.0.1"},
     {:guardian, "~> 0.14.2"},
     {:bamboo, "~> 0.8.0"},
     {:bamboo_smtp, "~> 1.3.0"},
     {:slugger, "~> 0.1.0"},
     {:ecto_enum, "~> 1.0.1"},
     {:scrivener_ecto, "~> 1.1.4"},
     {:credo, "~> 0.6.1", only: [:dev, :test]},
     {:ex_machina, "~> 2.0", only: :test}
     # {:dialyxir, "~> 0.4.4", only: [:dev, :test], runtime: false},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
