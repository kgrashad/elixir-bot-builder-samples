defmodule BotBuilder.Activity do
    @derive [Poison.Encoder]
    defstruct [:attachements, :channelId, :entities, :serviceUrl, :text, :timestamp, :message, :conversation, :from, :recipient]
end

defmodule BotBuilder.Conversation do
    @derive [Poison.Encoder]
    defstruct [:id, :name, :isGroup]
end

defmodule BotBuilder.From do
    @derive [Poison.Encoder]
    defstruct [:id, :name]
end

defmodule BotBuilder.Recipient do
    @derive [Poison.Encoder]
    defstruct [:id, :name]
end