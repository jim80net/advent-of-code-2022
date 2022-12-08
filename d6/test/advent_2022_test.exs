defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "part2" do
    assert Advent2022.part2('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 19
    assert Advent2022.part2('bvwbjplbgvbhsrlpgdmjqwftvncz') == 23
    assert Advent2022.part2('nppdvjthqldpwncqszvftbrmjlhg') == 23
    assert Advent2022.part2('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg') == 29
    assert Advent2022.part2('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw') == 26
  end

  test "part1" do
    assert Advent2022.part1('mjqjpqmgbljsphdztnvjfqwrcgsmlb') == 7
    assert Advent2022.part1('bvwbjplbgvbhsrlpgdmjqwftvncz') == 5
    assert Advent2022.part1('nppdvjthqldpwncqszvftbrmjlhg') == 6
    assert Advent2022.part1('nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg') == 10
    assert Advent2022.part1('zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw') == 11
  end

  test "parse_input" do
    result =
      Advent2022.read_input("input.test")
      |> Advent2022.parse_input()

    assert result == 'mjqjpqmgbljsphdztnvjfqwrcgsmlb'
  end
end
