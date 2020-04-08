defmodule PeachTest do
  # import CSVLixir
  use ExUnit.Case
  doctest Peach

  @tag timeout: 6000_000
  test "normalise_text" do
    test_data = [
      ["foo", "foo"],
      ["\n", "\n"],
      ["🚼", "🚼"],
      [[500], "Ǵ"],
      [[600], "ɘ"],
      ["＋－．～）｝", "+-.~)}"],
      ["１２３", "123"],
      ["ａｂｃＡＢＣ", "abcABC"]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "normalise_text.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.normalise_text(input) == expected_output
    end)
  end

  @tag timeout: 6000_000
  test "remove_emojis" do
    test_data = [
      ["🧐🙍🏾‍♂️🦎🇧🇮🇦🇶", ""],
      ["💔foo🈶bar⏮", "foobar"]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "remove_emojis.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

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

  @tag timeout: 6000_000
  test "normalise_whitespace" do
    test_data = [
      ["in     put", "in put"],
      ["  ", ""],
      ["in     put ", "in put"]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "normalise_whitespace.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.normalise_whitespace(input) == expected_output
    end)
  end

  @tag timeout: 6000_000
  test "remove_punc" do
    test_data = [
      ["!@#$%^&*()", ""],
      [" ", " "]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "remove_punc.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.remove_punc(input) == expected_output
    end)
  end

  @tag timeout: 6000_000
  test "replace_punc" do
    test_data = [
      ["this.is.a.test", "this is a test"],
      ["!@#$%^&*()", String.duplicate(" ", 10)]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "replace_punc.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.replace_punc(input) == expected_output
    end)
  end

  @tag timeout: 6000_000
  test "remove_numbers" do
    test_data = [
      ["1234", ""],
      ["1foo2", "foo2"],
      ["1 2 3 bar", "bar"]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "remove_numbers.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

    test_data
    |> Enum.map(fn [input, expected_output] ->
      assert Peach.remove_numbers(input) == expected_output
    end)
  end

  @tag timeout: 6000_000
  test "pre_process" do
    test_data = [
      # ["ا","ا"], FAILURE CASE
      # ["مافهمت","مافهمت"], FAILURE CASE
      ["Travel advice", "travel advice"],
      ["Hi", "hi"],
      ["2️⃣", "2"],
      ["1️⃣", "1"]
    ]

    # Try to load alternative testing data.
    # CSVLixir requires the use if a try catch :-(
    test_data =
      try do
        Path.join(["test", "function_test_data", "pre_process.csv"])
        |> Path.expand()
        |> CSVLixir.read()
        |> Enum.to_list()
      catch
        _kind, %File.Error{reason: :enoent} -> test_data |> Enum.to_list()
      end

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

  test "levenshtein" do
    assert Peach.levenshtein_distance("foo", "bar") == 3
    assert Peach.levenshtein_distance("foo", "bar") != 2
    assert Peach.levenshtein_distance("", "") == 0
    assert Peach.levenshtein_distance("foo", "") == 3
  end

  test "ex_find_exact_match" do
    test_data = [
      ["*menu*", MapSet.new(["menu", "opt-in", "opt-out"]), "menu"],
      ["2.", MapSet.new(["1", "2", "3"]), "2"]
    ]

    test_data
    |> Enum.map(fn [input, keywords, expected_match] ->
      assert expected_match ==
               Peach.pre_process(input)
               |> Peach.find_exact_match(keywords)
    end)
  end

  test "find_fuzzy_matches_single_threshold" do
    keyword_set = MapSet.new(["menu", "optin", "optout"])

    test_data = [
      # one addition
      ["menuu", keyword_set, [{"menu", 1}]],
      # one deletion
      ["opin", keyword_set, [{"optin", 1}]],
      # exact match
      ["optin", keyword_set, [{"optin", 0}]],
      # exact match
      ["optout", keyword_set, [{"optout", 0}]],
      # one addition
      ["optint", keyword_set, [{"optin", 1}]]
    ]

    threshold = 1

    test_data
    |> Enum.map(fn [input, keyword_set, expected_matches] ->
      assert expected_matches ==
               Peach.pre_process(input)
               |> Peach.find_fuzzy_matches(keyword_set, threshold)
    end)
  end

  test "find_fuzzy_matches" do
    keyword_threshold_set = MapSet.new([{"menu", 1}, {"optin", 2}, {"optout", 2}])

    test_data = [
      # one addition
      ["menuu", keyword_threshold_set, [{"menu", 1}]],
      # one deletion
      ["opin", keyword_threshold_set, [{"optin", 1}]],
      # exact match
      ["optin", keyword_threshold_set, [{"optin", 0}]],
      # exact match
      ["optout", keyword_threshold_set, [{"optout", 0}]],
      # one addition, two replacements
      ["optint", keyword_threshold_set, [{"optin", 1}, {"optout", 2}]]
    ]

    test_data
    |> Enum.map(fn [input, keyword_threshold_set, expected_matches] ->
      assert expected_matches ==
               Peach.pre_process(input)
               |> Peach.find_fuzzy_matches(keyword_threshold_set)
    end)
  end
end
