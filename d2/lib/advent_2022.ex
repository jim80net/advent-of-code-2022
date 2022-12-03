defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application



  @doc """
  part 2: the sum of the set
  """
  def part2(data) do
    data
    |> Enum.map(&score_match2/1)
    |> Enum.sum()
  end

  @doc """
  score_match2
  A: Rock
  B: Paper
  C: Scissors

  X: Lose
  Y: Draw
  Z: Win
  
  # Translate to the score_match1 data
  AX: Rock + Lose = Rock + Scissors = AZ = 3
  AY: Rock + Draw = Rock + Rock = AX = 4
  AZ: Rock + Win = Rock + Paper = AY = 8
  BX: Paper + Lose = Paper + Rock = BX = 1
  BY: Paper + Draw = Paper + Paper = BY = 5
  BZ: Paper + Win = Paper + Scissors = BZ = 9
  CX: Scissors + Lose = Scissors + Paper = CY = 2
  CY: Scissors + Draw = Scissors + Scissors = CZ = 6
  CZ: Scissors + Win = Scissors + Rock = CX = 7
  """

  def score_match2([opponent, myself]) do
    case {opponent, myself} do
      {"A", "X"} -> score_match1(["A", "Z"])
      {"A", "Y"} -> score_match1(["A", "X"])
      {"A", "Z"} -> score_match1(["A", "Y"])
      {"B", "X"} -> score_match1(["B", "X"])
      {"B", "Y"} -> score_match1(["B", "Y"])
      {"B", "Z"} -> score_match1(["B", "Z"])
      {"C", "X"} -> score_match1(["C", "Y"])
      {"C", "Y"} -> score_match1(["C", "Z"])
      {"C", "Z"} -> score_match1(["C", "X"])
    end
  end

  @doc """
  part 1: the sum of the set
  """
  def part1(data) do
    data
    |> Enum.map(&score_match1/1)
    |> Enum.sum()
  end

  @doc """
  score_match1
  A: Rock
  B: Paper
  C: Scissors

  X: Rock (1)
  Y: Paper (2)
  Z: Scissors (3)

  AX: Rock vs Rock = Draw (3) + Rock (1) = 4
  AY: Rock vs Paper = Win (6) + Paper (2) = 8
  AZ: Rock vs Scissors = Lose (0) + Scissors (3) = 3
  BX: Paper vs Rock = Lose (0) + Rock (1) = 1
  BY: Paper vs Paper = Draw (3) + Paper (2) = 5
  BZ: Paper vs Scissors = Win (6) + Scissors (3) = 9
  CX: Scissors vs Rock = Win (6) + Rock (1) = 7
  CY: Scissors vs Paper = Lose (0) + Paper (2) = 2
  CZ: Scissors vs Scissors = Draw (3) + Scissors (3) = 6
  """
  def score_match1([opponent, myself]) do
    case {opponent, myself} do
      {"A", "X"} -> 4
      {"A", "Y"} -> 8
      {"A", "Z"} -> 3
      {"B", "X"} -> 1
      {"B", "Y"} -> 5
      {"B", "Z"} -> 9
      {"C", "X"} -> 7
      {"C", "Y"} -> 2
      {"C", "Z"} -> 6
    end
  end

  @doc """
  Parse the input
  """
  def parse_input(input) do
    input
    |> Enum.map(fn line -> String.split(line, " ") end) 
  end

  @doc """
  Read the input file
  """
  def read_input() do
    File.stream!("input")
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end


  @doc """
  main function
  """
  def start(_type, _args) do
    children = []
    processes = Supervisor.start_link(children, strategy: :one_for_one, name: Advent2022.Supervisor)

    processed_data = read_input()
    |> parse_input()
    # |> IO.inspect()

    processed_data
    |> part1()
    |> IO.inspect()

    processed_data
    |> part2()
    |> IO.inspect()

    processes
  end
end
