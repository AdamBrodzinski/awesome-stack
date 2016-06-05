defmodule GraphQL.PublicSchema do
  use Absinthe.Schema
  import_types GraphQL.Types

  query do
    field :user, :user do
      arg :id, non_null(:id)
      resolve &GraphQL.Resolvers.User.find_one_by_id/2
    end
  end

  # convert db keys to symbols since we're not using Ecto
  default_resolve fn _, %{source: source, definition: %{name: name}} ->
    if is_boolean(Map.get(source, name)) do
      {:ok, Map.get(source, name)}
    else
      {:ok, Map.get(source, name) || Map.get(source, String.to_existing_atom(name))}
    end
  end
end
