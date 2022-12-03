defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "part1" do
    assert Advent2022.part1([{"vJrwpWtwJgWr", "hcsFMMfFFhFp"}, {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"}]) == 54
  end

  test "priority" do
    assert Advent2022.priority("a") == 1
    assert Advent2022.priority("Z") == 52
  end

  test "find_match" do
    assert Advent2022.find_match({"vJrwpWtwJgWr", "hcsFMMfFFhFp"}) == "p"
    assert Advent2022.find_match({"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"}) == "L"
  end

  test "parse_input" do
    result = Advent2022.read_input("input.test")
    |> Enum.take(2)
    |> Advent2022.parse_input()

    assert result == [{"vJrwpWtwJgWr", "hcsFMMfFFhFp"}, {"jqHRNqRjqzjGDLGL", "rsFMfFZSrLrFZsSL"}]
  end

end
