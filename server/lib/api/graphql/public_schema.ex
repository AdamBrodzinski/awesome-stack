defmodule GraphQL.PublicSchema do
  use Absinthe.Schema
  import_types GraphQL.Types

  query do
    field :user, :user do
      arg :id, non_null(:id)
      resolve &GraphQL.Resolvers.User.find_one_by_id/2
    end
  end
end
