defmodule Peach do
  @moduledoc """
  Documentation for `Peach`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Peach.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Normalize text
  Unicode NFKC (Normalisation Form Compatibility Composition) normalisation.
  """
  def normalise_text do
    # return normalize('NFKC', text)
    :to_do
  end

  @doc """

  """
  def remove_emojis do
    # return demoji.replace(text)
    :to_do
  end

  @doc """
  Replace spans of whitespace with a single space
  """
  def normalise_whitespace do
    # return re.sub(r'\s+', ' ', text).strip()
    :to_do
  end

  @doc """
  Remove punctuation without substitution
  """
  def remove_punc do
    # chars_to_remove = string.punctuation + '*'
    # return text.translate(str.maketrans('', '', chars_to_remove))
    :to_do
  end

  @doc """
  Replace punctuation marks with spaces
  """
  def replace_punc do
    # return text.translate(str.maketrans(string.punctuation, ' '*len(string.punctuation)))
    :to_do
  end

  @doc """
  Remove numbers without substitution. Applied before keyword matching
  """
  def remove_numbers do
    # return re.sub(r'\b\d+\s+', '', text)
    :to_do
  end

  @doc """
  Pre-process an utterance in prepartion for number AND keyword matching
  """
  def pre_process do
    # return normalise_whitespace(replace_punc(remove_emojis(normalise_text(text.lower()))))
    :to_do
  end

  @doc """
  Extract the first few characters of the utterance.

  def get_brief(text: str, num_chars: int = 20) -> str:
  """
  def get_brief do
    #     in_one_line = text.replace('\n', '\\n').replace('\r', '\\r')
    #     brief = text if len(in_one_line) < num_chars else in_one_line[:(num_chars-3)]+'...'
    #     return brief
    :to_do
  end
end
