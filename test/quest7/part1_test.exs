defmodule Quest7.Part1Test do
  use ExUnit.Case

  test "should give correct result for test input" do
    assert Quest7.Part1.calculate("A:+,-,=,=
    B:+,=,-,+
    C:=,-,+,+
    D:=,=,=,+") == "BDCA"
  end
end
