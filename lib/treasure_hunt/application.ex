defmodule TreasureHunt.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      TreasureHunt.Repo,
      # Start the Telemetry supervisor
      TreasureHuntWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: TreasureHunt.PubSub},
      # Start the Endpoint (http/https)
      TreasureHuntWeb.Endpoint
      # Start a worker by calling: TreasureHunt.Worker.start_link(arg)
      # {TreasureHunt.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TreasureHunt.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TreasureHuntWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
