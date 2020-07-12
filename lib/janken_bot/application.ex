defmodule JankenBot.Application do
	use Application

	def start(_type, _args) do
		import Supervisor.Spec, warn: false

		children = [
			JankenBot.Scheduler,
		]

		opts = [strategy: :one_for_one, name: JankenBot.Supervisor]
		Supervisor.start_link(children, opts)
	end
end