import RethinkDB.Query

defmodule App.QueryFields.User do
  @string %GraphQL.Type.String{}

  def get() do
    %{
      type: App.Types.User.get(),
      args: %{
        id: %{type: @string }
      },
      resolve: fn(_root, args, _ast) ->
        table("users")
        |> get(args.id)
        |> App.DB.run
        |> strip_wrapper
        |> convert_to_string_map
      end
    }
  end

  defp convert_to_string_map(data) do
    for {key, val} <- data, into: %{}, do: {String.to_atom(key), val}
  end

  defp strip_wrapper(%{data: nil}), do: %{}
  defp strip_wrapper(%{data: doc}), do: doc
  defp strip_wrapper(_anything), do: %{}
end
