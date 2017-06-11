# phoenix_components

This library helps you write encapsulated bits of HTML into a single unit called component in your server rendered Phoenix web site. Similar to how react/ember/web components do.

## Synopsis

You can use the new `component` helper in any template

```eex
# /web/templates/pages/show.html.eex

<%= component :button do %>
  My cool button!
<% end %>
```

With the corresponding component definition

```ex
# /components/button/view.ex
defmodule Components.ButtonView do
  use PhoenixComponents.View

  def classes do
    "btn btn-default"
  end
end
```

```eex
# /web/components/button/template.html.eex
<button class="<%= classes %>">
  <%= @content %>
</button>
```

## Installation

Add `phoenix_components` to your `mix.exs` deps:

```elixir
def deps do
  [{:phoenix_components, "~> 0.1.0"}]
end
```

## Configuration

You can configure where to put the components by editing your application
configuration file `config/config.exs`.

```ex
config :phoenix_components, path: "lib/foo/bar"
```

Components are obtained from `web/components` by default.

## License

phoenix_components is licensed under the MIT license.

See [LICENSE](./LICENSE) for the full license text.
