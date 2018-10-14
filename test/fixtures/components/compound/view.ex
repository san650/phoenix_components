defmodule MyApp.Components.Compound do
  @moduledoc """
  Dummy compound component
  """
  use MyApp.Component

  import_components [:button, :jumbotron], from: MyApp.Components
end
