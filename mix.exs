defmodule Peach.MixProject do
  use Mix.Project

  def project do
    [
      app: :peach,
      version: "0.1.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "Peach",
      source_url: "https://github.com/turnhub/peach"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false},
      {:mix_test_watch, "~> 1.0.1", only: :dev, runtime: false},
      {:levenshtein, "~> 0.3.0"},
      {:csvlixir, "~> 2.0.3", only: :test},
      {:credo, "~> 1.4", only: :dev, runtime: false},
      {:remove_emoji, "~> 1.0.1"}
    ]
  end

  defp description() do
    "an elixir library to generate potential fuzzy matches"
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/turnhub/peach"}
    ]
  end
end
