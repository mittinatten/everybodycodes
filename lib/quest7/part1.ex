defmodule Quest7.Part1 do
  alias Quest7.Plan

  defp rank(plans) do
    plans
    |> Enum.map(&{&1.label, Plan.sum(&1, 10)})
    |> Enum.sort_by(&elem(&1, 1), :desc)
    |> Enum.map(fn {label, _} -> label end)
    |> List.to_string()
  end

  def calculate(input) do
    input
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&Plan.init(&1, 10))
    |> rank
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    calculate(data)
  end
end
