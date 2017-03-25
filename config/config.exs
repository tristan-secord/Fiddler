# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :fiddler,
  ecto_repos: [Fiddler.Repo]

# Configures the endpoint
config :fiddler, Fiddler.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DlIzbr9SfhWilFxkPDDLAprs4+eC6tbkPNyVuDxdw7BIoLaaamZe6KQy+6onaqKe",
  render_errors: [view: Fiddler.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Fiddler.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

  config :guardian, Guardian,
    allowed_algos: ["HS512"], # optional
    verify_module: Guardian.JWT,  # optional
    issuer: "Fiddler",
    ttl: { 30, :days },
    verify_issuer: true, # optional
    secret_key: "DlIzbr9SfhWilFxkPDDLAprs4+eC6tbkPNyVuDxdw7BIoLaaamZe6KQy+6onaqKe",
    serializer: Fiddler.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
