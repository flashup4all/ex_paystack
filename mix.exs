defmodule ExPaystack.MixProject do
  use Mix.Project

  @project_url "https://github.com/flashup4all/ex_paystack"

  def project do
    [
      app: :ex_paystack,
      version: "0.0.1",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      source_url: @project_url,
      homepage_url: @project_url,
      description: description(),
      deps: deps(),
      aliases: aliases(),
      package: package(),
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        ignore_warnings: ".dialyzer_ignore.exs"
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
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
      {:uri_query, "~> 0.1.1"},
      {:httpoison, "~> 1.8"},
      {:poison, "~> 5.0"},

      # Code Quality
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:sobelow, "~> 0.8", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.10", only: :test},
      # documentation
      {:ex_doc, "~> 0.27", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get"],
      "assets.deploy": ["esbuild default --minify", "phx.digest"],
      quality: ["format", "credo --strict", "sobelow --verbose", "dialyzer"],
      "quality.ci": [
        "format --check-formatted",
        "credo --strict",
        "sobelow --exit",
        "dialyzer"
      ]
    ]
  end

  defp description do
    """
    Elixir Paystack library.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Bardeson Lucky"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/flashup4all/ex_paystack"}
    ]
  end
end
