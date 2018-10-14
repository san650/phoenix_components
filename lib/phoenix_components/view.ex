defmodule PhoenixComponents.View do
  @moduledoc """
  This module provides a way to easily generate helper functions to render
  components.

  The module can be included by others Phoenix.View modules to import components easily.

  ## Example

  When working on a project with several components you can use this module in your `web/web.ex` definition.

      defmodule MyAppWeb do

        #...

        def view do
          quote do
            use Phoenix.View, root: "lib/myapp_web/templates"
                              namespace: MyAppWeb

            use PhoenixComponents.View, namespace: MyAppWeb.Components

            # ...
          end
        end
      end

  After you include the module you can use the following helpers

      defmodule MyAppWeb.UserView do
        use MyAppWeb, :view

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
  def component(namespace, name) do
    do_component(namespace, name, "", [])
  end

  @doc """
    Helper to render a component by name and specifying the content in a block.

    ## Example

        <%= component :button do %>
          Submit
        <% end %>
  """
  def component(namespace, name, do: block) do
    do_component(namespace, name, block, [])
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Example

        <%= component :button, color: "red", size: "small", label: "Submit" %>
  """
  def component(namespace, name, attrs) when is_list(attrs) do
    do_component(namespace, name, "", attrs)
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Example

        <%= component :button, color: "red", size: "small" do %>
          Submit
        <% end %>
  """
  def component(namespace, name, attrs, do: block) when is_list(attrs) do
    do_component(namespace, name, block, attrs)
  end

  defp do_component(namespace, name, content, attrs) do
    safe_content = html_escape(content)

    name
    |> to_pascal_case
    |> prefix_module(namespace)
    |> render("template.html", attrs: Enum.into(attrs, %{}), content: safe_content)
  end

  defp prefix_module(atom, namespace) do
    Module.concat(namespace, atom)
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
    namespace = Keyword.get(opts, :from)

    for name <- components do
      if namespace do
        quote do
          def unquote(name)(), do: component(unquote(namespace), unquote(name))
          def unquote(name)(attrs), do: component(unquote(namespace), unquote(name), attrs)

          def unquote(name)(attrs, block),
            do: component(unquote(namespace), unquote(name), attrs, block)
        end
      else
        quote do
          def unquote(name)(), do: component(@namespace, unquote(name))
          def unquote(name)(attrs), do: component(@namespace, unquote(name), attrs)

          def unquote(name)(attrs, block),
            do: component(@namespace, unquote(name), attrs, block)
        end
      end
    end
  end

  defmacro __using__(namespace: namespace) do
    quote do
      @namespace unquote(namespace)
      import PhoenixComponents.View
    end
  end
end
