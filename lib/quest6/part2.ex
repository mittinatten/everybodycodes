defmodule Quest6.Part2 do
  alias Quest6.Tree

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    node = Tree.parse(data)
    branches = Tree.get_all_branches(node, ";")
    branch = Tree.find_branch_with_unique_length(branches)

    String.split(branch, ";")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&String.at(&1, 0))
    |> List.to_string()
  end
end
