defmodule PhoenixComponents.Component do
  defmacro __using__(_opts) do
    quote do
      use Phoenix.View, root: "web/components"
      use Phoenix.HTML
    end
  end
end
