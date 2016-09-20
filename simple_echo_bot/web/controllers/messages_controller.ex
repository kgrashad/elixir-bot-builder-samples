defmodule SimpleEchoBot.MessagesController do
  use SimpleEchoBot.Web, :controller
  alias BotBuilder.Connector

  def messages(conn, params) do
    get_message(conn, params)
  end

  defp get_message(conn, %{"text" => text} = params) do
    params
    |> Connector.parse_activity
    |> Connector.reply("You said: " <> text)
    
    conn
    |> put_status(202)
    |> json(%{})
  end

  defp get_message(conn, _) do
    conn
    |> put_status(:bad_request)
    |> json(%{ error: "Invalid Request"})
  end
end
