defmodule NotificationPocWeb.Router do
  use NotificationPocWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NotificationPocWeb do
    pipe_through :api
  end

  scope "/graphql_api" do
    if Mix.env() == :dev do
      forward "/graphiql", Absinthe.Plug.GraphiQL,
        schema: Graphql.Schema,
        socket: NotificationPocWeb.UserSocket    
    end

    forward "/", Absinthe.Plug, schema: Graphql.Schema
  end
end
