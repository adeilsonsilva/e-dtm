defmodule CaptainTest do
  use ExUnit.Case
  doctest Captain

  test "greets the world" do
    assert Captain.hello() == :world
  end
end
