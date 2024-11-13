defmodule Quest1.Part3 do
  def calcNumberOfPotions(input) do
    input
    |> String.codepoints()
    |> Enum.chunk_every(3)
    |> Enum.map(fn triple -> Quest1.strengthTriple(triple) end)
    |> Enum.sum()
  end

  def solve(filePath) do
    {:ok, data} = File.read(filePath)
    calcNumberOfPotions(data)
  end
end
