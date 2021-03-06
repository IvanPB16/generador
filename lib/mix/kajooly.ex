defmodule Mix.Kajooly do
  alias Generador.Config

  def parse_config!(_task, args) do
    {opts, _, _} = OptionParser.parse(args, switches: [format: :string, app: :string])
    format = convert_format(opts[:format] || Config.template_format())
    otp_app = opts[:app] || Config.otp_app()

    unless otp_app do
      Mix.raise("""
        No OTP application specified
        You need to specify an OTP app to generate files within.
        config :generador,
        otp_app: my_app
      """)
    end

    unless format in ["eex", "leex"] do
      Mix.raise("""
        Template format is invalid: #{inspect(format)}. Either configure it as
        shown below or pass it via the `--format` option.

          config :generador,
          template_format: eex

        Supported formats: eex
      """)
    end
    %{otp_app: otp_app, format: format}
  end

  def ensure_phoenix_is_loaded!(mix_task \\ "task") do
    case Application.load(:phoenix) do
      :ok ->
        :ok

      {:error, {:already_loaded, :phoenix}} ->
        :ok

      {:error, reason} ->
        Mix.raise("mix #{mix_task} could not complete due to Phoenix not being loaded: #{reason}")
    end
  end

  defp convert_format(format), do: format
end
