defmodule PhoenixComponents.Mixfile do
  use Mix.Project

  def project do
    [
      app: :phoenix_components,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      description: description(),
      elixir: "~> 1.4",
      package: package(),
      source_url: "https://github.com/san650/phoenix_components",
      start_permanent: Mix.env == :prod,
      version: "1.0.3",
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [coveralls: :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
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
    This library helps you write encapsulated bits of HTML into a single unit called component in your server rendered Phoenix web site. Similar to how react/ember/web components do.
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/san650/phoenix_components"},
      maintainers: ["Santiago Ferreira"],
      name: :phoenix_components,
    ]
  end
end
