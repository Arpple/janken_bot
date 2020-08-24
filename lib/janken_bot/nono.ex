defmodule JankenBot.Nono do
  @base_url "https://p.eagate.573.jp"

  @index "/game/bemani/wbr2020/01/card.html"
  @action_url "/game/bemani/wbr2020/01/card_save.html"

  def run(cookie) do
    cookie
    |> get_token()
    |> submit(cookie)
  end

  def get_token(cookie) do
    %{ body: body } = HTTPoison.get!(
      @base_url <> @index,
      [
        {"Cookie", cookie},
        {"Origin", "https://p.eagate.573.jp"},
        {"Referer", "https://p.eagate.573.jp/game/bemani/wbr2020/01/card.html"}
      ]
    )

    [token] = body
    |> Floki.parse_document!()
    |> Floki.find("#id_initial_token")
    |> Floki.attribute("value")
  end

  def submit(token, cookie) do
    IO.inspect(cookie)
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

    Floki.parse_document!(body)
  end
end
