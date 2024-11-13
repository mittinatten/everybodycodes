defmodule Quest1 do
  @moduledoc """
  Helper functions for Quest1
  """

  def strengthSingle(c) do
    case c do
      "A" ->
        0

      "B" ->
        1

      "C" ->
        3

      "D" ->
        5

      _ ->
        0
    end
  end

  def strengthPair(pair) do
    case pair do
      ["x", a] -> strengthSingle(a)
      [a, "x"] -> strengthSingle(a)
      [a, b] -> strengthSingle(a) + strengthSingle(b) + 2
      _ -> 0
    end
  end

  def strengthTriple(triple) do
    case triple do
      ["x", a, b] -> strengthPair([a, b])
      [a, b, "x"] -> strengthPair([a, b])
      [a, "x", b] -> strengthPair([a, b])
      [a, b, c] -> strengthSingle(a) + strengthSingle(b) + strengthSingle(c) + 6
      _ -> 0
    end
  end
end
