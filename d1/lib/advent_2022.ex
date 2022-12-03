defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  @doc """
  part 2: the sum of the top 3 of the set
  """
  def part2(data) do
    data
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(0, &+/2)
  end

  @doc """
  part 1: the max value of the set
  """
  def part1(data) do
    data
    |> Enum.max()
  end

  @doc """
  reduce_by_elf
  """
  def reduce_by_elf(data) do
    data
    |> Enum.map(fn group -> Enum.reduce(group, 0, &+/2) end)
  end

  @doc """
  Parse the input
  """
  def parse_input(input) do
    grouped_by_paragraph = input
    |> Enum.chunk_by(&(&1 != ""))
    |> Enum.filter(&(&1 != [""]))

    Enum.map(grouped_by_paragraph, fn group ->
      Enum.map(group, &String.to_integer/1)
    end)      
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
    |> reduce_by_elf()

    processed_data
    |> part1()
    |> IO.inspect()

    processed_data
    |> part2()
    |> IO.inspect()

    processes
  end
end
