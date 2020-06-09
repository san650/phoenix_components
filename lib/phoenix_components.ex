defmodule PhoenixComponents do
  @moduledoc """

  After installing and configuring PhoenixComponents, you are ready to write
  a component.

  ## Generating a component
  PhoenixComponents provides a mix task for generating a component. It's a good
  start for writing your own component.

      $ mix phx.gen.component button
      * creating lib/sample_web/components/button/view.ex
      * creating lib/sample_web/components/button/template.html.eex
      * creating test/sample_web/components/button_test.exs

  As you can see, generator created a view and a template. They are the necessary
  parts of a valid component. The view contains helper functions and the template
  contains the HTML.

  ### Edit the view file

      defmodule SampleWeb.Components.Button do
        use PhoenixComponents.Component

        def classes do
          "btn btn-default"
        end
      end

  ### Edit the template file

      <button class="<%= classes %>">
        <%= @content %>
      </button>

  > The `@content` variable will contain the content defined inside the button
  > block.

  ## Using the component
  You can use the component from any template by using the helper function
  `component`.

      <%= component :button do %>
        My cool button!
      <% end %>

  The content inside the component block is passed to the component as the
  `@content` variable.

  ### Using the component with attributes

  When calling a component you can pass any attribute you like:

      <%= button type: :submit do %>
        Submit form!
      <% end %>

  Inside the component's template, these attributes are available in the
  `@attrs` map:

      <button type="<%= @attrs.type %>">
        <%= @content %>
      </button>
  """
end
