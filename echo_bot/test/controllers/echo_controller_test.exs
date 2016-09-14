defmodule EchoBot.EchoControllerTest do
  use EchoBot.ConnCase

  test "GET /api/echo", %{conn: conn} do
    conn = get conn, "/api/echo"
    assert json_response(conn, 400)
  end

  test "POST /api/echo", %{conn: conn} do
    conn = post conn, "/api/echo"
    assert json_response(conn, 400)
  end

  test "echo with message parameter", %{conn: conn} do
    msg = "test message"
    params = %{"message" => msg}
    conn = post conn, echo_path(conn, :echo, params)
    assert Map.equal?(json_response(conn, 200), %{"echoed_message" => "test message"})
  end

  test "echo missing message parameter", %{conn: conn} do
    msg = "test message"
    params = %{"parametername" => msg}
    conn = post conn, echo_path(conn, :echo, params)
    assert Map.equal?(json_response(conn, 400), %{"error" => "Please specify the 'message' parameter"})
  end
end
