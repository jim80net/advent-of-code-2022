defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  def part2(charlist) do
    # IO.inspect("Evaluating #{charlist}")
    {first_thirteen, rest} = Enum.split(charlist, 13)
    initial_mem = Enum.reverse(first_thirteen)
    rest
    |> Enum.reduce_while({initial_mem, 12}, fn element, acc ->
        {mem, count} = acc
        # IO.inspect({element, mem, count})
        if [element | mem] == Enum.uniq([element | mem]) do
          {:halt, count + 2}
        else
          newmem = [element | mem]
          |> Enum.take(13)
          {:cont, {newmem, count + 1}}
        end
      end)
  end
 


  def part1(charlist) do
    # IO.inspect("Evaluating #{charlist}")
    {first_three, rest} = Enum.split(charlist, 3)
    initial_mem = Enum.reverse(first_three)
    rest
    |> Enum.reduce_while({initial_mem, 2}, fn element, acc ->
        {mem, count} = acc
        # IO.inspect({element, mem, count})
        if [element | mem] == Enum.uniq([element | mem]) do
          {:halt, count + 2}
        else
          newmem = [element | mem]
          |> Enum.take(3)
          {:cont, {newmem, count + 1}}
        end
      end)
  end
 
  def parse_input(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_charlist/1)
    |> Enum.to_list()
    |> Enum.at(0)
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
  end

  @doc """
  main function
  """
  def start(_type, _args) do
    children = [
    ]

    processes =
      Supervisor.start_link(children, strategy: :one_for_one, name: Advent2022.Supervisor)

    main()
    processes
  end

  def main do
    Application.ensure_all_started(:advent_2022)
    
    read_input('input')
    |> parse_input()
    |> part1()
    |> IO.inspect()

    read_input('input')
    |> parse_input()
    |> part2()
    |> IO.inspect()


    Application.stop(:advent_2022)
  end

end
