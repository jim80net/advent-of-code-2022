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

  describe "move/4 moves a crate, and moves them one at a time" do
    test "single" do
      CrateState.set_state(CrateState, ['AD', 'BE', 'CF'])
      CrateState.move(CrateState, 1, 1, 2)
      assert CrateState.state(CrateState) == ['AD', 'E', 'BCF']
    end

    test "double" do
      CrateState.set_state(CrateState, ['ADG', 'BEH', 'CFI'])
      CrateState.move(CrateState, 2, 1, 2)
      assert CrateState.state(CrateState) == ['ADG', 'H', 'EBCFI']
    end
  end

  describe "move2/4 moves a crate, but does not change the order of the crates" do
    test "single" do
      CrateState.set_state(CrateState, ['AD', 'BE', 'CF'])
      CrateState.move2(CrateState, 1, 1, 2)
      assert CrateState.state(CrateState) == ['AD', 'E', 'BCF']
    end

    test "double" do
      CrateState.set_state(CrateState, ['ADG', 'BEH', 'CFI'])
      CrateState.move2(CrateState, 2, 1, 2)
      assert CrateState.state(CrateState) == ['ADG', 'H', 'BECFI']
    end
  end
end