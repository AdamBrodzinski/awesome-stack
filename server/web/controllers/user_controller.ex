defmodule App.UserController do
  use App.Web, :controller
  alias App.User
  plug :scrub_params, "user" when action in [:create]

  def create(conn, %{"user" => user_params}) do
    case User.insert("1", %{name: "Adam"}) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", user_path(conn, :show, user))
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(App.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
