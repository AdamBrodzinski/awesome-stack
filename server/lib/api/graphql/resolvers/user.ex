import RethinkDB.Query, only: [table: 1, get: 2, insert: 3]

defmodule GraphQL.Resolvers.User do
  def create(args, _) do
    data = %{
      created_at: RethinkDB.Query.now,
      updated_at: RethinkDB.Query.now,
      email: args.email,
      password: args.password,
    }

    table("users")
    |> insert(data, %{return_changes: true})
    |> DB.Helpers.run
  end

  def find_one_by_id(args, _) do
    table("users")
      |> get(args.id)
      |> DB.Helpers.run
  end
end
