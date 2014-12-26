defmodule JB do
  use Application
  require Logger

  @scraper_name :jb_scraper

  def start(_type, _args) do
    import Supervisor.Spec, warn: true

    db = "sraped_urls_" <> "#{Mix.env}"

    children = [
      worker(MongoService, [db]),
      worker(JB.Scraper, [[name: @scraper_name]])
    ]

    opts = [strategy: :one_for_one, name: JB.Supervisor]
    Supervisor.start_link(children, opts)
  end
end