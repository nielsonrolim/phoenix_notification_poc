defmodule NotificationPoc.Repo.Migrations.CreateConversations do
  use Ecto.Migration

  def change do
    create table(:conversations) do
      add :sender_fractal_id, :integer
      add :recipient_fractal_id, :integer
      add(:messages, {:array, :map}, default: [])

      timestamps()
    end

  end
end
