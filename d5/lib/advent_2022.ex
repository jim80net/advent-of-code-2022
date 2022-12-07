defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  @doc """
  Generate the processed data from read_input
  """
  def get_starting_state({state, _instructions}) do
    state
    # Drop the last line which is the numbering of spaces
    |> Enum.drop(-1) 
    |> Enum.map(fn line ->
      line
      |> String.to_charlist()
      # Each slot is 4 characters wide. Example: [N] [Z] [ ] [ ]\n
      |> Enum.chunk_every(4)
      # Return either ?A..?Z or 0
      |> Enum.map(fn slot ->
        slot
        |> Enum.filter(fn char ->
          Enum.member?(?A..?Z, char)
        end)
        |> Enum.at(0) || 0
      end) 
    end)
    # At this point, we have a list of lists of the starting state,
    # where each row indicates the height of the space, and the column indicates the stack number.
    # Now, transpose the matrix so that the rows are the stack numbers, and the columns are the heights of the spaces.
    # Then, filter out the empty spaces
    |> Enum.zip()
    |> Enum.map(fn row -> 
        row
        |> Tuple.to_list()
        |> Enum.filter(fn element ->
          element != 0
        end)
    end)
  end

  @doc """
  Read the input file. 
  Returns  {state, instructions} = {list, list}
  """
  def read_input() do
    read_input('input')
  end

  def read_input(filename) do
    File.stream!(filename)
    # The first blank line is the end of the state
    |> Enum.split_while(fn line -> line != "\n" end)
  end

  @doc """
  main function
  """
  def start(_type, _args) do
    children = []

    processes =
      Supervisor.start_link(children, strategy: :one_for_one, name: Advent2022.Supervisor)

    read_input('input.test')
    |> get_starting_state()
    |> IO.inspect()

    # |> parse_input()
    # |> part1()
    # |> IO.inspect()

    # read_input()
    # |> parse_input()
    # |> part2()
    # |> IO.inspect()

    processes
  end
end
