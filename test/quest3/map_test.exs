defmodule Quest3MapTests do
  use ExUnit.Case

  test "init() reads zero tile map from input" do
    empty = Quest3.Map.init("")
    assert Enum.count(empty) == 0
  end

  test "init() reads empty single tile map from input" do
    single = Quest3.Map.init(".")
    assert Enum.count(single) == 1
    assert Enum.count(single[0]) == 1
    assert single[0][0] == :empty
  end

  test "init() reads loaded single tile map from input" do
    single = Quest3.Map.init("#")
    assert Enum.count(single) == 1
    assert Enum.count(single[0]) == 1
    assert single[0][0] == 0
  end

  test "init() handles trailing new lines" do
    map = Quest3.Map.init("#\n\n")
    assert Enum.count(map) == 1
    assert Enum.count(map[0]) == 1
    assert map[0][0] == 0
  end

  test "init() handles multiline map" do
    map = Quest3.Map.init(".#.\n##.\n..#")
    assert Enum.count(map) == 3
    assert Arrays.to_list(map[0]) == [:empty, 0, :empty]
    assert Arrays.to_list(map[1]) == [0, 0, :empty]
    assert Arrays.to_list(map[2]) == [:empty, :empty, 0]
  end

  test "dig() handles empty single tile map" do
    single = Quest3.Map.init(".")
    dug = Quest3.Map.dig(single)
    assert dug[0][0] == :empty
  end

  test "dig() handles loaded single tile map" do
    single = Quest3.Map.init("#")
    assert single[0][0] == 0
    dug = Quest3.Map.dig(single)
    assert dug[0][0] == 1
  end

  test "dig() doesn't dig if slope too high" do
    map = Quest3.Map.init(".#.\n##.\n..#")

    dug = Quest3.Map.dig(map)
    assert Arrays.to_list(dug[0]) == [:empty, 1, :empty]
    assert Arrays.to_list(dug[1]) == [1, 1, :empty]
    assert Arrays.to_list(dug[2]) == [:empty, :empty, 1]
  end

  test "dig() digs if possible in composite map" do
    map = Quest3.Map.init(".#.\n###\n.#.")
    dug = Quest3.Map.dig(map)
    assert Arrays.to_list(dug[0]) == [:empty, 1, :empty]
    assert Arrays.to_list(dug[1]) == [1, 1, 1]
    assert Arrays.to_list(dug[2]) == [:empty, 1, :empty]
  end

  test "dig() does nothing if applied to dug out map" do
    map = Quest3.Map.init(".#.\n###\n.#.")
    dug = Quest3.Map.dig(map) |> Quest3.Map.dig() |> Quest3.Map.dig()
    assert Arrays.to_list(dug[0]) == [:empty, 1, :empty]
    assert Arrays.to_list(dug[1]) == [1, 2, 1]
    assert Arrays.to_list(dug[2]) == [:empty, 1, :empty]
  end

  test "dig() can dig deeper when terrain allows it" do
    map = Quest3.Map.init("..#..\n.###.\n#####\n.###.\n..#..")
    dug = Quest3.Map.dig(map) |> Quest3.Map.dig() |> Quest3.Map.dig()
    assert Arrays.to_list(dug[0]) == [:empty, :empty, 1, :empty, :empty]
    assert Arrays.to_list(dug[1]) == [:empty, 1, 2, 1, :empty]
    assert Arrays.to_list(dug[2]) == [1, 2, 3, 2, 1]
    assert Arrays.to_list(dug[3]) == [:empty, 1, 2, 1, :empty]
    assert Arrays.to_list(dug[4]) == [:empty, :empty, 1, :empty, :empty]
  end

  test "digAllTheWay() digs until finished" do
    map = Quest3.Map.init("..#..\n.###.\n#####\n.###.\n..#..")
    dug = Quest3.Map.digAllTheWay(map)
    assert Arrays.to_list(dug[0]) == [:empty, :empty, 1, :empty, :empty]
    assert Arrays.to_list(dug[1]) == [:empty, 1, 2, 1, :empty]
    assert Arrays.to_list(dug[2]) == [1, 2, 3, 2, 1]
    assert Arrays.to_list(dug[3]) == [:empty, 1, 2, 1, :empty]
    assert Arrays.to_list(dug[4]) == [:empty, :empty, 1, :empty, :empty]
  end

  test "volume() returns number of dug out cubes" do
    map = Quest3.Map.init(".#.\n###\n.#.")
    dug = Quest3.Map.dig(map) |> Quest3.Map.dig()
    assert Quest3.Map.volume(dug) == 6
  end
end
