defmodule GraphQL.Types do
  use Absinthe.Schema

  @desc "An item in module"
  object :user do
    field :id, :id
    field :email, :string
    field :created_at, :string
  end
end
