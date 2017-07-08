# phoenix_components
[![Build Status](https://travis-ci.org/mvdwg/phoenix_components.svg?branch=master)](https://travis-ci.org/mvdwg/phoenix_components)

This library helps you write encapsulated bits of HTML into a single unit called component in your server rendered Phoenix web site. Similar to how react/ember/web components do.

## Table of content

* [Synopsis](#synopsis)
* [Installation](#installation)
* [Quick start](#quickstart)
* [Configuration](#configuration)
* [License](#license)

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
# /web/components/button/view.ex
defmodule MyApp.Components.ButtonView do
  use PhoenixComponents.Component

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

## Quick start

This is a quick overview of how to create and use a component in your application.

### 1. Importing PhoenixComponents.View in all application views

After installing the dependency you need to configure your application.

You can do this by adding this line to your `web/web.ex` file

Look for the line `def view do` and update it to include this line

```ex
def view do
  quote do
    use Phoenix.View, root: "web/templates"
    use PhoenixComponents.View # Add this line
    ...
```

### 2. Creating a `button` component

Phoenix components are defined by two different parts, a view and a template.  The view contains helper functions and the template contains the HTML.

To create a button component you need to create the view file `web/components/button/view.ex` with the following content

```ex
defmodule MyApp.Components.Button do
  use PhoenixComponents.Component

  def classes do
    "btn btn-default"
  end
end
```

Then create the template file `web/components/button/template.html.eex` with the following content

```eex
<button class="<%= classes %>">
  <%= @content %>
</button>
```

Note that `@content` variable will contain the content defined inside the button block. Next section shows this in more detail.

### 3. Using the component

You can use the component from any template by using the helper function `component`.

In any template, e.g. `web/templates/pages/show.html.eex` add the button component.

```eex
<%= component :button do %>
  My cool button!
<% end %>
```

The content inside the component block is passed to the component as the `@content` variable.

### 4. Importing components into views

You can import the components in any view by using the `import_components` function. This allows you to avoid having to call `component` helper and instead just use the name of the component.

```eex
defmodule MyApp.PageView do
  use Phoenix.Web, :view
  import_components [:button, :jumbotron]
end
```

Then you can use these helpers from your templates

```eex
<%= button type: :submit do %>
  Submit form!
<% end %>
```

### 5. Using attributes inside your components

When calling a component you can pass any attribute you like.

```eex
<%= button type: :submit do %>
  Submit form!
<% end %>
```

Inside the component's template these attributes are going to be available in the `@attrs` map.

```eex
<button type="<%= @attrs.type %>">
  <%= @content %>
</button>
```

## Configuration

You can configure where to put the components by editing your application
configuration file `config/config.exs`.

```ex
config :phoenix_components, path: "lib/foo/bar"
```

Components are obtained from `web` by default.

## License

phoenix_components is licensed under the MIT license.

See [LICENSE](./LICENSE) for the full license text.
