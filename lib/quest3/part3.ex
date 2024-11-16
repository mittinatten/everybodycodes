defmodule Quest3.Part3 do
  import Quest3.Map

  def getTotalDigout(input) do
    initRoyal(input) |> digAllTheWayRoyal() |> volume()
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    getTotalDigout(data)
  end
end
