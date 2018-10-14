defmodule PhoenixComponents.Integration.ComponentTest do
  use ExUnit.Case

  alias PhoenixComponents.View, as: Renderer

  @namespace MyApp.Components

  with "a content block" do
    test "renders a component without attributes" do
      html = Renderer.component @namespace, :button do
        "Lorem ipsum"
      end

      assert parse(html) == {"button", [], ["\nLorem ipsum"]}
    end

    test "renders a component with attributes" do
      html = Renderer.component @namespace, :jumbotron, color: "red" do
        "Lorem ipsum"
      end

      assert parse(html) == {"div", [{"class", "jumbotron-red"}], ["\nLorem ipsum"]}
    end
  end

  with "no content block" do
    test "renders a component without attributes (no block)" do
      html = Renderer.component @namespace, :button

      assert parse(html) == {"button", [], []}
    end

    test "renders a component with attributes (no block)" do
      html = Renderer.component @namespace, :jumbotron, color: "blue"

      assert parse(html) == {"div", [{"class", "jumbotron-blue"}], []}
    end
  end

  with "imported components" do
    defmodule Imported do
      use PhoenixComponents.View, namespace: MyApp.Components
      import_components [:button, :jumbotron]
    end

    test "generates component/1 helper" do
      html = Imported.button

      assert parse(html) == {"button", [], []}
    end

    test "generates component/2 helper" do
      html = Imported.button do
        "Lorem ipsum"
      end

      assert parse(html) == {"button", [], ["\nLorem ipsum"]}
    end

    test "generates component/3 helper" do
      html = Imported.jumbotron color: "yellow" do
        "Foo bar"
      end

      assert parse(html) == {"div", [{"class", "jumbotron-yellow"}], ["\nFoo bar"]}
    end
  end

  with "imported components using from module" do
    defmodule ImportedFrom do
      use PhoenixComponents.View, namespace: NonExisting
      import_components [:button, :jumbotron], from: MyApp.Components
    end

    test "generates component/1 helper using from module" do
      html = ImportedFrom.button

      assert parse(html) == {"button", [], []}
    end

    test "generates component/2 helper using from module" do
      html = ImportedFrom.button do
        "Lorem ipsum"
      end

      assert parse(html) == {"button", [], ["\nLorem ipsum"]}
    end

    test "generates component/3 helper using from module" do
      html = ImportedFrom.jumbotron color: "yellow" do
        "Foo bar"
      end

      assert parse(html) == {"div", [{"class", "jumbotron-yellow"}], ["\nFoo bar"]}
    end
  end

  test "importing components inside other components" do
    html = Renderer.component @namespace, :compound

    assert parse(html) == {"button", [], [
      {"div", [{"class", "jumbotron-red"}], ["\n\n    Hello, World!\n"]}
    ]}
  end

  def parse({:safe, html}) do
    Floki.parse(html)
  end
end
