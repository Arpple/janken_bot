defmodule JankenBot do
  @moduledoc """
  Documentation for `JankenBot`.
  """

  alias JankenBot.Web

  def go() do
    cookie = get_cookie()

    cookie
    |> Web.get_link()
    |> Web.go(cookie)
  end

  def get_cookie() do
    cookie = Application.get_env(:janken_bot, :cookie)
  end
end
