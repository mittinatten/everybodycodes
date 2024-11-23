defmodule Quest7.Part2 do
  alias Quest7.Plan
  alias Quest7.Track

  def calculate(planInput, track) do
    planInput
    |> String.split("\n")
    |> Enum.filter(&(&1 != ""))
    |> Enum.map(&Plan.init(&1, String.length(track) * 10))
    |> Enum.map(fn plan -> {plan.label, Track.run(track, plan, 10, 10)} end)
    |> Enum.sort_by(&elem(&1, 1), :desc)
    |> Enum.map(fn {label, _} -> label end)
    |> List.to_string()
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)

    track =
      Track.init("S-=++=-==++=++=-=+=-=+=+=--=-=++=-==++=-+=-=+=-=+=+=++=-+==++=++=-=-=--
    -                                                                     -
    =                                                                     =
    +                                                                     +
    =                                                                     +
    +                                                                     =
    =                                                                     =
    -                                                                     -
    --==++++==+=+++-=+=-=+=-+-=+-=+-=+=-=+=--=+++=++=+++==++==--=+=++==+++-

")

    calculate(data, track)
  end
end
