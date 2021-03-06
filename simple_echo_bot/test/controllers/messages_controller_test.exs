defmodule SimpleEchoBot.MessagesControllerTest do
  use SimpleEchoBot.ConnCase

  test "GET /api/messages", %{conn: conn} do
    conn = get conn, "/api/messages"
    assert json_response(conn, 400)
  end

  test "POST /api/messages", %{conn: conn} do
    conn = post conn, "/api/messages"
    assert json_response(conn, 400)
  end

  # For this test to pass, you must run emulator
  # TODO: how can we stub the API post so we don't need the emulator to be running?
  test "messages with text parameter", %{conn: conn} do
    params = %{
      "type": "message",
      "id": "2527a2c005a346f08e4465555e64a3ff",
      "timestamp": "2016-09-19T10:57:24.469395Z",
      "serviceUrl": "http://localhost:9000/",
      "channelId": "emulator",
      "from": %{
        "id": "2c1c7fa3",
        "name": "User1"
      },
      "conversation": %{
        "isGroup": false,
        "id": "8a684db8",
        "name": "Conv1"
      },
      "recipient": %{
        "id": "56800324",
        "name": "Bot1"
      },
      "text": "hi",
      "attachments": [],
      "entities": []
    }
    conn = post conn, messages_path(conn, :messages, params)
    assert Map.equal?(json_response(conn, 202), %{})
  end

  test "messages missing text parameter", %{conn: conn} do
    params = %{}
    conn = post conn, messages_path(conn, :messages, params)
    assert Map.equal?(json_response(conn, 400), %{"error" => "Invalid Request"})
  end
end
