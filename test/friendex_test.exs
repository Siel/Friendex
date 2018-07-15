defmodule FriendexTest do
  use ExUnit.Case
  doctest Friendex

  test "greets the world" do
    assert Friendex.hello() == :world
  end
end
