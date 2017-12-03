defmodule InfiniteMonkeysTest do
  use ExUnit.Case
  doctest InfiniteMonkeys

  test "can generate random text - length 5" do
    expected = 5
    result = String.length(InfiniteMonkeys.generate_text(5))
    assert expected == result
  end

  test "can generate random text - length 10" do
    expected = 10
    result = String.length(InfiniteMonkeys.generate_text(10))
    assert expected == result
  end

  test "can generate random text - length 10000" do
    expected = 10000
    result = String.length(InfiniteMonkeys.generate_text(10000))
    assert expected == result
  end
end
