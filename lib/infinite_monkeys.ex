defmodule InfiniteMonkeys do

  def run do

    text_length = 100
    word_file = "./english-words/words_alpha.txt"
    loop_count = 100

    IO.puts "Infinite Monkeys: running"

    case File.read(word_file) do
      {:ok, content} ->
        begin_search(text_length, String.split(content, "\n"), loop_count)
      {:error, _reason} -> "File does not exist"
    end

    IO.puts "Infinite Monkeys: exit"
  end

  def begin_search(text_length, words, run_count) do
    text = generate_text(text_length)

    matches = Enum.filter(words, fn(word) ->
      word = String.trim(word)
      {:ok, regexr} = Regex.compile(word)
      count_matches(text, regexr) > 0
    end)

    matches = Enum.map(matches, fn(word) ->
      word = String.trim(word)
      {:ok, regexr} = Regex.compile(word)
      {word, count_matches(text, regexr)}
    end)

    if(length(matches) > 0) do
      IO.puts generate_log_file_contents(text, matches)
    end

    if(run_count > 0) do
      run_count = run_count - 1
      IO.puts "#{run_count} searches remaining"
      InfiniteMonkeys.begin_search(text_length, words, run_count)
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

    matches_as_text = for(match <- matches) do
      {word, count} = match
      if(count > 0) do
        "#{word}: #{count}\n"
      else
        ""
      end
    end

    Enum.join([
      "#{text}\n\n",
      "MATCHES\n",
      matches_as_text
    ])
  end

end

# fun but uneccessary code
# Reason: too slow to run when variable "words" is very long --------------------------------------
# def find_matches(text, words) do
#   if(length(words) < 1) do
#     []
#   else
#     [ word | words ] = words
#
#     {:ok, regexr} = Regex.compile(word)
#     match_count = count_matches(text, regexr)
#
#     if(match_count > 0) do
#       [{word, match_count}] ++ InfiniteMonkeys.find_matches(text, words)
#     else
#       [] ++ InfiniteMonkeys.find_matches(text, words)
#     end
#   end
# end
# test "can find and return only words with matches" do
#   text = "baconeggseggshamhamham"
#   matches = [
#     {"bacon", 1},
#     {"eggs", 2},
#     {"ham", 3},
#   ]
#
#   expected = matches
#   result = InfiniteMonkeys.find_matches(text, ["bacon", "eggs", "ham"])
#   assert expected == result
# end
#
# test "can find and return only words with matches - able to filter out noise" do
#   text = "kdeeiebaconldieoeeggsieueieggsijeijoeijohamoi899hamonfnfehamiofijoei"
#   matches = [
#     {"bacon", 1},
#     {"eggs", 2},
#     {"ham", 3},
#   ]
#
#   expected = matches
#   result = InfiniteMonkeys.find_matches(text, ["bacon", "eggs", "ham"])
#   assert expected == result
# end
