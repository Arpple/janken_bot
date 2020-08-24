defmodule JankenBot do
  @moduledoc """
  Documentation for `JankenBot`.
  """

  alias JankenBot.Web
  alias JankenBot.Nono

  def janken() do
    cookies = get_cookies()

    for cookie <- cookies do
      case Web.get_link(cookie) do
        {:ok, link} ->
          Web.go(link, cookie)

        {:error, _msg} ->
          nil
      end
    end
  end

  def nono() do
    cookies = get_cookies()

    for cookie <- cookies do
      Nono.run(cookie)
    end
  end

  def get_cookies() do
    Application.get_env(:janken_bot, :cookies, [])
  end
end
