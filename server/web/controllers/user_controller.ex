defmodule App.UserController do
  use App.Web, :controller
  alias App.Query

  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => params}) do
    data = %{
      name: params["name"],
      email: params["email"],
    }

    case Query.insert("users", data) do
      {:ok, doc} ->
        conn
        |> put_status(:created)
        |> json doc
      {:error, error_json} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json %{error: true}
    end
  end
end
