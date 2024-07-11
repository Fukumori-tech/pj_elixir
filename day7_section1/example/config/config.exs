import Config

config :example, Example.Repo,
  database: "example_repo",#↑のmodではこのdbからだけデータをとってくる
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

  config :example, ecto_repos: [Example.Repo]
