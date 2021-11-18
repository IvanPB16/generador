defmodule Mix.Tasks.Kajooly.Gen do
  @moduledoc """
    This module provides a task to run the Kajooly application.
  """
  @shortdoc "Generador kajooly"

  use Mix.Task

  def run(args) do
    IO.inspect(args)

    if Mix.Project.umbrella?() do
      Mix.raise("mix kajooly.Generate can only be run inside an application directory")
    end

    %{format: format} = Mix.Kajooly.parse_config!("kajooly.gen", args)

    IO.inspect(format, label: "Este es el formato")

    Mix.Kajooly.ensure_phoenix_is_loaded!("torch.gen.html")

    Mix.shell().info("""
      Generador Kajooly
    """)
  end
end
