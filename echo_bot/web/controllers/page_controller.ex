defmodule EchoBot.PageController do
  use EchoBot.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
