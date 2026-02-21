defmodule KulolaWeb.TestimonialLive.Show do
  use KulolaWeb, :live_view

  alias Kulola.Testimonials

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:testimonial, Testimonials.get_testimonial!(id))}
  end

  defp page_title(:show), do: "Show Testimonial"
  defp page_title(:edit), do: "Edit Testimonial"
end
