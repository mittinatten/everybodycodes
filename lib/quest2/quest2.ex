defmodule Quest2 do
  import Bitwise

  def getWords(input) do
    if input == "" || String.starts_with?(input, "WORDS:") == false do
      []
    else
      [firstLine | _] = String.split(input, "\n")
      [_, words] = String.split(firstLine, "WORDS:")

      String.split(words, ",")
      |> Enum.filter(fn word -> word != "" end)
      |> Enum.map(fn word -> String.trim(word) end)
    end
  end

  def countWords(rows, words) do
    words
    |> Enum.map(fn word ->
      {:ok, regex} = Regex.compile(word)

      rows
      |> Enum.map(fn row ->
        Regex.scan(regex, row) |> length
      end)
      |> Enum.sum()
    end)
    |> Enum.sum()
  end

  def getAllMatchingLetters(rows, words) do
    Enum.map(rows, fn row ->
      Enum.flat_map(words, fn word ->
        [
          findLettersForWord(row, word),
          findLettersForWord(String.reverse(row), word) |> Enum.reverse()
        ]
      end)
      |> mergeAllRows()
    end)
  end

  def getAllMatchingLettersCircular(rows, words) do
    Enum.map(rows, fn row ->
      Enum.flat_map(words, fn word ->
        # this is not the most efficient way, but good enough for now
        for shift <- 0..max(String.length(word) - 1, 0) do
          rotatedLeft = RotateList.string_left(row, shift)

          mergeAllRows([
            findLettersForWord(String.reverse(rotatedLeft), word)
            |> Enum.reverse()
            |> RotateList.right(shift),
            findLettersForWord(rotatedLeft, word) |> RotateList.right(shift)
          ])
        end
      end)
      |> mergeAllRows()
    end)
  end

  defp mergeAllRows(rows) when length(rows) <= 1, do: rows

  defp mergeAllRows([first | rest]) do
    rest
    |> Enum.reduce(first, fn acc, row -> mergeRows(acc, row) end)
  end

  defp setInRange(list, {start, length}, value) do
    0..(length - 1)
    |> Enum.reduce(list, fn index, result ->
      List.replace_at(result, start + index, value)
    end)
  end

  def findLettersForWord(row, word) do
    size = String.length(row)
    startingValue = List.duplicate(0, size)

    {:ok, regex} = Regex.compile(word)

    Regex.scan(regex, row, return: :index)
    |> Enum.reduce(
      startingValue,
      fn [range], acc -> setInRange(acc, range, 1) end
    )
  end

  defp mergeRows(row1, row2) do
    Enum.zip_with(row1, row2, fn a, b -> bor(a, b) end)
  end
end
