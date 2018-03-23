defmodule Razor.Arguments do
  use Arguments

  command(
    "new",
    do: [
      arguments: [:name, :dir]
    ]
  )

  flag(
    "name",
    do: [
      type: :string,
      alias: :n,
      defaults: fn n ->
        [dir: "./#{n}"]
      end
    ]
  )

  flag(
    "dir",
    do: [
      type: :string,
      alias: :d
    ]
  )

  flag(
    "repo",
    do: [
      type: :string,
      alias: :r
    ]
  )

  flag(
    "version",
    do: [
      type: :boolean,
      alias: :v
    ]
  )
end
