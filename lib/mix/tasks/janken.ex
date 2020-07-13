defmodule Mix.Tasks.Janken do
	use Mix.Task

	@shortdoc "execute janken bot"
	def run([]) do
		Application.ensure_all_started(:httpoison)
		JankenBot.go()
	end
end