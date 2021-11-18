defmodule Mix.Tasks.Kajooly.Gen do
  @moduledoc """
    This module provides a task to run the Kajooly application.
  """
  @shortdoc "Generador kajooly"

  use Mix.Task
  @switches [hexagonal: :string]
  def run(args) do

    if Mix.Project.umbrella?() do
      Mix.raise("mix kajooly.Generate can only be run inside an application directory")
    end

    %{format: format} = Mix.Kajooly.parse_config!("kajooly.gen", args)

    Mix.Kajooly.ensure_phoenix_is_loaded!("kajooly.gen")

    {attr1, attr2} = build(args)
    files_to_be_generated(attr1, attr2)

    Mix.shell().info("""
      Generador Kajooly
    """)
  end

  def build(args, help \\ __MODULE__) do
    {_opts, parsed, _} = parse_opts(args)
    [attr1, attr2] = validate_args!(parsed, help)
    {attr1, attr2}
  end

  defp parse_opts(args) do
    {opts, parsed, invalid} = OptionParser.parse(args, switches: @switches)

    {opts, parsed, invalid}
  end

  defp validate_args!([attr1, attr2] = args, help) do
    IO.inspect args
    cond do
      attr1 == attr2 ->
        help.raise_with_help "Los nombres son iguales"
      true ->
        args
    end
  end

  defp validate_args!(_, help) do
    help.raise_with_help "Invalid arguments"
  end

  @doc false
  @spec raise_with_help(String.t) :: no_return()
  def raise_with_help(msg) do
    Mix.raise """
    #{msg}

    Es para generar nuevos archivos
    """
  end

  defp files_to_be_generated(attr1, attr2) do
    app_dir = File.cwd!()
    app_name = Path.basename(app_dir)
    path = Path.join([app_dir, "lib", app_name, "#{attr1}"])

    if !File.exists?(path) do
      File.mkdir_p(path)
    end
    file_path = Path.join([path, "#{attr2}.ex"])
    File.write(
      file_path,
      """
      defmodule #{String.capitalize(app_name)}.#{String.capitalize(attr2)} do
        def hello do
          IO.puts "Hello Dante"
        end

        def goodbye do
          IO.puts "Goodbye Dante"
        end
      end
      """,
      [:write]
    )
  end
end
