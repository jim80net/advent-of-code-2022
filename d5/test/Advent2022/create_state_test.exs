defmodule Advent2022Test.CrateState do
  use ExUnit.Case
  # doctest Advent2022
  alias Advent2022.CrateState

  describe "set_state/2" do
    test "sets the state" do
      CrateState.set_state(CrateState, ['D', 'E', 'F'])
      assert CrateState.state(CrateState) == ['D', 'E', 'F']
    end
  end

  describe "move/4" do
    test "moves a crate" do
      CrateState.set_state(CrateState, ['AD', 'BE', 'CF'])
      CrateState.move(CrateState, 1, 1, 2)
      assert CrateState.state(CrateState) == ['AD', 'E', 'BCF']
    end
  end
end