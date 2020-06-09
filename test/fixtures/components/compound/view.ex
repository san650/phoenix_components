defmodule MyApp.Components.Compound do
  @moduledoc """
  Dummy compound component
  """
  use PhoenixComponents.Component

  import_components([:button, :jumbotron])
end
