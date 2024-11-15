defmodule Quest2.Part3 do
  import Bitwise

  defp sumUpResults(rows, cols) do
    nrows = length(rows)
    ncols = length(cols)

    if nrows == 0 || ncols == 0 do
      0
    else
      for i <- 0..(nrows - 1) do
        row = Enum.at(rows, i)

        for j <- 0..(ncols - 1) do
          col = Enum.at(cols, j)

          bor(Enum.at(row, j) || 0, Enum.at(col, i) || 0)
        end
        |> Enum.sum()
      end
      |> Enum.sum()
    end
  end

  # List of string rows, is converted to a list of the corresponding columns
  # assumes all rows same length
  defp getCols(rows) do
    # Enum.zip_with(rows, fn x -> x end) # also works, but only for small lists
    rowCharacters = Enum.map(rows, &String.codepoints(&1))
    ncols = length(Enum.at(rowCharacters, 0) || [])

    for i <- 0..(ncols - 1) do
      for row <- rowCharacters do
        Enum.at(row, i)
      end
    end
    |> Enum.map(&List.to_string(&1))
  end

  def checkArmour(input) do
    words = Quest2.getWords(input)
    [_, _ | untrimmed] = String.split(input, "\n")

    rows = Enum.map(untrimmed, &String.trim(&1)) |> Enum.filter(&(&1 != ""))
    rowMatches = Quest2.getAllMatchingLettersCircular(rows, words)

    cols = getCols(rows)
    colMatches = Quest2.getAllMatchingLetters(cols, words)

    sumUpResults(rowMatches, colMatches)
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    checkArmour(data)
  end
end
