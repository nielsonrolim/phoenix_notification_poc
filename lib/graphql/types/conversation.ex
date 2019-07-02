defmodule Graphql.Types.Conversation do
  use Absinthe.Schema.Notation

  object :conversation do
    field :sender_fractal_id, non_null(:integer)
    field :recipient_fractal_id, non_null(:integer)
    field :messages, list_of(:message)
  end

  object :message do
    field :id,   :string
    field :sender_fractal_id, :integer
    field :recipient_fractal_id, :integer
    field :body, :string
  end
end
