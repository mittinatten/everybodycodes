defmodule Quest4.Part1 do
  def parseInput(input) do
    String.split(input, "\n")
    |> Enum.map(&String.trim(&1))
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.to_integer(&1))
  end

  def calculate(input) do
    values = parseInput(input)

    min = Enum.min(values)
    Enum.map(values, &(&1 - min)) |> Enum.sum()
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    calculate(data)
  end
end
