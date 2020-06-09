defmodule PhoenixComponents.Integration.ComponentTest do
  use ExUnit.Case

  alias PhoenixComponents.View, as: Renderer

  with "a content block" do
    test "renders a component without attributes" do
      html = Renderer.component :button do
        "Lorem ipsum"
      end

      assert parse(html) == {"button", [], ["\nLorem ipsum"]}
    end

    test "renders a component with attributes" do
      html = Renderer.component :jumbotron, color: "red" do
        "Lorem ipsum"
      end

      assert parse(html) == {"div", [{"class", "jumbotron-red"}], ["\nLorem ipsum"]}
    end
  end

  with "no content block" do
    test "renders a component without attributes (no block)" do
      html = Renderer.component :button

      assert parse(html) == {"button", [], []}
    end

    test "renders a component with attributes (no block)" do
      html = Renderer.component :jumbotron, color: "blue"

      assert parse(html) == {"div", [{"class", "jumbotron-blue"}], []}
    end
  end

  with "imported components" do
    defmodule Imported do
      use PhoenixComponents.View
      import_components [:button, :jumbotron]
    end

    test "generates component/0 helper" do
      html = Imported.button

      assert parse(html) == {"button", [], []}
    end

    test "generates component/1 helper" do
      html = Imported.button do
        "Lorem ipsum"
      end

      assert parse(html) == {"button", [], ["\nLorem ipsum"]}
    end

    test "generates component/2 helper" do
      html = Imported.jumbotron color: "yellow" do
        "Foo bar"
      end

      assert parse(html) == {"div", [{"class", "jumbotron-yellow"}], ["\nFoo bar"]}
    end
  end

  test "importing components inside other components" do
    html = Renderer.component :compound

    assert parse(html) == {"button", [], [
      {"div", [{"class", "jumbotron-red"}], ["\n    Hello, World!\n"]}
    ]}
  end

  def parse({:safe, html}) do
    [parsed_html] = Floki.parse_document!(html)
    parsed_html
  end
end
