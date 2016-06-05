defmodule GraphQL.Types do
  use Absinthe.Schema

  @desc "Acme User"
  object :user do
    field :id, :id
    field :email, :string
    field :created_at, :string
  end
end
