defmodule NotificationPoc.Repo do
  use Ecto.Repo,
    otp_app: :notification_poc,
    adapter: Ecto.Adapters.Postgres

  def init(_, opts) do
    {:ok, build_opts(opts)}
  end

  defp build_opts(opts) do
    system_opts = [
      database: System.get_env("DB_NAME"),
      hostname: System.get_env("DB_HOST"),
      password: System.get_env("DB_PASSWORD"),
      username: System.get_env("DB_USERNAME")
    ]

    system_opts
    |> remove_empty_opts()
    |> merge_opts(opts)
  end

  defp merge_opts(system_opts, opts) do
    Keyword.merge(opts, system_opts)
  end

  defp remove_empty_opts(system_opts) do
    Enum.reject(system_opts, fn {_k, value} -> is_nil(value) end)
  end

end
