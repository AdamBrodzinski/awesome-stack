defmodule App.Router do
  use App.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", App do
    pipe_through :api
  end
end
