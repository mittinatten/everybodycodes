defmodule Quest1.Part1 do
  def calcNumberOfPotions(input) do
    input
    |> String.codepoints()
    |> Enum.map(fn c -> Quest1.strengthSingle(c) end)
    |> Enum.sum()
  end

  def solve() do
    {:ok, data} = File.read(__DIR__ <> "/input1.txt")
    calcNumberOfPotions(data)
  end
end
