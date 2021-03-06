defmodule Expaste.PasteChannel do
  use Phoenix.Channel

  def join("paste", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("message:new", payload, socket) do
    broadcast! socket, "message:new", payload

    {:noreply, socket}
  end
end
