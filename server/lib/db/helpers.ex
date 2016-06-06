defmodule DB.Helpers do
  @moduledoc """
  Helpers to allow easier access to RethinkDB. These are
  not required but help clean up boilerplate.
  """


  @doc """
  Allows you to return a tuple with :ok or :error,
  instead of the normal RethinkDB JSON err/succ response
    Example:
    table('users') |> DB.run
    >> {:ok, [{name: "Jane"}, {name: "Bob"}]}
  """
  def run(query, opts) do
    query
    |> DB.RethinkDB.run(opts)
    |> handle_response
  end

  def run(query) do
    run(query, [])
  end


  @doc """
  Only return the first document of the result but
  still return it in an :ok or :error tuple
  """
  def first(data) do
    case data do
      {:ok, list} -> {:ok, list |> List.first}
      {:err, _err} -> data
    end
  end


  defp handle_response(%{data: %{"r" => errors}}), do: raise List.first errors

  defp handle_response(%{data: %{"first_error" => error}}), do: {:error, error}

  # if user uses `return_changes:true` on an insert or update
  defp handle_response(%{data: %{"changes" => [%{"new_val" => new_doc}]}}) do
    {:ok, new_doc}
  end

  defp handle_response(%{data: data}), do: {:ok, data}

  defp handle_response(%RethinkDB.Exception.ConnectionClosed{}) do
    raise "Cannot connect to RethinkDB"
  end
end
