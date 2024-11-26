defmodule Quest15.Map do
  alias __MODULE__
  defstruct tiles: nil, door: nil, width: 0, height: 0

  def init(input) do
    if String.length(input) == 0 do
      %Map{tiles: Arrays.new([])}
    else
      tiles = String.split(input, "\n") |> trim_and_build_rows()

      set_door(%Map{
        tiles: tiles,
        door: nil,
        width: Enum.count(tiles[0]),
        height: Enum.count(tiles)
      })
    end
  end

  defp trim_and_build_rows(rows) do
    rows
    |> Enum.map(&String.trim(&1))
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&init_row(&1))
    |> Enum.into(Arrays.new())
  end

  defp init_row(row) do
    String.codepoints(row)
    |> Enum.map(
      &case &1 do
        "#" -> :bush
        "." -> :path
        "H" -> :herb
      end
    )
    |> Enum.into(Arrays.new())
  end

  defp set_door(map = %Map{}) do
    door = get_frame(map) |> Enum.find(fn {i, j} -> map.tiles[i][j] == :path end)
    %Map{map | door: door}
  end

  defp get_frame(map = %Map{}) do
    top_bottom =
      for i <- 0..(map.width - 1) do
        [{0, i}, {map.height - 1, i}]
      end
      |> List.flatten()

    middle =
      for j <- 1..(map.height - 2) do
        [{j, 0}, {j, map.width - 1}]
      end
      |> List.flatten()

    top_bottom ++ middle
  end

  def get_neighbours(map = %Map{}, {i, j}) do
    h = map.height
    w = map.width
    result = if i > 0, do: [{i - 1, j}], else: []
    result = if j > 0, do: [{i, j - 1} | result], else: result
    result = if i < h - 1, do: [{i + 1, j} | result], else: result
    result = if j < w - 1, do: [{i, j + 1} | result], else: result

    result
    |> Enum.filter(fn nb ->
      case get_tile(map, nb) do
        :path -> true
        :herb -> true
        :bush -> false
      end
    end)
  end

  def get_tile(map = %Map{}, {i, j}) do
    map.tiles[i][j]
  end

  def get_herbs(map = %Map{}) do
    # what's a cleaner way to do this? (using reduce?)
    for i <- 0..(map.height - 1) do
      for j <- 0..(map.width - 1) do
        if map.tiles[i][j] == :herb, do: {i, j}
      end
      |> Enum.filter(&(&1 != nil))
    end
    |> List.flatten()
  end
end
