defmodule EchoBot.Router do
  use EchoBot.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EchoBot do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", EchoBot do
    pipe_through :api

    get "/echo", EchoController, :echo
    post "/echo", EchoController, :echo
  end
end