defmodule NotificationPoc.Startup do
  def ensure_indexes do
    IO.puts("Using database #{Application.get_env(:notification_poc, :db_config)[:name]}")

    Mongo.command(:mongo, %{createIndexes: "messages",
      indexes: [%{key: %{sender_fractal_id: 1}, name: "sender_fractal_id_idx", unique: true}]
    })
  end
end
