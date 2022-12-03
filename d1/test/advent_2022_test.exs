defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "parse_input" do
    assert Advent2022.parse_input(["1", "", "2", "3"]) == [[1], [2, 3]]
  end

  test "reduce_by_elf" do
    assert Advent2022.reduce_by_elf([[1], [2, 3]]) == [1, 5]
  end

  test "part1" do
    assert Advent2022.part1([1, 5]) == 5
  end

  test "part2" do
    assert Advent2022.part2([1, 5, 6, 7, 8]) == 21
  end
end
