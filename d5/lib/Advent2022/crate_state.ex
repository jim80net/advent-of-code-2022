defmodule Advent2022.CrateState do
  use GenServer

  # client

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc "Return the full state"
  def state(pid) do
    GenServer.call(pid, {:state})
  end

  @doc "Set the state"
  def set_state(pid, newstate) do
    GenServer.cast(pid, {:set_state, newstate})
  end

  def move(_pid, 0, _from, _to) do
    :ok
  end
  @doc "Move a crate from one stack to another"
  def move(pid, howmany, from, to) do
    GenServer.cast(pid, {:move, from, to})
    move(pid, howmany - 1, from, to)
  end

  @doc "Move a crate from one stack to another, but do not change the order of the crates"
  def move2(pid, howmany, from, to) do
    GenServer.cast(pid, {:move2, howmany, from, to})
  end

  # Server (callbacks)

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:state}, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast({:set_state, newstate}, _state) do
    {:noreply, newstate}
  end

  @impl true
  def handle_cast({:move, from, to}, state) do
    [from_head | from_tail] = Enum.at(state, from)

    newstate =
      state
      |> List.replace_at(from, from_tail)
      |> List.replace_at(to, [from_head | Enum.at(state, to)])

    {:noreply, newstate}
  end

  @impl true
  def handle_cast({:move2, howmany, from, to}, state) do
    {from_head, from_tail} = Enum.at(state, from) |> Enum.split(howmany)

    newstate =
      state
      |> List.replace_at(from, from_tail)
      |> List.replace_at(to, Enum.at(state, to) |> List.insert_at(0, from_head) |> List.flatten)

    {:noreply, newstate}
  end
end
