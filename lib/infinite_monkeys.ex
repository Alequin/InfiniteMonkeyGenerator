defmodule InfiniteMonkeys do

  def run do
    IO.puts "Infinite Monkeys: running"

    case File.read("./english-words/words_alpha.txt") do
      {:ok, content} -> begin_search(content)
      {:error, _reason} -> "File does not exist"
    end

    IO.puts "Infinite Monkeys: exit"
  end

  defp begin_search(words) do
    IO.puts words
  end

end
