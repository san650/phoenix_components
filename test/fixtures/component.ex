defmodule MyApp.Component do
  defmacro __using__(_opts) do
    quote do
      use PhoenixComponents.Component,
        app_module: MyApp,
        root: "test/fixtures"
    end
  end
end
