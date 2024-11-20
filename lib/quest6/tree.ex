defmodule Quest6.Node do
  alias __MODULE__

  defstruct children: nil, label: nil

  @spec new(String.t()) :: %Node{}
  def new(label) do
    %Node{label: label}
  end

  @spec set_children(%Node{}, list(%Node{})) :: %Node{}
  def set_children(node = %Node{}, children) do
    %Quest6.Node{node | children: children}
  end

  def leaf?(node = %Node{}), do: node.children == nil

  @spec get_label(%Node{}) :: String.t()
  def get_label(node), do: node.label
end

defmodule Quest6.Tree do
  alias Quest6.Node

  def parse(input) do
    flat_nodes =
      input
      |> String.split("\n")
      |> Enum.map(&String.trim/1)
      |> Enum.filter(&(&1 != ""))
      |> Enum.filter(&(!(String.contains?(&1, "ANT") && String.contains?(&1, "BUG"))))
      |> Enum.map(&get_node_data/1)

    root = Enum.find(flat_nodes, fn {label, _} -> label == "RR" end)

    if root == nil do
      nil
    else
      {label, children} = root
      build_tree(Node.new(label), children, flat_nodes)
    end
  end

  defp build_tree(node, children, _flat_nodes) when children == [], do: node

  defp build_tree(root, child_labels, flat_nodes) do
    children =
      for child_label <- child_labels do
        child_node =
          Node.new(child_label)

        flat_child_node =
          Enum.find(flat_nodes, fn {label, _} -> label == child_label end)

        if flat_child_node == nil do
          child_node
        else
          {_, node_children} = flat_child_node
          build_tree(child_node, node_children, flat_nodes)
        end
      end

    Node.set_children(root, children)
  end

  defp get_node_data(row) do
    [label, childData] = String.split(row, ":")
    children = String.split(childData, ",")
    {label, children}
  end

  def get_all_branches(node, nodeSeparator \\ "") do
    get_all_branches(node, "", fn node -> node.label <> nodeSeparator end)
  end

  defp get_all_branches(node, trace, get_trace_for_node) do
    newTrace = trace <> get_trace_for_node.(node)

    if Node.leaf?(node) do
      newTrace
    else
      for child <- node.children do
        get_all_branches(child, newTrace, get_trace_for_node)
      end
      |> List.flatten()
    end
  end

  defp update_count(branch, map) do
    Map.update(
      map,
      String.length(branch),
      {1, [branch]},
      fn {count, branches} ->
        {count + 1, [branch | branches]}
      end
    )
  end

  def count_branch_lengths(branches) do
    Enum.reduce(branches, %{}, &update_count/2)
  end

  def find_branch_with_unique_length(branches) do
    map = count_branch_lengths(branches)
    value = Map.values(map) |> Enum.find(fn {count, _} -> count == 1 end)
    value |> elem(1) |> Enum.at(0)
  end
end
