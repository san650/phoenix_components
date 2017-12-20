defmodule MyApp.Components.Jumbotron do
  @moduledoc """
  Dummy jumbotron component
  """
  use PhoenixComponents.Component

  def class(color) do
    "jumbotron-#{color}"
  end
end
