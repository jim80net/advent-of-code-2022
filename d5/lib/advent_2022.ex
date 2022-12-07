defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application
  alias Advent2022.CrateState


  def part2({state, instructions}) do
    CrateState.set_state(CrateState, state)

    instructions
    |> Enum.each(fn {how_many, from, to} ->
      CrateState.move2(CrateState, how_many, from, to)
    end)

    CrateState.state(CrateState)
    |> Enum.map(fn stack ->
      stack
      |> Enum.at(0)
    end)
  end

  def part1({state, instructions}) do
    CrateState.set_state(CrateState, state)

    instructions
    |> Enum.each(fn {how_many, from, to} ->
      CrateState.move(CrateState, how_many, from, to)
    end)

    CrateState.state(CrateState)
    |> Enum.map(fn stack ->
      stack
      |> Enum.at(0)
    end)
  end

  @doc """
  Parse the instructions from the input file
  {how many, from index, to index}
  """
  def parse_instructions({_state, instructions}) do
    instructions
    # Drop the first line which is blank.
    |> Enum.drop(1)
    |> Enum.map(fn line ->
      [_original | matches] = Regex.run(~r/move (\d+) from (\d+) to (\d+)/, line)

      [how_many, from, to] =
        matches
        |> Enum.map(fn match -> String.to_integer(match) end)
      
      {how_many, from - 1, to - 1}
    end)
  end

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
    children = [
     {Advent2022.CrateState, name: Advent2022.CrateState}
    ]

    processes =
      Supervisor.start_link(children, strategy: :one_for_one, name: Advent2022.Supervisor)

    main()
    processes
  end

  def main do
    Application.ensure_all_started(:advent_2022)
    
    state = read_input('input')
    |> get_starting_state()
    instructions = read_input('input')
    |> parse_instructions()

    part1({state, instructions})
    |> IO.inspect()

    part2({state, instructions})
    |> IO.inspect()

    Application.stop(:advent_2022)
  end

end
