defmodule GameOfLifeCheat.PatternsTest do
  use ExUnit.Case, async: true

  alias GameOfLifeCheat.{World, Patterns}

  test "pattern block (still life)" do
    pattern = Patterns.block()

    world =
      World.new(16, pattern)
      |> World.tick()

    next_world = World.new(16, pattern)

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, pattern)

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, pattern)

    assert world.cells == next_world.cells
  end

  test "pattern blinker (period 2 oscilator)" do
    pattern = Patterns.blinker()

    world =
      World.new(16, pattern)
      |> World.tick()

    next_pattern = MapSet.new([{4, 2}, {4, 3}, {4, 4}])

    next_world = World.new(16, next_pattern)

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, pattern)

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, next_pattern)

    assert world.cells == next_world.cells
  end

  test "pattern glider" do
    pattern = Patterns.glider()

    world =
      World.new(16, pattern)
      |> World.tick()

    next_world = World.new(16, MapSet.new([{3, 4}, {4, 5}, {4, 6}, {5, 4}, {5, 5}]))

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, MapSet.new([{3, 5}, {4, 6}, {5, 4}, {5, 5}, {5, 6}]))

    assert world.cells === next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, MapSet.new([{4, 4}, {4, 6}, {5, 5}, {5, 6}, {6, 5}]))

    assert world.cells == next_world.cells

    world =
      world
      |> World.tick()

    next_world = World.new(16, MapSet.new([{4, 6}, {5, 4}, {5, 6}, {6, 5}, {6, 6}]))

    assert world.cells == next_world.cells
  end
end
