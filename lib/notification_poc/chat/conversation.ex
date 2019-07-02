defmodule NotificationPoc.Chat.Conversation do
  use Ecto.Schema
  import Ecto.Changeset

  alias NotificationPoc.Chat.Message

  schema "conversations" do
    field :recipient_fractal_id, :integer
    field :sender_fractal_id, :integer
    embeds_many :messages, Message

    timestamps()
  end

  @doc false
  def changeset(conversation, attrs) do
    conversation
    |> cast(attrs, [:sender_fractal_id, :recipient_fractal_id, :messages])
    |> validate_required([:sender_fractal_id, :recipient_fractal_id, :messages])
  end
end
