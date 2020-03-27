defmodule PeachTest do
  use ExUnit.Case
  doctest Peach

  test "greets the world" do
    assert Peach.hello() == :world
  end

  test "normalise_text" do
    assert Peach.normalise_text() == :to_do
  end

  test "remove_emojis" do
    assert Peach.remove_emojis() == :to_do
  end

  test "normalise_whitespace" do
    assert Peach.normalise_whitespace() == :to_do
  end

  test "remove_punc" do
    assert Peach.remove_punc() == :to_do
  end

  test "replace_punc" do
    assert Peach.replace_punc() == :to_do
  end

  test "remove_numbers" do
    assert Peach.remove_numbers() == :to_do
  end

  test "pre_process" do
    assert Peach.pre_process() == :to_do
  end

  test "get_brief" do
    assert Peach.get_brief() == :to_do
  end
end
