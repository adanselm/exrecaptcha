defmodule Exrecaptcha.Mixfile do
  use Mix.Project

  def project do
    [app: :exrecaptcha,
     version: "0.0.1",
     elixir: "~> 1.0.0",
     deps: deps,
     package: package]
  end

  def application do
    [applications: [:logger, :httpotion]]
  end

  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.1.0"},
      {:httpotion, "~> 0.2.0"}
    ]
  end

    defp package do
    [files: ["lib", "mix.exs", "README.md", "COPYING"],
     contributors: ["Adrien Anselme"],
     licenses: ["Do What the Fuck You Want to Public License, Version 2"],
     links: %{ "GitHub" => "https://github.com/adanselm/exrecaptcha" }]
  end
end
