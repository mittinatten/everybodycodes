defmodule Quest3.Part1 do
  import Quest3.Map

  def getTotalDigout(input) do
    init(input) |> digAllTheWay() |> volume()
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    getTotalDigout(data)
  end
end
