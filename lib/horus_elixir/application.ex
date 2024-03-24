defmodule HorusElixir.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      HorusElixirWeb.Telemetry,
      HorusElixir.Repo,
      {DNSCluster, query: Application.get_env(:horus_elixir, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: HorusElixir.PubSub},
      {Cachex, name: :api_cache},
      # Start a worker by calling: HorusElixir.Worker.start_link(arg)
      # {HorusElixir.Worker, arg},
      # Start to serve requests, typically the last entry
      HorusElixirWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HorusElixir.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HorusElixirWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
