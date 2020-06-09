# phoenix_components
[![Build Status](https://travis-ci.org/san650/phoenix_components.svg?branch=master)](https://travis-ci.org/san650/phoenix_components)
[![codebeat badge](https://codebeat.co/badges/135fa334-d08a-4b0a-8bc5-1ae5ea0c939a)](https://codebeat.co/projects/github-com-san650-phoenix_components-master)
[![SourceLevel](https://app.sourcelevel.io/github/san650/phoenix_components.svg)](https://app.sourcelevel.io/github/san650/phoenix_components)
[![Coverage Status](https://coveralls.io/repos/github/san650/phoenix_components/badge.svg?branch=master)](https://coveralls.io/github/san650/phoenix_components?branch=master)

Provide server-side rendered components for Phoenix.

## Installation

Add `phoenix_components` to your `mix.exs` deps:

```elixir
def deps do
  [{:phoenix_components, "~> 1.0.0"}]
end
```

Then, add one config to config file:

```elixir
config :phoenix_components,
  root: "lib/sample_web",
  namespace: SampleWeb,
```

### Extra step for Elixir <= 1.3

If you're running Elixir <= 1.3, don't forget to add it under you applications
list in `mix.exs`:

```elixir
def application do
  [applications: [:phoenix_components]]
end
```

## Usage

Visit [HexDocs](https://hexdocs.pm/phoenix_components/PhoenixComponents) for more details.

## License

See [LICENSE](./LICENSE) for the full license text.
