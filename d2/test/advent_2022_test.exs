defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "parse_input" do
    assert Advent2022.parse_input(["A X", "B Y"]) == [["A", "X"], ["B", "Y"]]
  end

  test "score_match1" do
    assert Advent2022.score_match1(["A", "X"]) == 4
    assert Advent2022.score_match1(["A", "Y"]) == 8
    assert Advent2022.score_match1(["A", "Z"]) == 3
    assert Advent2022.score_match1(["B", "X"]) == 1
    assert Advent2022.score_match1(["B", "Y"]) == 5
    assert Advent2022.score_match1(["B", "Z"]) == 9
    assert Advent2022.score_match1(["C", "X"]) == 7
    assert Advent2022.score_match1(["C", "Y"]) == 2
    assert Advent2022.score_match1(["C", "Z"]) == 6
  end

  test "part1" do
    assert Advent2022.part1([["A", "Y"], ["B", "X"], ["C", "Z"]]) == 15
  end

  test "part2" do
    assert Advent2022.part2([["A", "Y"], ["B", "X"], ["C", "Z"]]) == 12
  end
end
