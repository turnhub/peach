defmodule PeachTest do
  # import CSVLixir
  use ExUnit.Case
  doctest Peach

  @tag timeout: 600_000
  test "normalise_text" do
    test_data = [
      ["foo", "foo"],
      ["\n", "\n"],
      ["🚼", "🚼"]
    ]

    test_data =
      Path.join(["test", "function_test_data", "normalise_text.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.normalise_text(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "remove_emojis" do
    test_data = [
      ["🧐🙍🏾‍♂️🦎🇧🇮🇦🇶", ""],
      ["💔foo🈶bar⏮", "foobar"]
    ]

    test_data =
      Path.join(["test", "function_test_data", "remove_emojis.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      Peach.remove_emojis(input) == expected_output
    end)
  end

  # there are some failing cases in the emoji removal
  # this test is purely to document those cases
  test "document failing emoji removal" do
    assert Peach.remove_emojis("0️⃣") != ""
    assert Peach.remove_emojis("1️⃣") != ""
    assert Peach.remove_emojis("2️⃣") != ""
    assert Peach.remove_emojis("3️⃣") != ""
    assert Peach.remove_emojis("4️⃣") != ""
    assert Peach.remove_emojis("5️⃣") != ""
    assert Peach.remove_emojis("6️⃣") != ""
    assert Peach.remove_emojis("7️⃣") != ""
    assert Peach.remove_emojis("8️⃣") != ""
    assert Peach.remove_emojis("9️⃣") != ""
    assert Peach.remove_emojis("#️⃣") != ""
    assert Peach.remove_emojis("*️⃣") != ""
    assert Peach.remove_emojis("©️") != ""
    assert Peach.remove_emojis("®️") != ""
  end

  @tag timeout: 600_000
  test "normalise_whitespace" do
    test_data = [
      ["in     put", "in put"],
      ["  ", ""],
      ["in     put ", "in put"]
    ]

    test_data =
      Path.join(["test", "function_test_data", "normalise_whitespace.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.normalise_whitespace(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "remove_punc" do
    test_data = [
      ["!@#$%^&*()", ""],
      [" ", " "]
    ]

    test_data =
      Path.join(["test", "function_test_data", "remove_punc.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.remove_punc(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "replace_punc" do
    test_data = [
      ["this.is.a.test", "this is a test"],
      ["!@#$%^&*()", String.duplicate(" ", 10)]
    ]

    test_data =
      Path.join(["test", "function_test_data", "replace_punc.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.replace_punc(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "remove_numbers" do
    test_data = [
      ["1234", ""],
      ["1foo2", "foo"],
      ["1 2 3 bar", "bar"]
    ]

    test_data =
      Path.join(["test", "function_test_data", "remove_numbers.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.remove_numbers(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "pre_process" do
    test_data = [
      # ["ا","ا"], FAILURE CASE
      # ["مافهمت","مافهمت"], FAILURE CASE
      ["Travel advice", "travel advice"],
      ["Hi", "hi"]
    ]

    test_data =
      Path.join(["test", "function_test_data", "pre_process.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.pre_process(input) == expected_output
    end)
  end

  test "convert to one line" do
    test_data = [
      ["\nfoo\nbar", "\\nfoo\\nbar"],
      ["\rfoo\rbar", "\\rfoo\\rbar"]
    ]

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.convert_to_one_line(input) == expected_output
    end)
  end

  @tag timeout: 600_000
  test "get_brief" do
    test_data = [
      # TODO: update test values
      ["this is short sentence", "this is short sentence"],
      [
        "this is a much longer sentence that will run on for quite some time",
        "this is a much longer sentence that will run on ..."
      ]
    ]

    test_data =
      Path.join(["test", "function_test_data", "get_brief.csv"])
      |> Path.expand()
      |> CSVLixir.read()
      |> Enum.to_list()

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.get_brief(input, 50) == expected_output
    end)
  end

  # test "levenshtein" do
  #   assert Peach.lvnshtn("cat", "dog") == 3
  # end
end
