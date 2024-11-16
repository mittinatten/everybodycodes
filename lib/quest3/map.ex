defmodule Quest3.Map do
  def init(input) do
    if String.length(input) == 0 do
      Arrays.new([])
    else
      String.split(input, "\n") |> trimAndBuildRows()
    end
  end

  def initRoyal(input) do
    if String.length(input) == 0 do
      Arrays.new([])
    else
      # need to pad map with "."
      rows = String.split(input, "\n") |> Enum.map(&("." <> &1 <> "."))
      emptyRow = String.duplicate(".", String.length(Enum.at(rows, 0)))
      rows = [emptyRow | rows] ++ [emptyRow]
      rows |> trimAndBuildRows()
    end
  end

  defp trimAndBuildRows(rows) do
    rows
    |> Enum.map(&String.trim(&1))
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&initRow(&1))
    |> Enum.into(Arrays.new())
  end

  def initRow(row) do
    String.codepoints(row)
    |> Enum.map(&if &1 == "#", do: 0, else: :empty)
    |> Enum.into(Arrays.new())
  end

  defp digRecursive(map, neighborFunction) do
    next = dig(map, neighborFunction)

    if next != map do
      digRecursive(next, neighborFunction)
    else
      next
    end
  end

  def digAllTheWay(map) do
    digRecursive(map, &getNeighbours/2)
  end

  def digAllTheWayRoyal(map) do
    digRecursive(map, &getNeighborsRoyal/2)
  end

  def dig(map, neighborFunction \\ &getNeighbours/2) do
    height = Enum.count(map)

    for i <- 0..(height - 1) do
      width = Enum.count(map[i])

      for j <- 0..(width - 1) do
        value = map[i][j]

        if value == :empty do
          :empty
        else
          nb = neighborFunction.({i, j}, {height, width})

          if Enum.any?(nb, &(value - digDepthAt(map, &1) > 0)),
            do: value,
            else: value + 1
        end
      end
      |> Enum.into(Arrays.new())
    end
    |> Enum.into(Arrays.new())
  end

  defp digDepthAt(map, {i, j}) do
    depth(map[i][j])
  end

  defp depth(value) do
    if value == :empty || value == nil, do: 0, else: value
  end

  defp getNeighbours({i, j}, {h, w}) do
    result = if i > 0, do: [{i - 1, j}], else: []
    result = if j > 0, do: [{i, j - 1} | result], else: result
    result = if i < h - 1, do: [{i + 1, j} | result], else: result
    if j < w - 1, do: [{i, j + 1} | result], else: result
  end

  def getNeighborsRoyal({i, j}, {h, w}) do
    if i < 0 || i >= h || j < 0 || j >= w do
      []
    else
      result = getNeighbours({i, j}, {h, w})
      result = if i > 0 && j > 0, do: [{i - 1, j - 1} | result], else: result
      result = if i > 0 && j < w - 1, do: [{i - 1, j + 1} | result], else: result
      result = if i < h - 1 && j > 0, do: [{i + 1, j - 1} | result], else: result
      if i < h - 1 && j < w - 1, do: [{i + 1, j + 1} | result], else: result
    end
  end

  def volume(map) do
    Enum.map(map, fn row -> Enum.map(row, &depth(&1)) |> Enum.sum() end) |> Enum.sum()
  end

  def to_string(map) do
    map
    |> Enum.map(fn row ->
      Enum.map(
        row,
        &if &1 == nil do
          "."
        else
          Integer.to_string(&1)
        end
      )
      |> List.to_string()
    end)
  end
end
