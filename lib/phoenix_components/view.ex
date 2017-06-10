defmodule PhoenixComponents.View do
  import Phoenix.View, only: [render: 3]
  import Phoenix.HTML, only: [html_escape: 1]

  @doc """
    Helper to render components.

    ## Examples

      <%= component :button, type: "submit" do %>
        Submit
      <% end %>
  """
  def component(name, [do: block]) do
    content = html_escape(block)

    name
    |> PhoenixComponents.Helpers.to_pascal_case
    |> prefix_module(Components)
    |> render("template.html", content: content)
  end

  defp prefix_module(atom, base_module) do
    Module.concat(base_module, atom)
  end
end
