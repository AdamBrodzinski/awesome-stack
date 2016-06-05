defmodule GraphQL.Resolvers.User do
  @items %{
    "foo" => %{id: "foo", email: "foo@example.com"},
    "bar" => %{id: "bar", email: "bar@example.com"}
  }

  def find_one_by_id(%{id: item_id}, _) do
    # return faked data
    {:ok, @items[item_id]}
  end
end
