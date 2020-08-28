defmodule JankenBot.Nono do
  @base_url "https://p.eagate.573.jp"

  @index "/game/bemani/wbr2020/01/card.html"
  @action_url "/game/bemani/wbr2020/01/card_save.html"

  def run(cookie) do
    event_page = get_event_page(cookie)
    token = get_token(event_page)
    card_type = get_card_type(event_page)

    case token do
      {:ok, token} ->
        Enum.map(["0", "1", "2"], fn card_type ->
          submit(token, card_type, cookie)
        end)

      error ->
        error
    end
  end

  defp get_event_page(cookie) do
    %{ body: body } = HTTPoison.get!(
      @base_url <> @index,
      [
        {"Cookie", cookie},
        {"Origin", "https://p.eagate.573.jp"},
        {"Referer", "https://p.eagate.573.jp/game/bemani/wbr2020/01/card.html"}
      ]
    )

    body
    |> Floki.parse_document!()
  end
  
  defp get_token(event_page) do
    token_values = event_page
    |> Floki.find("#id_initial_token")
    |> Floki.attribute("value")

    case token_values do
      [] ->
        {:error, "cannot find token"}

      [token] ->
        {:ok, token}
    end
  end

  defp get_card_type(event_page) do
    "1" # TODO: read from image name
  end

  defp submit(token, card_type, cookie) do
    %{ body: body } = HTTPoison.post!(
      @base_url <> @action_url,
      "c_type=#{card_type}&c_id=0&t_id=#{token}",
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
