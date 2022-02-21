defmodule ExPaystack.MixProject do
  use Mix.Project

  @project_url "https://github.com/flashup4all/ex_paystack"

  def project do
    [
      app: :ex_paystack,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      source_url: @project_url,
      homepage_url: @project_url,
      description: "Elixir Paystack library ",
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :httpoison]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:uri_query, "~> 0.1.1"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"}
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
