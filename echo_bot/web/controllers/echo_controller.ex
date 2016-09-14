defmodule EchoBot.EchoController do
  use EchoBot.Web, :controller
  alias EchoBot.Models.Message

  def echo(conn, params) do
    get_message(conn, params)
  end

  defp get_message(conn, %{"message" => msg}) do
    json(conn, %{ echoed_message: msg})
  end

  defp get_message(conn, _) do
    conn |>
    put_status(:bad_request) |>
    json(%{ error: "Please specify the 'message' parameter"})
  end
end
