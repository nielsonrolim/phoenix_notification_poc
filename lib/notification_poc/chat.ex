defmodule NotificationPoc.Chat do
  @moduledoc """
  The Chat context.
  """

  import Ecto.Query, warn: false
  alias NotificationPoc.Repo

  alias NotificationPoc.Chat.Conversation

  def list_conversations do
    Repo.all(Conversation)
  end

  def get_conversation!(sender_fractal_id, recipient_fractal_id) do
    Repo.one(
      from c in Conversation,
        where:
          c.sender_fractal_id in [^sender_fractal_id, ^recipient_fractal_id] and
          c.recipient_fractal_id in [^sender_fractal_id, ^recipient_fractal_id]
    )
  end

  def create_conversation(attrs \\ %{}) do
    {messages, attrs} = Map.pop(attrs, :messages)

    case get_conversation!(attrs[:sender_fractal_id], attrs[:recipient_fractal_id]) do
      nil ->
        Conversation.changeset(%Conversation{}, attrs)
        |> Ecto.Changeset.put_embed(:messages, messages)

      conversation ->
        Conversation.changeset(conversation, attrs)
        |> Ecto.Changeset.put_embed(:messages, messages ++ conversation.messages)
    end
      |> Repo.insert_or_update()
  end
end
