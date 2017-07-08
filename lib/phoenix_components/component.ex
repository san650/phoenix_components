defmodule PhoenixComponents.Component do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.View, root: Application.get_env(:phoenix_components, :path, "web")
      use Phoenix.HTML
      use PhoenixComponents.View
    end
  end
end
