defmodule Quest5.Part2Test do
  use ExUnit.Case

  test "part 2 example data gives right result" do
    assert Quest5.Part2.calculate("2 3 4 5\n6 7 8 9") == 50_877_075
  end
end
