defmodule NotificationPocWeb.Router do
  use NotificationPocWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", NotificationPocWeb do
    pipe_through :api
  end
end
