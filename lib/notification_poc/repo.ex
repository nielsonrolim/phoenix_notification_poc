defmodule NotificationPoc.Repo do
  use Ecto.Repo,
    otp_app: :notification_poc,
    adapter: Ecto.Adapters.Postgres
end
