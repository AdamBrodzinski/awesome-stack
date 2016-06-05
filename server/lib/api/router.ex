defmodule Api.Router do
  use Api.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/api", Absinthe.Plug, schema: GraphQL.PublicSchema

  scope "/api", Api do
    pipe_through :api

  end
end
