defmodule GameOfLifeCheatWeb.GameLive do
  use Phoenix.LiveView

  alias GameOfLifeCheat.{World, Patterns}

  @size 16
  @cell_size 50
  @tick 200

  def render(assigns) do
    ~L"""
    <div>
      <h1>Game of Life: <%= @count %></h1>
      <div style="display: flex; flex-wrap: wrap; width: <%= @cell_size * @size %>px; height: <%= @cell_size * @size %>px;">
        <%= for cell <- World.to_coords(@world) do %>
          <div style="background: <%= if cell.status == :alive, do: "black", else: "white" %>; width: <%= @cell_size %>px; height: <%= @cell_size %>px;">
          </div>
        <% end %>
      </div>
    </div>
    """
  end

  def mount(_session, socket) do
    count = 0

    world = World.new(@size, Patterns.glider())

    next_socket =
      socket
      |> assign(:size, @size)
      |> assign(:cell_size, @cell_size)
      |> assign(:count, count)
      |> assign(:world, world)

    schedule_tick()

    {:ok, next_socket}
  end

  def handle_event("inc", _value, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("dec", _value, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def handle_info(:tick, socket) do
    schedule_tick()

    world =
      socket.assigns.world
      |> World.tick()

    next_socket =
      socket
      |> update(:count, &(&1 + 1))
      |> assign(:world, world)

    {:noreply, next_socket}
  end

  defp schedule_tick() do
    Process.send_after(self(), :tick, @tick)
  end
end
