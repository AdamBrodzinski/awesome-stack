defmodule App.Router do
  use App.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/v1", App do
    pipe_through :api
    post "/users", UserController, :create
  end

  scope "/graphql" do
    pipe_through :api

    if Mix.env == :dev do
      get "/", GraphQL.Plug, schema: {App.GraphSchema, :schema}
    end

    post "/", GraphQL.Plug, schema: {App.GraphSchema, :schema}
  end
end
