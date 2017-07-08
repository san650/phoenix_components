defmodule PhoenixComponents.Components.Jumbotron do
  use PhoenixComponents.Component

  def class(color) do
    "jumbotron-#{color}"
  end
end
