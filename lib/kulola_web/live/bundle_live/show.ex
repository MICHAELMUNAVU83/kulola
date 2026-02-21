defmodule KulolaWeb.BundleLive.Show do
  use KulolaWeb, :live_view

  alias Kulola.Bundles

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bundle, Bundles.get_bundle!(id))}
  end

  defp page_title(:show), do: "Show Bundle"
  defp page_title(:edit), do: "Edit Bundle"
end
