defmodule DataConversation.MixProject do
  use Mix.Project

  def project do
    [
      app: :data_conversation,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 2.2"}, #for request API, use HTTPoison
      {:jason, "~> 1.4"} # for use JSON, use Jason
    ]
  end
end
