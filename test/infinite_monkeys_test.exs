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

  test "can identify matches in text - pattern: b" do
    expected = 3
    result = InfiniteMonkeys.count_matches("abcbdb", ~r/b/)
    assert expected == result
  end

  test "can identify matches in text - pattern: b$" do
    expected = 1
    result = InfiniteMonkeys.count_matches("abcbdb", ~r/b$/)
    assert expected == result
  end

  test "can identify matches in text - pattern: ice cream" do
    text = Enum.join([
      "It was a lovely day and everyone was out for a strole. ",
      "They past a shop selling ice cream and could not resist have some. ",
      "They stepped inside immediately"
    ])

    expected = 1
    result = InfiniteMonkeys.count_matches(text, ~r/ice cream/)
    assert expected == result
  end

  test "can create log file contents" do
    text = "baconeggseggshamhamham"
    matches = [
      {"bacon", 1},
      {"eggs", 2},
      {"ham", 3}
    ]

    expected = "baconeggseggshamhamham\nbacon: 1\neggs: 2\nham: 3\n"
    result = InfiniteMonkeys.generate_log_file_contents(text, matches)
    assert expected == result
  end

end
