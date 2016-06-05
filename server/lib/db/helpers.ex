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


  # returns a tuple based on RethinkDB response
  defp handle_response(%{data: data}) do
    case data do
      %{"first_error" => error} -> {:error, error}
      # Rethink related error
      %{"r" => errors} -> raise List.first errors
      _ ->
        {:ok, data}
    end
  end

  defp handle_response(%RethinkDB.Exception.ConnectionClosed{}) do
    raise "Cannot connect to RethinkDB"
  end
end
