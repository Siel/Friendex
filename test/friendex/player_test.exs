defmodule FriendexTest.Player do
  use ExUnit.Case
  doctest Friendex

  @test_name "Tatiana"
  @test_email "prueba@prueba.com"
  @wrong_email "prueba@prueba"

  test "The function Player.new returns a player struct" do
    assert {:ok, %Friendex.Player{}} = Friendex.Player.new(@test_name, @test_email)
  end

  test "The function Player.new with :admin option creates an admin user" do
    assert {:ok, %Friendex.Player{admin: true}} = Friendex.Player.new(@test_name, @test_email, :admin)
  end

  test "Player.new/2/3 returns :error if the email is wrong formatted" do
    assert {:error, "Invalid email"} = Friendex.Player.new(@test_name, @wrong_email)
    assert {:error, "Invalid email"} = Friendex.Player.new(@test_name, @wrong_email, :admin)
  end
end
