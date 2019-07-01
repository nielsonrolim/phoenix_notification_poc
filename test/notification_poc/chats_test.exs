defmodule NotificationPoc.ChatsTest do
  use NotificationPoc.DataCase

  alias NotificationPoc.Chats

  describe "messages" do
    alias NotificationPoc.Chats.Message

    @valid_attrs %{body: "some body", recipient_fractal_id: "some recipient_fractal_id", sender_fractal_id: "some sender_fractal_id"}
    @update_attrs %{body: "some updated body", recipient_fractal_id: "some updated recipient_fractal_id", sender_fractal_id: "some updated sender_fractal_id"}
    @invalid_attrs %{body: nil, recipient_fractal_id: nil, sender_fractal_id: nil}

    def message_fixture(attrs \\ %{}) do
      {:ok, message} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chats.create_message()

      message
    end

    test "list_messages/0 returns all messages" do
      message = message_fixture()
      assert Chats.list_messages() == [message]
    end

    test "get_message!/1 returns the message with given id" do
      message = message_fixture()
      assert Chats.get_message!(message.id) == message
    end

    test "create_message/1 with valid data creates a message" do
      assert {:ok, %Message{} = message} = Chats.create_message(@valid_attrs)
      assert message.body == "some body"
      assert message.recipient_fractal_id == "some recipient_fractal_id"
      assert message.sender_fractal_id == "some sender_fractal_id"
    end

    test "create_message/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chats.create_message(@invalid_attrs)
    end

    test "update_message/2 with valid data updates the message" do
      message = message_fixture()
      assert {:ok, %Message{} = message} = Chats.update_message(message, @update_attrs)
      assert message.body == "some updated body"
      assert message.recipient_fractal_id == "some updated recipient_fractal_id"
      assert message.sender_fractal_id == "some updated sender_fractal_id"
    end

    test "update_message/2 with invalid data returns error changeset" do
      message = message_fixture()
      assert {:error, %Ecto.Changeset{}} = Chats.update_message(message, @invalid_attrs)
      assert message == Chats.get_message!(message.id)
    end

    test "delete_message/1 deletes the message" do
      message = message_fixture()
      assert {:ok, %Message{}} = Chats.delete_message(message)
      assert_raise Ecto.NoResultsError, fn -> Chats.get_message!(message.id) end
    end

    test "change_message/1 returns a message changeset" do
      message = message_fixture()
      assert %Ecto.Changeset{} = Chats.change_message(message)
    end
  end
end
