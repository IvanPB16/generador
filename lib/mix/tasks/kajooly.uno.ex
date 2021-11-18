defmodule Mix.Tasks.Kajooly.Uno do
  @moduledoc """
    This module provides a task to run the Kajooly application.
  """
  @shortdoc "Generador kajooly uno"

  use Mix.Task

  def run(args) do
    IO.inspect(args)

    if Mix.Project.umbrella?() do
      Mix.raise("mix kajooly.Generate can only be run inside an application directory")
    end

    %{format: format} = Mix.Kajooly.parse_config!("kajooly.gen", args)

    Mix.Kajooly.ensure_phoenix_is_loaded!("kajooly.gen")

    if format == "leex" do
      Mix.Task.run("phx.gen.live", args)
    end

    Mix.shell().info("""
      Generador Kajooly
    """)
  end

end
