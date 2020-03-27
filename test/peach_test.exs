defmodule PeachTest do
  use ExUnit.Case
  doctest Peach

  test "greets the world" do
    assert Peach.hello() == :world
  end

  test "normalise_text" do
    assert Peach.normalise_text() == :todo
  end

  test "remove_emojis" do
    assert Peach.remove_emojis() == :todo
  end

  test "normalise_whitespace" do
    assert Peach.normalise_whitespace() == :todo
  end

  test "remove_punc" do
    assert Peach.remove_punc() == :todo
  end

  test "replace_punc" do
    assert Peach.replace_punc() == :todo
  end

  test "remove_numbers" do
    assert Peach.remove_numbers() == :todo
  end

  test "pre_process" do
    assert Peach.pre_process() == :todo
  end

  test "get_brief" do
    assert Peach.get_brief() == :todo
  end
end
