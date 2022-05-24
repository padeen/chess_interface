defmodule ChessInterfaceWeb.GameChannel do
  use ChessInterfaceWeb, :channel

  alias ChessEngine.Board

  def join("game:default", _payload, socket) do
    {:ok, socket}
  end

  def handle_in("start_board", _payload, socket) do
    Board.start_new()
    {:reply, :ok, socket}
  end
end
