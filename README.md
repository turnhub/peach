# Peach

An elixir library to do approximate/fuzzy string matching.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `peach` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:peach, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/peach](https://hexdocs.pm/peach).

## Test

to test with CSV data, create a folder in the `/test/` folder called `function_test_data` and put the following CSVs in them:

* `normalise_whitespace.csv`
* `remove_punc.csv`
* `pre_process.csv`
* `remove_emojis.csv`
* `normalise_text.csv`
* `replace_punc.csv`
* `get_brief.csv`
* `remove_numbers.csv`

then run `mix test`
or `mix test.watch test/peach_test.exs --failed --max-failures=1 --seed=0`
