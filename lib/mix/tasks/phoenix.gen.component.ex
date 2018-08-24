defmodule Mix.Tasks.Phoenix.Gen.Component do
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
        Mix.raise "Expected module name to be given, please use \"mix phx.component my_component\""
      [name | _] ->
        generate(component_name: name)
    end
  end

  defp generate(component_name: name) do
    config_path = Application.get_env(:phoenix_components, :path, "web")

    path = Path.join([config_path, "components", name])

    [module_base] =
      :phoenix_components
      |> Application.fetch_env!(:app_name)
      |> Module.split

    assigns = %{
      name: name,
      module_name: to_pascal_case(name),
      module_base: module_base,
    }

    # Creates component
    File.mkdir_p!(path)
    create_file Path.join(path, "view.ex"), view_template(assigns)
    create_file Path.join(path, "template.html.eex"), template_text()

    # Creates test
    test_path =
      config_path
      |> String.replace_prefix("lib", "test") # Phoenix >= 1.3
      |> String.replace_prefix("web", "test") # Phoenix < 1.3
      |> Kernel.<>("/components")

    File.mkdir_p!(test_path)
    create_file Path.join(test_path, "#{name}_test.exs"), test_template(assigns)
  end

  embed_template :view, """
  defmodule <%= @module_base %>.Components.<%= @module_name %> do
    use PhoenixComponents.Component
  end
  """

  embed_text :template, """
  <p><%= @content %></p>
  """

  embed_template :test, """
  defmodule <%= @module_base %>.Components.<%= @module_name %>Test do
    use ExUnit.Case

    test "renders block" do
      html = PhoenixComponents.View.component :<%= @name %> do
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
  """
end
