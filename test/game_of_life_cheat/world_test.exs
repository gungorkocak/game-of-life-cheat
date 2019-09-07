defmodule GameOfLifeCheat.WorldTest do
  use ExUnit.Case, async: true

  alias GameOfLifeCheat.{Cell, World}

  test "create empty world with given size" do
    world = World.new(16)

    assert Enum.count(world.cells) == 16 * 16
    assert Enum.all?(world.cells, fn {_, %Cell{status: status}} -> status == :dead end)
  end

  test "create existing world with given size and pattern" do
    pattern = MapSet.new([{1, 1}, {1, 2}, {8, 8}, {9, 8}])
    world = World.new(16, pattern)

    Enum.each(world.cells, fn {{x, y}, cell} ->
      if MapSet.member?(pattern, {x, y}) do
        assert cell.status == :alive
      else
        assert cell.status == :dead
      end
    end)
  end

  test "to_coords returns all world cells in ordered list" do
    pattern = MapSet.new([{1, 1}, {1, 3}, {2, 3}])

    coords =
      World.new(4, pattern)
      |> World.to_coords()

    assert [
             %Cell{status: :alive},
             %Cell{status: :dead},
             %Cell{status: :alive},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :alive},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead},
             %Cell{status: :dead}
           ] = coords
  end

  test "get_neighbors gets relevant neighbors for a given coordinate" do
    pattern = MapSet.new([{1, 1}, {1, 3}, {2, 3}])

    world = World.new(4, pattern)
    neighbors = World.get_neighbors(world, {2, 2})

    assert [
             %Cell{status: :alive},
             %Cell{},
             %Cell{status: :alive},
             %Cell{},
             %Cell{status: :alive},
             %Cell{},
             %Cell{},
             %Cell{}
           ] = neighbors
  end

  # NOTE: we can use https://bitstorm.org/gameoflife/ to assert next world state.
  test "tick iterates world correctly" do
    world =
      World.new(16, MapSet.new([{3, 3}, {3, 5}, {4, 5}, {4, 6}]))
      |> World.tick()

    next_world = World.new(16, MapSet.new([{3, 4}, {3, 5}, {3, 6}, {4, 4}, {4, 5}, {4, 6}]))

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, MapSet.new([{2, 5}, {3, 4}, {3, 6}, {4, 4}, {4, 6}, {5, 5}]))

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, MapSet.new([{2, 5}, {3, 4}, {3, 6}, {4, 4}, {4, 6}, {5, 5}]))

    assert world.cells == next_world.cells
  end
end
