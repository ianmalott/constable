use Mix.Config

config :constable, Constable.Endpoint,
  http: [port: System.get_env("PORT") || 4000],
  url: [host: "localhost"],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin", cd: Path.expand("../", __DIR__)]],
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

config :constable, Constable.Repo,
  url: System.get_env("DATABASE_URL")

config :constable, Constable.Mailer,
  adapter: Bamboo.LocalAdapter

config :constable, :shubox_script_url, "http://shubox.io/x/a7c92ded.js"

config :honeybadger, :environment_name, :dev

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20
