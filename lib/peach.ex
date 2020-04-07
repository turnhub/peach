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
    # python
    #   return normalise_whitespace(replace_punc(remove_emojis(normalise_text(text.lower()))))

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
    # python:
    #     in_one_line = text.replace('\n', '\\n').replace('\r', '\\r')
    phrase
    |> String.replace("\n", "\\n")
    |> String.replace("\r", "\\r")
  end

  @doc """
  Extract the first few characters of the utterance.
  """
  def get_brief(phrase, num_chars) do
    # python
    #     in_one_line = text.replace('\n', '\\n').replace('\r', '\\r')
    #     brief = text if len(in_one_line) < num_chars else in_one_line[:(num_chars-3)]+'...'
    #     return brief

    single_line_value = convert_to_one_line(phrase)

    if String.length(single_line_value) < num_chars do
      phrase
    else
      end_slice_value = num_chars - 4
      String.slice(phrase, 0..end_slice_value) <> "..."
    end
  end

  def get_brief(phrase) do
    get_brief(phrase, 20)
  end

  def levenshtein_distance(first_phrase, second_phrase) do
    :levenshtein.levenshtein(first_phrase, second_phrase)
  end
end
