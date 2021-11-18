defmodule Generador.Config do
  def otp_app do
    Application.get_env(:generador, :otp_app)
  end

  def template_format do
    Application.get_env(:generador, :template_format)
  end
end
