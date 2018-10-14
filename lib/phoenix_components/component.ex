defmodule PhoenixComponents.Component do
  @moduledoc """
  Module used to define the view part of a component.

  This module is used to define the view associated to a component. It serves
  two different purposes, define from where to load the template of a component
  and import the helpers to use inside the component's template.

  ## Example

  PhoenixComponents defines the view template at `web/components/` by default.

  E.g. `web/components/awesome_button/view.eex`

      defmodule YourApp.Components.AwesomeButton do
        use PhoenixComponents.Component

        def class_for_type(type) do
          "btn--" <> to_string(type)
        end
      end

  This in combination with a template defines a component.

  E.g. `web/components/awesome_button/template.html.eex`

      <button class="<%= class_for_type @attr.type %>">
        <%= @content %>
      </button>

  """

  @doc """
  When used, defines the current module as a Component View module.
  """
  defmacro __using__(opts) do
    root = Keyword.get(opts, :root)
    module_base = Keyword.get(opts, :module_base)

    quote do
      use Phoenix.View, root: unquote(root)
      use Phoenix.HTML
      use PhoenixComponents.View, module_base: unquote(module_base)
    end
  end
end
