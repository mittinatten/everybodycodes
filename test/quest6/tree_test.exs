defmodule Quest6.TreeTest do
  use ExUnit.Case
  alias Quest6.Tree
  alias Quest6.Node

  @leaf %Node{children: nil, label: "@"}

  test "parses empty tree" do
    assert Tree.parse("") == nil
  end

  test "parses single edge tree" do
    assert Tree.parse("RR:@") == %Node{label: "RR", children: [@leaf]}
  end

  test "parses 2-edge tree" do
    assert Tree.parse("RR:A\nA:@") == %Node{
             label: "RR",
             children: [
               %Node{
                 label: "A",
                 children: [@leaf]
               }
             ]
           }
  end

  test "parses simple branched tree" do
    assert Tree.parse("RR:A,B\nA:@\nB:@") == %Node{
             label: "RR",
             children: [
               %Node{label: "A", children: [@leaf]},
               %Node{label: "B", children: [@leaf]}
             ]
           }
  end

  test "parses complex branched tree" do
    assert Tree.parse("RR:A,B\nA:C,D\nB:@\nC:E\nD:@\nE:@,@") ==
             %Node{
               label: "RR",
               children: [
                 %Node{
                   label: "A",
                   children: [
                     %Node{
                       label: "C",
                       children: [
                         %Node{label: "E", children: [@leaf, @leaf]}
                       ]
                     },
                     %Node{label: "D", children: [@leaf]}
                   ]
                 },
                 %Node{label: "B", children: [@leaf]}
               ]
             }
  end

  test "can get all branches of simple tree" do
    node = Tree.parse("RR:A\nA:@")
    assert Tree.get_all_branches(node) == ["RRA@"]
  end

  test "can get all branches of complex tree" do
    node = Tree.parse("RR:A,B\nA:C,D\nB:@\nC:E\nD:@\nE:@,@")
    assert Tree.get_all_branches(node) == ["RRACE@", "RRACE@", "RRAD@", "RRB@"]
  end

  test "can get all branches of separated by semicolosn" do
    node = Tree.parse("RR:ABBA,B\nABBA:C,D\nB:@\nC:E\nD:@\nE:@,@")

    assert Tree.get_all_branches(node, ";") == [
             "RR;ABBA;C;E;@;",
             "RR;ABBA;C;E;@;",
             "RR;ABBA;D;@;",
             "RR;B;@;"
           ]
  end

  test "can get map of branch lengths" do
    node = Tree.parse("RR:A,B\nA:C,D\nB:@\nC:E\nD:@\nE:@,@")
    branches = Tree.get_all_branches(node)

    assert Tree.count_branch_lengths(branches) == %{
             4 => {1, ["RRB@"]},
             5 => {1, ["RRAD@"]},
             6 => {2, ["RRACE@", "RRACE@"]}
           }
  end

  test "can get branch with unique length" do
    node = Tree.parse("RR:A,B\nA:C,D\nB:@\nC:E\nD:@\nE:@,@")
    branches = Tree.get_all_branches(node)

    assert Tree.find_branch_with_unique_length(branches) == "RRB@"
  end

  test "can get branch with unique from part 1 test data" do
    node = Tree.parse("RR:A,B,C
    A:D,E
    B:F,@
    C:G,H
    D:@
    E:@
    F:@
    G:@
    H:@")
    branches = Tree.get_all_branches(node)

    assert Tree.find_branch_with_unique_length(branches) == "RRB@"
  end
end
