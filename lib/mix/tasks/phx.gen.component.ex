defmodule Mix.Tasks.Phx.Gen.Component do
  @shortdoc "Generates a Phoenix component"

  @moduledoc """
  Generates a Phoenix component.

      mix phx.gen.component Button

  Accepts the module name for the component

  The generated files will contain:

  For a regular application:

    * a component in `lib/my_app_web/components`
    * a component test in `test/my_app_web/components`

  For an umbrella application:

    * a component in `apps/my_app_web/lib/app_name_web/components`
    * a component test in `apps/my_app_web/test/my_app_web/components`

  """
  use Mix.Task

  @doc false
  def run(args) do
    if Mix.Project.umbrella?() do
      Mix.raise "mix phx.gen.component can only be run inside an application directory"
    end
    [component_name] = validate_args!(args)
    context_app = Mix.Phoenix.context_app()
    web_prefix = Mix.Phoenix.web_path(context_app)
    test_prefix = Mix.Phoenix.web_test_path(context_app)
    binding = Mix.Phoenix.inflect(component_name)
    binding = Keyword.put(binding, :module, "#{binding[:web_module]}.Components.#{binding[:scoped]}")

    Mix.Phoenix.check_module_name_availability!(binding[:module])

    Mix.Phoenix.copy_from paths(), "priv/templates/phx.gen.component", binding, [
      {:eex, "view.ex",            Path.join([web_prefix, "components", binding[:path], "view.ex"])},
      {:eex, "template.html.eex",  Path.join([web_prefix, "components", binding[:path], "template.html.eex"])},
      {:eex, "component_test.exs", Path.join([test_prefix, "components", "#{binding[:path]}_test.exs"])},
    ]

  end

  @spec raise_with_help() :: no_return()
  defp raise_with_help do
    Mix.raise """
    mix phx.gen.component expects just the module name:

        mix phx.gen.component Button

    """
  end

  defp validate_args!(args) do
    unless length(args) == 1 do
      raise_with_help()
    end
    args
  end

  defp paths do
    [".", :phoenix]
  end
end
