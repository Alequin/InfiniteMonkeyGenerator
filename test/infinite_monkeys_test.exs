defmodule InfiniteMonkeysTest do
  use ExUnit.Case
  doctest InfiniteMonkeys

  test "greets the world" do
    assert InfiniteMonkeys.hello() == :world
  end
end
