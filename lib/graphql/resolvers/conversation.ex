defmodule Graphql.Resolvers.Conversation do
  alias NotificationPoc.Chat

  def show(%{sender_fractal_id: sender_fractal_id, recipient_fractal_id: recipient_fractal_id},_info) do
    case Chat.get_conversation!(sender_fractal_id, recipient_fractal_id) do
      nil -> {:error, "a error has ocurred"}
      conversation -> {:ok, conversation}
    end
  end
end
