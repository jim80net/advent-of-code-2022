defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  def part2(data) do
    data
    |> Enum.map(fn [left, right] -> overlap?(left, right) || overlap?(right, left) end)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  @doc """
  overlap? returns true if the two ranges overlap.
  """
  def overlap?(left, right) do
    first..last = left
    Enum.member?(right, first) or Enum.member?(right, last)
  end

  @doc """
  part1: Count the number of range pairings where one range is a subset of the other range.
  """
  def part1(data) do
    data
    |> Enum.map(fn [left, right] -> is_subset?(left, right) || is_subset?(right, left) end)
    |> Enum.filter(fn x -> x == true end)
    |> Enum.count()
  end

  @doc """
  Return true if the left range is a subset of the right range.
  """
  def is_subset?(left, right) do
    first..last = left
    Enum.member?(right, first) and Enum.member?(right, last)
  end

  @doc """
  Generate the processed data
  """
  def parse_input(input) do
    input
    |> Enum.map(fn line ->
      line
      |> String.split(",")
      |> Enum.map(fn pair -> 
        pair
        |> String.split("-")
        |> Enum.map(fn num -> String.to_integer(num) end)
        |> case do
          [min, max] -> Range.new(min, max)
        end
      end)

     end) 
  end

  @doc """
  Read the input file
  """
  def read_input() do read_input('input') end
  def read_input(filename) do
    File.stream!(filename)
    |> Stream.map(&String.trim/1)
    |> Enum.to_list()
  end


  @doc """
  main function
  """
  def start(_type, _args) do
    children = []
    processes = Supervisor.start_link(children, strategy: :one_for_one, name: Advent2022.Supervisor)

    read_input()
    |> parse_input()
    |> part1()
    |> IO.inspect()

    read_input()
    |> parse_input()
    |> part2()
    |> IO.inspect()

    processes
  end
end
