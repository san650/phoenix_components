# phoenix_components

[![Build Status](https://travis-ci.org/san650/phoenix_components.svg?branch=master)](https://travis-ci.org/san650/phoenix_components)

This library helps you write encapsulated bits of HTML into a single unit called
component in your server rendered Phoenix web site. Similar to how
react/ember/web components do.

## Table of content

* [Synopsis](#synopsis)
* [Installation](#installation)
* [Quick start](#quickstart)
* [Configuration](#configuration)
* [License](#license)

## Synopsis

You can generate a new component with the built-in generator

```
$ mix phx.gen.component Button
* creating lib/app_web/components/button/view.ex
* creating lib/app_web/components/button/template.html.eex
* creating test/app_web/components/button_test.exs
```

Then you can use the new component in a template

```ex
# lib/app_web/views/page_view.ex
defmodule AppWeb.PageView do
  use AppWeb, :view
  use PhoenixComponents.View, namespace: AppWeb.Components

  import_components [:button]

  # you can also import from specific module, like external dependencies
  import_components [:button], from: AwesomeComponentLibrary
end
```

```eex
# lib/app_web/templates/page/show.html.eex

<%= button type: :primary do %>
  My cool button!
<% end %>
```

With the corresponding component definition

```ex
# lib/app_web/components/button/view.ex
defmodule AppWeb.Components.Button do
  use PhoenixComponents.Component, namespace: AppWeb.Components,
                                   root: "lib/app_web/components"

  def class_for_type(type) do
    "btn btn--" <> to_string(type)
  end
end
```

```eex
# lib/app_web/components/button/template.html.eex
<button class="<%= class_for_type @attrs.type %>">
  <%= @content %>
</button>
```

## Installation

Add `phoenix_components` to your `mix.exs` deps:

```elixir
def deps do
  [{:phoenix_components, "~> 1.0.0"}]
end
```

### Extra step for Elixir 1.3 and lower

If you're running Elixir 1.3 or lower, don't forget to add it under you
applications list in mix.exs

```ex
def application do
  [applications: [:phoenix_components]]
end
```

## Quick start

This is a quick overview of how to create and use a component in your
application.

### 1. Importing PhoenixComponents.View in all application views

After installing the dependency you need to configure your application.

You can do this by adding this line to your `lib/app_web.ex` file

Look for the line `def view do` and update it to include the following:

```ex
def view do
  quote do
    use Phoenix.View, root: "lib/app_web/components"
                      namespace: AppWeb

    # add this line
    use PhoenixComponents.View, namespace: AppWeb.Components
    ..
end

# add this helper for components, usage example: `use AppWeb, :component`
def component do
  quote do
    use PhoenixComponents.Component, namespace: AppWeb.Components,
                                     root: "lib/app_web/components"
  end
end
```

### 2. Enabling phoenix live reload for components

Add components pattern to your live_reload config.

```ex
config :app, AppWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/app_web/views/.*(ex)$},
      ~r{lib/app_web/templates/.*(eex)$},
      ~r{lib/app_web/components/*/.*(eex)$} # add this line
    ]
  ]
```

### 3. Creating a `button` component

Phoenix components are defined by two different parts, a view and a template.
The view contains helper functions and the template contains the HTML.

To create a button component you need to create the view file
`lib/app_web/components/button/view.ex` with the following content

```ex
defmodule AppWeb.Components.Button do
  use AppWeb, :component

  def classes do
    "btn btn-default"
  end
end
```

Then create the template file `lib/app_web/components/button/template.html.eex`
with the following content

```eex
<button class="<%= classes %>">
  <%= @content %>
</button>
```

Note that `@content` variable will contain the content defined inside the button
block. Next section shows this in more detail.

### 4. Using the component

You can use the component from any template by using the helper function
`component`.

In any template, e.g. `web/templates/pages/show.html.eex` add the button
component.

```eex
<%= component :button do %>
  My cool button!
<% end %>
```

The content inside the component block is passed to the component as the
`@content` variable.

### 5. Importing components into views

You can import the components in any view by using the `import_components`
function. This allows you to avoid having to call `component` helper and instead
just use the name of the component.

```eex
defmodule AppWeb.PageView do
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

### 6. Using attributes inside your components

When calling a component you can pass any attribute you like.

```eex
<%= button type: :submit do %>
  Submit form!
<% end %>
```

Inside the component's template these attributes are going to be available in
the `@attrs` map.

```eex
<button type="<%= @attrs.type %>">
  <%= @content %>
</button>
```

## Project's health

[![Build Status](https://travis-ci.org/san650/phoenix_components.svg?branch=master)](https://travis-ci.org/san650/phoenix_components)
[![codebeat badge](https://codebeat.co/badges/135fa334-d08a-4b0a-8bc5-1ae5ea0c939a)](https://codebeat.co/projects/github-com-san650-phoenix_components-master)
[![Ebert](https://ebertapp.io/github/san650/phoenix_components.svg)](https://ebertapp.io/github/san650/phoenix_components)
[![Coverage Status](https://coveralls.io/repos/github/san650/phoenix_components/badge.svg?branch=master)](https://coveralls.io/github/san650/phoenix_components?branch=master)

## License

phoenix_components is licensed under the MIT license.

See [LICENSE](./LICENSE) for the full license text.
