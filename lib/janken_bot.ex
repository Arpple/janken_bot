defmodule JankenBot do
  @moduledoc """
  Documentation for `JankenBot`.
  """

  alias JankenBot.Janken
  alias JankenBot.Nono

  def janken() do
    get_cookies()
    |> Enum.map(&Janken.run/1)
  end

  def nono() do
    get_cookies()
    |> Enum.map(&Nono.run/1)
  end

  def get_cookies() do
    Application.get_env(:janken_bot, :cookies, [])
  end
end
