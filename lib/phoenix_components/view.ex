defmodule PhoenixComponents.View do
  @moduledoc """
  This module provides a way to easily generate helper functions to render
  components.

  The module can be included by others Phoenix.View modules to import components easily.

  ## Example

  When working on a project with several components you can use this module in your `web/web.ex` definition.

      defmodule MyApp.Web do

        #...

        def view do
          quote do
            use Phoenix.View, root: "web/templates"
            use PhoenixComponents.View

            # ...
          end
        end
      end

  After you include the module you can use the following helpers

      defmodule MyApp.UserView do
        use MyApp.Web, :view

        import_component [:button, :jumbotron]
      end

  After you import a component into the view module you can use the component as follows

      <div>
        <%= button type: :primary do %>
          Submit
        <% end %>
      </div>

  Alternatively, you can also render a component without importing it by using the helper function `component`.

      <div>
        <%= component :button, type: :primary do %>
          Submit
        <% end %>
      </div>
  """

  import Phoenix.View, only: [render: 3]
  import Phoenix.HTML, only: [html_escape: 1]
  import PhoenixComponents.Helpers, only: [to_pascal_case: 1]

  @doc """
    Helper to render a component by name.

    ## Example

        <%= component :button %>
  """
  def component(module_base, name) do
    do_component(module_base, name, "", [])
  end

  @doc """
    Helper to render a component by name and specifying the content in a block.

    ## Example

        <%= component :button do %>
          Submit
        <% end %>
  """
  def component(module_base, name, do: block) do
    do_component(module_base, name, block, [])
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Example

        <%= component :button, color: "red", size: "small", label: "Submit" %>
  """
  def component(module_base, name, attrs) when is_list(attrs) do
    do_component(module_base, name, "", attrs)
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Example

        <%= component :button, color: "red", size: "small" do %>
          Submit
        <% end %>
  """
  def component(module_base, name, attrs, do: block) when is_list(attrs) do
    do_component(module_base, name, block, attrs)
  end

  defp do_component(module_base, name, content, attrs) do
    safe_content = html_escape(content)

    name
    |> to_pascal_case
    |> prefix_module(Components)
    |> prefix_module(module_base)
    |> render("template.html", attrs: Enum.into(attrs, %{}), content: safe_content)
  end

  defp prefix_module(atom, module_base) do
    Module.concat(module_base, atom)
  end

  @doc """
    Macro to generate helpers for components inside views.

    ## Example

        import_components [:button, :jumbotron]

        import_components [:button, :jumbotron], from: SomeOtherModule

    Then you can use the component directly

        <%= button type: "submit" %>
  """
  defmacro import_components(components, opts \\ []) do
    module_base = Keyword.get(opts, :from)

    for name <- components do
      if module_base do
        quote do
          def unquote(name)(), do: component(unquote(module_base), unquote(name))
          def unquote(name)(attrs), do: component(unquote(module_base), unquote(name), attrs)

          def unquote(name)(attrs, block),
            do: component(unquote(module_base), unquote(name), attrs, block)
        end
      else
        quote do
          def unquote(name)(), do: component(@module_base, unquote(name))
          def unquote(name)(attrs), do: component(@module_base, unquote(name), attrs)

          def unquote(name)(attrs, block),
            do: component(@module_base, unquote(name), attrs, block)
        end
      end
    end
  end

  defmacro __using__(module_base: module_base) do
    quote do
      @module_base unquote(module_base)
      import PhoenixComponents.View
    end
  end
end
