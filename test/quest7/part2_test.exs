defmodule Quest7.Part2Test do
  use ExUnit.Case

  test "should give correct result for test input" do
    track = Quest7.Track.init("S+===
    -   +
    =+=-+")

    assert Quest7.Part2.calculate(
             "A:+,-,=,=
    B:+,=,-,+
    C:=,-,+,+
    D:=,=,=,+",
             track
           ) == "DCBA"
  end
end
