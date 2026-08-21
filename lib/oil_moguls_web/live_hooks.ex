defmodule OilMogulsWeb.LiveHooks do
  @moduledoc false
  import Phoenix.Component
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    {:cont,
     socket
     |> assign(:current_path, "/")
     |> attach_hook(:assign_path, :handle_params, &assign_path/3)}
  end

  defp assign_path(_params, url, socket) do
    path = url |> URI.parse() |> Map.get(:path) || "/"
    {:cont, assign(socket, :current_path, path)}
  end
end
