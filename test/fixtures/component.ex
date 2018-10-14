defmodule MyApp.Component do
  defmacro __using__(_opts) do
    quote do
      use PhoenixComponents.Component,
        module_base: MyApp,
        root: "test/fixtures"
    end
  end
end
