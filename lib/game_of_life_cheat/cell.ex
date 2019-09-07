defmodule GameOfLifeCheat.Cell do
  defstruct status: :dead

  alias GameOfLifeCheat.Cell

  @doc """
  Evolves Cell to its next state.

  ### Examples

  iex> neighbors = [%Cell{ status: :alive }, %Cell{ status: :alive }, %Cell{ status: :alive }]
  ...> Cell.evolve(%Cell{ status: :dead}, neighbors)
  %Cell{ status: :alive }
  """
  def evolve(cell = %Cell{status: :dead}, neighbors) do
    case count_alives(neighbors) do
      3 -> %Cell{cell | status: :alive}
      _ -> cell
    end
  end

  def evolve(cell = %Cell{status: :alive}, neighbors) do
    case count_alives(neighbors) do
      count when count == 2 or count == 3 -> cell
      _ -> %Cell{status: :dead}
    end
  end

  defp count_alives(neighbors) do
    Enum.count(neighbors, fn cell -> cell.status == :alive end)
  end
end
