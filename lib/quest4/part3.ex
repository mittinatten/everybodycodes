defmodule Quest4.Part3 do
  def calculate(input) do
    values = Quest4.Part1.parseInput(input)
    min = Enum.min(values)
    max = Enum.max(values)

    for level <- min..max do
      {Enum.map(values, &abs(&1 - level)) |> Enum.sum(), level}
    end
    |> Enum.min_by(fn {strikes, _} -> strikes end)
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    calculate(data)
  end
end
