defmodule MyApp.Component do
  @moduledoc false
  defmacro __using__(_opts) do
    quote do
      use PhoenixComponents.Component,
        namespace: MyApp.Components,
        root: "test/fixtures/components"
    end
  end
end
