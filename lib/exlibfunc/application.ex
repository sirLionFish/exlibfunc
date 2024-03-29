defmodule Exlibfunc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Exlibfunc.Repo,
      # Start the Telemetry supervisor
      ExlibfuncWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Exlibfunc.PubSub},
      # Start the Endpoint (http/https)
      ExlibfuncWeb.Endpoint
      # Start a worker by calling: Exlibfunc.Worker.start_link(arg)
      # {Exlibfunc.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Exlibfunc.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ExlibfuncWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
