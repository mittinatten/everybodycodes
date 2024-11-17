defmodule Quest5.ClapDance do
  alias __MODULE__

  defstruct columns: [[], [], [], []],
            clapper: nil,
            columnIndex: 0,
            column: nil,
            count: 0,
            rowIndex: 0,
            direction: :down,
            round: 0,
            shout: ""

  def init(input) do
    rows =
      String.split(input, "\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.split(&1, " "))
      |> Enum.map(fn row -> Enum.map(row, &String.to_integer/1) end)

    populateColumns(rows, %ClapDance{})
  end

  defp populateColumns([], dance), do: dance

  defp populateColumns(rows, dance = %ClapDance{columns: cols}) do
    [row | rest] = rows
    cols = Enum.zip_with(cols, row, &(&1 ++ [&2]))
    populateColumns(rest, %{dance | columns: cols})
  end

  def run(dance = %ClapDance{}, numberRounds) do
    updatedDance = step(dance)

    if dance.round > numberRounds,
      do: dance,
      else: run(updatedDance, numberRounds)
  end

  def step(dance = %ClapDance{clapper: nil, column: nil}) do
    [clapper | restClapper] = Enum.at(dance.columns, dance.columnIndex)
    columnIndex = nextColumn(dance)
    column = Enum.at(dance.columns, columnIndex)
    columns = List.replace_at(dance.columns, dance.columnIndex, restClapper)

    %ClapDance{
      dance
      | columns: columns,
        clapper: clapper,
        column: column,
        columnIndex: columnIndex,
        rowIndex: 0,
        round: dance.round + 1,
        count: 1,
        direction: :down
    }
  end

  def step(dance = %ClapDance{column: nil}) do
    columnIndex = nextColumn(dance)
    column = Enum.at(dance.columns, columnIndex)

    %ClapDance{dance | column: column, columnIndex: columnIndex, direction: :down, rowIndex: 0}
  end

  def step(dance = %ClapDance{}) when dance.clapper == dance.count do
    newColumn =
      if dance.direction == :down do
        List.insert_at(dance.column, dance.rowIndex, dance.clapper)
      else
        List.insert_at(dance.column, dance.rowIndex + 1, dance.clapper)
      end

    %ClapDance{
      dance
      | columns: List.replace_at(dance.columns, dance.columnIndex, newColumn),
        column: nil,
        clapper: nil,
        count: 0
    }
    |> shout()
  end

  def step(dance = %ClapDance{direction: :down}) do
    if dance.rowIndex < length(dance.column) - 1 do
      %ClapDance{dance | rowIndex: dance.rowIndex + 1, count: dance.count + 1}
    else
      %ClapDance{dance | count: dance.count + 1, direction: :up}
    end
  end

  def step(dance = %ClapDance{direction: :up}) do
    if dance.rowIndex > 0 do
      %ClapDance{dance | rowIndex: dance.rowIndex - 1, count: dance.count + 1}
    else
      %ClapDance{dance | column: nil}
    end
  end

  defp nextColumn(dance = %ClapDance{}) do
    if dance.columnIndex == length(dance.columns) - 1, do: 0, else: dance.columnIndex + 1
  end

  defp shout(dance = %ClapDance{}) do
    %ClapDance{
      dance
      | shout:
          Enum.map(dance.columns, &hd/1) |> Enum.map(&Integer.to_string/1) |> List.to_string()
    }
  end
end
