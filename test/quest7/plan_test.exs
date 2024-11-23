defmodule Quest7.PlanTest do
  use ExUnit.Case
  alias Quest7.Plan

  test "inits from simple input" do
    assert Plan.init("A:+", 1) == %Plan{plan: ["+"], label: "A"}
  end

  test "inits from input with several actions" do
    assert Plan.init("A:+,-", 2) == %Plan{plan: ["+", "-"], label: "A"}
  end

  test "init() repeats plan until length reached" do
    assert Plan.init("A:+", 3) == %Plan{plan: ["+", "+", "+"], label: "A"}
  end

  test "init() repeats plan until length reached when not exact multiple" do
    assert Plan.init("A:+,-", 3) == %Plan{plan: ["+", "-", "+"], label: "A"}

    assert Plan.init("A:+,-,=", 7) == %Plan{
             plan: ["+", "-", "=", "+", "-", "=", "+"],
             label: "A"
           }
  end

  test "can sum over simple plan" do
    plan = Plan.init("A:+", 1)
    assert Plan.sum(plan, 10) == 11
  end

  test "can sum over sample input" do
    plan = Plan.init("A:+,-,=,=", 10)
    assert Plan.sum(plan, 10) == 103

    plan = Plan.init("B:+,=,-,+", 10)
    assert Plan.sum(plan, 10) == 116

    plan = Plan.init("C:=,-,+,+", 10)
    assert Plan.sum(plan, 10) == 107

    plan = Plan.init("D:=,=,=,+", 10)
    assert Plan.sum(plan, 10) == 110
  end
end
