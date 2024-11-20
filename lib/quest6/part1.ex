defmodule Quest6.Part1 do
  alias Quest6.Tree

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    node = Tree.parse(data)
    branches = Tree.get_all_branches(node)
    Tree.find_branch_with_unique_length(branches)
  end
end
