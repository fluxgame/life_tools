# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :life_tools,
  ecto_repos: [LifeTools.Repo]

# Configures the endpoint
config :life_tools, LifeToolsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "UxBsOK55YYYOe3xUvK0a46uiva/+9xo8TJKSTV45Yysx2VJo6eg0MrwUEUfqBaPa",
  render_errors: [view: LifeToolsWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LifeTools.PubSub,
  live_view: [signing_salt: "2iYPIKvv"]


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, adapter: Tesla.Adapter.Hackney

tmdb_api_key = System.get_env("TMDB_API_KEY") ||
  raise """
  environment variable IMDB_API_KEY is missing.
  """

config :life_tools,
   tmdb_api_key: tmdb_api_key,
   tmdb_base_url: "https://api.themoviedb.org/3"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"