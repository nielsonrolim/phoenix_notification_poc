defmodule NotificationPoc.Chat.Message do
  use Ecto.Schema

  embedded_schema do
    field :sender_fractal_id
    field :application
    field :body
  end
end