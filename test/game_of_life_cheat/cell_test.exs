defmodule GameOfLifeCheat.CellTest do
  use ExUnit.Case, async: true

  alias GameOfLifeCheat.Cell

  test "evolve from dead to alive with 3 alive neighbors" do
    neighbors = [
      %Cell{status: :alive},
      %Cell{},
      %Cell{},
      %Cell{status: :alive},
      %Cell{},
      %Cell{},
      %Cell{status: :alive},
      %Cell{}
    ]

    evolved =
      %Cell{status: :dead}
      |> Cell.evolve(neighbors)

    assert %Cell{status: :alive} = evolved
  end

  test "evolve dead as unchanged without 3 alive neighbors" do
    neighbors = [
      %Cell{status: :alive},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{status: :alive},
      %Cell{}
    ]

    evolved =
      %Cell{status: :dead}
      |> Cell.evolve(neighbors)

    assert %Cell{status: :dead} = evolved
  end

  test "evolve from alive to dead with fewer than 2 alive neighbors" do
    neighbors = [
      %Cell{},
      %Cell{status: :alive},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{},
      %Cell{}
    ]

    evolved =
      %Cell{status: :alive}
      |> Cell.evolve(neighbors)

    assert %Cell{status: :dead} = evolved
  end

  test "evolve from alive to dead with more than 3 alive neighbors" do
    neighbors = [
      %Cell{},
      %Cell{status: :alive},
      %Cell{},
      %Cell{status: :alive},
      %Cell{status: :alive},
      %Cell{},
      %Cell{status: :alive},
      %Cell{}
    ]

    evolved =
      %Cell{status: :alive}
      |> Cell.evolve(neighbors)

    assert %Cell{status: :dead} = evolved
  end

  test "evolve alive as unchanged with 2 or 3 alive neighbors" do
    neighbors = [
      %Cell{},
      %Cell{status: :alive},
      %Cell{},
      %Cell{status: :alive},
      %Cell{},
      %Cell{},
      %Cell{status: :alive},
      %Cell{}
    ]

    evolved =
      %Cell{status: :alive}
      |> Cell.evolve(neighbors)

    assert %Cell{status: :alive} = evolved
  end
end
