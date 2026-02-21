defmodule KulolaWeb.BundleLive.Index do
  use KulolaWeb, :live_view

  alias Kulola.Bundles
  alias Kulola.Bundles.Bundle

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :bundles, Bundles.list_bundles())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Bundle")
    |> assign(:bundle, Bundles.get_bundle!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bundle")
    |> assign(:bundle, %Bundle{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bundles")
    |> assign(:bundle, nil)
  end

  @impl true
  def handle_info({KulolaWeb.BundleLive.FormComponent, {:saved, bundle}}, socket) do
    {:noreply, stream_insert(socket, :bundles, bundle)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bundle = Bundles.get_bundle!(id)
    {:ok, _} = Bundles.delete_bundle(bundle)

    {:noreply, stream_delete(socket, :bundles, bundle)}
  end
end
