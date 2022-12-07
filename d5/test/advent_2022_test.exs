defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "get_starting_state" do
    result =
      Advent2022.read_input("input.test")
      |> Advent2022.get_starting_state()

    assert result == ['NZ', 'DCM', 'P']
  end
end
