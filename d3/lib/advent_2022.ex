defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  def part1(data) do
    data
    |> Enum.map(&find_match/1)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end
    

  def convert_char_to_int(char) when char in ?A..?Z, do: char - ?A + 27
  def convert_char_to_int(char) when char in ?a..?z, do: char - ?a + 1

  @doc """
  Convert a letter to a priority number.
  a = 1, b = 2, ..., z = 26,
  A = 27, B = 28, ..., Z = 52
  """
  def priority(s) do
    s
    |> String.to_charlist
    |> Enum.at(0)
    |> convert_char_to_int()
  end

  @doc """
  Compare the two strings and return the first matching letter.
  """
  def find_match({a, b}) do
    b_list = String.codepoints(b)
    a
    |> String.codepoints()
    |> Enum.map(fn element -> if element in b_list, do: element, else: nil end)
    |> Enum.filter(fn element -> element != nil end)
    |> Enum.at(0)
  end


  @doc """
  Generate the processed data
  """
  def parse_input(input) do
    input
    |> Enum.map(fn line ->
      position = Integer.floor_div(String.length(line), 2)
      String.split_at(line, position)
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

    processed_data = read_input()
    |> parse_input()
    #|> IO.inspect()

    processed_data
    |> part1()
    |> IO.inspect()

    # processed_data
    # |> part2()
    # |> IO.inspect()

    processes
  end
end
