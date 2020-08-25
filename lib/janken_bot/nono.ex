defmodule JankenBot.Nono do
  @base_url "https://p.eagate.573.jp"

  @index "/game/bemani/wbr2020/01/card.html"
  @action_url "/game/bemani/wbr2020/01/card_save.html"

  def run(cookie) do
    token = get_token(cookie)

    case token do
      {:ok, token} ->
        submit(token, cookie)

      error ->
        error
    end
  end

  defp get_token(cookie) do
    %{ body: body } = HTTPoison.get!(
      @base_url <> @index,
      [
        {"Cookie", cookie},
        {"Origin", "https://p.eagate.573.jp"},
        {"Referer", "https://p.eagate.573.jp/game/bemani/wbr2020/01/card.html"}
      ]
    )

    token_values = body
    |> Floki.parse_document!()
    |> Floki.find("#id_initial_token")
    |> Floki.attribute("value")

    case token_values do
      [] ->
        {:error, "cannot find token"}

      [token] ->
        {:ok, token}
    end
  end

  defp submit(token, cookie) do
    %{ body: body } = HTTPoison.post!(
      @base_url <> @action_url,
      "c_type=1&c_id=0&t_id=#{token}",
      [
        {"Cookie", cookie},
        {"Content-Type", "application/x-www-form-urlencoded"},
        {"Origin", "https://p.eagate.573.jp"},
        {"Referer", "https://p.eagate.573.jp/game/bemani/wbr2020/01/card.html"},
      ]
    )

    :ok
  end
end
