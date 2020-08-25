defmodule JankenBot.Janken do
  @base_url "https://p.eagate.573.jp"

  @index "/game/bemani/bjm2020/janken/index.html"

  def run(cookie) do
    link = get_event_page(cookie)
    |> get_submit_link()
    
    case link do
      {:ok, link} ->
        submit(link, cookie)

      {:error, _msg} ->
        nil
    end
  end

  defp get_submit_link(event_page) do
    selects = event_page
    |> Floki.find("#janken-select .inner a")

    case selects do
      [] -> 
        {:error, "already selected"}

      [ first | _ ] -> 
        [ link ] = first
        |> Floki.attribute("href")
    
        {:ok, link}
    end
  end

  defp get_event_page(cookie) do
    %{ body: body } = HTTPoison.get!(@base_url <> @index, %{}, hackney: [
      cookie: [cookie]
    ])

    Floki.parse_document!(body)
  end

  defp submit(link, cookie) do
    HTTPoison.get!(@base_url <> link, %{}, hackney: [
      cookie: [cookie]
    ])

    :ok
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
