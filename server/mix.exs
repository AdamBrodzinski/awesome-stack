defmodule Api.Mixfile do
  use Mix.Project

  def project do
    [app: :api,
     version: "1.0.0",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [mod: {Api, []},
     applications: [
       :phoenix,
       :phoenix_pubsub,
       :cowboy,
       :logger,
       :rethinkdb,
     ]]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  defp deps do
    [{:phoenix, "~> 1.2.0-rc"},
     {:phoenix_pubsub, "~> 1.0.0-rc"},
     {:cowboy, "~> 1.0"},
     {:rethinkdb, "~> 0.4.0"},
    ]
  end
end
