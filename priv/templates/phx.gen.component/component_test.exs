defmodule <%= @module %>Test do
  use ExUnit.Case

  test "renders block" do
    html = PhoenixComponents.View.component <%= @web_module %>.Components, :<%= @singular %> do
      "Hello, World!"
    end

    assert raw(html) == "<p>Hello, World!</p>"
  end

  defp raw({:safe, html}) do
    html
    |> to_string
    |> String.trim
  end
end
