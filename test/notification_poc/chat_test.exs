defmodule NotificationPoc.ChatTest do
  use NotificationPoc.DataCase

  alias NotificationPoc.Chat

  describe "conversations" do
    alias NotificationPoc.Chat.Conversation

    @valid_attrs %{messages: "some messages", recipient_fractal_id: 42, sender_fractal_id: 42}
    @update_attrs %{messages: "some updated messages", recipient_fractal_id: 43, sender_fractal_id: 43}
    @invalid_attrs %{messages: nil, recipient_fractal_id: nil, sender_fractal_id: nil}

    def conversation_fixture(attrs \\ %{}) do
      {:ok, conversation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_conversation()

      conversation
    end

    test "list_conversations/0 returns all conversations" do
      conversation = conversation_fixture()
      assert Chat.list_conversations() == [conversation]
    end

    test "get_conversation!/1 returns the conversation with given id" do
      conversation = conversation_fixture()
      assert Chat.get_conversation!(conversation.id) == conversation
    end

    test "create_conversation/1 with valid data creates a conversation" do
      assert {:ok, %Conversation{} = conversation} = Chat.create_conversation(@valid_attrs)
      assert conversation.messages == "some messages"
      assert conversation.recipient_fractal_id == 42
      assert conversation.sender_fractal_id == 42
    end

    test "create_conversation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_conversation(@invalid_attrs)
    end

    test "update_conversation/2 with valid data updates the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{} = conversation} = Chat.update_conversation(conversation, @update_attrs)
      assert conversation.messages == "some updated messages"
      assert conversation.recipient_fractal_id == 43
      assert conversation.sender_fractal_id == 43
    end

    test "update_conversation/2 with invalid data returns error changeset" do
      conversation = conversation_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_conversation(conversation, @invalid_attrs)
      assert conversation == Chat.get_conversation!(conversation.id)
    end

    test "delete_conversation/1 deletes the conversation" do
      conversation = conversation_fixture()
      assert {:ok, %Conversation{}} = Chat.delete_conversation(conversation)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_conversation!(conversation.id) end
    end

    test "change_conversation/1 returns a conversation changeset" do
      conversation = conversation_fixture()
      assert %Ecto.Changeset{} = Chat.change_conversation(conversation)
    end
  end
end
