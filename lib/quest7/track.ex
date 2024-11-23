defmodule Quest7.Track do
  alias Quest7.Plan

  def init(input) do
    [topRow | rest] =
      String.split(input, "\n") |> Enum.map(&String.trim/1) |> Enum.filter(&(&1 != ""))

    middle = rest |> Enum.take(length(rest) - 1)
    rightCol = middle |> Enum.map(&String.last/1) |> List.to_string()
    bottomRow = rest |> List.last() |> String.reverse()
    leftCol = middle |> Enum.map(&String.first/1) |> Enum.reverse() |> List.to_string()

    wrongStart = topRow <> rightCol <> bottomRow <> leftCol
    String.replace(wrongStart, "S", "") <> "S"
  end

  def run(track, plan, times, start \\ 10)
  def run(_, _, 0, _), do: 0
  # assumes plan has same length as track n times

  def run(track, plan, times, start) do
    {thisRound, restPlan} = Enum.split(plan.plan, String.length(track))

    modifiedPlan =
      %Plan{
        plan
        | plan: Enum.zip_with(String.codepoints(track), thisRound, &modify/2)
      }

    {values, lastValue} = Plan.run(modifiedPlan, start)

    Enum.sum(values) + run(track, %Plan{plan | plan: restPlan}, times - 1, lastValue)
  end

  defp modify("S", action), do: action
  defp modify("=", action), do: action
  defp modify("+", _), do: "+"
  defp modify("-", _), do: "-"
end
