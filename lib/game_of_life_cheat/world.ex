defmodule GameOfLifeCheat.World do
  alias GameOfLifeCheat.Cell

  @moduledoc """
  Module that is responsible for time and space actions of `Cell` agents.
  """

  defstruct cells: %{},
            size: 0

  @doc """
  Initiates a world by given size x size.

  Takes optional second argument called pattern
  which you can specify as a `%MapSet{}` for initial `%Cell{status: alive}` cells.

  ### Examples

    iex> World.new(4)
    %World{cells: %{{1, 1} => %Cell{}, {1, 2} => %Cell{}, ..., {4, 4} => %Cell{}}}

    iex> World.new(4, MapSet.new([{1, 1}, {2, 1}]))
    %World{cells: %{{1, 1} => %Cell{status: :alive}, ..., {2, 1} => %Cell{status: :alive}, ..., {4, 4} => %Cell{}}}

  """
  def new(size, pattern \\ %MapSet{}) do
    %__MODULE__{size: size}
    |> populate_cells(size, pattern)
  end

  @doc """
  Translates `world.cells`'s `%Cell{}` values into a list.

  Returning list is sorted by given cell keys as coordinates.

  ### Examples

      iex> World.to_coords(%World{cells: %{{1, 2} => %Cell{status: :alive}, {1, 1} => %Cell{}}})
      [%Cell{status: :dead}, %Cell{status: :alive}]

  """
  def to_coords(%__MODULE__{cells: cells}) do
    cells
    |> Enum.sort()
    |> Enum.map(&elem(&1, 1))
  end

  @doc """
  Gets 8 neighbor `%Cell{}` around a `cell`'s given coordinates.
  """
  def get_neighbors(%__MODULE__{cells: cells}, {x, y}) do
    for i <- (x - 1)..(x + 1),
        j <- (y - 1)..(y + 1),
        cell = Map.get(cells, {i, j}),
        cell && (i != x || j != y) do
      cell
    end
  end

  @doc """
  Evaluates world cells to their next state.
  """
  def tick(world = %__MODULE__{cells: cells, size: size}) do
    next_cells =
      for x <- 1..size,
          y <- 1..size,
          cell = Map.get(cells, {x, y}),
          neighbors = get_neighbors(world, {x, y}),
          into: %{} do
        {{x, y}, Cell.evolve(cell, neighbors)}
      end

    %__MODULE__{world | cells: next_cells}
  end

  defp populate_cells(world, size, pattern) do
    cells =
      for x <- 1..size, y <- 1..size, into: %{} do
        if MapSet.member?(pattern, {x, y}) do
          {{x, y}, %Cell{status: :alive}}
        else
          {{x, y}, %Cell{}}
        end
      end

    %{world | cells: cells}
  end
end
