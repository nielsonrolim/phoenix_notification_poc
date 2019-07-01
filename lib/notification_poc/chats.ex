defmodule NotificationPoc.Chats do
  @moduledoc """
  The Chats context.
  """

  # message_changeset = NotificationPoc.Chats.Message.changeset(%NotificationPoc.Chats.Message{}, {body: "Olá", sender_fractal_id: "123", recipient_fractal_id: "321"})

  def insert(%Ecto.Changeset{} = changeset) do
    case Mongo.find_one_and_replace(:mongo, mongo_collection_name(changeset), %{_id: %{"$exists" => false}}, changeset.changes, [return_document: :after, upsert: true]) do
      {:ok, content} ->
        {:ok, AtomicMap.convert(content, %{ignore: true})}
      {:error, error} ->
        {:error, error}
    end
  end

  defp mongo_collection_name(data_source) when is_atom(data_source) do
    struct(data_source)
    |> data_source.changeset(%{})
    |> mongo_collection_name
  end

  defp mongo_collection_name(%Ecto.Changeset{} = changeset) do
    changeset.data.__meta__.source()
  end
end
