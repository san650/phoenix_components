defmodule PhoenixComponents.View do
  @moduledoc """
  This module provides a way to easily generate helper functions to render
  components.

  The module can be included by others `Phoenix.View` modules to import components
  easily.

  ## Basic Usage

  Configure PhoenixComponents:

      config :phoenix_components,
        root: "lib/sample_web",
        namespace: SampleWeb

  Include `PhoenixComponents.View`:

      defmodule SampleWeb do
        def view do
          quote do
            # ...

            use PhoenixComponents.View

            # ...
          end
        end
      end

  ### Render a component without importing

  Render a component without importing it by using the helper function `component`:

      <div>
        <%= component :button do %>
          Submit
        <% end %>
      </div>

  ### Render a component with importing

  Import a component to a view:

      defmodule SampleWeb.UserView do
        use SampleWeb, :view

        import_component [:button, :jumbotron]
      end

  After importing, you can use the component in your template:

      <div>
        <%= button do %>
          Submit
        <% end %>
      </div>

  ## Attributes

  The attributes can be accessed in the template as a map `@attrs`.

  Suppose that we define a component `button` with following template:

      <button class="<%= @attr.type %>">
        <%= @content %>
      </button>

  Use above component:

      <div>
        <%= button type: :primary do %>
          Submit
        <% end %>
      </div>

  For more details, please read `PhoenixComponents.Component`.
  """

  import Phoenix.View, only: [render: 3]
  import Phoenix.HTML, only: [html_escape: 1]
  import PhoenixComponents.Helpers, only: [to_pascal_case: 1]

  @doc """
    Helper to render a component by name.

    ## Example

        <%= component :button %>
  """
  def component(name) do
    do_component(name, "", [])
  end

  @doc """
    Helper to render a component by name and inner block.

    ## Example

        <%= component :button do %>
          Submit
        <% end %>
  """
  def component(name, [do: block]) do
    do_component(name, block, [])
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    ## Example

        <%= component :button, color: "red", size: "small", label: "Submit" %>
  """
  def component(name, attrs) when is_list(attrs) do
    do_component(name, "", attrs)
  end

  @doc """
    Helper to render a component by name, a list of attributes and inner block.

    ## Example

        <%= component :button, color: "red", size: "small" do %>
          Submit
        <% end %>
  """
  def component(name, attrs, [do: block]) when is_list(attrs) do
    do_component(name, block, attrs)
  end

  defp do_component(name, content, attrs) do
    safe_content = html_escape(content)
    namespace = Application.fetch_env!(:phoenix_components, :namespace)

    name
    |> to_pascal_case
    |> prefix_module(Components)
    |> prefix_module(namespace)
    |> render("template.html", attrs: Enum.into(attrs, %{}), content: safe_content)
  end

  defp prefix_module(atom, base_module) do
    Module.concat(base_module, atom)
  end

  @doc """
    Macro to generate helpers for components inside views.

    ## Example

        import_components [:button, :jumbotron]

    Then you can use the component directly

        <%= button type: "submit" %>
  """
  defmacro import_components(components) do
    for name <- components do
      quote do
        def unquote(name)(), do: component(unquote(name))

        def unquote(name)(attrs), do: component(unquote(name), attrs)

        def unquote(name)(attrs, block), do: component(unquote(name), attrs, block)
      end
    end
  end

  defmacro __using__(_) do
    quote do
      import PhoenixComponents.View
    end
  end
end
