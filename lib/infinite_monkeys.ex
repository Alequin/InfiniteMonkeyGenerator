defmodule InfiniteMonkeys do

  def run do
    IO.puts "Infinite Monkeys: running"

    case File.read("./english-words/words_alpha.txt") do
      {:ok, content} -> begin_search(String.split(content, "\n"))
      {:error, _reason} -> "File does not exist"
    end

    IO.puts "Infinite Monkeys: exit"
  end

  def begin_search(words) do
    text = generate_text(10000)

    matches = Enum.map(words, fn(word) ->
      case Regex.compile(word) do
        {:ok, regexr} -> {word, count_matches(text, regexr)}
        {:error, _reason} -> "regexr failed"
      end
    end)

    for(match <- matches) do
      {word, count} = match
      IO.puts word
      IO.puts count
    end
  end

  def generate_text(charCount) do
    letter = InfiniteMonkeys.generate_random_letter
    if(charCount > 0) do
      "#{letter}#{InfiniteMonkeys.generate_text(charCount-1)}"
    end
  end

  def generate_random_letter do
    letter_code = 96 + :rand.uniform(26)
    <<letter_code :: utf8>>
  end

  def count_matches(text, pattern) do
    length(Regex.scan(pattern, text))
  end

  def generate_log_file_contents(text, matches) do

  end

end
