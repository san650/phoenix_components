defmodule Mix.Tasks.Phx.Gen.Component do
  use Mix.Task

  import Mix.Generator
  import PhoenixComponents.Helpers, only: [to_pascal_case: 1]

  @shortdoc "Creates a new Phoenix component"
  @moduledoc """
  Creates a new Phoenix component.
  It expects the name of the component as argument.

      mix phoenix.component my_button

  A component at web/components/my_button path will be created.
  """

  @switches []

  def run(argv) do
    {_, argv} = OptionParser.parse!(argv, strict: @switches)

    case argv do
      [] ->
        Mix.raise(
          "Expected module name to be given, please use \"mix phx.component lib/my_app_web MyApp my_component\""
        )

      [root, namespace, name | _] ->
        generate(root, namespace, name)
    end
  end

  defp generate(root, namespace, name) do
    path = Path.join([root, name])

    [namespace] =
      namespace
      |> Module.split()

    assigns = %{
      name: name,
      module_name: to_pascal_case(name),
      namespace: namespace
    }

    # Creates component
    File.mkdir_p!(path)
    create_file(Path.join(path, "view.ex"), view_template(assigns))
    create_file(Path.join(path, "template.html.eex"), template_text())

    # Creates test
    test_path =
      root
      # Phoenix >= 1.3
      |> String.replace_prefix("lib", "test")
      # Phoenix < 1.3
      |> String.replace_prefix("web", "test")

    File.mkdir_p!(test_path)
    create_file(Path.join(test_path, "#{name}_test.exs"), test_template(assigns))
  end

  embed_template(:view, """
  defmodule <%= @namespace %>.<%= @module_name %> do
    use <%= @namespace %>.Component
  end
  """)

  embed_text(:template, """
  <p><%= @content %></p>
  """)

  embed_template(:test, """
  defmodule <%= @namespace %>.<%= @module_name %>Test do
    use ExUnit.Case

    test "renders block" do
      html = PhoenixComponents.View.component <%= @namespace %>, :<%= @name %> do
        "Hello, World!"
      end

      assert raw(html) == "<p>Hello, World!</p>"
    end

    def raw({:safe, html}) do
      html
      |> to_string
      |> String.trim
    end
  end
  """)
end
