defmodule Graphql.Schema do
  @moduledoc """
  Module for defining graphQL schemas
  """
  use Absinthe.Schema

  import_types(Graphql.Types.Conversation)

  query do
    @desc "Show conversation by sender and recipient"
    field :show_conversation, :conversation do
      arg(:sender_fractal_id, non_null(:integer))
      arg(:recipient_fractal_id, non_null(:integer))

      resolve(&Graphql.Resolvers.Conversation.show/2)
    end
  end
end
