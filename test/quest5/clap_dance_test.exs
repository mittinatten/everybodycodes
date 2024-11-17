defmodule Quest5.ClapDanceTest do
  use ExUnit.Case
  import Quest5.ClapDance
  alias Quest5.ClapDance

  test "init() handles empty input" do
    assert init("") == %ClapDance{columns: [[], [], [], []]}
  end

  test "init() handles single row input" do
    assert init("1 2 3 4") == %ClapDance{columns: [[1], [2], [3], [4]]}
  end

  test "init() handles multi row input" do
    assert init("1 2 3 4\n5 6 7 8\n9 10 11 12") == %ClapDance{
             columns: [
               [1, 5, 9],
               [2, 6, 10],
               [3, 7, 11],
               [4, 8, 12]
             ]
           }
  end

  test "step() from initial state sets up first round" do
    assert step(%ClapDance{columns: [[1], [2], [3], [4]]}) == %ClapDance{
             columns: [[], [2], [3], [4]],
             columnIndex: 1,
             column: [2],
             clapper: 1,
             round: 1,
             count: 1
           }
  end

  test "step() with finished column sets up next column" do
    assert step(%ClapDance{columns: [[1], [2], [3], [4]], columnIndex: 1, count: 1}) ==
             %ClapDance{
               columns: [[1], [], [3], [4]],
               columnIndex: 2,
               column: [3],
               clapper: 2,
               round: 1,
               count: 1
             }
  end

  test "step() with finished column sets up next column downwards" do
    assert step(%ClapDance{
             columns: [[1], [2], [3], [4]],
             columnIndex: 1,
             count: 1,
             direction: :up
           }) ==
             %ClapDance{
               columns: [[1], [], [3], [4]],
               columnIndex: 2,
               column: [3],
               clapper: 2,
               round: 1,
               count: 1,
               direction: :down
             }
  end

  test "step() with finished column wraps tp next column" do
    assert step(%ClapDance{columns: [[1], [2], [3], [4]], columnIndex: 3, count: 1}) ==
             %ClapDance{
               columns: [[1], [2], [3], []],
               columnIndex: 0,
               column: [1],
               clapper: 4,
               round: 1,
               count: 1
             }
  end

  test "step() with clapper but no column moves to next column" do
    assert step(%ClapDance{columns: [[1], [2], [3], [4]], columnIndex: 1, clapper: 8, round: 1}) ==
             %ClapDance{
               columns: [[1], [2], [3], [4]],
               columnIndex: 2,
               column: [3],
               clapper: 8,
               round: 1
             }
  end

  test "step() with clapper but no column wraps to next column" do
    assert step(%ClapDance{columns: [[1], [2], [3], [4]], columnIndex: 3, clapper: 8, round: 1}) ==
             %ClapDance{
               columns: [[1], [2], [3], [4]],
               columnIndex: 0,
               column: [1],
               clapper: 8,
               round: 1
             }
  end

  test "step() when clapper matches count going downwards inserts clapper and shouts" do
    assert step(%ClapDance{
             columns: [[1], [2], [3], [4]],
             columnIndex: 1,
             clapper: 8,
             round: 1,
             count: 8,
             rowIndex: 0,
             column: [2]
           }) == %ClapDance{
             columns: [[1], [8, 2], [3], [4]],
             round: 1,
             columnIndex: 1,
             column: nil,
             clapper: nil,
             shout: "1834"
           }
  end

  test "step() when clapper matches count going upwards inserts clapper and shouts" do
    assert step(%ClapDance{
             columns: [[1], [2], [3], [4]],
             columnIndex: 1,
             clapper: 8,
             round: 1,
             count: 8,
             rowIndex: 0,
             column: [2],
             direction: :up
           }) == %ClapDance{
             columns: [[1], [2, 8], [3], [4]],
             round: 1,
             columnIndex: 1,
             column: nil,
             clapper: nil,
             direction: :up,
             shout: "1234"
           }
  end

  test "step() with finished round sets up next round" do
    assert step(%ClapDance{
             columns: [[1], [2], [3], [4]],
             columnIndex: 1,
             column: nil,
             clapper: nil,
             count: 5,
             round: 3
           }) ==
             %ClapDance{
               columns: [[1], [], [3], [4]],
               columnIndex: 2,
               column: [3],
               clapper: 2,
               count: 1,
               round: 4
             }
  end

  test "step() when going downwards moves down column" do
    assert step(%ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             clapper: 8,
             count: 1,
             rowIndex: 0,
             column: [2, 3],
             direction: :down
           }) == %ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             column: [2, 3],
             count: 2,
             rowIndex: 1,
             clapper: 8
           }
  end

  test "step() when going downwards beyond column changes direction down column" do
    assert step(%ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             clapper: 8,
             count: 1,
             rowIndex: 1,
             column: [2, 3],
             direction: :down
           }) == %ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             column: [2, 3],
             count: 2,
             rowIndex: 1,
             clapper: 8,
             direction: :up
           }
  end

  test "step() when going upward moves up column" do
    assert step(%ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             clapper: 8,
             count: 1,
             rowIndex: 1,
             column: [2, 3],
             direction: :up
           }) == %ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             column: [2, 3],
             count: 2,
             rowIndex: 0,
             clapper: 8,
             direction: :up
           }
  end

  test "step() when going upward beyond column prepares for next column" do
    assert step(%ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             clapper: 8,
             count: 1,
             rowIndex: 0,
             column: [2, 3],
             direction: :up
           }) == %ClapDance{
             columns: [[1], [2, 3], [3], [4]],
             column: nil,
             count: 1,
             rowIndex: 0,
             clapper: 8,
             direction: :up
           }
  end
end
