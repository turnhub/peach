defmodule PeachTest do
  use ExUnit.Case
  doctest Peach

  test "greets the world" do
    assert Peach.hello() == :world
  end
end
