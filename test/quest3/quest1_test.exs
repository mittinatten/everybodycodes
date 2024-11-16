defmodule Quest1Tests do
  use ExUnit.Case

  test "sums potions in part 1" do
    assert Quest1.Part1.calcNumberOfPotions("") == 0
    assert Quest1.Part1.calcNumberOfPotions("AAAA") == 0
    assert Quest1.Part1.calcNumberOfPotions("B") == 1
    assert Quest1.Part1.calcNumberOfPotions("C") == 3
    assert Quest1.Part1.calcNumberOfPotions("ABBAC") == 5
  end

  test "sums potions in part 2" do
    assert Quest1.Part2.calcNumberOfPotions("") == 0
    assert Quest1.Part2.calcNumberOfPotions("\n") == 0
    assert Quest1.Part2.calcNumberOfPotions("X") == 0
    assert Quest1.Part2.calcNumberOfPotions("D") == 0
    assert Quest1.Part2.calcNumberOfPotions("Ax") == 0
    assert Quest1.Part2.calcNumberOfPotions("AA") == 2
    assert Quest1.Part2.calcNumberOfPotions("xA") == 0
    assert Quest1.Part2.calcNumberOfPotions("xB") == 1
    assert Quest1.Part2.calcNumberOfPotions("BB") == 4
    assert Quest1.Part2.calcNumberOfPotions("DD") == 12
    assert Quest1.Part2.calcNumberOfPotions("BC") == 6
    assert Quest1.Part2.calcNumberOfPotions("CA") == 5
    assert Quest1.Part2.calcNumberOfPotions("Dx") == 5
    assert Quest1.Part2.calcNumberOfPotions("AxBCDDCAxD") == 28
  end

  test "get correct triples strength" do
    assert Quest1.strengthTriple(["x", "B", "x"]) == 1
    assert Quest1.strengthTriple(["A", "A", "A"]) == 6
    assert Quest1.strengthTriple(["A", "x", "A"]) == 2
    assert Quest1.strengthTriple(["B", "C", "D"]) == 15
  end

  test "sums potions in part 3" do
    assert Quest1.Part3.calcNumberOfPotions("") == 0
    assert Quest1.Part3.calcNumberOfPotions("D") == 0
    assert Quest1.Part3.calcNumberOfPotions("xBx") == 1
    assert Quest1.Part3.calcNumberOfPotions("xBxAAABCDxCC") == 30
  end
end
