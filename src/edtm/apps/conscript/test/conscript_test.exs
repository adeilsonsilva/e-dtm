defmodule ConscriptTest do
  use ExUnit.Case
  doctest Conscript

  test "greets the world" do
    assert Conscript.hello() == :world
  end
end
