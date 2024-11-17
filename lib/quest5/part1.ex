defmodule Quest5.Part1 do
  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    dance = Quest5.ClapDance.init(data)
    Quest5.ClapDance.run(dance, 10)
  end
end
