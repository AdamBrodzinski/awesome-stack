defmodule App.Types.User do
  @string %GraphQL.Type.String{}

  def get() do
    %GraphQL.Type.ObjectType{
      name: "User",
      description: "A generic User",
      fields: %{
        id: %{type: %GraphQL.Type.String{}},
        name: %{type: %GraphQL.Type.String{}},
        email: %{type: %GraphQL.Type.String{}},
      }
    }
  end
end
