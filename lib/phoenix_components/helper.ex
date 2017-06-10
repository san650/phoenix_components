defmodule PhoenixComponents.Helpers do
  def to_pascal_case(name) do
    name
    |> to_string
    |> String.split("_")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join
    |> String.to_atom
  end
end
