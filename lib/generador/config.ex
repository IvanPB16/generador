defmodule Generador.Config do
  def otp_app do
    Application.get_env(:kajooly, :otp_app)
  end

  def template_format do
    Application.get_env(:kajooly, :template_format)
  end
end
