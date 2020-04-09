defmodule Peach do
  @doc """
  Normalize text
  Unicode NFKC (Normalisation Form Compatibility Composition) normalisation.
  """
  def normalise_text(phrase) do
    # https://hexdocs.pm/elixir/1.9.4/String.html#normalize/2
    # erlang.org/doc/man/unicode.html#characters_to_nfkc_binary-1
    :unicode.characters_to_nfkc_binary(phrase)
  end

  @doc """
  Remove emojis from a string.

  WARNING: this currently does not work for 0️⃣ 1️⃣ 2️⃣ 3️⃣ 4️⃣ 5️⃣ 6️⃣ 7️⃣ 8️⃣ 9️⃣ #️⃣ *️⃣ ©️ ®️
  it replaces it with the symbol, rather than remove it completely
  """
  def remove_emojis(phrase) do
    RemoveEmoji.sanitize(phrase)
  end

  @doc """
  Replace spans of whitespace with a single space
  """
  def normalise_whitespace(phrase) do
    String.replace(phrase, ~r/\s+/u, " ")
    |> String.trim()
  end

  @doc """
  Remove punctuation without substitution
  """
  def remove_punc(phrase) do
    String.replace(phrase, ~r/[\p{P}\p{S}]/u, "")
  end

  @doc """
  Replace punctuation marks with spaces
  """
  def replace_punc(phrase) do
    String.replace(phrase, ~r/[\p{P}\p{S}]/u, " ")
  end

  @doc """
  Remove numbers without substitution. Applied before keyword matching
  """
  def remove_numbers(phrase) do
    String.replace(phrase, ~r/\b\d+\s*/u, "")
  end

  @doc """
  Pre-process an utterance in prepartion for number AND keyword matching
  """
  def pre_process(phrase) do
    phrase
    |> String.downcase()
    |> normalise_text
    |> remove_emojis
    |> replace_punc
    |> normalise_whitespace
  end

  @doc """
  Get string in to one line
  """
  def convert_to_one_line(phrase) do
    phrase
    |> String.replace("\n", "\\n")
    |> String.replace("\r", "\\r")
  end

  @doc """
  Extract the first few characters of the utterance.
  """
  def get_brief(phrase, num_chars \\ 20) do
    single_line_value = convert_to_one_line(phrase)

    if String.length(single_line_value) < num_chars do
      phrase
    else
      end_slice_value = num_chars - 4
      String.slice(phrase, 0..end_slice_value) <> "..."
    end
  end

  @doc """
  Calculate the Levenshtein edit distance.
  """
  def levenshtein_distance(first_phrase, second_phrase) do
    :levenshtein.levenshtein(first_phrase, second_phrase)
  end

  @doc """
  Find if there is an exact match to keyword set. The keywords may be numbers.
  """
  def find_exact_match(input, keyword_set),
    do: Enum.find(keyword_set, &String.equivalent?(input, &1))

  @doc """
  Find the fuzzy matches to the keyword_threshold set. Each keyword has its own threshold.
  """
  def find_fuzzy_matches(input, keyword_threshold_set) do
    cleaned_input = remove_numbers(input)

    keyword_threshold_set
    # add the edit distance.
    |> Enum.map(fn {keyword, threshold} ->
      {keyword, levenshtein_distance(cleaned_input, keyword), threshold}
    end)
    # only keep close matches.
    |> Enum.filter(fn {_keyword, distance, threshold} ->
      distance <= threshold
    end)
    # drop threshold.
    |> Enum.map(fn {keyword, distance, _threshold} ->
      {keyword, distance}
    end)
    # order from best to worst matches.
    |> Enum.sort(&(elem(&1, 1) < elem(&2, 1)))
  end

  @doc """
  Find the fuzzy matches to the keyword set. All keywords use the same threshold.
  """
  def find_fuzzy_matches(input, keyword_set, threshold) do
    # build keyword_threshold_set.
    keyword_threshold_set =
      keyword_set
      |> Enum.map(fn keyword ->
        {keyword, threshold}
      end)

    find_fuzzy_matches(input, keyword_threshold_set)
  end
end
