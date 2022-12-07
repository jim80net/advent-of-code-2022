defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "part2" do
    assert Advent2022.part2([[2..4, 6..8], [2..3, 4..5]]) == 0
    assert Advent2022.part2([[2..4, 2..8], [2..3, 4..5]]) == 1
    assert Advent2022.part2([[2..4, 3..5], [2..3, 4..5]]) == 1    
  end

  test "overlap?" do
    assert Advent2022.overlap?(2..4, 6..8) == false
    assert Advent2022.overlap?(2..4, 3..8) == true
  end

  test "part1" do
    assert Advent2022.part1([[2..4, 6..8], [2..3, 4..5]]) == 0
    assert Advent2022.part1([[2..4, 2..8], [2..3, 4..5]]) == 1
    assert Advent2022.part1([[2..4, 2..3], [2..3, 4..5]]) == 1    
  end

  test "is_subset?/2" do
    assert Advent2022.is_subset?(2..4, 6..8) == false
    assert Advent2022.is_subset?(2..4, 1..8) == true
  end

  test "parse_input" do
    result = Advent2022.read_input("input.test")
    |> Enum.take(2)
    |> Advent2022.parse_input()

    assert result == [[2..4, 6..8], [2..3, 4..5]]
  end

end
