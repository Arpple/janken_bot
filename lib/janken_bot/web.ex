defmodule JankenBot.Web do
  @base_url "https://p.eagate.573.jp"

  @index "/game/bemani/bjm2020/janken/index.html"

  def get_link(cookie) do
    %{ body: body } = HTTPoison.get!(@base_url <> @index, %{}, hackney: [
      cookie: [cookie]
    ])

    [ first | _ ] = body
    |> Floki.parse_document!()
    |> Floki.find("#janken-select .inner a")

    [ link ] = first
    |> Floki.attribute("href")

    link
  end

  def go(link, cookie) do
    HTTPoison.get!(@base_url <> link, %{}, hackney: [
      cookie: [cookie]
    ])
  end

  def get_stamp(cookie) do
    %{ body: body } = HTTPoison.get!(@base_url <> @index, %{}, hackney: [
      cookie: [cookie]
    ])

    ps = body
    |> Floki.parse_document!()
    |> Floki.find(".stamp-num p")

    p = Enum.at(ps, 1)
    |> Floki.raw_html()
  end
end
