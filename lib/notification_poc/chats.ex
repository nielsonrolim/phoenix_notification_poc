defmodule NotificationPoc.Chats do
  @moduledoc """
  The Chats context.
  """

  # message_changeset = NotificationPoc.Chats.Message.changeset(%NotificationPoc.Chats.Message{}, {body: "Olá", sender_fractal_id: "123", recipient_fractal_id: "321"})
  # NotificationPoc.Chats.all(NotificationPoc.Chats.Message, %{sender_fractal_id: "123"})

  @mongo_query_limit Application.get_env(:notification_poc, :data_pagination)[:limit]
  @mongo_query_sort %{_id: 1}

  def insert(%Ecto.Changeset{} = changeset) do
    case Mongo.find_one_and_replace(
           :mongo,
           mongo_collection_name(changeset),
           %{_id: %{"$exists" => false}},
           changeset.changes,
           return_document: :after,
           upsert: true
         ) do
      {:ok, content} ->
        {:ok, AtomicMap.convert(content, %{ignore: true})}

      {:error, error} ->
        {:error, error}
    end
  end

  def all(data_source, queryable) when is_atom(data_source) and is_map(queryable) do
    Mongo.find(
      :mongo,
      mongo_collection_name(data_source),
      queryable_to_mongo_query(queryable),
      limit: safe_limit(queryable),
      sort: Map.get(queryable, :sort, @mongo_query_sort)
    )
    |> Enum.to_list()
    |> AtomicMap.convert(%{ignore: true})
  end

  defp mongo_collection_name(data_source) when is_atom(data_source) do
    struct(data_source)
    |> data_source.changeset(%{})
    |> mongo_collection_name
  end

  defp mongo_collection_name(%Ecto.Changeset{} = changeset) do
    changeset.data.__meta__.source()
  end

  defp queryable_to_mongo_query(queryable) do
    mongo_query =
      queryable
      |> Map.drop([:first, :last, :before, :after, :limit, :offset, :sort])

    cond do
      Map.has_key?(queryable, :before) ->
        Map.put(mongo_query, "_id", %{"$lt": BSON.ObjectId.decode!(Map.get(queryable, :before))})

      Map.has_key?(queryable, :after) ->
        Map.put(mongo_query, "_id", %{"$gt": BSON.ObjectId.decode!(Map.get(queryable, :after))})

      true ->
        mongo_query
    end
  end

  defp safe_limit(queryable) do
    Map.get(queryable, :limit, @mongo_query_limit)
    |> (fn limit ->
          case limit do
            value when value > @mongo_query_limit ->
              @mongo_query_limit

            _ ->
              limit
          end
        end).()
  end
end
