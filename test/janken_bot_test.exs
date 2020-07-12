defmodule JankenBotTest do
  use ExUnit.Case
  doctest JankenBot

  test "greets the world" do
    assert JankenBot.hello() == :world
  end
end
