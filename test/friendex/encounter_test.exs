defmodule FriendexTest.Encounter do
  use ExUnit.Case
  doctest Friendex.Encounter

  test "Create an encounter without description" do
    assert {:ok, %Friendex.Encounter{description: nil}} = Friendex.Encounter.new(2015, 5, 12, 9, "Prueba")
  end
end
