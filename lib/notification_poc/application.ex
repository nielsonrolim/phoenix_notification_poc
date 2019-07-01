defmodule NotificationPoc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    database_config = Application.get_env(:notification_poc, :db_config)

    children = [
      NotificationPocWeb.Endpoint,
      %{
        id: Mongo,
        start: {Mongo, :start_link, [database_config]}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NotificationPoc.Supervisor]

    result = Supervisor.start_link(children, opts)

    NotificationPoc.Startup.ensure_indexes

    result
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NotificationPocWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
