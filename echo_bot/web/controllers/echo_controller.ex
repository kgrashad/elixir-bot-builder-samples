defmodule EchoBot.EchoController do
  use EchoBot.Web, :controller

  def echo(conn, params) do
    get_message(conn, params)
  end

  defp get_message(conn, %{ "serviceUrl" => serviceUrl, "text" => text, "from" => from, "conversation" => conversation, "recipient" => recipient}) do
    # Create the echo response and post it to the connector API
    # Eventually this should be moved to the elixir-bot-builder and just exposed here as bot.send
    # TODO: Should we do the post async without waiting for it?
    # TODO: How to handler failures in encoding or posting? Right now we are raising exceptions (!)
    url = Enum.join([serviceUrl, "v3/conversations/", conversation["id"], "/activities"], "")
    body = Poison.encode!(%{
      type: "message",
      from: %{ id: recipient["id"], name: recipient["name"]}, 
      conversation: %{ id: conversation["id"], name: conversation["name"]},
      recipient: %{ id: from["id"], name: from["name"]},
      text: "You said: " <> text})

    HTTPotion.post!(url, [body: body, headers: [{"Content-Type", "application/json"}]])
    
    conn 
    |> put_status(202)
    |> json(%{})
  end

  defp get_message(conn, _) do
    conn |>
    put_status(:bad_request) |>
    json(%{ error: "Invalid Request"})
  end
end