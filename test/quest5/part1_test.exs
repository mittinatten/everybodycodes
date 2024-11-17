defmodule Quest5.Part1Test do
  use ExUnit.Case

  test "run() on example data gives right result" do
    dance = Quest5.ClapDance.init("2 3 4 5\n3 4 5 2\n4 5 2 3\n5 2 3 4")
    result = Quest5.ClapDance.run(dance, 10)

    assert result.shout == "2323"
  end
end
