defmodule Quest2.Part1 do
  def checkHelmet(input) do
    words = Quest2.parseWordsSpec(input)
    [_, _ | inscription] = String.split(input, "\n")
    Quest2.countWords(inscription, words)
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    checkHelmet(data)
  end
end
