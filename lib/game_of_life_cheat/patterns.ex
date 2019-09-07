defmodule GameOfLifeCheat.Patterns do
  def block() do
    MapSet.new([{3, 3}, {3, 4}, {4, 3}, {4, 4}])
  end

  def blinker() do
    MapSet.new([{3, 3}, {4, 3}, {5, 3}])
  end

  def glider() do
    MapSet.new([{3, 5}, {4, 3}, {4, 5}, {5, 4}, {5, 5}])
  end
end
