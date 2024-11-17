defmodule Quest5.Part2 do
  def step(state, shoutMap \\ %{}) do
    next = Quest5.ClapDance.step(state)

    if next.round > state.round && state.shout != "" do
      IO.puts(state.shout)
      count = Map.get(shoutMap, state.shout, 0) + 1
      shoutMap = Map.put(shoutMap, state.shout, count)

      if count >= 2024 do
        IO.puts(Map.get(shoutMap, "6285"))
        String.to_integer(state.shout) * state.round
      else
        step(next, shoutMap)
      end
    else
      step(next, shoutMap)
    end
  end

  def calculate(data) do
    state = Quest5.ClapDance.init(data)
    IO.inspect(state)
    step(state)
  end

  def solve(inputFile) do
    {:ok, data} = File.read(inputFile)
    calculate(data)
  end
end
