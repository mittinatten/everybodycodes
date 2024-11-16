defmodule Quest3Part3Tests do
  use ExUnit.Case

  test "get correct result for example input in part 1" do
    assert Quest3.Part3.getTotalDigout("..........
    ..###.##..
    ...####...
    ..######..
    ..######..
    ...####...
    ..........") == 29
  end
end
