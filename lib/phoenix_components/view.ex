defmodule PhoenixComponents.View do
  import Phoenix.View, only: [render: 3]
  import Phoenix.HTML, only: [html_escape: 1]

  @doc """
    Helper to render a component by name.

    ## Examples

      <%= component :button %>
  """
  def component(name) do
    do_component(name, "", [])
  end

  @doc """
    Helper to render a component by name and specifying the content in a block.

    ## Examples

      <%= component :button do %>
        Submit
      <% end %>
  """
  def component(name, [do: block]) do
    do_component(name, block, [])
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Examples

      <%= component :button, color: "red", size: "small", label: "Submit" %>
  """
  def component(name, attrs) when is_list(attrs) do
    do_component(name, "", attrs)
  end

  @doc """
    Helper to render a component by name and a list of attributes.

    Note that attributes are available in the template as the map @attrs.

    ## Examples

      <%= component :button, color: "red", size: "small" do %>
        Submit
      <% end %>
  """
  def component(name, attrs, [do: block]) when is_list(attrs) do
    do_component(name, block, attrs)
  end

  defp do_component(name, content, attrs) when do
    safe_content = html_escape(content)

    name
    |> PhoenixComponents.Helpers.to_pascal_case
    |> prefix_module(Components)
    |> render("template.html", attrs: Enum.into(attrs, %{}), content: safe_content)
  end

  defp prefix_module(atom, base_module) do
    Module.concat(base_module, atom)
  end
end
