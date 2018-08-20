# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :expaste,
  ecto_repos: [Expaste.Repo]

# Configures the endpoint
config :expaste, ExpasteWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NZWGumziB/ukgtlHjYuW9N4xtG/6Veny2NN4gRgoRDkK79xV42+CJtLn+im/LYL8",
  render_errors: [view: ExpasteWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Expaste.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
