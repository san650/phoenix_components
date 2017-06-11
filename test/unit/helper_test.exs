defmodule PhoenixComponents.Unit.HelpersTest do
  use ExUnit.Case

  alias PhoenixComponents.Helpers

  describe "to_pascal_case/1" do
    test "converts cammel_case atom to PascalCase" do
      assert Helpers.to_pascal_case(:foo_bar_baz) === :FooBarBaz
      assert Helpers.to_pascal_case(:foo) === :Foo
    end
  end
end
