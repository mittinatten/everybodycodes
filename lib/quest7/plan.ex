defmodule Quest7.Plan do
  alias __MODULE__

  defstruct plan: [], label: nil

  def init(inputRow, length \\ nil) do
    trimmed = String.trim(inputRow)
    [label, rawPlan] = String.split(trimmed, ":")
    singlePlan = String.split(rawPlan, ",")

    length =
      if length == nil, do: length(singlePlan), else: length

    plan =
      List.duplicate(singlePlan, div(length, length(singlePlan)) + 1)
      |> List.flatten()
      |> Enum.take(length)

    %Plan{plan: plan, label: label}
  end

  def sum(plan, start) do
    run(plan, start)
    |> elem(0)
    |> Enum.sum()
  end

  def run(plan, start) do
    plan.plan
    |> Enum.map_reduce(start, fn action, sum ->
      value = act(action, sum)
      {value, value}
    end)
  end

  defp act("+", sum), do: sum + 1
  defp act("=", sum), do: sum
  defp act("-", 0), do: 0
  defp act("-", sum), do: sum - 1
end
