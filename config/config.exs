use Mix.Config

config :janken_bot, JankenBot.Scheduler,
	timezone: :utc,
	jobs: [
		{ "5 1,6,11 * * *", { JankenBot, :go, [] } }
	]

import_config "#{Mix.env()}.exs"