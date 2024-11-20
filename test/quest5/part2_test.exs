defmodule Quest5.Part2Test do
  use ExUnit.Case

  # We have the wrong shout already by round 4, but can't see anthing wrong when I step through it manually 🤷‍♂️
  test "part 2 example data gives right result" do
    assert Quest5.Part2.calculate("2 3 4 5\n6 7 8 9") == 50_877_075
  end
end
