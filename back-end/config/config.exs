# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :json_api,
  ecto_repos: [JsonApi.Repo]

# Configures the endpoint
config :json_api, JsonApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VtlB7Ykyjeq74MJcBWSHb2ZL31YEUeNcXGKowy8SdRGXQBIB3qVpvX3j4idreC1b",
  render_errors: [view: JsonApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JsonApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config de guardian
config :json_api, JsonApi.Guardian,
       issuer: "json_api",
       secret_key: "Pn96YR2ctpyBd01JG4AKJRGOeoNOqyI4NqYZvOKdaQtK/UT5qTqiHFQLJzu4FdGQ"

# Config du bundle cors_plug
config :cors_plug,
  origin: ["http://localhost:8080"],
  max_age: 86400,
  methods: ["GET", "POST", "DELETE", "PUT"]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
