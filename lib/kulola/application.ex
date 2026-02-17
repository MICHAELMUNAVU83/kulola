defmodule Kulola.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KulolaWeb.Telemetry,
      Kulola.Repo,
      {DNSCluster, query: Application.get_env(:kulola, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Kulola.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Kulola.Finch},
      # Start a worker by calling: Kulola.Worker.start_link(arg)
      # {Kulola.Worker, arg},
      # Start to serve requests, typically the last entry
      KulolaWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kulola.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KulolaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
