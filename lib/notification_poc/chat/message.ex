defmodule NotificationPoc.Chat.Message do
  use Ecto.Schema

  embedded_schema do
    field :sender_fractal_id, :string
    field :recipient_fractal_id, :string
    field :body, :string
  end
end