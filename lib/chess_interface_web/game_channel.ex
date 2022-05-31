defmodule ChessInterfaceWeb.GameChannel do
  use ChessInterfaceWeb, :channel

  alias ChessEngine.{Game, GameSupervisor}

  def join("game:" <> _name, _payload, socket) do
    {:ok, socket}
  end

  def handle_in("new_game", _payload, socket) do
    "game:" <> name = socket.topic

    case GameSupervisor.start_game(name) do
      {:ok, _pid} -> {:reply, :ok, socket}
      {:error, reason} -> {:reply, {:error, %{reason: inspect(reason)}}, socket}
    end
  end

  def handle_in("add_player", payload, socket) do
    %{"player2_name" => player2_name} = payload

    case Game.add_player(via(socket.topic), player2_name) do
      :ok ->
        broadcast!(socket, "player_added", %{message: "New player joined: " <> player2_name})
        {:noreply, socket}

      {:error, reason} ->
        {:reply, {:error, %{reason: inspect(reason)}}, socket}

      :error ->
        {:reply, :error, socket}
    end
  end

  def handle_in("select_colors", payload, socket) do
    %{"player1_color" => player1_color, "player2_color" => player2_color} = payload
    player1_color = String.to_existing_atom(player1_color)
    player2_color = String.to_existing_atom(player2_color)

    case Game.select_colors(via(socket.topic), player1_color, player2_color) do
      :ok -> {:reply, :ok, socket}
      _ -> {:reply, :error, socket}
    end
  end

  defp via("game:" <> name), do: Game.via_tuple(name)
end
