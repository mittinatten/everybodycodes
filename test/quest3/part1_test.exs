defmodule Quest3Part1Tests do
  use ExUnit.Case

  test "get correct result for example input in part 1" do
    assert Quest3.Part1.getTotalDigout("..........
    ..###.##..
    ...####...
    ..######..
    ..######..
    ...####...
    ..........") == 35
  end
end
