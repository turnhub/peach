# Peach

An elixir library to do approximate/fuzzy string matching.

## Installation

This package is not [available in Hex](https://hex.pm/docs/publish), as it has dependencies that are not themselves published on hex. the package can be installed
by adding `peach` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:peach, "~> 0.1.1", github: "turnhub/peach", branch: "develop"},
  ]
end
```

Public docs are also unfortunately not available due to our inability to publish this package.
Please see the code for documentation.

## Testing

To test run `mix test`.

To test with CSV data, create a folder in the `/test/` folder called `function_test_data` and put the following CSVs in them:

* `normalise_whitespace.csv`
* `remove_punc.csv`
* `pre_process.csv`
* `remove_emojis.csv`
* `normalise_text.csv`
* `replace_punc.csv`
* `get_brief.csv`
* `remove_numbers.csv`

then run `mix test`
or `mix test.watch test/peach_test.exs --max-failures=1 --seed=0`

## Using

Below are some examples of how Peach might be used to do the type of fuzzy matching automation required in the first tier of a menu centred chatbot.

### Menu number and keyword match.

```elixir
    input = "2.)"
    keyword_set = MapSet.new(["1", "2", "menu"])

    matches =
      Peach.pre_process(input)
      |> Peach.find_exact_match(keyword_set)

    assert matches == "2"
```

```elixir
    input = "_menu_"
    keyword_set = MapSet.new(["1", "2", "menu"])

    matches =
      Peach.pre_process(input)
      |> Peach.find_exact_match(keyword_set)

    assert matches == "menu"
```

### Fuzzy keyword match with global threshold.

```elixir
    input = "menuu"
    keyword_set = MapSet.new(["menu", "optin", "optout"])
    threshold = 1

    matches =
      Peach.pre_process(input)
      |> Peach.find_fuzzy_matches(keyword_set, threshold)

    assert matches == [{"menu", 1}]
```

### Fuzzy keyword match with a threshold per keyword.

```elixir
    input = "optint"
    keyword_threshold_set = MapSet.new([{"menu", 1}, {"optin", 2}, {"optout", 2}])

    matches =
      Peach.pre_process(input)
      |> Peach.find_fuzzy_matches(keyword_threshold_set)

    assert matches == [{"optin", 1}, {"optout", 2}]
```
