defmodule PhoenixComponents.Helpers do
  @moduledoc false

  import Phoenix.Naming, only: [camelize: 1]

  @doc """
  Converts a cammel_case string or atom into a PascalCase atom.

  ## Example

      iex> PhoenixComponents.Helpers.to_pascal_case "dummy"
      :Dummy

      iex> PhoenixComponents.Helpers.to_pascal_case "dummy_string"
      :DummyString

      iex> PhoenixComponents.Helpers.to_pascal_case "Dummy"
      :Dummy

      iex> PhoenixComponents.Helpers.to_pascal_case "DUMMY"
      :DUMMY

      iex> PhoenixComponents.Helpers.to_pascal_case :dummy_string
      :DummyString
  """
  def to_pascal_case(name) do
    name
    |> to_string
    |> camelize
    |> String.to_atom()
  end
end
