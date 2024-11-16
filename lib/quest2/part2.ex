defmodule Quest2.Part2 do
  def countLettersWithReverse(rows, words) do
    Quest2.getAllMatchingLetters(rows, words)
    |> Enum.map(fn row -> Enum.sum(row) end)
    |> Enum.sum()
  end

  def checkShield(input) do
    words = Quest2.parseWordsSpec(input)
    [_, _ | rows] = String.split(input, "\n")

    countLettersWithReverse(rows, words)
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    checkShield(data)
  end
end
