defmodule PhoenixComponents.Integration.ComponentTest do
  use ExUnit.Case

  alias PhoenixComponents.View, as: Renderer

  test "renders a component with a content block" do
    {:safe, html} = Renderer.component :button do
      "Lorem ipsum"
    end

    assert to_string(html) == """
    <button>
    Lorem ipsum</button>
    """
  end
end
