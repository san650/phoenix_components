defmodule PhoenixComponents.Integration.ComponentTest do
  use ExUnit.Case

  alias PhoenixComponents.View, as: Renderer

  with "a content block" do
    test "renders a component without attributes" do
      {:safe, html} = Renderer.component :button do
        "Lorem ipsum"
      end

      assert to_string(html) == """
      <button>
      Lorem ipsum</button>
      """
    end

    test "renders a component with attributes" do
      {:safe, html} = Renderer.component :jumbotron, color: "red" do
        "Lorem ipsum"
      end

      assert to_string(html) == """
      <div class="jumbotron-red">
      Lorem ipsum</div>
      """
    end
  end

  with "no content block" do
    test "renders a component without attributes (no block)" do
      {:safe, html} = Renderer.component :button

      assert to_string(html) == """
      <button>
      </button>
      """
    end

    test "renders a component with attributes (no block)" do
      {:safe, html} = Renderer.component :jumbotron, color: "blue"

      assert to_string(html) == """
      <div class="jumbotron-blue">
      </div>
      """
    end
  end

end
