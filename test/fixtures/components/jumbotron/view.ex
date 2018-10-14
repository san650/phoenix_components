defmodule MyApp.Components.Jumbotron do
  @moduledoc """
  Dummy jumbotron component
  """
  use MyApp.Component

  def class(color) do
    "jumbotron-#{color}"
  end
end
