defmodule OilMoguls.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    :ok =
      :logger.add_primary_filter(
        :ignore_client_disconnects,
        {&OilMoguls.LoggerTranslator.filter/2, []}
      )

    children = [
      OilMogulsWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:oil_moguls, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: OilMoguls.PubSub},
      # Start a worker by calling: OilMoguls.Worker.start_link(arg)
      # {OilMoguls.Worker, arg},
      # Start to serve requests, typically the last entry
      OilMogulsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: OilMoguls.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    OilMogulsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
