defmodule NotificationPoc.Chats.Message do
  use Ecto.Schema
  import Ecto.Changeset

  schema "messages" do
    field :body, :string
    field :recipient_fractal_id, :string
    field :sender_fractal_id, :string

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:body, :sender_fractal_id, :recipient_fractal_id])
    |> validate_required([:body, :sender_fractal_id, :recipient_fractal_id])
  end
end
