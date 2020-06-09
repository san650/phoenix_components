defmodule PhoenixComponents.Mixfile do
  use Mix.Project

  @version "1.0.3"
  @github_url "https://github.com/san650/phoenix_components"

  def project do
    [
      app: :phoenix_components,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      description: description(),
      elixir: "~> 1.4",
      package: package(),
      start_permanent: Mix.env == :prod,
      version: @version,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test],

      # docs
      source_url: @github_url,
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 0.3", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:excoveralls, "~> 0.7", only: :test},
      {:floki, ">= 0.17.2", only: :test},
      {:phoenix, ">= 1.2.1"},
      {:phoenix_html, "~> 2.11"},
    ]
  end

  defp description do
    """
    Provide server-side rendered components for Phoenix.
    """
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{GitHub: @github_url},
      maintainers: ["Santiago Ferreira"],
      name: :phoenix_components,
    ]
  end
end
