defmodule RotateList do
  def left(list, 0), do: list
  def left(list, _) when list == [], do: list
  def left(list, _) when length(list) == 1, do: list
  def left([h | t], 1), do: t ++ [h]
  def left([h | t], n), do: left(t ++ [h], n - 1)

  def right(list, 0), do: list
  def right(list, _) when list == [], do: list
  def right(list, _) when length(list) == 1, do: list
  def right(list, n), do: list |> Enum.reverse() |> left(n) |> Enum.reverse()

  def string_left(string, n), do: String.codepoints(string) |> left(n) |> List.to_string()
  def string_right(string, n), do: String.codepoints(string) |> right(n) |> List.to_string()
end
