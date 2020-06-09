defmodule PhoenixComponents.Component do
  @moduledoc """
  Module used to define the view associated to a component.

  This  It serves two different purposes:
  - define from where to load the template of a component.
  - import the helpers to use inside the component's template.

  Every component defined by PhoenixComponents must include two files:
  - view - contains helper functions
  - template - contains the HTML

  ## Example

  Following code define a component called `awesome_button`.

  The view file - `lib/sample_web/components/awesome_button/view.ex`:

      defmodule SampleWeb.Components.AwesomeButton do
        use PhoenixComponents.Component

        def class_for_type(type) do
          "btn--" <> to_string(type)
        end
      end

  The template file - `lib/sample_web/components/awesome_button/template.html.eex`:

      <button class="<%= class_for_type @attr.type %>">
        <%= @content %>
      </button>
  """

  @doc """
  When used, defines current module as a Component View module.
  """
  defmacro __using__(_opts) do
    quote do
      use Phoenix.View, root: Application.fetch_env!(:phoenix_components, :root)
      use Phoenix.HTML
      use PhoenixComponents.View
    end
  end
end
