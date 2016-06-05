import RethinkDB.Query 
import RethinkDB.Query, only: [table: 1, get: 2]

defmodule GraphQL.Resolvers.User do

  def find_one_by_id(args, _) do
    table("users")
      |> get(args.id)
      |> DB.Helpers.run
  end
end
