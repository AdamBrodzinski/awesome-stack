defmodule App.Router do
  use App.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1", App do
    pipe_through :api
    post "/users", UserController, :create
  end
end
