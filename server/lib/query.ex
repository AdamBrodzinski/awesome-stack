defmodule App.Query do
  import App.DB, only: [run: 1]
  alias RethinkDB.Query

  def get(table, id) when is_bitstring(id) do
    Query.table(table)
    |> Query.get(id)
    |> run
    |> catch_errors
    |> handle_get_response
  end

  def get(table, index, value) do
    Query.table(table)
    |> Query.get_all([value], %{index: index})
    |> run
    |> catch_errors
    |> handle_get_response
  end

  def get_many(table, index, value) do
    Query.table(table)
    |> Query.get_all([value], %{index: index})
    |> run
    |> catch_errors
    |> handle_get_many_response
  end

  def get_many(table, params) when is_map(params)do
    Query.table(table)
    |> Query.filter(params)
    |> run
    |> catch_errors
    |> handle_get_many_response
  end

  def insert(table, doc) do
    Query.table(table)
    |> Query.insert(doc, %{return_changes: true})
    |> run
    |> catch_errors
    |> handle_insert_response
  end

  def update(table, id, params) do
    Query.table(table)
    |> Query.get(id)
    |> Query.update(params)
    |> run
    |> catch_errors
    |> handle_update_response
  end

  def delete(table, id) do
    Query.table(table)
    |> Query.get(id)
    |> Query.delete
    |> run
    |> catch_errors
    |> handle_delete_response
  end

  def catch_errors(%RethinkDB.Exception.ConnectionClosed{}) do
    raise "Cannot connect to RethinkDB"
  end

  def catch_errors(%{data: data}) do
    case data do
      %{"first_error" => error} ->
        {:error, error}
      %{"r" => errors} ->
        {:error, List.first errors}
      %{"replaced" => 0, "skipped" => 1} ->
        {:error, "Not Found"}
      %{"deleted" => 0, "skipped" => 1} ->
        {:error, "Not Found"}
      nil ->
        {:error, "Not found"}
      _ ->
        data
    end
  end

  def handle_get_response({:error, error}), do: {:error, error}
  def handle_get_response([]), do: {:error, "Not found"}
  def handle_get_response([item]), do: {:ok, item}
  def handle_get_response(data) when is_map(data), do: {:ok, data}

  def handle_get_many_response({:error, error}), do: {:error, error}
  def handle_get_many_response(data) when is_list(data), do: data

  def handle_insert_response({:error, error}), do: {:error, error}
  def handle_insert_response(%{
    "errors" => 0,
    "inserted" => number,
    "changes" => changes,
    "generated_keys" => _keys
  }) when number >= 1 do
    case number do
      1 -> {:ok, List.first(changes)["new_val"]}
      number -> {:ok, number}
    end
  end

  def handle_update_response({:error, error}), do: {:error, error}
  def handle_update_response(%{"replaced" => number, "skipped" => 0}), do: {:ok, number}

  def handle_delete_response({:error, error}), do: {:error, error}
  def handle_delete_response(%{"deleted" => number, "skipped" => 0}), do: {:ok, number}
end
