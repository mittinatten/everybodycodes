defmodule Quest7.TrackTest do
  use ExUnit.Case
  alias Quest7.Track
  alias Quest7.Plan

  test "parses sample input" do
    assert Track.init("S+===\n-   +\n=+=-+") == "+===++-=+=-S"
  end

  test "can run sample input" do
    track = Track.init("S+===\n-   +\n=+=-+")

    plan = Plan.init("A:+,-,=,=", String.length(track))
    assert Track.run(track, plan, 1) == 129
    plan = Plan.init("A:+,-,=,=", String.length(track) * 10)
    assert Track.run(track, plan, 10) == 1290

    plan = Plan.init("B:+,=,-,+", String.length(track))
    assert Track.run(track, plan, 1) == 148
    plan = Plan.init("B:+,=,-,+", String.length(track) * 10)
    assert Track.run(track, plan, 10) == 3640

    plan = Plan.init("C:=,-,+,+", String.length(track))
    assert Track.run(track, plan, 1) == 154
    plan = Plan.init("C:=,-,+,+", String.length(track) * 10)
    assert Track.run(track, plan, 10) == 3700

    plan = Plan.init("D:=,=,=,+", String.length(track))
    assert Track.run(track, plan, 1) == 158
    plan = Plan.init("D:=,=,=,+", String.length(track) * 10)
    assert Track.run(track, plan, 10) == 4280
  end
end
