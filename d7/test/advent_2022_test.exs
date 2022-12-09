defmodule Advent2022Test do
  use ExUnit.Case
  doctest Advent2022

  test "parse_input" do
    result =
      Advent2022.read_input("input.test")
      |> Advent2022.parse_input()

    assert result == [
             ["$ cd /"],
             ["$ ls", "dir a", "14848514 b.txt", "8504156 c.dat", "dir d"],
             ["$ cd a"],
             ["$ ls", "dir e", "29116 f", "2557 g", "62596 h.lst"],
             ["$ cd e"],
             ["$ ls", "584 i"],
             ["$ cd .."],
             ["$ cd .."],
             ["$ cd d"],
             ["$ ls", "4060174 j", "8033020 d.log", "5626152 d.ext", "7214296 k"]
           ]
  end
end
