defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "part1" do
    state = ['NZ', 'DCM', 'P']
    instructions = [
      {1, 1, 0},
      {3, 0, 2},
      {2, 1, 0},
      {1, 0, 1}
    ]
    # ['C', 'M', 'ZNDP']

    assert Advent2022.part1({state, instructions}) == 'CMZ'
  end

  test "parse_instructions" do
    result =
      Advent2022.read_input("input.test")
      |> Advent2022.parse_instructions()

    # {how many, from index, to index}
    assert result == [
             {1, 1, 0},
             {3, 0, 2},
             {2, 1, 0},
             {1, 0, 1}
           ]
  end

  test "get_starting_state" do
    result =
      Advent2022.read_input("input.test")
      |> Advent2022.get_starting_state()

    assert result == ['NZ', 'DCM', 'P']
  end
end
