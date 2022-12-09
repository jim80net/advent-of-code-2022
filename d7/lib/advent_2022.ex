defmodule Advent2022 do
  @moduledoc """
  Documentation for `Advent2022`.
  """
  use Application

  def parse_input(data) do
    start_fun = fn -> [:first] end

    reducer = fn element, acc ->
      cond do
        acc == [:first] ->
          {[], [element]}

        String.starts_with?(element, "$ ") ->
          emitted_acc = acc |> List.flatten() |> Enum.reverse()
          {[emitted_acc], [element]}

        true ->
          {[], [element | acc]}
      end
    end

    last_fun = fn acc ->
      emitted_acc = acc |> List.flatten() |> Enum.reverse()
      {[emitted_acc], []}
    end

    after_fun = fn acc -> acc end

    data
    |> Stream.transform(start_fun, reducer, last_fun, after_fun)
    |> Enum.to_list()
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
    |> Stream.map(&String.trim/1)
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
    |> IO.inspect()

    Application.stop(:advent_2022)
  end
end
