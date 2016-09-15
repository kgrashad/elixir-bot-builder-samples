defmodule BotBuilder.Connector do
  @moduledoc """
  A module that handles interacting with BotBuilder Connector API.

  This can be used in your controller as:
      params
      |> Connector.parse_activity
      |> Connector.reply("Hi there")
  """

  alias BotBuilder.Activity
  alias BotBuilder.Conversation
  alias BotBuilder.From
  alias BotBuilder.Recipient

  def parse_activity(%{} = activity) do
    # TODO: Do we really need to encode then decode?
    activity
    |> Poison.encode!
    |> Poison.decode!(as: %Activity{conversation: %Conversation{}, from: %From{}, recipient: %Recipient{}})
  end

  def reply(%Activity{} = activity, message) do
    # Create the response and post it to the connector API
    # Eventually this should be moved to the elixir-bot-builder
    # TODO: Should we do the post async without waiting for it?
    # TODO: How to handler failures in encoding or posting? Right now we are raising exceptions (!)
    url = Enum.join([activity.serviceUrl, "v3/conversations/", activity.conversation.id, "/activities"], "")
    body = Poison.encode!(%{
      type: "message",
      from: %{ id: activity.recipient.id, name: activity.recipient.name}, 
      conversation: %{ id: activity.conversation.id, name: activity.conversation.name},
      recipient: %{ id: activity.from.id, name: activity.from.name},
      text: message})

    HTTPotion.post!(url, [body: body, headers: [{"Content-Type", "application/json"}]])
    end
end
