defmodule Quest1.Part2 do
  def calcNumberOfPotions(input) do
    input
    |> String.trim()
    |> String.codepoints()
    |> Enum.chunk_every(2)
    |> Enum.map(fn pair -> Quest1.strengthPair(pair) end)
    |> Enum.sum()
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    calcNumberOfPotions(data)
  end
end
