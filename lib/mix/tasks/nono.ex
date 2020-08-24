defmodule Mix.Tasks.Nono do
	use Mix.Task

	@shortdoc "execute nono rush bot"
	def run([]) do
		Application.ensure_all_started(:httpoison)
		JankenBot.nono()
	end
end
